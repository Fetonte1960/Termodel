{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit inser;

INTERFACE

uses definiz,globfunz,genproc,verifica,halotp4,graph,angoli,WM,
     spazio,debug,diseg,osnap,controll,defuti{$ifdef win},multilin{$endif};

Procedure Ins_tro;

{---------------------------------------------------------------------------}
implementation




Procedure Ins_tro;

Var
    Nome:String;
    Spx,Spy,Spz,Dir,Dirz,Dir1,DirZ1,orx,ory,orz,angrot:real;
    Sptr,SpDat,SpPez:integer;

    TrCorr,Count,trin,i,trsel,k:integer;
    fi:file of cadrec;
    Caso2,verticale:boolean;
    errore:string;
    usc:stacchi;
    BufCad:Cadrec;
    BufCalc:Calcrec;
    Ris1:datiint;
    Dist_temp:real;
    st_dist,disttemp:string;
    trovato:boolean;
    error:integer;
    verttrsel:boolean;{cippo}
    st1:string;
begin

errore:='';
Nome:=ReadCom(W_M(21),nomebl,0); {('Nome del Blocco',nomebl,0);}

if Nome='' then cod:=130
else
  begin
  nomebl:=nome;
  Nome:=Driveprog+nome;
  cod:=130;
  errore:=Spazio_ins(Nome);
  if Errore='' then
    begin
    st1:='';
    richiesta(W_M(31));  { '<Dal punto>/Spezza:'}
    st1:=W_M(31);
    readcord(x,y,cod,scelta,st1,5);

{S}   if (St1<>'')and(upcase(St1[1])=CH20)then

      begin

      if SelezLinea(Trattosel)<>130 then

        begin
        xp:=xg(dis^[Trattosel]^.x1,dis^[Trattosel]^.y1);
        yp:=yg(dis^[Trattosel]^.y1,dis^[Trattosel]^.z1);
        {Tretino(x,y);}
        richiesta('');
(* cippo  il codice seguente non serve
        if (c_Osnap)and(not sezione) then  {- osnap alla pianta -}
          begin
          Calcdirez(trattosel,C_ang,Dist_temp);
          str(c_dist*conf.Altnum/40000:5:3,st_dist);

          st1:='(Osnap)Selezionare una linea del disegno/Distanza('+st_dist+')'; {*TR*}
          richiesta(st1+':');
            REPEAT
            trovato:=false;
            readcord(x,y,cod,scelta,ST1,3);
            if st1='' then
              begin
              if cod=132 then
                begin
                x:=xe(x);
                y:=ye(x,y);
                trovato:=osn(x,y,0,0,xe(xp),ye(xp,yp),8,st1);
                if not trovato then richiesta(st1);
                st1:='';
                x:=xg(x,y);
                y:=yg(y,0);
                end
              end
            else
              begin
              ST_DIST:=ST1;
              val(st_dist,dist_temp,error);
              if error=0 then C_dist:=Dist_temp*40000/Conf.AltNum
              else write(chr(7));
              str(c_dist*conf.Altnum/40000:5:3,st_dist);
              st1:='(Osnap)Selezionare una linea del disegno/Distanza('+st_dist+')'; {*TR*}
              richiesta(st1+':');
              end;
            until (cod=130)or(trovato);
          delbox;
          end
        else
          begin      cippo *)
          richiesta(W_M(32)); { 'Selezionare punto'); }
          st1:='';
          readcord(x,y,cod,scelta,st1,7);
          isocur(x,y,2);
          richiesta('');
     (*     end;  cippo *)

        Ver_spez(xe(x),ye(x,y),ze(y),Trattosel,Cod);

        if cod=132 then

          begin

          with dis^[nrighe]^ do

            begin
            entita:='L';
            color :=dis^[TrattoSel]^.color ;
            tlinea:=dis^[TrattoSel]^.tlinea;
            x1    :=xe(x);
            y1    :=ye(x,y);
            z1    :=ze(y);
            x2    :=dis^[TrattoSel]^.x2;
            y2    :=dis^[TrattoSel]^.y2;
            z2    :=dis^[TrattoSel]^.z2;
            NLinea:=Dis^[TrattoSel]^.NLinea;
            Npezzo:=Dis^[TrattoSel]^.NPezzo;
            Rid   :=Dis^[TrattoSel]^.Rid;
            Tronco:=Dis^[TrattoSel]^.Tronco;
            flag:=true;
            end;

          with dis^[TrattoSel]^ do

            begin
            x2:=xe(x);
            y2:=ye(x,y);
            z2:=ze(y);
            Nlinea:=NRighe;
            Npezzo:=0;
            Rid:='';
            end;

          NRighe:=NewRiga;
          xp:=xg(dis^[Trattosel]^.x2,dis^[Trattosel]^.y2);
          yp:=yg(dis^[Trattosel]^.y2,dis^[Trattosel]^.z2);
          end
        end
      else cod:=132;
      end
    else
      begin
      if cod=132 then
        begin
        xp:=xg(dis^[Trattosel]^.x2,dis^[Trattosel]^.y2);
        yp:=yg(dis^[Trattosel]^.y2,dis^[Trattosel]^.z2);
        end
      end;

    end;
  end;

