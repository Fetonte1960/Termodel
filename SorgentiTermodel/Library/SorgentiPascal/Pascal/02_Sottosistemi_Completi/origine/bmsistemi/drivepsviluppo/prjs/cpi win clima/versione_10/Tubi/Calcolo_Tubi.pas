unit Calcolo_Tubi;
interface

uses  SysUtils, Math, Dialogs,
     {Uses definite per tubi}
      iotubi, definiz,varcarichi ,equil, uti_calc,
      uutigen, Libreriagenerale, UdataLink, Uleggitxt;

Var   Contr:boolean;

Function calcoli:boolean;
Function Perdita_Tubo(diametro,portata:real):real;

var  valvsce:boolean=false;
     cod_valvoletaratura:string='';
implementation
{$Ifdef Versione_14}
uses mess_reti;
  {$else}
uses UMain_calcTubi;
  {$endif}

var portsce, equilsce,tubiok: boolean;


{***************************  LOADlink  ******************************}

Procedure LoadLink(Nome:String);
var i:integer;
begin
  if (exsot) {and (rit=2)} then
  begin
    assign(FGTemp,nome+'.lnk');
    try
      reset(FGTemp);
      i:=0;
      while not eof(FGTemp) do
      begin
        i:=i+1;
        if FGTB^[i]=nil then new(FGTB^[i]);
        read(FGTemp,FGTB^[i]^);
      end;
      close(FGTemp);
      NLink:=i;
    except
      close(FGTemp);
    end;
  end;
end;

{***************************  Savelink  ******************************}
Procedure Savelink(Nome:String);
Var i:integer;
begin
//if fgtb^[1]=nil then new(fgtb^[1]);
//exit;
  if (exsot) {and (rit=2)} then
  begin

    if wr then
    Writeln(lst,'SaveLink :',Manrip);

    assign(FGTemp,nome+'.lnk');
    try              
      rewrite(FGTemp);
      for i:=1 to NLink Do
      begin
      write(FGTemp,FGTB^[i]^);
      {dispose(FGTB^[i]);
      FGTB^[i]:=nil;}
      end;
      close(FGTemp);
    except
      close(FGTemp);
    end;
  end;
End;

{***************************  CercaInd  ******************************}

Function CercaInd(Ind:integer):integer;
Var i:integer;
    c:boolean;
Begin

  if wr then
  Writeln(lst,'Cercaind :',Manrip);
  i:=1;
  if manrip then
  While (Not(Ind=Fgtb^[i]^.IndM)) and (i<NLink) Do i:=i+1
  else
  While (Not(Ind=Fgtb^[i]^.IndR)) and (i<NLink) Do i:=i+1;

  CercaInd:=i;
{  writeln(lst,manrip,' CERCAIND    term=',ind,'  indm=',fgtb^[i].indm,'   indr=',fgtb^[i].indr);    }



End;

{***************************  ISot  ******************************}

Function Isot:integer;

Begin
  if wr then
  Writeln(lst,'Indsot :',Manrip);   {  Indsot : }

  if Manrip then Isot:=1 else Isot:=2;

End;

{***************************  Scaricaterm ******************************}

procedure ScaricaTerm(nome:string);

var i,j,k,im,inds,l:integer;
begin
exit;
  im:=0;
  if wr then
  Writeln(lst,'Scarica: ',Manrip);
  for i:=1 to ntronchi do
  begin
    if dati^[i]^.ti<>0 then
    begin
      if dati^[i]^.pros[1]=0 then
      begin
        if dati^[i]^.term <>0  then
        begin
          j:=dati^[i]^.ti;
          while dis^[j]^.nlinea<>0 do j:=dis^[j]^.nlinea;
          IM:=IM+1;
          NEW(FGTB^[IM]);
          if not(piantubi) then
          begin
            dis^[j]^.z1:=0;
            dis^[j]^.z2:=0;
            FGTB^[im]^.x:=dis^[j]^.x1;
            FGTB^[im]^.y:=dis^[j]^.y1;
            FGTB^[im]^.z:=dis^[j]^.z1;
          end
          else
          begin
             {numeracci sulla portata nuccio 1-10-96 }

            {FGTB^[im]^.x:=dis^[j]^.x2;
            FGTB^[im]^.y:=dis^[j]^.y2;
            FGTB^[im]^.z:=dis^[j]^.z2;}

            inds:=0;
            for L:=1 to ultriga do
            if dis^[L]^.entita<>'' then
            if dis^[L]^.entita[1]='T' then
            if dis^[L]^.tronco=dati^[i]^.term then
            inds:=L;

            FGTB^[im]^.x:=dis^[inds]^.x1;
            FGTB^[im]^.y:=dis^[inds]^.y1;
            FGTB^[im]^.z:=dis^[inds]^.z1;
          end;
          FGTB^[im]^.IndM:=dati^[i]^.term;
          FGTB^[im]^.Termin:=GTerm^[dati^[i]^.term]^;
{         writeln(lst,manrip,'  SCARICATERM   term= ',dati^[i].term,'   indm=',fgtb^[im].indm);  }
        end;
      end;
    end;
  end;
  Nlink:=im;
end;

{***************************  Caricaterm  ******************************}
procedure CaricaTerm(nome:string);

var i,j,k,indmin:integer;
    Dmin,DTemp:real;
begin
exit;
  for i:=1 to ultTronco do Dati^[i]^.pp:=0;


  NGterm:=1;
  GTerm^[1]^.Cod:='';
  if wr then
  Writeln(lst,' Carica:',Manrip);
  For k:=1 to NLink do
  begin
    DTemp:=10E6;
    for i := 1 to ntronchi do
    if dati^[i]^.ti<>0 then
    if dati^[i]^.pros[1]=0 then
    if (dati^[i]^.term<>0) or (not(piantubi)) then
    begin
      j:=dati^[i]^.ti;
      while dis^[j]^.nlinea<>0 do j:=dis^[j]^.nlinea;
      if not(piantubi) then
      begin
        dis^[j]^.z1:=0;
        dis^[j]^.z2:=0;
      end;
      Dmin:=sqrt(SQR(FGTB^[k]^.x - dis^[j]^.x2) + SQR(FGTB^[k]^.y - dis^[j]^.y2) + SQR(FGTB^[k]^.z - dis^[j]^.z2));
{      Dmin:=sqrt(SQR(FGTB^[k].x - dis^[j].x2) + SQR(FGTB^[k].y - dis^[j].y2));
writeln(lst,'dmin=',dmin:5:2,' z=',fgtb^[k].z:5:2,' z2=',dis^[j].z2:5:2);}
      if Dmin < DTemp then
      begin
        indmin:=i;
        DTemp:=Dmin;
      end;
    end;
    GTerm^[NGTerm]^:=FGTB^[k]^.termin;
    dati^[indmin]^.term:=NGTerm;
        FGTB^[k]^.IndR:=dati^[indmin]^.term;;

        {controllo doppioni nuccio 1-10-96}

    if dati^[indmin]^.pp<>0
    then writeln('in ripresa tronco:',indmin,' gia puntato');
    dati^[indmin]^.pp:=999;

    ngterm:=ngterm+1;
{    writeln(lst,manrip,'   CARICATERM   term=',dati^[indmin].term,'   indr=',fgtb^[k].indr,'   indm=',fgtb^[k].indm);}
  end;
  UltGTerm:=NGTerm-1;
end;


{************************** LOADVaLV   ***************************************}

procedure LoadValv(nome:string);
var i:integer;
    j:integer;
    f:file of elvalv;
begin
{
   if exist(nome)then
   begin
     assign(f,nome);
     try
       reset(f);
       read(f,valv_D^);
       close(f);
     except
       close(f);
     end;
   end
   else
 }
   for i:=1 to NPerditeConc do
    with valv_D^[i] do
     begin
        Cod  :=PerdConc_D^[i].Cod;
        dmin :=0;
        dmax :=0;
        for j:=1 to PerdConc_D[i].NDPerdC do
          begin
          if round(PerdConc_D^[i].DPerdC[j].PCgiri)=PerdConc_D^[i].DPerdC[j].PCgiri then
          tacche[j].cod:=float_to_str(PerdConc_D^[i].DPerdC[j].PCgiri,0)
          else tacche[j].cod:=float_to_str(PerdConc_D^[i].DPerdC[j].PCgiri,2);
          tacche[j].kv1:=PerdConc_D^[i].DPerdC[j].PCKV;
          tacche[j].kv2:=0;
          tacche[j].kv3:=0;
          end;
     end;
end;

{************************** LOADDIS*****************************************}

Procedure LoadDis(nomedis:string);

var i:integer;
    estens:string;

begin
exit;
if wr then
Writeln(lst,'Loaddis:',Nomedis,'  ',Manrip);
if ManRip then estens := '.ret' else estens := '.rea';
Ultriga:=1;
  if exist(nomedis+Estens) then
  begin
    i:=1;
    assign(f_i,nomedis+Estens);
    try
      reset(f_i);
      while not(eof(f_i)) and (i<=lungdis) do
      begin
        if dis^[i]=nil then new(dis^[i]);
        read(f_i,dis^[i]^);
        i:=i+1;
      end;

      UltRiga:=i-1;
      close(f_i);
    except
      close(f_i);
    end;
  end
  else
  begin
   Ultriga:=1;
   new(dis^[Ultriga]);
   dis^[Ultriga]^.entita:='';
  end;

Nrighe:=Ultriga;
if ManRip then estens := '.dtr' else estens := '.dta';
UltTronco:=1;
if exist(nomedis+estens) then
  begin
  i:=1;
  assign(fr,nomedis+estens);
  try
    reset(fr);
    while not(eof(fr)) and (i<=lungDati) do
      begin
        if Dati^[i]=nil then new(dati^[i]);
        read(fr,dati^[i]^);
        i:=i+1;
      end;
      UltTronco:=i-1;
      close(fr);
  except
      close(fr);
  end;
end
else
begin
 Ulttronco:=1;
 new(dati^[UltTronco]);
 dati^[UltTronco]^.Ti:=0;
end;

Ntronchi:=ultTronco;


if ManRip then estens := '.tpn' else estens := '.tpa';
if exist(nomedis+estens) then
begin
  i:=1;
  Assign(fr1,nomedis+estens);
  Try
    reset(fr1);
    while not(eof(fr1)) and (i<=lungDati) do
    begin
      if Dati2^[i]=nil then new(dati2^[i]);
      read(fr1,dati2^[i]^);
      i:=i+1;
    end;
    close(fr1);
  except
    close(fr1);
  end;
end;


if ManRip then estens := '.ter' else estens := '.tea';
  UltGTerm:=1;
  if exist(nomedis+estens) then
  begin
    i:=1;
    assign(fGT,nomedis+estens);
    try
      reset(fgt);
      while not(eof(fgt)) and (i<=MaxGTErm) do
      begin
        if Gterm^[i]=nil then new(Gterm^[i]);
        read(fgt,GTerm^[i]^);
        i:=i+1;
      end;
      UltGTerm:=i-1;
      close(fgt);
    except
      close(fgt);
    end;
  end
  else
  begin
    UltGTerm:=1;
    new(GTerm^[UltGTerm]);
    GTerm^[UltGTerm]^.Cod:='';
  end;

  NGTerm:=ultGTerm;

if ManRip then estens := '.ris' else estens := '.ria';

if exist(nomedis+estens) then
   begin
   assign(frisult,nomedis+estens);
    try
     reset(frisult);
     read(frisult,RisultCalc^);
     close(FRisult);
    except
     close(FRisult);
    end;
   end;

nomep:=nomedis;
nomep:=setleft(setright(nomep));
if ManRip then estens := '.quo' else estens := '.qua';
if exist(nomedis+estens) then piantubi:=true else piantubi:=false;
end;

{************************** SAVEDIS*****************************************}

Procedure SaveDis(Nome:string);
var i:integer;
    estens:string;
begin
exit;
if wr then
Writeln(lst,'Savedis: ',Nome,'  ',Manrip);

