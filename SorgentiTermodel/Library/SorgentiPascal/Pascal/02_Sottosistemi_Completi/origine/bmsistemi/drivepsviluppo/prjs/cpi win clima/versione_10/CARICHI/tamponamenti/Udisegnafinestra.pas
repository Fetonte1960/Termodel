unit UDisegnafinestra;

interface
uses Windows, SysUtils, Graphics, Classes,
     Db,dbtables, ExtCtrls, Math;

Const
  Maxsetti=5;
  
Type
Recsetti = Record
             Tipo:STRING;
             Altezza:REAL;
             Larghezza:REAL;
             LTelaio:REAL;
             KOpadisp:Real;
             KOpaL10:Real;
             TipoOpa:String[1];
             klinopa:Real;
             ltelsup:Real;
             ltelinf:Real;
             ltelsin:Real;
             lteldes:Real;
             formatelaio:String[1];
           End;

Ar_Recsetti=array[1..Maxsetti,1..Maxsetti]of Recsetti;

Var D_setti:^Ar_Recsetti;
    NsettiV:integer;
    NsettiOr:array[1..Maxsetti]of Integer;

procedure disegnaFinestra(var Image : TImage; Lf,Hf:integer;Rot:Boolean;cnv:integer;Var Imrec,Slaverec:Ttable);
Procedure CostruisciFinestra;
Procedure CalcolaFinestra;
Procedure Caricasetti;

implementation

uses USolomuri, UVariabiliPareti, Calcolo, Udb, UDataLink, Wizardusolomuri, LibreriaGenerale;

Var Lfin,Hfin:Integer;
    ruotato:boolean;
    qua:Trect;

Procedure CalcolaFinestra;
Var
  Stot,pertot,Stelaiotot,lnetta,hnetta,supnetta,sup_setti,hsetti, hsettiL10: real;
  FinTrasm, FinTrasmL10, FTrasmFin:real;
  i, j: integer;
  Zonaclimatica: String;
  ValLim: double;
