Unit ProcLe10;

INTERFACE

Uses
  SysUtils,
  Uvariabili, Varcarichi, calcHg, metodL10,
  Metod10, UFunzioniLegge10, procle13, Utireport, FunzProc1;



procedure stampaIrrag(var Npag,Nr:smallint);
procedure StampTotH(var Npag,Nr:smallint);
procedure InitTOt_Aei;
function calcPerimetro(CercaAmb:smallint):real;
function UnicoPav(Cod,Numeroamb:smallint):boolean;
function CalcTestMed:real;



{ ************************************************************************* }

IMPLEMENTATION

uses calccd;

function CalcTestMed:real;
var i,GM:smallint;
    Dtm,NumG:real;
begin
   DtM:=0;
   NumG:=0;

   GM:=GiorMese(IndMese^[1])-(prog^.GiornoIn-1);

   DtM:=DtM+GM*TempEstMed^[indMese^[1]];
   NumG:=NumG+GM;

   GM:=Prog^.GiornoFin;

   DtM:=DtM+GM*TempEstMed^[indMese^[MesiRisc]];
   NumG:=NumG+GM;

   for i:=2 to MesiRisc-1 do
    begin
       DtM:=DtM+GiorMese(indMese^[i])*TempEstMed^[indMese^[i]];
       NumG:=NumG+GiorMese(indMese^[i]);
    end;
   Dtm:=(Dtm/NumG);

   CalctestMed:=DtM;
end;



procedure InitTOt_Aei;
var i: smallint;
begin
  fillchar(Fil^,sizeof(Fil^),0);
  fillchar(Fig^,sizeof(Fig^),0);
  fillchar(TotAeiOpa,sizeof(TotAeiOpa),0);
  fillchar(TotAeiTrasp,sizeof(TotAeiTrasp),0);
{  fillchar(TotAeiOpaincl^,sizeof(TotAeiOpaIncl^),0);
  fillchar(TotAeiTraspIncl^,sizeof(TotAeiTraspIncl^),0);}
  fillchar(TotQsi^,sizeof(TotQsi^),0);
  fillchar(TotQse^,sizeof(TotQse^),0);
  fillchar(TotHEspLocFissi^,sizeof(TotHEspLocFissi^),0);
  fillchar(tabzona10^,sizeof(Tabzona10^),0);
  fillchar(Ql^,sizeof(Ql^),0);
  fillchar(Qp^,sizeof(Qp^),0);
  fillchar(Ed^,sizeof(Ed^),0);
  fillchar(Ep^,sizeof(Ep^),0);
  fillchar(RisFc^,sizeof(RisFc^),0);
  fillchar(prn_TotH^,sizeof(prn_TotH^),0);
end;

function CreaContest(S1,S2:string):string;
var K1,K2,k,i:smallint;
    Cont:string[130];
begin
   Cont:='';
   for i:=1 to 130 do Cont[i]:=' ';
   k2:=length(S2);
   if S1 > '' then
    begin
       S1:='Zona : '+S1+'';
       k1:=length(S1);
       delete(Cont,1,k1+1);
       insert(S1,Cont,1);
       k:=0;
       for i:=117-k2 to 117 do
        begin
           k:=k+1;
           Cont[i]:=S2[k];
        end
    end
   else Cont:=S2;

   Creacontest:=Cont;
end;

function UnicoPav(Cod,Numeroamb:smallint):boolean;
var i:smallint;
    Unico:boolean;
begin
  Unico:=false;
  for i:=1 to NFrontiere do
   if Frontiere_D^[i]^.CodAmb <> NumeroAmb then Unico:=Unico or (Frontiere_D^[i]^.CodEsposiz = Cod);
  UnicoPav:=Unico;
end;

function calcPerimetro(CercaAmb:smallint):real;
var i:smallint;
    LungP:real;
begin
  LungP:=0;
  for i:=1 to NFrontiere do
   with Frontiere_D^[i]^ do
    begin
       if (CodAmb = CercaAmb) and (LungMuro <> 0) then LungP:=LungP+LungMuro;
    end;
  CalcPerimetro:=LungP;
end;