if ManRip then estens:= '.dtr' else estens:= '.dta';
 assign(fr,nome+estens);rewrite(fr);
 for i:=1 to ulttronco do
 begin
   write(fr,dati^[i]^);
 end;
 close(fr);


  if ManRip then estens:= '.tpn' else estens:= '.tpa';
  assign(fr1,nome+estens);rewrite(fr1);
  for i:=1 to ulttronco do
  begin
    IF DATI2^[I]=NIL THEN NEW(DATI2^[I]);
    dati2^[i]^.x      :=dati^[i]^.x;
    dati2^[i]^.ti     :=dati^[i]^.ti;
    dati2^[i]^.y      :=dati^[i]^.y;
    dati2^[i]^.num    :=dati^[i]^.num;
    dati2^[i]^.coddiam:=dati^[i]^.coddiam;
    dati2^[i]^.lungh  :=dati^[i]^.lungh;

    write(fr1,dati2^[i]^);
    {
    dispose(dati^[i]);
    dati^[i]:=nil;
    dispose(dati2^[i]);
    dati2^[i]:=nil;
    dispose(dis^[i]);
    dis^[i]:=nil;
    }
  end;
  close(fr1);

if ManRip then estens:= '.ter' else estens:= '.tea';

{estens:='.ter';}

 assign(fgt,nome+estens);rewrite(fgt);
 for i:=1 to ultgterm do
 begin
   write(fgt,GTerm^[i]^);
   {dispose(GTerm^[i]);
   GTerm^[i]:=nil;}
 end;
 close(fgt);

{ assign(fconf,Nome+'.con');
 rewrite(fconf);
 write(fconf,conf);
 Close(fconf);}

if ManRip then estens:= '.ris' else estens:= '.ria';
 assign(fRisult,nome+estens);
 rewrite(fRisult);
 write(fRisult,RisultCalc^);
 close(fRisult);

nomep:=nome;
nomep:=setleft(setright(nomep));


end;
{*********************************  Car sanit  ***************************}
Procedure Carsanit;
const
el_unita3:TEl_Unita=
((0,0),
(6,0.3),
(8,0.4),
(10,0.5),
(12,0.6),
(14,0.67),
(16,0.75),
(18,0.82),
(20,0.89),
(25,1.05),
(30,1.18),
(35,1.35),
(40,1.45),
(50,1.65),
(60,1.90),
(70,2.10),
(80,2.25),
(90,2.45),
(100,2.60),
(120,2.90),
(140,3.20),
(160,3.50),
(180,3.75),
(200,3.95),
(225,4.25),
(250,4.50),
(275,4.80),
(300,5.05),
(400,6.00),
(500,6.90),
(600,7.55),
(700,8.30),
(800,8.80),
(900,9.50),
(1000,10.00),
(1250,11.30),
(1500,12.40),
(1750,13.60),
(2000,14.50),
(2250,15.40),
(2500,16.20),
(2750,17.00),
(3000,18.00),
(3500,19.50),
(4000,21.00),
(4500,22.00),
(5000,23.50),
(6000,25.50),
(7000,27.50),
(8000,29.00),
(9000,30.50),
(10000,32.00));

el_unita4:TEl_Unita=
((0,0),
(10,1.70),
(12,1.87),
(14,2.03),
(16,2.17),
(18,2.32),
(20,2.45),
(25,2.75),
(30,3.00),
(35,3.25),
(40,3.55),
(50,3.90),
(60,4.20),
(70,4.50),
(80,4.80),
(90,5.15),
(100,5.35),
(120,5.80),
(140,6.20),
(160,6.60),
(180,7.10),
(200,7.45),
(225,7.80),
(250,8.10),
(275,8.40),
(300,8.70),
(400,9.80),
(500,10.80),
(600,11.60),
(700,12.40),
(800,13.00),
(900,13.70),
(1000,14.20),
(1250,15.50),
(1500,16.50),
(1750,17.50),
(2000,18.50),
(2250,19.20),
(2500,20.00),
(2750,20.70),
(3000,21.40),
(3500,22.50),
(4000,24.00),
(4500,25.00),
(5000,26.00),
(6000,28.00),
(7000,29.00),
(8000,30.00),
(9000,31.50),
(10000,32.00),
(10001,32.1),
(10002,32.2));

el_unita1:TEl_Unita=
((0,0),
(10,0.50),
(12,0.60),
(14,0.68),
(16,0.78),
(18,0.85),
(20,0.93),
(25,1.13),
(30,1.30),
(35,1.46),
(40,1.62),
(50,1.90),
(60,2.20),
(70,2.40),
(80,2.65),
(90,2.90),
(100,3.15),
(120,3.65),
(140,3.90),
(160,4.25),
(180,4.60),
(200,4.95),
(225,5.35),
(250,5.75),
(275,6.10),
(300,6.45),
(400,7.80),
(500,9.00),
(600,10.00),
(700,11.00),
(800,11.90),
(900,12.90),
(1000,13.80),
(1250,15.50),
(1500,17.50),
(1750,18.80),
(2000,20.50),
(2250,22.00),
(2500,23.50),
(2750,24.50),
(3000,26.00),
(3500,28.00),
(4000,30.50),
(4500,32.50),
(5000,34.50),
(6000,38.00),
(7000,41.00),
(8000,44.00),
(9000,47.00),
(10000,50.00),
(10001,51),
(10002,52));

el_unita2:TEl_Unita=
((0,0),
(10,1.70),
(12,1.90),
(14,2.10),
(16,2.27),
(18,2.45),
(20,2.60),
(25,2.95),
(30,3.25),
(35,3.55),
(40,3.80),
(50,4.30),
(60,4.80),
(70,5.25),
(80,5.60),
(90,6.00),
(100,6.35),
(120,7.15),
(140,7.50),
(160,8.00),
(180,8.50),
(200,9.00),
(225,9.50),
(250,10.00),
(275,10.50),
(300,11.00),
(400,12.70),
(500,14.00),
(600,15.10),
(700,16.30),
(800,17.30),
(900,18.20),
(1000,19.00),
(1250,21.00),
(1500,23.00),
(1750,24.50),
(2000,26.00),
(2250,27.50),
(2500,28.50),
(2750,29.50),
(3000,30.50),
(3500,33.00),
(4000,35.00),
(4500,36.50),
(5000,37.50),
(6000,40.50),
(7000,44.00),
(8000,46.00),
(9000,48.00),
(10000,50.00),
(10001,51),
(10002,52));
begin
//New(el_unita);
  case tiposan of
  1:el_unita^:=el_unita1;
  2:el_unita^:=el_unita2;
  3:el_unita^:=el_unita3;
  4:el_unita^:=el_unita4;
  end
end;

{************************** U_Carico  **************************************}
Function U_carico(unita:real):real;
Var i:Integer;
begin
  i:=1;
  while (el_Unita^[i+1,1]<unita)and(i<=N_unita-2) do i:=i+1;
  if el_Unita^[i+1,1]<unita then
    begin
    U_carico:=0;
    {clrscr;}
    write('Unita di carico insufficienti');
    {repeat until keypressed;}
    HALT;
    end
  else U_carico:=el_unita^[i,2]+
              ((el_unita^[i+1,2]-el_unita^[i,2])/
              (el_unita^[i+1,1]-el_unita^[i,1]))*
              (unita-el_unita^[i,1]);
end;

{***************************  Portate        *******************************}

Procedure Portate;

var tr,indl:integer;
    port:real;

Function PortTronco(tr1:integer):real;

var i,k:integer;
    TotPort:real;


begin

if wr then
writeln(lst,' portate ',manrip);

TotPort:=0;

if Dati^[tr1]^.term<>0 then
begin
  if (peff1) and (not Manrip) then
  begin
    indl:=CercaInd(dati^[tr1]^.Term);
    GTerm^[Dati^[tr1]^.term]^.Port:=FGTB^[indl]^.port;
    Dati^[tr1]^.porteff:=FGTB^[indl]^.port;
  end;
  Totport:=GTerm^[Dati^[tr1]^.term]^.Port
end
else
begin
  i:=0;
  repeat
    i:=i+1;
    if dati^[tr1]^.pros[i]<>0 then TotPort:=TotPort+PortTronco(dati^[tr1]^.pros[i]);
  until (i=10)or(dati^[tr1]^.pros[i]=0);
end;
IF sanitario then
  begin
  PortTronco:=TotPort;
  dati^[tr1]^.porteff:=U_carico(TotPOrt);
  end
else
  begin
  if Dati^[tr1]^.Port<>0 then TotPort:=Dati^[tr1]^.Port;

  PortTronco:=TotPort;

  Dati^[tr1]^.PortEff:=TotPort;
  end;

end;

begin

if wr then
writeln(lst,'portate ',manrip);

RisultCalc^.portata:=PortTronco(RisultCalc^.Origine);
if reteprinc then
begin
  IF SANITARIO THEN RisultCalc^.portata:=U_carico(RisultCalc^.portata);
  str(RisultCalc^.portata:5:4,st_8);
  //writec(w_m(100)+st_8+w_m(101),14);   {  Portata totale:   /    l/s }
end;

end;


{***************************  Elev          *******************************}

Function Elev(a,b:real):real;
begin
elev:=exp(b*ln(a));
end;