begin
stot:=0;
Pertot:=0;
Stelaiotot:=0;
sup_setti:=0;
hsetti:=0;
hsettiL10 := 0;
if V_recFin.Codice <> '' then
begin
  for i:=1 to NsettiV do
   for j:=1 to Nsettior[i] do
    if d_Setti^[i,j].Tipo <> '' then
    begin
      with d_setti^[i,j] do
      if UpperCase(tipo)='FINESTRA' then
        begin
          Lnetta:=Larghezza-LTelaio*2;
          Hnetta:=Altezza-Ltelaio*2;
          supnetta:=Lnetta*Hnetta;
          stot:=stot+supnetta;
          PerTot:=Pertot+Lnetta*2+Hnetta*2;
          StelaioTot:=STelaioTot+larghezza*altezza-supnetta;
        end
      else
        begin
             if CompareStr(Uppercase(V_recFin.TipoSottoFin), 'NESSUNO') <> 0 then
                sup_setti := sup_setti + Larghezza * Altezza;
             if TipoOpa = 'P' then
             begin
                  hsetti:=hsetti + Larghezza * Altezza * KOpadisp;
                  hsettiL10:=hsettiL10 + Larghezza * Altezza * KOpaL10;
             end
             else
             begin
                  hsetti:=hsetti + Larghezza * KOpadisp;
                  hsettiL10:=hsetti;
             end
        end;
      end; {end dell'if che controlla se la riga è valida}

      dm1.TT1.Open;
      dm1.TT1.Edit;
      // Emanuela 14/7/2004 inserito il disabilita del change del campo 28
      // altrimenti si ha un errore di database not in insert mode
      dm1.TT1.Fields.DataSet.Edit;
      with V_recFin do
      begin
         set_ag(RoundTo(stot, -2));
         set_lg(RoundTo(Pertot, -2));
         Set_af(RoundTo(Stelaiotot, -2));
         Set_Supsetti(RoundTo(sup_setti, -2));
         set_SuperfUnit(stot+stelaiotot+sup_setti);

         // Emanuela 20/12/2004 inserito la verifica se area vetro e area telaio sono nulle
         if (Ag+Af) <> 0 then
            Set_Uw(RoundR(2,(Ag*KgL10+Af*kf+lg*Ki)/(Ag+Af))) // caratteristica serramento x dpr relazione
         else Set_Uw(0);

         // Emanuela 16/6/2004 inserito l'incremento di sicurezza
         if not SameValue((Ag + Af + sup_setti), 0, 0) then
         begin
             // Emanuela 25/10/2005 inserito il calcolo della trasmittanza senza il sottofinestra
             if (Ag+Af) <> 0 then
                FTrasmFin := (Ag*Kg+Af*kf+lg*Ki)/(Ag+Af)
             else FTrasmFin := 0;
             FinTrasmL10 := (Ag*KgL10+Af*kf+lg*Ki+hsettiL10)/(Ag+Af+sup_setti);
             FinTrasm    := (Ag*Kg+Af*kf+lg*Ki+hsetti)/(Ag+Af+sup_setti);
         end;
         if not SameValue(INCRSICUREZZAFINESTRA, 0, 0) then
         begin
            Set_trasmittanza(RoundR(2,(FinTrasm + ((FinTrasm * INCRSICUREZZAFINESTRA) / 100))));
            FTrasmFin := FTrasmFin + (FTrasmFin * INCRSICUREZZAFINESTRA) / 100;
         end
         else
         begin
           Set_trasmittanza(RoundR(2,(FinTrasm)));
         end;
         //Emanuela e Fabio decreto del 27/7/2005
         if WizardFSoloMuri <> nil then WizardFSoloMuri.Ed_TrasmFin.Text := Format('%1.2f' , [FTrasmFin]);
         {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
          if Calcolo192 then
          begin
           //Emanuela DPR 192
           ZonaClimatica := Info_ZonaClimatica_Fabbricato;
           case ZonaClimatica[1] of
             'A': ValLim := Tab4a[1];
             'B': ValLim := Tab4a[2];
             'C': ValLim := Tab4a[3];
             'D': ValLim := Tab4a[4];
             'E': ValLim := Tab4a[5];
             'F': ValLim := Tab4a[6];
           end;
           if ValLim = 0 then V_recFin.Set_VerificaF192('--');
           if FTrasmFin > Vallim then
              V_recFin.Set_VerificaF192('NO')
           else V_recFin.Set_VerificaF192('SI');
           V_recFin.Set_ValLimFT(ValLim);
           if WizardFSoloMuri <> nil then
           begin
            WizardFSoloMuri.ED_FValLim.Text := FloatToStr(ValLim);
            if FTrasmFin  > Vallim then
            Begin
              WizardFSoloMuri.ST_VerF.Color := $000000DF;
              WizardFSoloMuri.ST_VerF.Caption := 'Negativa';
            end
            else
            begin
              WizardFSoloMuri.ST_VerF.Color := $0000B700;
              WizardFSoloMuri.ST_VerF.Caption := 'Positiva';
            end;
           end;
          end
          else
          begin
           if WizardFSoloMuri <> nil then
           begin
            WizardFSoloMuri.Label6.Visible := False;
            WizardFSoloMuri.LB_FValLim.Visible := False;
            WizardFSoloMuri.ED_FValLim.Visible := False;
            WizardFSoloMuri.ST_VerF.Visible := False;
            WizardFSoloMuri.LB_InfoVerF.Visible := False;
           end;
          end;
         {$IFEND}


         Set_TrasmittL10(RoundR(2,(FinTrasmL10)));
         // Emanuela 20/12/2004 inserito la verifica se area totale del vetro è nulla
         if stot <> 0 then
            set_PercVetr(round(stot/(stot+STelaioTot)*100))
         else set_PercVetr(0);
         // Emanuela ricopiati i dati di altezza e larghezza affinchè si possono usare
         // per il calcolo
          set_Altezza(AltezzaFin + AltSopraFin + AltSottoFin + TelaioFin);
          set_Larghezza(LarghezzaFin + TelaioFin);
      end;
    dm1.TT1.POst;
  end;  
end;

Procedure Caricasetti;

Var i,Indbase:Integer;
begin
NsettiV:=0;
with dm1.TT3 do
  begin
  First;
  while not eof do
    begin
    inc(NsettiV);
    for i:=1 to Maxsetti do
    with  D_setti^[NsettiV,i] do
      begin
      Indbase:=(i-1)*round((fieldcount-2)/Maxsetti)+1;

      if fields[indbase+1].asstring<>'' then
      Tipo:=fields[indbase+1].asstring
      else Tipo:='';

      if tipo<>'' then NsettiOr[NsettiV]:=i;

      if fields[indbase+2].asstring<>'' then
      Altezza:=fields[indbase+2].asFloat
      else altezza:=0;

      if fields[indbase+3].asstring<>'' then
      Larghezza:=fields[indbase+3].asFloat
      else larghezza:=0;

      if fields[indbase+4].asstring<>'' then
      LTelaio:=fields[indbase+4].asFloat
      else LTelaio:=0;

      if fields[indbase+5].asstring<>'' then
      KOpadisp:=fields[indbase+5].asFloat
      else KOpadisp:=0;

      if fields[indbase+6].asstring<>'' then
      KOpaL10:=fields[indbase+6].asFloat
      else KOpaL10:=0;

      if fields[indbase+7].asstring<>'' then
      TipoOpa:=fields[indbase+7].asString
      else TipoOpa:='P';

      if fields[indbase+8].asstring<>'' then
      klinopa:=fields[indbase+8].asFloat
      else klinopa:=0;

      if fields[indbase+9].asstring<>'' then
      ltelsup:=fields[indbase+9].asFloat
      else ltelsup:=0;

      if fields[indbase+10].asstring<>'' then
      ltelinf:=fields[indbase+10].asFloat
      else ltelinf:=0;

      if fields[indbase+11].asstring<>'' then
      ltelsin:=fields[indbase+12].asFloat
      else ltelsin:=0;

      if fields[indbase+12].asstring<>'' then
      lteldes:=fields[indbase+12].asFloat
      else lteldes:=0;

      if fields[indbase+13].asstring<>'' then
      formatelaio:=fields[indbase+13].asString
      else formatelaio:='R';
      end;
    next;
    end;
  end;
end;
Function MX(X,Y:real):Integer;
begin
if ruotato then result:=round(Y*LFin/100)
else result:=round(X*LFin/100);
end;

Function MY(X,Y:real):Integer;
begin
if ruotato then result:=round(X*HFin/100)
else result:=round(Hfin-Y*HFin/100);
end;


procedure quadrato(XU,YL,XR,YD:real);
begin
with qua do
  begin
  Left:=MX(XU,YL);
  Top:=MY(XU,YL);
  Right:=MX(XR,YD);
  Bottom:=MY(XR,YD);
  end;
end;


procedure disegnaFinestra(var Image : TImage; Lf,Hf:integer;Rot:Boolean;cnv:integer;Var Imrec,Slaverec:Ttable);
Var Nomefile:string;
    spes,spestot,larg,largtot,largmax,fattconv,dimmax,posx,altmax:real;
    bmp:Tbitmap;
    MS: TMemoryStream;
    i,j:Integer;

Procedure DisAnta(Image : TImage; xa,ya,xb,yb,tel:real);
begin
     if dm1.TT1.FindField('FinPor').AsString = 'Porta' then
        begin
             Quadrato(xa,ya,xb,yb);
             image.Canvas.Brush.Color:= $00004080;
             image.Canvas.fillrect(qua);
        end
     else
        begin // caso finestra
              Quadrato(xa,ya,xb,yb);
              image.Canvas.Brush.Color:=clmaroon;
              image.Canvas.fillrect(qua);
              Quadrato(xa+tel*Fattconv,ya+tel*Fattconv,xb-tel*Fattconv,yb-tel*Fattconv);
              image.Canvas.Brush.Color:=claqua;
              image.Canvas.fillrect(qua);
        end;
end;
Procedure DisSopraluce(Image : TImage; xa,ya,xb,yb,tel:real);
begin
     Quadrato(xa,ya,xb,yb);
     image.Canvas.Brush.Color:=clmaroon;
     image.Canvas.fillrect(qua);
     Quadrato(xa+tel*Fattconv,ya+tel*Fattconv,xb-tel*Fattconv,yb-tel*Fattconv);
     image.Canvas.Brush.Color:=clAqua;
     image.Canvas.fillrect(qua);
end;

Procedure DisCassonetto(Image : TImage; xa,ya,xb,yb:real);
begin
     Quadrato(xa,ya,xb,yb);
     image.Canvas.Brush.Color:= clLtGray;
     image.Canvas.fillrect(qua);
end;

Procedure DisParete(Image : TImage; xa,ya,xb,yb:real);
begin
     Quadrato(xa,ya,xb,yb);
     if dm1.TT1.FindField('FinPor').AsString = 'Porta' then
        image.Canvas.Brush.Color:= $00004080
     else
        image.Canvas.Brush.Color:= $00E4E4E4;

     image.Canvas.fillrect(qua);
end;

begin
  Caricasetti;
  CalcolaFinestra;
  Lfin:=Lf;
  Hfin:=Hf;
  ruotato:=rot;
  Fattconv:=1;
  slaverec.First;
  spes:=0;
  larg:=0;
  if NsettiV = 0 then
  begin
     Image.Canvas.TextOut(Image.Width div 4, Image.Height div 2, 'Definire le proprietà dell''elemento');
  end;

  For i:=1 to NsettiV do
    begin
    Largmax:=0;
    for j:=1 to Nsettior[i] do
    Largmax:=largmax+D_setti^[i,j].Larghezza;
    if Largmax>Larg then larg:=Largmax;
    spes:=spes+D_setti^[i,1].Altezza*Fattconv;
    end;

  spestot:=spes;
  largtot:=Larg;
  if (largtot=0) or (spestot=0) then exit;
  if spestot>largtot then dimmax:=spestot else dimmax:=largtot;
  fattCONV:=80/DIMMAX;
  Spestot:=spestot*fattconv;
  Largtot:=Largtot*fattconv;
  slaverec.First;
  spes:=0;
  Quadrato(0,0,100,100);
  image.Canvas.Brush.Color:=clwhite;
  image.Canvas.fillrect(qua);


  For i:=1 to NsettiV do
    begin
      try
      bmp:=TBitmap.Create;
      POsX:=50-largTot/2;
      for j:=1 to Nsettior[i] do
      with D_setti^[i,j] do
        begin
        if tipo<>'' then
          begin
          if Tipo='Finestra' then
          DisAnta(Image, 50-spestot/2+spes,posx,50-spestot/2+spes+Altezza*Fattconv,POsx+Larghezza*Fattconv,LTelaio)
          else if Tipo = 'Sopral' then
          DisSopraluce(Image, 50-spestot/2+spes,posx,50-spestot/2+spes+Altezza*Fattconv,POsx+Larghezza*Fattconv,LTelaio)
          else if Tipo = 'Cassone' then
          DisCassonetto(Image, 50-spestot/2+spes,POsx,50-spestot/2+spes+Altezza*Fattconv,POsx+Larghezza*Fattconv)
          else
          Disparete(Image, 50-spestot/2+spes,POsx,50-spestot/2+spes+Altezza*Fattconv,POsx+Larghezza*Fattconv);

          end;
        posx:=posx+Larghezza*Fattconv;
        end;
      finally

      // Memorizzo l'immagine nel database by piero
      imrec.First;
      if imrec.eof then imrec.append;
      imrec.edit;
      MS := TMemoryStream.Create();

      image.Picture.Bitmap.SaveToStream(MS);
      (Imrec.FieldByName('immagine')as Tgraphicfield).LoadFromStream(MS);
      Imrec.FieldByName('Descrizione').AsString := V_TabStruttura.Descr;
      Imrec.FieldByName('Codice').AsString := V_TabStruttura.Nfile;
      imrec.Post;
      ms.free;

      image.Canvas.brush.Bitmap:=Nil;
      bmp.Free;
      end;
    spes:=spes+D_setti^[i,1].Altezza*Fattconv;
    end;
  if cnv=2 then
  begin
      imrec.First;
      if imrec.eof then imrec.append;
      imrec.edit;
      MS := TMemoryStream.Create();
      image.Picture.Bitmap.SaveToStream(MS);
      (Imrec.FieldByName('immagine')as Tgraphicfield).LoadFromStream(MS);
      Imrec.FieldByName('Descrizione').AsString := V_TabStruttura.Descr;
      Imrec.FieldByName('Codice').AsString := V_TabStruttura.Nfile;
      imrec.Post;
      ms.free;
   end;
end;


Procedure CostruisciFinestra;
begin
// Modifica del 09/06/2004 by Piero
// ripulisco le informazioni presenti in tabella sempre
dm1.TT3.First;
while not dm1.TT3.eof do
begin
     dm1.TT3.delete;
     dm1.TT3.First;
end;

with V_RecFin do
  begin

   if (AltezzaFin > 0)and(LarghezzaFin > 0)and(AnteFin > 0) then
     begin
          dm1.TT1.Edit;
          seT_Trasmittanza(2.3);
          dm1.TT1.POst;

          if (AltCassoFin > 0)and(TipoCassoFin<>'') then
             begin
                  dm1.TT3.append;
                  dm1.TT3.edit;
                  with V_RecSetti do
                     begin
                          set_tipo('Cassone');
                          Set_Altezza(AltCassoFin);
                          Set_Larghezza(LarghezzaFin);
                     end;
                  dm1.TT3.POst;
             end;

           if (AltsopraFin > 0){and(TiposopraFin<>'')} then
             begin
                  // gestire come se fosse una finestra con le ante relative
                  dm1.TT3.append;
                  dm1.TT3.edit;
                  with V_RecSetti do
                     begin
                          // Emanuela 27/9/2004 necessario perchè altrimenti non si può distinguere tra
                          // sopra finestra

                          set_tipo('Sopral');
                                                            { TODO : controllare se l'eliminazione del tipo sopral va bene }
                          //set_tipo('Finestra');
                          Set_Altezza(AltsopraFin);
                          Set_Larghezza(LarghezzaFin);
                          Set_LTelaio(TelaioFin);
                     end;
       end;


     dm1.TT3.append;
     dm1.TT3.edit;
     with V_RecSetti do
       begin
            set_tipo('Finestra');
            Set_Altezza(Altezzafin);
            Set_Larghezza(LarghezzaFin/antefin);
            Set_LTelaio(TelaioFin);
            if anteFin>1 then
            begin
                 set_tipo2('Finestra');
                 set_Altezza2(Altezzafin);
                 Set_Larghezza2(LarghezzaFin/antefin);
                 Set_LTelaio2(TelaioFin);
            end;
            if anteFin>2 then
            begin
                 set_tipo3('Finestra');
                 set_Altezza3(Altezzafin);
                 Set_Larghezza3(LarghezzaFin/antefin);
                 Set_LTelaio3(TelaioFin);
            end;
            if anteFin>3 then
            begin
                 set_tipo4('Finestra');
                 set_Altezza4(Altezzafin);
                 Set_Larghezza4(LarghezzaFin/antefin);
                 Set_LTelaio4(TelaioFin);
            end;
            if anteFin>4 then
            begin
                 set_tipo5('Finestra');
                 set_Altezza5(Altezzafin);
                 Set_Larghezza5(LarghezzaFin/antefin);
                 Set_LTelaio5(TelaioFin);
            end;
       end;

     dm1.TT3.POst;
     end;
     if (AltSottoFin > 0)and(TipoSottoFin <> '') then
       begin
            dm1.TT3.append;
            dm1.TT3.edit;
            with V_RecSetti do
            begin
                  // Emanuela 27/9/2004 necessario perchè altrimenti non si può distinguere tra
                  // sotto finestra
                  set_tipo('Parete');
                 //set_tipo('Finestra');

                 Set_Altezza(AltSottoFin);
                 Set_Larghezza(LarghezzaFin);
                 Set_KOpadisp(kSottoFin);
                 Set_KOpaL10(kSottoFinL10);
            end;

            dm1.TT3.POst;
       end;

  end;  
end;

end.