// ------------------------------
// Calcolo dell' H totale di zona
// ------------------------------
 { TODO -oFabio -cIndice : Stampa della tabella riassuntiva degli H apporti RIEPILOGO DATI DEI FATTORI DI DISPERSIONE VERSO L'ESTERNO. }
 
procedure StampTotH(var Npag,Nr:smallint);
begin
   with prn_TotH^ do
    begin

    // Fabio 21-07-2oo4 Eliminato il contributo di HTerreno dall' HTotZona
    // perchè dalla relazione è escuso dalla stampa nel calcolo del totale.
    
       // HTotZona:=HOpaEst+HTraspEst+HPontEst+HLocNR+HVent+HTerreno;

      HTotZona:=HOpaEst+HTraspEst+HPontEst+HLocNR+HVent;

       // ---------------------------------------------------------
       // Stampa Tabella
       // RIEPILOGO DATI DEI FATTORI DI DISPERSIONE VERSO L'ESTERNO
       // ---------------------------------------------------------

        W_Reale('HSUP_OPA_EST', prn_TotH^.HOpaEst, 1);
        W_Reale('HSUP_FIN_EST', prn_TotH^.HTraspEst, 1);
        W_Reale('HPONTI_TERM',  prn_TotH^.HPontEst, 1);
        W_Reale('HLOC_NORISC',  prn_TotH^.HLocNR, 1);
        W_Reale('HVEN_INF_EST', prn_TotH^.HVent, 1);
        W_Reale('HTOTALE_EST',  prn_TotH^.HTotZona,1);

    end;
    
   {StampaMask(Longint(@prn_TotH^),'TotHZona.prn',true);
   if flagstampa then nr:=nr+LungMask('TotHZona.prn');}
  { StampaNPag(npag,nr);
   NuovaPagina(nr,npag);}
end;



procedure stampaIrrag(var Npag,Nr:smallint);

//type
 { stampQ=record
            DescM:string[115];
            Tot:array[1..12] of real;
          end;
  mes=array[1..12] of st3;  }
var i,j,Pag,Lm:smallint;
 //   StQ:^stampQ;
    {str1,str2:string[120];}
 //   DM:^mes; {array[1..12] of st3;}


procedure IrraggOpache;
var i,j:smallint;
    TotH:STRING[20];
    HTilt:real;
    Prefisso:string;
begin
   for i:=1 to MEsp do
    begin
       if TotAeiOpa[i] > 0 then
        begin
         {  LoadArch(Pdati10^.prov,FileDisc[i]);}
           fillchar(stq^,sizeof(stq^),0);
           STR(TotAeiOpa[i]:8:2,TotH);
           {EspArray[i]:=format(EspArray[i],10);}
           Stq^.DescM:='IRRAGGIAMENTO SULLE SUPERFICI OPACHE '+ EspArray[i] +' Aei = '+TotH+' [mý]' ;
           case i of
             1:for j:=1 to MesiRisc do Stq^.Tot[j]:=(HbH^[indMese^[j]]+HdH^[indMese^[j]])*TotAeiOpa[i]*GiorMese(IndMese^[j]);
             2:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertSUD^[indMese^[j]]*TotAeiOpa[i]*GiorMese(IndMese^[j]);
             3:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertSOSE^[indMese^[j]]*TotAeiOpa[i]*GiorMese(IndMese^[j]);
             4:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertEO^[indMese^[j]]*TotAeiOpa[i]*GiorMese(IndMese^[j]);
             5:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertNONE^[indMese^[j]]*TotAeiOpa[i]*GiorMese(IndMese^[j]);
             6:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertN^[indMese^[j]]*TotAeiOpa[i]*GiorMese(IndMese^[j]);
           end;

           for j:=1 to MesiRisc do TotQse^[indMese^[j]]:=TotQse^[indMese^[j]]+Stq^.Tot[j];
           case i of
           1:Prefisso:='OR';
           2:Prefisso:='VS';
           3:Prefisso:='VSOSE';
           4:Prefisso:='VEO';
           5:Prefisso:='VNONE';
           6:Prefisso:='VN';
           end;

           // Stampa della tabella RIEPILOGO DATI DI IRRAGGIAMENTO DELLE SUPERFICI OPACHE

           for j:=1 to mesirisc_st do W_MesiL10_real(j,'IRR'+prefisso,Stq^.Tot[j],0, indMese^[j], MesiRisc_St);

           // Stampa della tabella RIEPILOGO SUPERFICI TRASPARENTI OPACHE
           W_reale('SUP'+Prefisso,TotAeiOpa[i],2);

        end;
    end;
 (*  for i:=1 to NEsposizioni do
    begin
       if TotAeiOpaIncl^[i] > 0 then
        begin
           fillchar(stq,sizeof(stq),0);
           STR(TotAeiOpaIncl^[i]:8:2,TotH);
           Stq.DescM:='IRRAGGIAMENTO SULLA SUPERFICE OPACA '+esposizioni_d^[i].denom+' Aei = '+TotH+' [mý]' ;
           for j:=1 to MesiRisc do
            begin
               CalcHtilt(indMese^[j],HdH^[indMese^[j]],HbH^[indMese^[j]],Prog^.LatCom,
                         esposizioni_d^[i].inclin,esposizioni_d^[i].Orient,HTilt);
               Stq.Tot[j]:=HTilt*TotAeiOpaIncl^[i]*GiorMese(IndMese^[j]);
            end;
           for j:=1 to MesiRisc do TotQse^[indMese^[j]]:=TotQse^[indMese^[j]]+Stq.Tot[j];
           if stampe_word then writetesto('inirrad.prn');
           StampaMask(Longint(@Stq),Ofs(StQ),'Totirrad.prn',true);
           Pag:=Pag+Lm;
        end;
    end;*)
    fillchar(stq^,sizeof(stq^),0);
    Stq^.DescM:=' [Qse] TOTALE IRRAGGIAMENTO SULLE SUPERFICI OPACHE  ';
    for j:=1 to MesiRisc do Stq^.Tot[j]:=TotQse^[indMese^[j]];
end;

procedure IrraggTrasp;
var i,j:smallint;
    TotH:STRING[20];
    HTilt:real;
    Prefisso:string;
begin

   for i:=1 to MEsp do
    begin
       if TotAeiTrasp[i] > 0 then
        begin
           fillchar(stq^,sizeof(stq^),0);
           STR(TotAeiTrasp[i]:8:2,TotH);
           Stq^.DescM:='IRRAGGIAMENTO SULLE SUPERFICI TRASPARENTI '+EspArray[i]+' Aei = '+TotH+' [mý]';
           case i of
             1:for j:=1 to MesiRisc do Stq^.Tot[j]:=(HbH^[indMese^[j]]+HdH^[indMese^[j]])*TotAeiTrasp[i]*GiorMese(IndMese^[j]);
             2:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertSUD^[indMese^[j]]*TotAeiTrasp[i]*GiorMese(IndMese^[j]);
             3:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertSOSE^[indMese^[j]]*TotAeiTrasp[i]*GiorMese(IndMese^[j]);
             4:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertEO^[indMese^[j]]*TotAeiTrasp[i]*GiorMese(IndMese^[j]);
             5:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertNONE^[indMese^[j]]*TotAeiTrasp[i]*GiorMese(IndMese^[j]);
             6:for j:=1 to MesiRisc do Stq^.Tot[j]:=VertN^[indMese^[j]]*TotAeiTrasp[i]*GiorMese(IndMese^[j]);
           end;
           for j:=1 to MesiRisc do TotQsi^[indMese^[j]]:=TotQsi^[indMese^[j]]+Stq^.Tot[j];
           case i of
           1:Prefisso:='OR';
           2:Prefisso:='VS';
           3:Prefisso:='VSOSE';
           4:Prefisso:='VEO';
           5:Prefisso:='VNONE';
           6:Prefisso:='VN';
           end;
           // -----------------------------------------------------------
           // Stampa tabella
           // RIEPILOGO DATI DI IRRAGGIAMENTO DELLE SUPERFICI TRASPARENTI
           // -----------------------------------------------------------
           for j:=1 to mesirisc_st do W_MesiL10_real(j,'IRF'+prefisso,Stq^.Tot[j],0, indMese^[j], MesiRisc_St);

           // Stampa della tabella RIEPILOGO SUPERFICI TRASPARENTI IRRAGGIATE
           W_reale('SUPF'+Prefisso,TotAeiTrasp[i],2);

        end;
    end;

(*    for i:=1 to NEsposizioni do
    begin
       if TotAeiTraspIncl^[i] > 0 then
        begin
           fillchar(stq,sizeof(stq),0);
           STR(TotAeiTraspIncl^[i]:8:2,TotH);
           Stq.DescM:='IRRAGGIAMENTO SULLA SUPERFICE TRASPATENTI '+esposizioni_d^[i].denom+' Aei = '+TotH+' [mý]' ;
           for j:=1 to MesiRisc do
            begin
               CalcHtilt(indMese^[j],HdH^[indMese^[j]],HbH^[indMese^[j]],Prog^.LatCom,
                         esposizioni_d^[i].inclin,esposizioni_d^[i].Orient,HTilt);
               Stq.Tot[j]:=HTilt*TotAeiTraspIncl^[i]*GiorMese(IndMese^[j]);
            end;
           for j:=1 to MesiRisc do TotQsi^[indMese^[j]]:=TotQsi^[indMese^[j]]+Stq.Tot[j];
           if stampe_word then writetesto('inirrad.prn');
           StampaMask(Longint(@Stq),Ofs(StQ),'Totirrad.prn',true);
           Pag:=Pag+Lm;
        end;
    end;*)

    Stq^.DescM:=' [Qsi] TOTALE IRRAGGIAMENTO SULLE SUPERFICI TRASPARENTI  ';
    for j:=1 to MesiRisc do Stq^.Tot[j]:=TotQsi^[indMese^[j]];
    Stq^.DescM:=' TOTALE IRRAGGIAMENTO Qs   ';
    for j:=1 to MesiRisc do Stq^.Tot[j]:=TotQsi^[indMese^[j]]+TotQse^[indMese^[j]];
    TrovaMeseInsol; { trova il mese con maggiore insolazione}

    if MeseMagIns in [1..12] then
     TotQs:=TotQs+TotQsi^[MesemagIns]+TotQse^[MesemagIns];

end;

begin
  for i:=1 to 12 do
    if IndMese^[i] in[1..12] then
     begin
       DM^[i]:=Mese_Ita[IndMese^[i]];
       MesiRisc:=i;
     end
   else DM^[i]:='';

   TrovaMeseInsol;  {cerca il mese con la massima insolazione}

{   for i:=1 to 12 do
    begin
       TotQse^[i] :=0;
       TotQsi^[i] :=0;
    end;}
   IrraggOpache;
   IrraggTrasp;
end;

end.