{***************************  F0              *******************************}
Function F0(form:integer;D0,E1,V0,Ni,dens,Q0:real):real ;
var
    re,C0,C1,C2,F1:real;
{
form2:  F0=5.3740442/(8*dens#)*PI^2*D0^.1345*(ABS(VO)*PI*D0^2/4)^(-.148):F(j)=F0:RETURN
form3:  F0=9806.65*(.00328+.00084/D0)/(8*DENS#)*PI^2                    :F(j)=F0:RETURN
form4:  F0=9.6497436/(8*DENS#)*PI^2*D0^.22*(ABS(VO)*PI*D0^2/4)^(-.22)   :F(j)=F0:RETURN
form5:  F0=17.279317/(8*DENS#)*PI^2*D0^.28*(ABS(VO)*PI*D0^2/4)^(-.18)   :F(j)=F0:RETURN
form6:  F0=11.238421/(8*DENS#)*PI^2*D0^.19*(ABS(VO)*PI*D0^2/4)^(-.19)   :F(j)=F0:RETURN
form7:  F0=2*D0/VO^2/DENS#*87.1*1E+04*(1+91.44/(D0*1E+03)+.0018*(D0*1E+03))*(Q0*3600)^2/(D0*1E+03)^5*DENS#/1.25:F(j)=F0:RETURN
}
begin
  case form of
  1:begin              {-- Darcy e coeff. Colebruc --}
    re:=abs(V0*D0/NI);
    if re >2000 then
      begin
      F1:=0.0001;
        repeat
        C0:=E1/(D0*3.7)+2.51/(SQRT(F1)*RE);
        C1:=-2*ln(C0)/2.302585-1/SQRT(F1);
        C2:=C1/((1/2.302585*2.51/RE/C0+0.5)/elev(F1,1.5));
        if abs(C2)>0.0001 then F1:=F1-C2
        until abs(C2)<=0.0001;
      F0:=F1
      end
    else if (re<0.1) then F0:=640 else F0:=64/re;
    end;
  2:F0:=5.3740442/(8*dens)*sqr(PI)*elev(D0,0.1345)*
             elev((ABS(V0)*PI*sqr(D0)/4),(-0.148));
  3:F0:=9806.65*(0.00328+0.00084/D0)/(8*DENS)*sqr(PI);
  4:F0:=9.6497436/(8*DENS)*sqr(PI)*elev(D0,0.22)*
              elev(ABS(V0)*PI*sqr(D0)/4,(-0.22));
  5:F0:=17.279317/(8*DENS)*sqr(PI)*elev(D0,0.28)*
            elev((ABS(V0)*PI*sqr(D0)/4),(-0.18));
  6:F0:=11.238421/(8*DENS)*sqr(PI)*elev(D0,0.19)*
           elev((ABS(V0)*PI*sqr(D0)/4),(-0.19));
  7:F0:=2*D0/sqr(V0)/DENS*87.1*1E+04*(1+91.44/(D0*1E+03)+0.0018*(D0*1E+03))*
                                sqr(Q0*3600)/elev((D0*1E+03),5)*DENS/1.25;
  end;
end;

{$I Perdconc.pas}

Function Perdita_Tubo(diametro,portata:real):real;
Var velocita:real;
const dens=973.0719;
begin
Diametro:=diametro/1000;
Portata :=portata/1000;
Velocita:=4*Portata/(PI*sqr(diametro));

result:=F0({Tubaz_D^[i].sez[j].Form}1  ,
            Diametro                 ,
            {Tubaz_D^[i].Rug}0.0015/1000     ,
            Velocita                 ,
            {FluM_D^.Visc}0.000924/{FluM_D^.Dens}dens,
            {FluM_D^.Dens}dens             ,
            Portata                   )*
            sqr(Velocita)*{FluM_D^.dens}dens/(2*Diametro);

end;

{***************************  dimensiona     *******************************}
Procedure dimensiona;
var tr,k   :integer;
    TotPerd:real;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  DimensTronco   *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
Function DimensTronco(tr1:integer;perdprec,portprec:real;var Sfavorito:integer):real;

var i,k:integer;
    TotPerd    :real;
    PerditeSfav:real;
    PerdRamo   :real;
    SfavRamo   :integer;
    RifPres    :real;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Dimens         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function Dimens(TR:integer):real;

var i,j,k:integer;
    Diametro,Portata,Velocita,Perdita:real;  {-- Espresse in SI --}
    MaxPerd  :real;
    Trovato  :boolean;
    tipoperd :integer;
    indl     :integer;
    max_sez  :integer;
    Port_colle:real;


function corpocolle(tt:integer):boolean;
begin
result:=false;
if dati^[tt]^.Ti<>0 then
result:=(dis^[dati^[tt]^.Ti].coll)and(dati^[tt]^.pros[1]<>0);
end;
function velcolle:real;
begin
if Generalita_D^.maxvelColl=0 then
result:=0.5
else result:=Generalita_D^.maxvelColl;
end;
procedure iterfissacolle(tt:integer;diam:string;primo:boolean);
var i:integer;
begin
if corpocolle(tt) then
  begin
  if not primo then
    begin
    dati^[tt]^.SWDiam:='*';
    dati^[tt]^.Coddiam:=diam;
    end;
  i:=0;
    repeat
    inc(i);
    if  dati^[tt]^.pros[i]<>0 then  iterfissacolle(dati^[tt]^.pros[i],diam,false);
    until (i=6)or(dati^[tt]^.pros[i]=0);
  end;
end;
begin

{if wr then
Writeln(lst,'Dimens ',manrip);     }

with dati^[tr]^ do

begin
if codicetubo=1 then
indl:=CercaInd(Term);
  i:=0;
  Pd:=0;
  Pl:=0;
  Pp:=0;



if term<>0 then
begin
  indl:=CercaInd(Term);
  if manrip then
  begin
    FGTB^[indl]^.swdiam:=swdiam;
    FGTB^[indl]^.CodDiam:=CodDiam;
    FGTB^[indl]^.Diam:=Diam;
  end
  else
  begin
    swdiam:=FGTB^[indl]^.swdiam;
    Diam:=FGTB^[indl]^.Diam;
    CodDiam:=FGTB^[indl]^.CodDiam;
  end;
end;



repeat
i:=i+1;
//until (Upstring(tipo)=Upstring(Tubaz_D^[i].Cod))or(i=Maxtubaz);
until (Upstring(tipo)=Upstring(Tubaz_D^[i].Cod))or(i=Ntubaz);

max_sez:=Tubaz_D^[i].NSez;

//if (i=maxtubaz)and(Upstring(tipo)<>Upstring(Tubaz_D^[i].Cod)) then
if (i=Ntubaz)and(Upstring(tipo)<>Upstring(Tubaz_D^[i].Cod)) then
writec(w_m(103)+Tipo+w_m(29),20);   {Tipo tubazione / non trovata}

if (SWDiam='*')or(Verifica) then    {-- Diametro bloccato --}
begin

  j:=0;
  repeat
    j:=j+1;
  until (Upstring(CodDiam)=Upstring(Tubaz_D^[i].Sez[j].Dnom))or
                                                      (j=Max_Sez);



  if (J=max_sez)and(Upstring(CodDiam)<>Upstring(Tubaz_D^[i].Sez[j].DNom))

  then
    writec(w_m(40)+CodDiam+w_m(105),20)    { Diametro tubazione / non trovato }
    else
    begin
    Diametro:=Tubaz_D^[i].sez[j].Dint/1000;
    Portata :=Dati^[tr]^.porteff/1000;
    Velocita:=4*Portata/(PI*sqr(diametro));
    Perdita:=F0(Tubaz_D^[i].sez[j].Form  ,
              Diametro                 ,
              Tubaz_D^[i].Rug/1000     ,
              Velocita                 ,
              FluM_D^.Visc/FluM_D^.Dens,
              FluM_D^.Dens             ,
              Portata                   )*
              sqr(Velocita)*FluM_D^.dens/(2*Diametro);
    end;
end
else                 {-- Calcolo Diametro --}
begin
  j:=0;
  Trovato:=false;
  Perdita:=0;
  MaxPerd:=Generalita_D^.DPS;
  if Tubaz_D^[i].sez[j+1].Dint =0 then inc(j); //pezza per progetto olivieri manca una riga in archivio 
  repeat
    if Tubaz_D^[i].sez[j+1].Dint >0 then
    begin
      j:=J+1;
      Diametro:=Tubaz_D^[i].sez[j].Dint/1000;
      if corpocolle(tr) then
      Portata :=portprec/1000
      else Portata :=Dati^[tr]^.porteff/1000;
      if diametro <> 0 then
         Velocita:=4*Portata/(PI*sqr(diametro))
      else Velocita := 0;
      if ((velocita <= Generalita_D^.Maxvels)and(not corpocolle(tr)))or((velocita <= velcolle)and(corpocolle(tr))) then
      begin
        Perdita:=F0(Tubaz_D^[i].sez[j].Form  ,
                  Diametro                 ,
                  Tubaz_D^[i].Rug/1000     ,
                  Velocita                 ,
                  FluM_D^.Visc/FluM_D^.Dens,
                  FluM_D^.Dens             ,
                  Portata                    )*
                  sqr(Velocita)*FluM_D^.dens/(2*Diametro);
        if perdita<=MaxPerd then trovato:=true;
      end;
    end
    //else Trovato:=true;
  Until (j=Max_Sez)or(Trovato);
  if trovato then  CodDiam:=Tubaz_D^[i].sez[j].DNom
  else
    begin
    dati^[tr]^.CodDiam :='!!! '+ Tubaz_D^[i].sez[j].DNom;
    tubiOk:=false;
    end;
end;

Pl:=0;

diam:=Tubaz_D^[i].sez[j].Dint;
if corpocolle(tr) then iterfissacolle(tr,dati^[tr]^.CodDiam,false);

for k:=1 to 5 do
if (Pconc[k].cod<>'')and(Pconc[k].N<>0) then
  if not isZero(velocita) then
     pl := pl + RoundTo(PerdConc(Pconc[k].cod,velocita,perdita,diam,tipoperd)*(Pconc[k].N), -4);
//pl := pl/1E3;
pl := pl/1000;
if (not(upcase(Generalita_D^.Ritorno[1])=cyes) and (rit=1)) then
    Pd:=Perdita*Lungh/1000+FluM_D^.dens*DH*9.81/1000
else Pd:=Perdita*Lungh/1000;


Dimens:=Pd+pl;

if (term<>0) and manrip then
begin
  if GTerm^[Term]^.Taratura<>'' then
  GTerm^[term]^.Perd:=
  PerdConc(GTerm^[term]^.Taratura,velocita,perdita,diam,tipoperd)/(Divrit*1000);
end;
end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* end  Dimens     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}


var indl:integer;

begin

{if wr then
Writeln(lst,' DimensTronco ',manrip);        }
//if Dati^[tr1]^.codicetubo=1 then
//showmessage(float_to_str(Dati^[tr1]^.porteff,4));
if Dati^[tr1]^.porteff>0 then TotPerd:=Dimens(tr1)  {-- Perdite progressive --}
else TotPerd:=0;

Dati^[Tr1]^.pp:=TotPerd+PerdPrec;

i:=0;
PerditeSfav:=0;

if dati^[tr1]^.term=0 then
begin
  repeat
    i:=i+1;
    if dati^[tr1]^.pros[i]<>0 then
    begin
      PerdRamo:=DimensTronco(dati^[tr1]^.pros[i],TotPerd+PerdPrec,dati^[tr1]^.porteff,SfavRamo);

      if i=1 then RifPres:=PerdRamo {-- Calcolo portata effettiva --}
      else
      begin
        if ((manrip) and (abs(RifPres-PerdRamo) > Generalita_D^.Tolleranza)) then converge:=false;
{       writeln(lst,'rifpres=',rifpres:5:3,'Perdramo=',perdramo:5:3,manrip);}
      end;
      if PerdRamo>Perditesfav then
      begin
        PerditeSfav:=PerdRamo;
        Sfavorito  :=SfavRamo;
      end;

{     dati^[dati^[tr1].pros[i]].pr:=Perdramo;
      dati^[dati^[tr1].pros[i]].pr:=dati^[dati^[tr1].pros[i]].pd+dati^[dati^[tr1].pros[i]].pl+perditesfav;
      writeln(lst,'i=',i,' tr1=',tr1,'  dati^[dati^[tr1].pros[i]].pr:=',dati^[tr1].pr:5:3);}

    end;
  until (i=6)or(dati^[tr1]^.pros[i]=0);
end
else
begin
  sfavRamo:=tr1;
  Sfavorito:=tr1;

  if (not manrip) and (peff) then
  begin
   Indl:=cercaind(dati^[tr1]^.term);
   FGTB^[indl]^.pp:=Dati^[Tr1]^.pp;
  end;

  if (peff) and (manrip) then
  begin
    indl:=cercaind(dati^[tr1]^.term);
    PerditeSfav:=GTerm^[dati^[tr1]^.term]^.perd+FGTB^[indl]^.pp;
  end
  else PerditeSfav:=GTerm^[dati^[tr1]^.term]^.perd;
{  if not manrip then Perditesfav:=0;}
  if (reteprinc)and(GTerm^[dati^[tr1]^.term]^.NumTer<>0) then
     DatiSot^[GTerm^[dati^[tr1]^.term]^.NumTer,isot].sbil:=Dati^[tr1]^.pp;
end;

ToTPerd:=TotPerd+PerditeSfav;
dati^[tr1]^.pr:=TotPerd;
DimensTronco:=TotPerd;

end;



{*-*-*-*-*-*-*-*-*-*-*-*-*-*       Main      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

begin

{if wr then
Writeln(lst,' Dimensiona ',manrip); }

RisultCalc^.Sfavor:=0;//diego 28 08 2011
RisultCalc^.perdita:=DimensTronco(RisultCalc^.Origine,0,0,RisultCalc^.Sfavor);

if reteprinc then
begin
  PerditaTotale:=RisultCalc^.perdita;
  {gotoxy(1,15);}
{  write(w_m(108),RisultCalc^.perdita*divrit:5:3,w_m(109)+ '   '); }   {    Prevalenza alla pompa:  /Kpa }
{  gotoxy(1,16);write(w_m(110));}    {    Percorso piu` sfavorito ==> }
  if princsfavor=0 then
  begin

    princsfavor:=RisultCalc^.Sfavor;

    // Emanuela 8/2/2004 verificato se c'è qualche valore uguale a nil
    if Dati^[princSfavor] <> nil then
    begin
      if GTerm^[Dati^[princSfavor]^.Term]^.NumTer<>0 then
      begin
        sottosfavor:=DatiSot^[GTerm^[Dati^[PrincSfavor]^.Term]^.NumTer,isot].Sfavor;
        nsottosfavor:=GTerm^[Dati^[PrincSfavor]^.Term]^.NumTer;
      end;
    end;
  end;
  (*if (manrip) and(rit=1) or (not manrip) and(rit=2)  then
  begin

    if GTerm^[Dati^[PrincSfavor].Term].NumTer=0 then
    begin
      write(w_m(111),Dati^[PrincSfavor].num) ;      {rete principale ,tronco Nø: }
    end
    else
    write(elsot[GTerm^[Dati^[PrincSfavor].Term].NumTer]);
  end;*)

end;
end;



{*************************  EQUILIBRATURA  *******************************}

Procedure Equilibratura;

var tr     :integer;
    TotPerd:real;
    xsbil,xsbilmin:real;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*     Equilibra     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function Equilibra(TR:integer;deltap:real):real;

var i,j,k,l:integer;
    Diametro,Portata,Velocita,Perdita:real;  {-- Espresse in SI --}
    MaxPerd  :real;
    Trovato  :boolean;
    TipoPerd :integer;
    PerdTerm :real;
    Pd1      :real;
    pl1      :real;
    deltap1  :real;
    DpTotI   :real;
    DpTotF   :real;
    SbilRes  :real;
    indl,max_sez:integer;
begin

  Equilibra:=Deltap;

  if (dati^[tr]^.term <> 0) and
     ((not reteprinc)or(GTerm^[dati^[tr]^.term]^.NumTer=0)) then
  begin
    indl:=CercaInd(dati^[tr]^.Term);
    if manrip then
    begin
      FGTB^[indl]^.swdiam:=dati^[tr]^.swdiam;

      if rit=2 then
      begin
        DpTotI:=Dati^[tr]^.pd+Dati^[tr]^.pl+GTerm^[dati^[tr]^.term]^.Perd
                +FGTB^[indl]^.pd+FGTB^[indl]^.pl;
      end;

      if rit=1 then
      begin
        DpTotI:=Dati^[tr]^.pd+Dati^[tr]^.pl+GTerm^[dati^[tr]^.term]^.Perd;
      end;

    end
    else
    begin

      DpTotI:=Dati^[tr]^.pd+Dati^[tr]^.pl;
      dati^[tr]^.swdiam:=FGTB^[indl]^.swdiam;
    end;
  end
  else DpTotI:=Dati^[tr]^.pd+Dati^[tr]^.pl;


  deltap1:=0;
  pd1:=0;
  pl1:=0;


  with dati^[tr]^ do

  if swdiam<>'*' then

  begin

                        { Ricerca Codice diametro }
    i:=0;
    repeat
      i:=i+1;
    //until (Upstring(tipo)=Upstring(Tubaz_D^[i].Cod))or(i=Maxtubaz);
    until (Upstring(tipo)=Upstring(Tubaz_D^[i].Cod))or(i=Ntubaz);
    //if (i=maxtubaz)and(Upstring(tipo)<>Upstring(Tubaz_D^[i].Cod)) then
    max_sez:= Tubaz_D^[i].nsez;
    //if (i=Ntubaz)and(Upstring(tipo)<>Upstring(Tubaz_D^[i].Cod)) then
    //writec(w_m(103)+Tipo+w_m(29),20);    { Tipo tubazione /   non trovata }

    {Caso di un ramo non terminale in ripresa o ramo qualunque in mandata}

    if (term=0)or(manrip) or
       ((reteprinc)and(GTerm^[term]^.NumTer<>0)) then

{    if (term=0)or(manrip) then}
    begin




{       writeln(lst,'term=',term,'  reteprinc=',reteprinc,'  manrip=',manrip);
       writeln(lst,'Numter=',GTerm^[term].NumTer);}





                    {-- Calcolo Diametro --}
      j:=0;
      Trovato:=false;
      Perdita:=0;
      MaxPerd:=Generalita_D^.DPE;


      repeat
        if Tubaz_D^[i].sez[j+1].Dint>0 then
        begin
          j:=j+1;
          Diametro:=Tubaz_D^[i].sez[j].Dint/1000;
          Portata :=Dati^[tr]^.porteff/1000;
          Velocita:=4*Portata/(PI*sqr(diametro));
          if velocita <= Generalita_D^.Maxvele then
          begin
            Perdita:=F0(Tubaz_D^[i].sez[j].Form  ,
                      Diametro                 ,
                      Tubaz_D^[i].Rug/1000     ,
                      Velocita                 ,
                      FluM_D^.Visc/FluM_D^.Dens,
                      FluM_D^.Dens             ,
                      Portata                   )*
                      sqr(Velocita)*FluM_D^.dens/(2*Diametro);


            if (perdita<=MaxPerd) then trovato:=true;



            if (Trovato) then
            begin

              pl:=0;


              for k:=1 to 5 do
              if (Pconc[k].cod<>'')and(Pconc[k].N<>0) then
              Pl:=pl+PerdConc(Pconc[k].cod,velocita,perdita,diam,tipoperd)*(Pconc[k].N);
              pl:=pl/1000;
              if (not(upcase(Generalita_D^.Ritorno[1])=cyes) and (rit=1)) then
              Pd:=Perdita*Lungh/1000+FluM_D^.dens*DH*9.81/1000
              else Pd:=Perdita*Lungh/1000;

              PerdTerm:=0;
              pd1:=0;
              pl1:=0;


              if (term<>0) and
                 ((not reteprinc)or(GTerm^[term]^.NumTer=0))then
              begin
                if rit=2 then
                begin

                  pd1:=Perdita*FGTB^[indl]^.lungh/1000;

                  for l:=1 to 5 do
                  begin
                    if (FGTB^[indl]^.Pconc[l].cod<>'')and(FGTB^[indl]^.Pconc[l].N<>0) then
                    Pl1:=pl1+PerdConc(FGTB^[indl]^.Pconc[l].cod,velocita,perdita,diam,tipoperd)*(FGTB^[indl]^.Pconc[l].N);


{if (indl=12) or (indl=13) then writeln(lst,'indl=',indl,'  sbil=',GTerm^[term].sbil) else
writeln(lst,'indl=',indl,'  N=',FGTB^[indl].Pconc[l].N,'  Cod=',FGTB^[indl].Pconc[l].Cod);}




                  end;
                  pl1:=pl1/1000;
                end;
                if (not reteprinc)or(GTerm^[term]^.NumTer=0)  then
                begin
                  if (GTerm^[term]^.Taratura<>'') then
                  begin
                    GTerm^[term]^.Perd:=
                    PerdConc(GTerm^[term]^.Taratura,velocita,perdita,diam,tipoperd)/(Divrit*1E3);
                  end;
                  PerdTerm:=GTerm^[term]^.Perd;
                end;
              end;


              deltap1:=pd1+pl1;

            {pd1:=pd+pd1;
              pl1:=pl+pl1;}

              DpTotF:=pd+pl+pd1+pl1+Perdterm;


            {if (pd1+pl1+PerdTerm)>(Deltap+deltap1) then Trovato:=false;}

              SbilRes:=Deltap-DpTotF+DptotI;


              if SbilRes <=0 then trovato:=False;

            end;
          end;
        end
        else trovato:=true;
      Until (j=Max_Sez)or(Trovato)or(Tubaz_D^[i].sez[j+1].DNom='');

      Equilibra:=sbilres;

      CodDiam :=Tubaz_D^[i].sez[j].DNom;
      Diam    :=Tubaz_D^[i].sez[j].Dint;


    end

    else

    {caso di un terminale in ripresa}

    begin

      j:=1;
      while TuBaz_D^[i].Sez[j].Dint<>FGTB^[indl]^.Diam Do j:=j+1;

      Diametro:=FGTB^[indl]^.Diam/1000;
      Portata :=Dati^[tr]^.porteff/1000;
      Velocita:=4*Portata/(PI*sqr(diametro));

      Perdita:=F0(Tubaz_D^[i].sez[j].Form  ,
                  Diametro                 ,
                  Tubaz_D^[i].Rug/1000     ,
                  Velocita                 ,
                  FluM_D^.Visc/FluM_D^.Dens,
                  FluM_D^.Dens             ,
                  Portata                   )*
                  sqr(Velocita)*FluM_D^.dens/(2*Diametro);
      {pd:=0;
      pl:=0;}


      pl:=0;
      for k:=1 to 5 do
      if (Pconc[k].cod<>'')and(Pconc[k].N<>0) then
      Pl:=pl+PerdConc(Pconc[k].cod,velocita,perdita,diam,tipoperd)*(Pconc[k].N);
      pl:=pl/1E3;
      if (not(upcase(Generalita_D^.Ritorno[1])=cyes) and (rit=1)) then
      Pd:=Perdita*Lungh/1000+FluM_D^.dens*DH*9.81/1000
      else Pd:=Perdita*Lungh/1000;
      PerdTerm:=0;


      CodDiam:=FGTB^[indl]^.CodDiam;
      Diam:=FGTB^[indl]^.Diam;


      DpTotF:=pd+pl;
      SbilRes:=Deltap-DpTotF+DptotI;
      Equilibra:=sbilres;

    end;

    {Caso di un terminale con rete di mandata }


    if manrip and (term<>0) and
    ((not reteprinc)or(GTerm^[term]^.NumTer=0)) then

{    if manrip and (term<>0) then}
    begin

      FGTB^[indl]^.CodDiam:=Tubaz_D^[i].sez[j].DNom;
      FGTB^[indl]^.Diam   :=Tubaz_D^[i].sez[j].Dint;

{      CodDiam :=Tubaz_D^[i].sez[j].DNom;
       Diam    :=Tubaz_D^[i].sez[j].Dint;}

      if (not reteprinc)or(GTerm^[term]^.NumTer=0)  then
      begin
        if (GTerm^[term]^.Taratura<>'') then
        begin
          GTerm^[term]^.Perd:=
          PerdConc(GTerm^[term]^.Taratura,velocita,perdita,diam,tipoperd)/(Divrit*1000);
        end;
        PerdTerm:=GTerm^[term]^.Perd;
      end;
      deltap1:=pd1+pl1;


    end;
  end
  else
  begin


    if (dati^[tr]^.term<>0) and
      ((not reteprinc)or(GTerm^[dati^[tr]^.term]^.NumTer=0)) then

    {if (dati^[tr].term<>0) then}

    begin
      if manrip then
      begin
        FGTB^[indl]^.CodDiam:=dati^[tr]^.CodDiam;
        FGTB^[indl]^.Diam:=dati^[tr]^.Diam;
      end
      else
      begin
        dati^[tr]^.Diam:=FGTB^[indl]^.Diam;
        dati^[tr]^.CodDiam:=FGTB^[indl]^.CodDiam;
      end;
    end;
  end;
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  IterEquil       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function IterEquil(tr1:integer):real;

var

i,x            :integer;
PerdTerm :real;

SbilMin        :real;
Sbil           :real;

begin


  SbilMin := 10E6;
  Sbil    := 0;

  if dati^[tr1]^.term=0 then
  begin
    i:=0;
    repeat
      i:=i+1;
      if dati^[tr1]^.pros[i]<>0 then
      begin
        Sbil := IterEquil(dati^[tr1]^.pros[i]);
        if (Sbil < SbilMin) then SbilMin := Sbil;
      end;
    until (i=6) or (dati^[tr1]^.pros[i]=0);
  end
  else
  begin
    PerdTerm:=0;
    if (reteprinc)and(GTerm^[dati^[tr1]^.term]^.NumTer<>0) then
    begin
      SbilMin:=DatiSot^[GTerm^[dati^[tr1]^.term]^.NumTer,isot].sbil;
    end
    else
    begin
      if manrip then
      SbilMin:=GTerm^[dati^[tr1]^.term]^.Sbil
      else SbilMin:=Fgtb^[Cercaind(dati^[tr1]^.term)]^.Termin.Sbil;
    end;
  end;

{  if ((SbilMin>0.1)or((not manrip)and(dati^[tr1].term<>0)))and(Dati^[tr1].porteff>0) then}

  if (SbilMin>0.0001)and(Dati^[tr1]^.porteff>0) then
  begin
    IterEquil:=Equilibra(tr1,SbilMin);
  end
  else
    ITerEquil:=0;

end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*       Main      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

begin

  {if wr then
  Writeln(lst,' Equilibratura ',manrip);}



  if reteprinc then
  begin
  PerditaTotale:=RisultCalc^.perdita;
  RisultCalc^.sbil:=IterEquil(RisultCalc^.origine);
  end
  else
  RisultCalc^.sbil:=IterEquil(RisultCalc^.origine);


end;

{***************************  CalcolaSbil   *******************************}

Procedure CalcolaSbil;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Tara           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function Tara(tronco:integer;sbilancio:real;var CodiceDiam:String):string;
Var KvC1,KvC2,KvC3:real;
    i,j,ultima:integer;
    trovato,trovato1:boolean;
begin
{ TODO -oDiego -cTubi : Valvole di taratura }
CodiceDiam:='';
i:=0;
Trovato:=false;
(*  ???? da capire}
repeat
  i:=i+1;
  if(UpString(Dati^[tronco]^.CodDiam)=UpString(Valv_D^[i].Cod)) then

  Trovato:=true;

until (Trovato)or(i=MaxCod);

if not trovato then
  begin
  i:=0;
  repeat
  i:=i+1;
  {if (Dati^[tronco]^.Diam>=Valv_D^[i].Dmin)and
     (Dati^[tronco]^.Diam<=Valv_D^[i].Dmax) then Trovato:=true;      }

  // Emanuela 22/8/2005 inserito un diverso controllo dato che non abbiamo un
  // diametro monimo e un diametro massimo

  //if (Dati^[tronco]^.Diam<=Valv_D^[i].Dmax) then T
  rovato:=true
  //else MessageDLG('Non esiste in archivio, una valvola con in diametro adatto per il tubo', mtInformation, [mbOK], 0);


  until (Trovato)or(i=MaxCod);
  end;
*)
cod_valvoletaratura:=uppercase(cod_valvoletaratura);
i:=1;
while  (i<NPerditeConc)and(cod_valvoletaratura<>uppercase(Valv_D^[i].cod)) do inc(i);
trovato:=cod_valvoletaratura=uppercase(Valv_D^[i].cod);

if Trovato then
  begin
  if sbilancio>0.0000001 then
  with dati^[tronco]^ do
   begin
   Kvc1:=PortEff*3.6/sqrt(sbilancio/100);
   KvC2:=PortEff/sqrt(sbilancio);
   KvC3:=PortEff*3600/sqrt(sbilancio*100);
   end
  else
   begin
   Kvc1:=1E6;
   KvC2:=1E6;
   KvC3:=1E6;
   end;
  j:=0;

  ultima:=1;
  while (Valv_D^[i].Tacche[ultima].Cod<>'')and(ultima<MaxTacche)do
  ultima:=ultima+1;

  trovato1:=false;
  repeat
  j:=j+1;

  if (j<Ultima) then
    begin
    if (Valv_D^[i].Tacche[j].Kv1<>0) then
      begin
      if  abs(Valv_D^[i].Tacche[j  ].Kv1-Kvc1)<
          abs(Valv_D^[i].Tacche[j+1].Kv1-Kvc1) Then trovato1:=true;
      end
    else
      begin
      if (Valv_D^[i].Tacche[j].Kv2<>0) then
      begin
      if abs(Valv_D^[i].Tacche[j  ].Kv2-Kvc2)<
         abs(Valv_D^[i].Tacche[j+1].Kv2-Kvc2) Then trovato1:=true;
      end
      else
        begin
        if (Valv_D^[i].Tacche[j].Kv3<>0) then
          begin
          if abs(Valv_D^[i].Tacche[j  ].Kv3-Kvc3)<
             abs(Valv_D^[i].Tacche[j+1].Kv3-Kvc3) Then trovato1:=true;
          end
        end
      end;
    end;
  until (Trovato1)or(j=ultima);

  Tara:=Valv_D^[i].Tacche[j].Cod;
  CodiceDiam:=Valv_D^[i].Cod;

  end

  else

  begin
  {gotoxy(1,22);}
  //writec(w_m(113),20);    {    Diametro Non Trovato  }
  Tara:='';
  end;

end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*   C_Sbil  *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure C_Sbil(tr:integer;PerdProg:real);

var i,k,l,m,indl:integer;
    maxsfav:real;
    param:string;

begin
  k:=0;

  i:=0;
  with dati^[tr]^ do pp:=PerdProg+pd+pl;

  if dati^[tr]^.term=0 then
  begin
    repeat
      i:=i+1;
      if dati^[tr]^.pros[i]<>0 then C_Sbil(dati^[tr]^.pros[i],dati^[tr]^.pp);
    until (i=6)or(dati^[tr]^.pros[i]=0);
  end
  else
  begin
  Gterm^[dati^[tr]^.term]^.sbil:=risultcalc.Perdita-dati^[tr]^.pp;
   (*
    indl:=Cercaind(dati^[tr]^.term);
    if (reteprinc)and(GTerm^[dati^[tr]^.term]^.NumTer<>0) then
      begin
      DatiSot^[GTerm^[dati^[tr]^.term]^.NumTer,isot].sbil:=dati^[tr]^.pp;
      FGTB^[indl]^.sfav:=0;
      end
    else
    begin

      if Not(Manrip) then
      begin
        FGTB^[indl]^.pp:=dati^[tr]^.pp;
        FGTB^[indl]^.lungh:=dati^[tr]^.lungh;
        FGTB^[indl]^.pd:=Dati^[tr]^.pd;
        FGTB^[indl]^.pl:=Dati^[tr]^.pl;
        for m:=1 to 5 do
        begin
          FGTB^[indl]^.PConc[m].N:=dati^[tr]^.Pconc[m].N;
          FGTB^[indl]^.PConc[m].Cod:=dati^[tr]^.Pconc[m].Cod;

        end;
      end
      else
      begin
        if dati^[tr]^.pp<0 then dati^[tr]^.pp:=0;
        if FGTB^[indl]^.pp<0 then FGTB^[indl]^.pp:=0;



{        writeln(lst,'dati^[tr].term=',dati^[tr].term,'  indl=',indl);}



        if rit=2 then
        FGTB^[indl]^.sfav:=dati^[tr]^.pp + FGTB^[indl]^.pp + GTerm^[dati^[tr]^.term]^.perd
        else
        FGTB^[indl]^.sfav:=dati^[tr]^.pp + GTerm^[dati^[tr]^.term]^.perd;

      end;

    end;
   *)
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*       Main      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
var k,l,indl     :integer;
    param        :string;

Procedure New_tara;
Var k:integer;
begin
    for k:=1 to ulttronco do
    begin
      if dati^[k]^.ti<>0 then
      begin
        if dati^[k]^.term<>0 then
        begin
          if (valvoletaratura) then
         // (GTerm^[dati^[k]^.term]^.sbil>=Generalita_d^.PerdMin) then
          begin
            GTerm^[dati^[k]^.term]^.Taratura:=
            Tara(k,Gterm^[dati^[k]^.term]^.sbil,param);
            GTerm^[dati^[k]^.term]^.Diam:=param;
          end
          else GTerm^[dati^[k]^.term]^.Taratura:='';
        end;
      end;
    end;
end;



begin
C_Sbil(RisultCalc^.Origine,RisultCalc^.Sbil);
new_tara;
exit;
  {if wr then
  Writeln(lst,' Calcolasbil ',Manrip);   }

{  writeln(lst,'origine=',RisultCalc^.origine,'sbil=',RisultCalc^.sbil);}

  C_Sbil(RisultCalc^.Origine,RisultCalc^.Sbil);

  l:=0;

  {maxsfav:=0;}

  if manrip then
  begin
    if Rrit=true then
    begin
    {if reteprinc then writeln(f_Deb,'rete principale')
    else writeln(f_Deb,'sottorete'); }
      for k:=1 to Nlink do
      begin
      {writeln(f_Deb,k,' ',FGTB^[k].sfav:6:3); }
        if FGTB^[k]^.sfav > maxsfav then
        begin
          maxsfav:=FGTB^[k]^.sfav;
          l:=k;
        end;
      end;
    end;
    for k:=1 to NTronchi do
    if dati^[k]^.ti<>0 then
    if dati^[k]^.term<>0 then
      begin
      if (reteprinc)and(GTerm^[dati^[k]^.term]^.NumTer<>0) then { Nuccio }
      GTerm^[dati^[k]^.term]^.sbil:=0
      else
        begin
        indl:=cercaind(dati^[k]^.term);
        {writeln(F_deb,'indice:',indl,' term:',dati^[k].term,' ',GTerm^[dati^[k].term].cod,' maxsf:',maxsfav:6:4,
              '  sfav:',FGTB^[indl].sfav:6:5); }
        GTerm^[dati^[k]^.term]^.sbil:=(maxsfav-FGTB^[indl]^.sfav)*Divrit;
        Fgtb^[indl]^.Termin.Sbil:=GTerm^[dati^[k]^.term]^.sbil;
        if GTerm^[dati^[k]^.term]^.sbil<0.0001 then
          begin
          {gotoxy(1,16);}
          //writec(w_m(110),16);{Percorso piu' sfavorito}
          if (xnome=numeroprog) then
            begin
            str(dati^[k]^.num,st_8);
            //writec(w_m(111)+st_8,16); {rete principale troncon}
            princsfavor:=k;
            end
          else
          //writec(xnome+'                              ',16);
          RisultCalc^.sfavor:=k;
          end;
        end

      end;
    RisultCalc^.perdita:=Maxsfav;
    PerditaTotale:=RisultCalc^.perdita;

    for k:=1 to NTronchi do
    begin
      if dati^[k]^.ti<>0 then
      begin
        if dati^[k]^.term<>0 then
        begin
          if (valvoletaratura) and
          (GTerm^[dati^[k]^.term]^.sbil>=Generalita_d^.PerdMin) then
          begin
            GTerm^[dati^[k]^.term]^.Taratura:=
            Tara(k,Gterm^[dati^[k]^.term]^.sbil,param);
            GTerm^[dati^[k]^.term]^.Diam:=param;
          end
          else GTerm^[dati^[k]^.term]^.Taratura:='';
        end;
      end;
    end;

    {gotoxy(1,15);}
{    write(w_m(108),RisultCalc^.perdita*divrit:5:3,w_m(109)+ '   ');  }
{    Prevalenza alla pompa: /kPa }


{ gotoxy(1,16);write(w_m(110));}    {    Percorso piu` sfavorito ==> }
  end;
end;



{***************************  Portate_eff    *******************************}

Procedure Portate_eff;

var tr:integer;
    port:real;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  PorteffTronco  *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure PorteffTronco(tr1:integer);

var i,k,indl       :integer;
    Ctot           :real;
    C              :array[1..6] of real;
    ferr :text;
begin

 { if wr then
  writeln(lst,'Portate_eff ',manrip);   }

  if Dati^[tr1]^.term<>0 then
  begin
    GTerm^[Dati^[tr1]^.term]^.Port:=Dati^[tr1]^.porteff;
    if (reteprinc)and(GTerm^[Dati^[tr1]^.term]^.NumTer<>0) then
    DatiSot^[GTerm^[Dati^[tr1]^.term]^.NumTer,isot].Portata:=Dati^[tr1]^.porteff;
    indl:=CercaInd(dati^[tr1]^.Term);
    FGTB^[indl]^.port:=GTerm^[Dati^[tr1]^.term]^.Port;
  end
  else

  begin
    i:=0;
    CTot:=0;
    repeat
      i:=i+1;
      if dati^[tr1]^.pros[i]<>0 then
      begin
        if Dati^[dati^[tr1]^.Pros[i]]^.pr <>0 then
        begin
          C[i]:=dati^[dati^[tr1]^.Pros[i]]^.PortEff/sqrt(Dati^[dati^[tr1]^.Pros[i]]^.pr);
          Ctot:=Ctot+C[i];
        end;
        {assign(ferr,'pippo.err');
        rewrite(ferr);
        writeln(ferr,'Peff=',dati^[dati^[tr1].pros[i]].PortEff:5:3,' Pr=',dati^[dati^[tr1].pros[i]].pr:5:3,' c=',c[i]:5:3);
        close(ferr);
        writeln(lst,'dati^[tr1].num=',dati^[tr1].num,' i=',i,'  tr1=',tr1);}
      end;
    until (i=6)or(dati^[tr1]^.pros[i]=0);

    i:=0;
    repeat
      i:=i+1;
      if dati^[tr1]^.pros[i]<>0 then
      begin
        if (C[i]<>0) and (CTot<>0) then
        Dati^[dati^[tr1]^.pros[i]]^.PortEff:=Dati^[tr1]^.PortEff*C[i]/CTot
        else
        Dati^[dati^[tr1]^.pros[i]]^.PortEff:=Dati^[tr1]^.PortEff;
{        writeln(lst,manrip,'  Dati^[tr1].pros[i]=',Dati^[tr1].pros[i],'  ctot=',ctot);}


        PorteffTronco(dati^[tr1]^.pros[i]);
      end
    until (i=6)or(dati^[tr1]^.pros[i]=0);

    if dati^[tr1]^.num=1 then
    begin
{      write(lst,'  Peff=',Dati^[dati^[tr1].pros[1]].PortEff:5:3,' Pr=',Dati^[dati^[tr1].pros[1]].pr:5:3,' c=',c[1]:5:3);
      writeln(lst,'  Peff=',Dati^[dati^[tr1].pros[2]].PortEff:5:3,' Pr=',Dati^[dati^[tr1].pros[2]].pr:5:3,' c=',c[2]:5:3);}
    end;

  end;

end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*       Main      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

begin
  Dati^[RisultCalc^.Origine]^.PortEff:=RisultCalc^.Portata;
  PorteffTronco(RisultCalc^.Origine);
end;
{***************************  InitPort;     *******************************}
Procedure InitPort;
var i:integer;
begin
for i:=1 to nterm do Term_d^[i].PortEff:=0
end;
{***************************  CaricaGTerm;     *******************************}

Procedure CaricaGTerm;

var i,j:integer;
    trovato:boolean;

begin
exit;
  {if wr then
  writeln(lst,'CaricaGTerm ',ultgterm,manrip);  }


  for i:=1 to UltGTerm do
  begin
    if (GTerm^[i]^.cod<>'') then
    begin

{      writeln(lst,'i=',i,'  manrip=',manrip,'  GTerm^[i].Numter=',GTerm^[i].Numter,'  GTerm^[i].cod=',GTerm^[i].cod);}

      trovato:=false;
      if RetePrinc then
      begin
        j:=0;
        repeat
          j:=j+1;
        until ((UpString(GTerm^[i]^.cod)=UpString(Elsot[j]))and
                        (GTerm^[i]^.cod<>''))   or
                                     (j=maxsot);

        if UpString(GTerm^[i]^.cod)=UpString(Elsot[j]) then
        begin
          Trovato:=True;
          GTerm^[i]^.Numter:=j;
          GTerm^[i]^.Port:=DatiSot^[j,isot].Portata;
          GTerm^[i]^.Perd:=DatiSot^[j,isot].Perdita;
          GTerm^[i]^.Taratura:='';
          GTerm^[i]^.Diam:='';
        end;
      end;
      if not trovato then
      begin
        j:=0;
        repeat
          j:=j+1;
        until ((UpString(GTerm^[i]^.cod)=UpString(Term_D^[j].cod))and
                        (GTerm^[i]^.cod<>''))   or
                                    (j=NTerm);

        if UpString(GTerm^[i]^.cod)=UpString(Term_D^[j].cod) then
        begin
          GTerm^[i]^.Numter:=0;
          GTerm^[i]^.Port:=Term_D^[j].Port;
          GTerm^[i]^.Diam:='';
          IF Term_D^[j].CodPerd='' then
          begin
            GTerm^[i]^.Perd:=Term_D^[j].Perd/divrit;
            GTerm^[i]^.Taratura:='';
          end
          else GTerm^[i]^.Taratura:=Term_D^[j].CodPerd;
        end
        else
        begin
          //Writeln(lst,w_m(118));    { Terminale non Trovato }
        end;
      end;
    end;
  end;
end;

{***************************  CaricaPresTerm;     *******************************}

Procedure CaricaPresTerm;

var i:integer;

begin

for i:=1 to UltGTerm do

if (GTerm^[i]^.cod<>'')and(GTerm^[i]^.NumTer<>0) then

GTerm^[i]^.Perd:=DatiSot^[GTerm^[i]^.NumTer,isot].Perdita

end;

{***************************  SaveGTerm;     *******************************}

Procedure SaveGTerm;

var i,j:integer;
    trovato:boolean;

begin
exit;
for i:=1 to UltGTerm do

if GTerm^[i]^.cod<>'' then

  begin
  trovato:=false;
  if not trovato then
    begin
    j:=0;
    repeat
    j:=j+1;
    until ((UpString(GTerm^[i]^.cod)=UpString(Term_D^[j].cod))and
                    (GTerm^[i]^.cod<>''))   or
                                (j=NTerm);

    if UpString(GTerm^[i]^.cod)=UpString(Term_D^[j].cod) then
      begin
      if {exist('Port.sce')}portsce then Term_D^[j].PortEff:=GTerm^[i]^.Port
      else Term_D^[j].PortEff:=0;
      Term_D^[j].Perd:=GTerm^[i]^.Perd*DivRit;
      end

    end;

  end;

end;

{***************************  ExistSottorete  ******************************}

procedure existsottorete(nome:string;var esiste:boolean);

var i:integer;
begin
esiste:=false;
exit;
  nsot:=0;
  for i:=1 to maxsot do elsot[i]:='';
  if exist(driveprog+nome+'.sot') then
  begin
    esiste:=true;
    assign(fa,driveprog+nome+'.sot');
    reset(fa);
    read(fa,vprog^);
    i:=0;
    repeat
     i:=i+1;
     if vprog^[i].nome<>''then
     begin
     elsot[i]:=vprog^[i].nome;
     end
    until (vprog^[i].nome='')or (i=maxsot);
    if vprog^[i].nome='' then i:=i-1;
    nsot:=i;
    close(fa);
  end;
  if (nsot=0) then esiste:=false;
end;


{$I CONTROLL}

Function calcoli:boolean;
{***************************  Calcolo          *******************************}
var errorok,errorok1:boolean;
    j,k,i,ind,v:integer;
    drive:string;
    st_250,st_2501:string[250];
    pc_250,pc_2501:array[0..250] of char;
    stpres_pompa:string[10];
    pcpres_pompa:array[0..10] of char;
    fsce:file;
begin
  if fgtb^[1]=nil then new(fgtb^[1]);
  tubiok:=true;
  {assign(F_deb,'dbg.txt');
  rewrite(F_deb);}
  //drivemess:=get_drive;
  drivemess:=PercorsoDrive;;
  //new(datisot);
  // new(risultcalc);
  //new(vprog);
  wr   :=false;
  Contr:=false;
  Peff:=false;
  Peff1:=false;
  rrit:=false;
  errorok:=true;
  errorok1:=true;
  {TextColor(7);}
  {$ifdef dos}
  readcolor;
  {$endif}
  {TextBackGround(1);}
  {window(1,3,80,25);}
  {clrscr;}
  xnome:='';

  { NUCCIO
  ASSIGN(filet,'drive1.int');
  RESET(filet);
  read(filet,drive);
  close(filet);

  ASSIGN(filet,drive+'\driveprg.int');
  RESET(filet);
  read(filet,driveprog);
  close(filet);


  ASSIGN(filet,drive+'\drivearc.int');
  RESET(filet);
  read(filet,drivearc);
  close(filet);

  ASSIGN(filet,drive+'\nomecom.dat');
  RESET(filet);
  read(filet,nomecommessa);
  close(filet);

  driveprog:=driveprog+'\'+nomecommessa+'\'+ch63+'\';
  drivearc:=drivearc+'\'+ch63+'\';

  }
  driveprog:=PercorsoDrive;
  drivearc:=PercorsoDrive;
  Numeroprog:='\Temporaneo';
  {DATA_DRIVE  :=DATA_DRIVE+'\'+ch63+'\'+w_m(43)+'\';}     {data-drive+\tubi\progetti\}

  Reset_Pun;
  System_init;
  for i:=1 to  Ngen do
  if Generalita_D1^[i].codice=V_RecGen.codice then
    begin
    Generalita_d^:=Generalita_D1^[i];
    Generalita_d^.valvtipo:=cod_valvoletaratura;
    end;
  //ReadNprog;
  {new(dati);new(dis)};{new(FGTB);}{new(dati2);}{new(GTerm);}
  //for ind:=0 to lungdis   do Dis^[ind]:=nil;

  //for ind:=0{cippo ex1} to lungdati  do Dati^[ind]:=nil;
  //for ind:=0{cippo ex1} to lungdati  do Dati2^[ind]:=nil;

  //for ind:=1 to maxgterm  do GTerm^[ind]:=nil;
  //for ind:=1 to maxgterm  do Fgtb^[ind]:=nil;

  {
  new(dis^[0]);
  new(dati^[0]);
  }
  new(dati2^[0]);


  ValvoleTaratura:=false;
  {Errori('Tprcart','Tpccart','Tprmcart');}


  princsfavor:=0;
  sottosfavor:=0;
  nsottosfavor:=0;

{ if exist(Data_drive+NumeroProg+'.quo') then piantubi:=true else piantubi:=false;}

  if exist(driveprog+NumeroProg+'.ria') then
  begin
    assign(frisult,driveprog+NumeroProg+'.ria');
    reset(frisult);
    read(frisult,RisultCalc^);
    close(FRisult);
    if RisultCalc^.origine<>0 then rit:= 2 else rit:=1;
  end
  else rit:=1;

{ if ((upcase(Generalita_D^.Ritorno[1])='S') and (rit=1)) then
    divrit:=2
  else
    divrit:=1;  }

  portsce:=false;
  equilsce:=false;
  //valvsce:=false;
  if (upcase(Generalita_D^.Ritorno[1])=cyes)  then
  begin
    divrit:=2;
    rit:=1;
  end
  else divrit:=1;

  if exist('ver.sce') then
  begin
    Verifica:=true;
    assign(fsce,'ver.sce');
    erase(fsce);
  end
  else Verifica:=false;

  Assign(flT,driveprog+NumeroProg+'.CLC');
  try
    Rewrite(FlT);
    i:=1;
    {Gotoxy(5,i);}
    Writec(w_m(119),i);    {OPZIONI DI CALCOLO SELEZIONATE }
    Writec('',10);
    if Verifica then
      begin
      inc(i);
      {gotoxy(5,i);}
      writec(w_m(120),2);    {  - Verifica di un impianto esistente }
      writeln(FlT,w_m(120));    {  - Verifica di un impianto esistente }
      end
    else
      begin
      inc(i);
      {gotoxy(5,i);}
      writec(w_m(121),i);    {  - Predimensionamento a perdita costante }
      writeln(FlT,w_m(121)); {  - Predimensionamento a perdita costante }
      end;
    if exist('equil.sce') then
      begin
      inc(i);
      {gotoxy(5,i);}
      writec(w_m(122),i);    { - Equilibratura della rete }
      writeln(FlT,w_m(122));    {  - Equilibratura della rete }
      equilsce:=true;
      assign(fsce,'equil.sce');
      erase(fsce);
      end;
    if exist('Valv.sce') then
      begin
      inc(i);
      {gotoxy(5,i);}
      writec(w_m(123),i);    {  - Inserimento di valvole per la taratura }
      writeln(FlT,w_m(123));     { - Inserimento di valvole per la taratura }
      valvsce:=true;
      assign(fsce,'valv.sce');
      erase(fsce);
      end;
    if exist('port.sce') then
      begin
      portsce:=true;
      assign(fsce,'port.sce');
      erase(fsce);
      messagebeep(10);
      inc(i);
      {gotoxy(5,i);}
      writec(w_m(124),i);    {  - Calcolo della portata effettiva (portata totale costante) }
      writeln(FlT,w_m(124));    {  - Calcolo della portata effettiva (portata totale costante) }

      st_250:='Calcolo della portata effettiva';
      st_2501:='Prev. pompa[kPa]  (0=portata totale costante)';
      stpres_pompa:='0';
      {strpcopy(pc_250,st_250);
      strpcopy(pc_2501,st_2501);}
      {strpcopy(pcpres_pompa,stpres_pompa);}
      if true{application^.execdialog(new(pinputdialog,init(vcalc,pc_250,pc_2501,pcpres_pompa,10)))=
      id_ok }then
      begin
        {stpres_pompa:=strpas(pcpres_pompa);}
        val(stpres_pompa,press_ponpa,v);
        if v<>0 then press_ponpa:=0;
      end
      else
      exit;


      {Inp_real(NIL,Press_ponpa,,'Prevalenza della pompa',0,10000);}
      end;
    if (exist('sanit1.sce'))or(exist('sanit2.sce'))or(exist('sanit3.sce'))or(exist('sanit4.sce')) then
      begin
      if (exist('sanit1.sce')) then
      begin
        tiposan:=1;
        assign(fsce,'sanit1.sce');
        erase(fsce);
      end;
      if (exist('sanit2.sce')) then
      begin
        tiposan:=2;
        assign(fsce,'sanit2.sce');
        erase(fsce);
      end;
      if (exist('sanit3.sce')) then
      begin
        tiposan:=3;
        assign(fsce,'sanit3.sce');
        erase(fsce);
      end;
      if (exist('sanit4.sce')) then
      begin
        tiposan:=4;
        assign(fsce,'sanit4.sce');
        erase(fsce);
      end;

      carsanit;
      inc(i);
      {gotoxy(5,i);}
      //writec('Calcolo di rete sanitaria con unità di carico',i); {*TR*}
      //writeln(FlT,'Calcolo di rete sanitaria con unita`` di carico');
      Sanitario:=true;
      end
    else sanitario:=false;
    Close(FlT);
  except
    Close(FlT);
  end;
  ManRip := true;
  ExistSottorete(NumeroProg,ExSot);
  ControlloInput(errorok);
  if rit=2 then
  begin
    ManRip := false;
    ControlloInput(errorok1);
    ManRip:=true;
  end;

  if (not(errorok)) or (not(errorok1)) then
  begin
    {$ifdef dos}
    clrscr;
    gotoxy(1,12);
    write(chr(7));
    TextColor(14);
    TextBackground(4);
    {$endif}
    writec(w_m(125),20); {  !!! DATI DI INPUT ERRATI! CONTROLLARE L''ELENCO ERRORI NEL MENU DI CALCOLO }

    {$ifdef dos}
    gotoxy(4,14);
    TextColor(7);
    TextBackground(1);
    Write(w_m(8));    { Premere un tasto per continuare }
    Repeat until Keypressed;
    halt;
    {$endif}
    exit;
  end;
  ExistSottorete(NumeroProg,ExSot);
  reteprinc:=false;
  {GotoXy(1,10);}
  (*if verifica then writec(w_m(41)+'                       ',10)    { ' þ Verifica }
  else writec(w_m(104)+'                 ',10);   {   þ Predimensionamento }    *)
  InitPort;
  if ExSot then
  begin
    for i:=1 to nsot do
    begin
      for j:=1 to rit do
      begin
        manrip:=(j=1);
        RetePrinc:=false;
        {GotoXy(1,11);}
        (*if Manrip then
        writec(w_m(150)+'    ',11) {  MANDATA}
        else
        writec(w_m(168)+'    ',11);    { RIPRESA }  *)
        {GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }
        Loaddis(driveprog+elsot[i]);
        Loadlink(driveprog+elsot[i]);
        CaricaGTerm;
        Portate;
        Dimensiona;
        DatiSot^[i,isot]:=RisultCalc^;
        Savedis(driveprog+ElSot[i]);
        Savelink(driveprog+elsot[i]);
      end;
    end;
  end;
for j:=1 to rit do
begin
  manrip:=(j=1);
  RetePrinc:=true;
  {GotoXy(1,11);}
  (*if Manrip then
  writec(w_m(150)+'    ',11)    {  MANDATA }
  else
  writec(w_m(168)+'    ',11);    {  RIPRESA }  *)
  {GotoXy(1,12);writec(w_m(201)+'                     ',12); }   {  > Rete principale }
  If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
  LoadLink(driveprog+NumeroProg);

{        RisultCalc^.origine:=1;
        RisultCalc^.perdita:=0;
        RisultCalc^.portata:=0;
        RisultCalc^.sbil   :=0;
        RisultCalc^.sfavor :=0;}

  CaricaGTerm;
  Portate;
  Dimensiona;
  If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
  SaveLink(driveprog+NumeroProg);
end;
if {exist('equil.sce')}equilsce and(rit=2) then
begin
  if rit=2 then
  begin
    Rrit:=true;
    for j:=1 to rit do
    begin
      if rit = 2 then
      Manrip:=not(j=1)
      else
      Manrip:=(j=1);
      {GotoXy(1,10);}
      {writec(w_m(220)+'                                   ',10);  }  {  þ Calcolo sbilanci }
      {GotoXy(1,11);}
     (* if Manrip then
      writec(w_m(150)+'    ',11)    {  MANDATA }
      else
      writec(w_m(168)+'    ',11);    {  RIPRESA }   *)
      {GotoXy(1,12);writec(w_m(201)+'                     ',12);}    {  > Rete principale }
      If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      MaxSfav:=0;
      CalcolaSbil;
      SaveLink(driveprog+NumeroProg);
      RisultCalc^.sfavor:=princSfavor;
      if manrip then SaveGTerm;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
    end;
    if ExSot then
    begin
      for i:=1 to nsot do
      begin
        for j:=1 to rit do
        begin
          if rit = 2 then
          Manrip:=not(j=1)
          else
          Manrip:=(j=1);
          {GotoXy(1,11);}
         (* if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA } *)
          {GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'        ',12); }   { > Sottorete: }
          Loaddis(driveprog+elsot[i]);
          RisultCalc^:=DatiSot^[i,isot];
          LoadLink(driveprog+Elsot[i]);
          CalcolaSbil;
          SaveLink(driveprog+Elsot[i]);
          if manrip then SaveGTerm;
          DatiSot^[i,isot]:=RisultCalc^;
          if i=nsottosfavor then RisultCalc^.sfavor:=sottosfavor;
          Savedis(driveprog+ElSot[i]);
        end;
      end;
    end;
    Rrit:=false;
    for j:=1 to rit do
    begin
      if rit = 2 then
      Manrip:=not(j=1)
      else
      Manrip:=(j=1);
      {GotoXy(1,10);}
      {writec(w_m(220)+'                                   ',10); }   {  þ Calcolo sbilanci }
      {GotoXy(1,11);}
     (* if Manrip then
      writec(w_m(150)+'    ',11)    {  MANDATA }
      else
      writec(w_m(168)+'    ',11);    {  RIPRESA }
      GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }   *)
      If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      CalcolaSbil;
      SaveLink(driveprog+NumeroProg);
      RisultCalc^.sfavor:=princSfavor;
      if manrip then SaveGTerm;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
    end;
    if ExSot then
    begin
      for i:=1 to nsot do
      begin
        for j:=1 to rit do
        begin
          if rit = 2 then
          Manrip:=not(j=1)
          else
          Manrip:=(j=1);
          (*GotoXy(1,11);
          if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
         else
             writec(w_m(168)+'    ',11);    {  RIPRESA }
          GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }     *)
          Loaddis(driveprog+elsot[i]);
          RisultCalc^:=DatiSot^[i,isot];
          LoadLink(driveprog+Elsot[i]);
          CalcolaSbil;
          SaveLink(driveprog+Elsot[i]);
          if manrip then SaveGTerm;
          DatiSot^[i,isot]:=RisultCalc^;
          if i=nsottosfavor then RisultCalc^.sfavor:=sottosfavor;
          Savedis(driveprog+ElSot[i]);
        end;
      end;
    end;
    manrip:=true;
  end;

  if ExSot then
  begin
    Reteprinc:=false;
   // GotoXy(1,10);writec(w_m(229)+'                    ',10);    {  þ Equilibratura }
    for i:=1 to nsot do
    begin
      (*GotoXy(1,11);
      if Manrip then
        writec(w_m(150)+'    ',11)    {  MANDATA }
      else
        writec(w_m(168)+'    ',11);    {  RIPRESA }
      GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }   *)
      Loaddis(driveprog+elsot[i]);
      RisultCalc^:=DatiSot^[i,isot];
      loadlink(driveprog+elsot[i]);
      {calcolasbil;}
      Equilibratura;
      Savelink(driveprog+elsot[i]);
      DatiSot^[i,isot]:=RisultCalc^;
      Savedis(driveprog+ElSot[i]);
    end;
  end;
  RetePrinc:=true;
(*  GotoXy(1,10);writec(w_m(229)+'                    ',10);    {  þ Equilibratura }
  GotoXy(1,11);
  if Manrip then
      writec(w_m(150)+'    ',11)    {  MANDATA }
  else
     writec(w_m(168)+'    ',11);    {  RIPRESA }
  GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }   *)
  If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
  loadlink(driveprog+Numeroprog);
  {calcolasbil;}
  Equilibratura;
  Savelink(driveprog+Numeroprog);
  If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
  if rit=2 then
  begin
    Rrit:=true;
    for j:=1 to rit do
    begin
      if rit = 2 then
      Manrip:=not(j=1)
      else
      Manrip:=(j=1);
     (* GotoXy(1,10);
      writec(w_m(220)+'                                   ',10);    {  þ Calcolo sbilanci }
      GotoXy(1,11);
      if Manrip then
         writec(w_m(150)+'    ',11)    {  MANDATA }
      else
        writec(w_m(168)+'    ',11);    {  RIPRESA }
      GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }    *)
      If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      Maxsfav:=0;
      CalcolaSbil;
      SaveLink(driveprog+NumeroProg);
      RisultCalc^.sfavor:=princSfavor;
      if manrip then SaveGTerm;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
    end;
    if ExSot then
    begin
      for i:=1 to nsot do
      begin
        for j:=1 to rit do
        begin
          if rit = 2 then
          Manrip:=not(j=1)
          else
          Manrip:=(j=1);
      (*    GotoXy(1,11);
          if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }
          GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }   *)
          Loaddis(driveprog+elsot[i]);
          RisultCalc^:=DatiSot^[i,isot];
          LoadLink(driveprog+Elsot[i]);
          CalcolaSbil;
          SaveLink(driveprog+Elsot[i]);
          if manrip then SaveGTerm;
          DatiSot^[i,isot]:=RisultCalc^;
          if i=nsottosfavor then RisultCalc^.sfavor:=sottosfavor;
          Savedis(driveprog+ElSot[i]);
        end;
      end;
    end;
    Rrit:=false;
    for j:=1 to rit do
    begin
      if rit = 2 then
      Manrip:=not(j=1)
      else
      Manrip:=(j=1);
   (*   GotoXy(1,10);
      writec(w_m(220)+'                                   ',10);    {  þ Calcolo sbilanci }
      GotoXy(1,11);
      if Manrip then
         writec(w_m(150)+'    ',11)    {  MANDATA }
      else
        writec(w_m(168)+'    ',11);    {  RIPRESA }
      GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }*)
      If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      CalcolaSbil;
      SaveLink(driveprog+NumeroProg);
      RisultCalc^.sfavor:=princSfavor;
      if manrip then SaveGTerm;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
    end;
    if ExSot then
    begin
      for i:=1 to nsot do
      begin
        for j:=1 to rit do
        begin
          if rit = 2 then
          Manrip:=not(j=1)
          else
          Manrip:=(j=1);
       (*   GotoXy(1,11);
          if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }
          GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }    *)
          Loaddis(driveprog+elsot[i]);
          RisultCalc^:=DatiSot^[i,isot];
          LoadLink(driveprog+Elsot[i]);
          CalcolaSbil;
          SaveLink(driveprog+Elsot[i]);
          if manrip then SaveGTerm;
          DatiSot^[i,isot]:=RisultCalc^;
          if i=nsottosfavor then RisultCalc^.sfavor:=sottosfavor;
          Savedis(driveprog+ElSot[i]);
        end;
      end;
    end;
    manrip:=false;
    if ExSot then
    begin
      Reteprinc:=false;
    (*  GotoXy(1,10);writec(w_m(229)+'                    ',10);    {  þ Equilibratura }
      for i:=1 to nsot do
      begin
        GotoXy(1,11);
        if Manrip then
            writec(w_m(150)+'    ',11)    {  MANDATA }
         else
            writec(w_m(168)+'    ',11);    {  RIPRESA }
        GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',11);    { > Sottorete: }  *)
        Loaddis(driveprog+elsot[i]);
        RisultCalc^:=DatiSot^[i,isot];
        Loadlink(driveprog+elsot[i]);
        Equilibratura;
        Savelink(driveprog+elsot[i]);
        DatiSot^[i,isot]:=RisultCalc^;
        Savedis(driveprog+ElSot[i]);
      end;
    end;
    RetePrinc:=true;
  (*  GotoXy(1,10);writec(w_m(229)+'                    ',10);    {  þ Equilibratura }
    GotoXy(1,11);
    if Manrip then
       writec(w_m(150)+'    ',11)    {  MANDATA }
    else
      writec(w_m(168)+'    ',11);    {  RIPRESA }
    //GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }
    //w_m('> Rete principale');              *)
    If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
    loadlink(driveprog+Numeroprog);
    Equilibratura;
    Savelink(driveprog+Numeroprog);
    If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
  //end;
end;

if {exist('equil.sce')}equilsce and(rit=1) then
  begin
  Reteprinc:=false;
  //GotoXy(1,10);writec(w_m(229)+'                    ',10);    {  þ Equilibratura }
  if ExSot then
  for i:=1 to nsot do
    begin
    //GotoXy(1,12);writec(' > '+w_m(200)+elsot[i]+'            ',12);
    Loaddis(driveprog+elsot[i]);
    RisultCalc^:=DatiSot^[i,isot];
    Equilibratura1;
    DatiSot^[i,isot]:=RisultCalc^;
    Savedis(driveprog+ElSot[i]);
    end;
  RetePrinc:=true;
  //GotoXy(1,12);writec(' > '+w_m(229)+'                     ',12);
  if ExSot then Loaddis(driveprog+NumeroProg);
  Equilibratura1;
  if ExSot then Savedis(driveprog+NumeroProg);
  end;


if {exist('port.sce')}portsce then
begin
  verifica:=true;
  if rit=2 then
  begin
    Peff:=true;
    Manrip:=true;
    if ExSot then
    begin
      for i:=1 to nsot do
      begin
        RetePrinc:=false;
        GotoXy(1,11);
       (* if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }
          GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: } *)
        Loaddis(driveprog+elsot[i]);
        Loadlink(driveprog+elsot[i]);
        Dimensiona;
        DatiSot^[i,isot]:=RisultCalc^;
        Savedis(driveprog+ElSot[i]);
        Savelink(driveprog+elsot[i]);
      end;
    end;
    If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
    LoadLink(driveprog+NumeroProg);
{   if manrip then CaricaGTerm;}
    dimensiona;
{   Peff:=false;}
  end;
 (* GotoXy(1,10);writec(w_m(230)+'                  ',10);    {  þ Calcolo portata effettiva }
  GotoXy(1,11);
  if Manrip then
     writec(w_m(150)+'    ',11)    {  MANDATA }
  else
   writec(w_m(168)+'    ',11);    {  RIPRESA }       *)
  Niter:=0;
  Repeat
    if rit=2 then
    begin
      manrip:=true;
     (* GotoXy(1,11);
      if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else                                              *)
             writec(w_m(168)+'    ',11);    {  RIPRESA }
      If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      Niter:=Niter+1;
      Converge:=true;
      RetePrinc:=true;
      str(niter,st_8);
     // Gotoxy(30,10);writec(w_m(231)+' '+st_8+'     ',10);    { Iterazione Nø: }
      //GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }
      //w_m('> Rete principale');
      Portate_Eff;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
      SaveLink(driveprog+NumeroProg);
      RetePrinc:=False;
      if ExSot then
      begin
        for i:=1 to nsot do
        begin
          manrip:=true;
        (*  GotoXy(1,11);
          if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }
             GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }    *)
          Loaddis(driveprog+elsot[i]);
          LoadLink(driveprog+elsot[i]);
          RisultCalc^:=DatiSot^[i,isot];
          Portate_eff;
{          if manrip then CaricaGTerm;}
          Dimensiona;
          DatiSot^[i,isot]:=RisultCalc^;
          Savedis(driveprog+ElSot[i]);
          SaveLink(driveprog+elsot[i]);

          Manrip:=false;
        (*  GotoXy(1,11);
          if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }   *)
          Peff1:=true;
          Loaddis(driveprog+Elsot[i]);
          LoadLink(driveprog+elsot[i]);
          Portate;
          Peff1:=false;
          dimensiona;
          Savedis(driveprog+Elsot[i]);
          SaveLink(driveprog+elsot[i]);
          Manrip:=true;
        end;
      end;
      RetePrinc:=true;
    //  GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }
      if ExSot Then
      begin
        manrip:=true;
      (*  GotoXy(1,11);
        if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }  *)
        Loaddis(driveprog+NumeroProg);
        LoadLink(driveprog+NumeroProg);
        CaricaPresTerm
      end;
      manrip:=true;
{      if manrip then CaricaGTerm;}
      Dimensiona;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
      SaveLink(driveprog+NumeroProg);
      Manrip:=false;
  (*    GotoXy(1,11);
      if Manrip then
             writec(w_m(150)+'    ',11)    {  MANDATA }
          else
             writec(w_m(168)+'    ',11);    {  RIPRESA }      *)
      Peff1:=true;
      If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      Portate;
      Peff1:=false;
      dimensiona;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
      SaveLink(driveprog+NumeroProg);
      Manrip:=true;
    end
    else
    begin
      Niter:=Niter+1;
      Converge:=true;
      RetePrinc:=true;
      str(niter,st_8);
     // Gotoxy(30,10);writec(w_m(231) +' '+st_8+'     ',10);    { Iterazione Nø: }
     // GotoXy(1,12);writec(w_m(201)+'                     ',11);    {  > Rete principale }
      if ExSot or (rit=2) then Loaddis(driveprog+NumeroProg);
      LoadLink(driveprog+NumeroProg);
      Portate_Eff;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
      SaveLink(driveprog+NumeroProg);
      RetePrinc:=False;
      if ExSot then
      for i:=1 to nsot do
      begin
      //  GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }
        Loaddis(driveprog+elsot[i]);
        LoadLink(driveprog+elsot[i]);
        RisultCalc^:=DatiSot^[i,isot];
        Portate_eff;
{        if manrip then CaricaGTerm;}
        Dimensiona;
        DatiSot^[i,isot]:=RisultCalc^;
        Savedis(driveprog+ElSot[i]);
        SaveLink(driveprog+elsot[i]);
      end;
      RetePrinc:=true;
   //   GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }
      if ExSot Then
      begin
        Loaddis(driveprog+NumeroProg);
        LoadLink(driveprog+elsot[i]);
        CaricaPresTerm;
      end;
{      if manrip then CaricaGTerm;}
      Dimensiona;
      If exsot or (rit =2) then Savedis(driveprog+NumeroProg);
      SaveLink(driveprog+NumeroProg);
    end;