if cod=132 then
  begin

  assign(fRisult,Nome+'.ris');
  reset(fRisult);
  read(fRisult,Ris1);
  close(fRisult);

  assign(fr,Nome+'.DTR');reset(fr);
  for k:=1 to Ris1.Origine Do
  Read(fr,BufCalc);
  close(fr);

  assign(fi,Nome+'.ret');reset(fi);
  for k:=1 to BufCalc.Ti do
  read(fi,BufCad);
  close(fi);

  dis^[0]^:=BufCad;
  CalcDirez(0,Dir,Dirz);
  Verticale:=Ug(abs(DirZ),PI/2,1);
  trsel:=trattosel;


  if (sezione)or(Verticale) then

   begin
     angrot:=0;
     verttrsel:=false;
     CalcDirez(trsel,Dir1,Dirz1);  {cippo}
     Verttrsel:=Ug(abs(DirZ1),PI/2,1); {cippo}

     if ( (format360(dir1-dir)   > PI/2) and
          (format360(dir1-dir)   < 3*PI/2) and
          (not(ug( format360(dir1-dir),PI/2,1) ) ) and
          (not(ug( format360(dir1-dir),3*PI/2,1) ) ) and
          (not verticale) and
          (not verttrsel)
        ) or

        ( (format360(dirz1-dirz) > PI/2) and
          (format360(dirz1-dirz) < 3*PI/2) and
          (not(ug( format360(dirz1-dirz),PI/2,1) ) ) and
          (not(ug( format360(dirz1-dirz),3*PI/2,1) ) )
        )
      Then
       begin
        Errore:=W_M(101);           {'Stacco non simmetrico !'}
        cod:=130;{errore:='*';}
       end
   end
  else
    begin

    retino:=true;
    st1:='';
    richiesta(W_M(23)); {'<Direzione del primo tratto>');}
    readcord(x,y,cod,scelta,ST1,2);

    delln;

    setclip(@xw1,@yw1,@xw2,@yw2);
    setcolor(7);
    isocur(x,y,2);
    trattosel:=trsel;
    if cod=132 then
      begin
      Calc_D(xp,yp,0,x,y,0,dir1,dirz1);
      angrot:=Format360(dir1-dir);
      end;
    end;

  with Dis^[0]^ do
    begin
    x2:=x2-x1;
    y2:=y2-y1;
    z2:=z2-z1;

    Modicord1(x2,y2,0,0,angrot,1);

    x1:=dis^[trsel]^.x2;
    y1:=dis^[trsel]^.y2;
    z1:=dis^[trsel]^.z2;

    x2:=x2+x1;
    y2:=y2+y1;
    z2:=z2+z1;
    end;


  if (Cod=132) then
    begin

    for k:=1 to 5 do usc[k]:=0;
    usc[0]:=trsel;
    usc[6]:=0;

      Case TipoNodo(Trsel) of
        1:usc[1]:=dis^[trsel]^.NLinea;
        3:for k:=1 to 5 Do
          if dati^[dis^[trsel]^.tronco]^.pros[k]<>0 then
          usc[k]:=dati^[dati^[dis^[trsel]^.tronco]^.pros[k]]^.ti;
      end;


    if Not(st_ok(usc)) {cippo or (errore='*')} then
      begin
      cod:=130;
      errore:='*';
      end;
   end

  end;

if cod=132 then

  begin
  assign(fRisult,Nome+'.ris');
  reset(fRisult);
  read(fRisult,Ris1);
  close(fRisult);


  with dis^[TrattoSel]^ do

    begin
    Spx:=x2;
    Spy:=y2;
    Spz:=z2;
    end;

  if ris1.Origine<>0 then
    begin

    assign(fi,Nome+'.ret');reset(fi);
    assign(fr,Nome+'.DTR');reset(fr);
    assign(fp,Nome+'.pzz');reset(fp);

    Caso2:=false;