{  press_ponpa:=1000;}

  If press_ponpa<>0 then
    begin
    converge:=converge and  (abs(Press_ponpa/divRit-PerditaTotale) <= Generalita_D^.Tolleranza);
    if not converge then
    RisultCalc^.Portata:=(RisultCalc^.Portata/sqrt(PerditaTotale))*sqrt(Press_ponpa/divrit);
    end;

  until (Converge) or (NIter=Generalita_D^.Iterazioni);
end;
if (Generalita_D^.ValvTipo<>'')and{(exist('valv.sce') )}valvsce then
begin
  //if Exist(Drivearc+Generalita_D^.ValvTipo+'.vlv') then
  begin
    LoadValv(Drivearc+Generalita_D^.ValvTipo+'.vlv');
    ValvoleTaratura:=true;
  end;
end;

Rrit:=true;
reteprinc:=true;
for j:=1 to rit do
begin
  if rit = 2 then
  Manrip:=not(j=1)
  else
  Manrip:=(j=1);
 (* GotoXy(1,10);
  if ValvoleTaratura then writec(w_m(219)+'              ',10)    {  þ Taratura con valvole }
  else writec(w_m(220)+'                                   ',10);   {  þ Calcolo sbilanci }
  GotoXy(1,11);
  if Manrip then
       writec(w_m(150)+'    ',11)    {  MANDATA }
    else
      writec(w_m(168)+'    ',11);    {  RIPRESA }
    GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }
  *)
  If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
  loadlink(driveprog+NumeroProg);
  Maxsfav:=0;
  xnome:=numeroprog;
  CalcolaSbil;
  SaveLink(driveprog+NumeroProg);
  RisultCalc^.sfavor:=princSfavor;
  if manrip then SaveGTerm;
  Savedis(driveprog+NumeroProg);
  PerditaTotale:=RisultCalc^.perdita;