{    if dati^[ULtTronco+Ris1.Origine]=nil then
    new(dati^[ULtTronco+Ris1.Origine]);    tolto perche inutile

      case Tiponodo(trattosel) of
      1:TrCorr:=InsNodo(Trattosel,NRighe,1,ULtTronco+Ris1.Origine);
      2:begin
        TrCorr:=ULtTronco+Ris1.Origine;
        Caso2:=true;
        end;
      3:begin
        TrCorr:=InsNodo(Trattosel,NRighe,3,ULtTronco+Ris1.Origine);
        end;
      end;  cippo   spostato }


    Sptr:=Ultriga;
    SpDat:=UltTronco;
    SpPez:=UltPezzo;
    Count:=0;
    trin:=0;
    while not eof(fr) do
      begin
      UltTronco:=UltTronco+1;
      if Dati^[UltTronco]=nil then new(Dati^[UltTronco]);
      Read(fr,Dati^[UltTronco]^);
      Count:=Count+1;
      with Dati^[UltTronco]^ do
      if Ti<>0 then
        begin
        x:=0;
        y:=0;
        if count=Ris1.Origine then Trin:=Ti;
        Ti:=Ti+spTr;
        for i:=1 to 6 do
        if pros[i]<>0 then Pros[i]:=Pros[i]+Spdat;
        for i:=0 to Pezzitr do
        if Pezzi[i]<>0 then Pezzi[i]:=Pezzi[i]+SpPez;
        end;
      end;



      case Tiponodo(trattosel) of
      1:TrCorr:=InsNodo(Trattosel,NRighe,1,ULtTronco);
      2:begin
        TrCorr:=ULtTronco;
        Caso2:=true;






        end;
      3:begin
        TrCorr:=InsNodo(Trattosel,NRighe,3,ULtTronco);
        end;
      end;






    while not eof(fp) do
      begin
      UltPezzo:=UltPezzo+1;
      if VPezzi^[UltPezzo]=nil then new(VPezzi^[UltPezzo]);
      Read(fp,VPezzi^[UltPezzo]^);
      end;

    Count:=0;

    while not eof(fi) do
      begin
      Count:=Count+1;
      UltRiga:=UltRiga+1;
      if Dis^[UltRiga]=nil then new(Dis^[UltRiga]);
      Read(fi,Dis^[UltRiga]^);
      if Count=Trin then
        begin
        orx:=Dis^[UltRiga]^.X1;
        ory:=Dis^[UltRiga]^.Y1;
        orz:=Dis^[UltRiga]^.Z1;
        end
      end;

    For i:=SpTr+1 to UltRiga do
    with Dis^[i]^ do
      begin
      X1:=X1-orx;
      Y1:=Y1-ory;
      Z1:=Z1-orz;
      Modicord1(x1,y1,spx,spy,angrot,1);
      Z1:=Z1+Spz;

      if entita[1]='L' then
        begin
        X2:=X2-orx;
        Y2:=Y2-ory;
        Z2:=Z2-orz;
        Modicord1(x2,y2,spx,spy,angrot,1);
        Z2:=Z2+Spz;
        end;
      flag:=true;
    (*  Disegna(i); cippo *)
      if tronco<>0 then tronco:=tronco+spdat;
      if nlinea<>0 then Nlinea:=Nlinea+Sptr;
      end;

    insersetflag(Sptr+1,ultriga); {cippo}
    DisUniOutQ(Sptr+1,ultriga);
    For i:=SpTr+1 to UltRiga do
    if (dis^[i]^.entita<>'')and(dis^[i]^.Flag) then
      begin
      Disegna(i);
      end;                      {cippo}

    close(fi);
    close(fr);
    close(fp);

    Ntronchi:=newtr;
    Nrighe  :=NewRiga;

    if caso2 then
      begin
      dis^[trattosel]^.Nlinea:=Dati^[trcorr]^.Ti;
      Dati^[trcorr]^.Ti:=Dati^[Dis^[trattosel]^.tronco]^.Ti;
      Dati^[Dis^[trattosel]^.tronco]^:=Dati^[trcorr]^;
      Dati^[trcorr]^.Ti:=0;
      CancNum(dis^[trattosel]^.TRonco);
      InitRec(dis^[trattosel]^.tronco,4);
      i:=Dati^[Dis^[trattosel]^.tronco]^.Ti;
      while i<>0 do
        begin
        dis^[i]^.Tronco:=Dis^[trattosel]^.tronco;
        i:=Dis^[i]^.NLinea;
        end;
      end;

    initrec(dis^[trattosel]^.tronco,4); {cippo-messie 09/06/94}
    initrec4(dis^[trattosel]^.tronco); {cippo-messie 09/06/94}

    end;

  end;

if errore<>'*' then
Richiesta(errore);

end;

end.