end;

if ExSot then
begin
  reteprinc:=false;
  for i:=1 to nsot do
  begin
    for j:=1 to rit do
    begin
      if rit = 2 then
      Manrip:=not(j=1)
      else
      Manrip:=(j=1);
   (*   GotoXy(1,11);
      if Manrip then
         writec(w_m(150)+'    ',11)    {  MANDATA }
      else
         writec(w_m(168)+'    ',11);    {  RIPRESA }
      GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }  *)
      Loaddis(driveprog+elsot[i]);
      RisultCalc^:=DatiSot^[i,isot];
      loadlink(driveprog+elsot[i]);
      xnome:=elsot[i];
      CalcolaSbil;
      Savelink(driveprog+elsot[i]);
      if manrip then SaveGTerm;
      DatiSot^[i,isot]:=RisultCalc^;
      if i=nsottosfavor then RisultCalc^.sfavor:=sottosfavor;
      Savedis(driveprog+ElSot[i]);
    end;
  end;
end;

{if rit=2 then  nuccio }
begin
  Rrit:=false;
  reteprinc:=true;
  for j:=1 to rit do
  begin
    if rit = 2 then
    Manrip:=not(j=1)
    else
    Manrip:=(j=1);
 (*   GotoXy(1,10);
    if ValvoleTaratura then writec(w_m(219)+'              ',10)   { þ Taratura con valvole }
    else writec(w_m(220)+'                                   ',10);   {  þ Calcolo sbilanci }
    GotoXy(1,11);
    if Manrip then
       writec(w_m(150)+'    ',11)    {  MANDATA }
    else
      writec(w_m(168)+'    ',11);    {  RIPRESA }
    GotoXy(1,12);writec(w_m(201)+'                     ',12);    {  > Rete principale }   *)
    If exsot or (rit =2) then Loaddis(driveprog+NumeroProg);
    loadlink(driveprog+NumeroProg);
    xnome:=numeroprog;
    CalcolaSbil;
    SaveLink(driveprog+NumeroProg);
    RisultCalc^.sfavor:=princSfavor;
    if manrip then SaveGTerm;
    Savedis(driveprog+NumeroProg);
    PerditaTotale:=RisultCalc^.perdita;
  end;
  if ExSot then
  begin
    reteprinc:=false;
    for i:=1 to nsot do
    begin
      for j:=1 to rit do
      begin
        if rit = 2 then
        Manrip:=not(j=1)
        else
        Manrip:=(j=1);
       (* GotoXy(1,11);
        if Manrip then
           writec(w_m(150)+'    ',11)    {  MANDATA }
        else
           writec(w_m(168)+'    ',11);    {  RIPRESA }
        GotoXy(1,12);writec(w_m(200)+' '+elsot[i]+'            ',12);    { > Sottorete: }     *)
        Loaddis(driveprog+elsot[i]);
        RisultCalc^:=DatiSot^[i,isot];
        loadlink(driveprog+elsot[i]);
        xnome:=elsot[i];
        CalcolaSbil;
        Savelink(driveprog+elsot[i]);
        if manrip then SaveGTerm;
        DatiSot^[i,isot]:=RisultCalc^;
        if i=nsottosfavor then RisultCalc^.sfavor:=sottosfavor;
        Savedis(driveprog+ElSot[i]);
      end;
    end;
  end;
end;
if risultcalc^.sfavor<>0 then
risultcalc^.Perdita:=risultcalc^.Perdita*2-Gterm^[Dati^[risultcalc^.sfavor]^.Term]^.perd/2
else risultcalc^.Perdita:=0;
if not(tubiok) then MessageDlg('Diametri in archivio non sufficienti , controllare la stampa (segnalati con !!!)', mtInformation, [mbOK], 0); 
result:=(errorok)and(errorok1);
(*gotoxy(1,10);
writec('                                                                 ',10);
gotoxy(1,11);
writec('                                                                 ',11);
gotoxy(1,12);
writec(w_m(221)+'                                       ',12); {     RISULTATI DI CALCOLO : }
gotoxy(1,13);
writec('                                                                 ',4);
gotoxy(1,15);
str(PerditaTotale*divrit:5:3,st_8);
writec(w_m(108)+st_8+w_m(109)+ '   ',15);{    Prevalenza alla pompa:/kPa}

{gotoxy(1,16);write(w_m(110));}    {    Percorso piu` sfavorito ==> }
{$ifdef dos}
gotoxy(4,20);
TextColor(7);
TextBackground(1);
Write(w_m(8));    { Premere un tasto per continuare }

Repeat until Keypressed;
{$endif}
TRANSFER_TERM(driveprog+NumeroProg + '.trm','S');
{close(F_deb);}
if sanitario then dispose(el_unita);      *)

end;


end.

