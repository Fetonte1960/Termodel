{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$E-}
{$C DEMANDLOAD}
unit Load_D;

INTERFACE

uses
genproc,
definiz,funzbase,WM,controll;

Procedure LoadDis(nomedis:string);
Procedure SaveDis(nome:string);

{---------------------------------------------------------------------------}
implementation


{***************************  Fat_er     *****************************}

Procedure Fat_er(mess:string;grafica:boolean);

begin
{ clrscr;
 gotoXy(5,10);
 write(Mess);
 repeat until keypressed;
 halt;}
end;

 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;

{************************** LOADDIS*****************************************}

Procedure LoadDis(nomedis:string);
var i,j:integer;
    fnd:file of dimdadis;
    type rccom=record
             Rsnap     ,
             griglia   ,
             altnum    :real;
           end;
var fcom:file of rccom;
    vcom:rccom;

procedure initconf;

function loadconfcom:boolean;
begin
  loadconfcom:=false;
  if exist(drivecart+'work.cfg') then
  begin
    assign(fcom,drivecart+'work.cfg');
    reset(fcom);
    read(fcom,vcom);
    close(fcom);
    loadconfcom:=true;
  end;
end;

begin
  with conf^ do
  begin
    Rcolore:=1;
    Tlinea:=1;
    griglia :=0;
    Rsnap:=0.01;
    altnum:=50;  {-- Scala --}
{M}    ManRip:=CH40;
{R}    CircRet:=CH43;
    Curve[1]:='079C';
    Curve[2]:='079R';
    Curve[3]:='079C';
    Curve[4]:='079R';

    Br90[1].RapLung:=0;
    Br90[1].CodCan[1]:='3717';
    Br90[1].CodCan[2]:='3722';
    Br90[1].CodCan[3]:='10CB';
    Br90[1].CodCan[4]:='12RB';

    Br90[2].RapLung:=5;
    Br90[2].CodCan[1]:='3717';
    Br90[2].CodCan[2]:='12RA';
    Br90[2].CodCan[3]:='10CB';
    Br90[2].CodCan[4]:='12RB';

    Br90[3].RapLung:=20;
    Br90[3].CodCan[1]:='3710';
    Br90[3].CodCan[2]:='10RA';
    Br90[3].CodCan[3]:='10CB';
    Br90[3].CodCan[4]:='39RD';

    BrD90[1].RapLung:=0;
    BrD90[1].CodCan[1]:='3711';
    BrD90[1].CodCan[2]:='3724';
    BrD90[1].CodCan[3]:='375';
    BrD90[1].CodCan[4]:='';

    BrD90[2].RapLung:=20;
    BrD90[2].CodCan[1]:='3723C';
    BrD90[2].CodCan[2]:='3723R';
    BrD90[2].CodCan[3]:='375';
    BrD90[2].CodCan[4]:='';

    BrD90[3].RapLung:=0;
    BrD90[3].CodCan[1]:='';
    BrD90[3].CodCan[2]:='';
    BrD90[3].CodCan[3]:='';
    BrD90[3].CodCan[4]:='';

    TEE[1]:='3734C';
    TEE[2]:='3733';
    TEE[3]:='3734C';
    TEE[4]:='3733';

    CROCE[1]:='3736C';
    CROCE[2]:='3736R';
    CROCE[3]:='3736C';
    CROCE[4]:='3736R';

    BocVert.TipoBoc:='C';
    BocVert.CodBoc[1]:='05LC';
    BocVert.CodBoc[2]:='05LR';
    BocVert.CodBoc[3]:='04LC';
    BocVert.CodBoc[4]:='04LR';

    BocOriz.TipoBoc:='R';
    BocOriz.CodBoc[1]:='05LC';
    BocOriz.CodBoc[2]:='05LR';
    BocOriz.CodBoc[3]:='04LC';
    BocOriz.CodBoc[4]:='04LR';
    if loadconfcom then
     begin
       griglia:=vcom.griglia;
       rsnap:=vcom.rsnap;
       altnum:=round(vcom.altnum);
     end;
  end;
end;

{ ---------------------------- INIT_COSTANTI ------------------------------ }

Procedure Init_COST;
var i : integer;
begin

 if not Exist(drivearc+'costanti.ark') then
  begin
     with costant^ do
      begin
         ColCan:=15;    ColQ:=4;
{ S,S}         QCan:=CH1; Por:=CH1;  Altquo:=4;
         C1:=0;     C2:=0;     C3:=0;
         C4:=0;     C5:=0;     C6:=0;
         C7:=0;     C8:=0;     C9:=0;
         C10:=0;    C11:=0;    C12:=0;
         C13:=0;    C14:=0;    C15:=0;
         C16:=0;    C17:=0;    C18:=0;
         C19:=0;    C20:=0;    C21:=0;
         C22:=0;    C23:=0;    C24:=0;
      end;
  end;
end;


{ ---------------------------- TRANSFER_Costanti -------------------------- }

PROCEDURE TRANSFER_Costanti(FileName:STring;Modo:CHAR);


VAR

  Fl   : FILE OF RecCostDis;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Cost;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,costant^);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,costant^);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_Costanti }

procedure InitRis;

begin
  with RisultCalc^ do
  begin
    Origine:=0;
    Sfavor :=0;
    DisUnif:=true;
    DisDimens:=False;
    Nodi:=false;
    Quota:=0;
  end;
end;



begin

{$ifdef win}
{$else}

if grafica then Richiesta('Caricamento in corso');{*TR*}

{$endif}

Ultriga:=1;
if dis^[1]=nil then new(dis^[1]);
dis^[1]^.Entita:='';

  if exist(nomedis+'.ret') then
  begin
    i:=1;
    assign(fi,nomedis+'.ret');reset(fi);
    while not(eof(fi)) and (i<=lungdis) do
    begin
      if dis^[i]=nil then new(dis^[i]);
      read(fi,dis^[i]^);
      i:=i+1;
    end;
    UltRiga:=i-1;
    close(fi);
  end
  else Ultriga:=1;
Nrighe:=Newriga;

UltTronco:=1;
NtrValid :=0;
if Dati^[1]=nil then new(dati^[1]);
dati^[1]^.Ti:=0;

if exist(nomedis+'.dtr') then
  begin
  i:=1;
  assign(fr,nomedis+'.dtr');reset(fr);
  while not(eof(fr)) and (i<=lungDati) do
    begin
      if Dati^[i]=nil then new(dati^[i]);
      read(fr,dati^[i]^);

      if dati^[i]^.Ti<>0 then NTrValid:=NtrValid+1;
      i:=i+1;
    end;
    UltTronco:=i-1;
    close(fr);
  end
  else Ulttronco:=1;

UltPezzo:=1;
if Vpezzi^[1]=nil then new(Vpezzi^[1]);
Vpezzi^[UltPezzo]^.Codice:='';

if exist(nomedis+'.pzz') then
  begin
  i:=1;
  assign(fp,nomedis+'.pzz');reset(fp);
  while not(eof(fp)) and (i<=lungpezzi) do
    begin
      if Vpezzi^[i]=nil then new(Vpezzi^[i]);
      read(fp,Vpezzi^[i]^);
      i:=i+1;
    end;
    Ultpezzo:=i-1;
    close(fp);
  end
  else Ultpezzo:=1;


Ntronchi:=ultTronco;

{
UltGTerm:=1;
if exist(nomedis+'.ter') then
  begin
  i:=1;
  assign(fGT,nomedis+'.ter');reset(fgt);
  while not(eof(fgt)) and (i<=MaxGTErm) do
    begin
      read(fgt,GTerm^[i]);
      i:=i+1;
    end;
    UltGTerm:=i-1;
    close(fgt);
  end
  else
    begin
    UltGTerm:=1;
    GTerm^[UltGTerm].Cod:='';
    end;

NGTerm:=ultGTerm;
}

PieniT   :=false;
PieniD   :=false;
PieniTerm:=false;

if exist(nomedis+'.con') then
   begin
   assign(fconf,nomedis+'.con');
   reset(fconf);
   read(fconf,conf^);
   close(fconf);
   end
else initconf;

if exist(nomedis+'.ris') then
   begin
   assign(frisult,nomedis+'.ris');
   reset(frisult);
   read(frisult,RisultCalc^);
   close(FRisult);
   with RisultCalc^ Do
     begin

       {-- Limiti in Pianta --}

     L_Xsup:=SL_Xsup;
     L_Xinf:=SL_Xinf;
     L_YSup:=SL_YSup;
     L_YInf:=SL_YInf;

       {-- Zoom Corrente --}

     Xsup:=SXsup;
     Xinf:=SXinf;
     YSup:=SYSup;
     YInf:=SYInf;
     ZInf:=SZInf;
     ZSup:=SZSup;

        {-- Zoom tutto (sezione) --}

     S_limXS:=xsup;
     S_LIMXI:=xinf;
     S_LimYS:=ysup;
     S_LimYI:=yinf;
     S_LimZS:=zsup;
     S_LimZI:=zinf;

     sezione:=Ssezione;
     end;
   end

else initRis;

if exist(NomeDis+'.msc') then
   begin
   assign(F_unmis,NomeDis+'.msc');
   reset(F_Unmis);
   read(F_Unmis,UnMis);
   Close(F_Unmis);
   end
 else
{ Fat_er(W_M(34),true);  'Manca il file unita di misura portata',true);}
 unmis:=1;
 transfer_costanti(drivearc+'costanti.ark','L');
 naggdis:=0;
 fillchar(VaiColDim^,sizeof(vaicoldim^),0);

 IF EXIST(DRIVEPROG+NOMEPROG+'.ddd') THEN
 begin
   assign(fnd,driveprog+nomeprog+'.DDD');
   reset(Fnd);
   while not eof(fnd) do
   begin
     inc(naggdis);
     read(fnd,vaicoldim^[naggdis]);
   end;
   close(fnd);
 end
 else
 with vaicoldim^[1] do
 begin
   inc(naggdis);
   nprogettu:=nomeprog;
   culuri:=0;
 end;
end;

{************************** SAVEDIS*****************************************}
Procedure SaveDis(nome:string);
var i:integer;
    fine:boolean;
    st3:string;
    fdebug:text;
    fnd: file of dimdadis;
begin
  assign(fi,Nome+'.ret');rewrite(fi);
  for i:=1 to ultriga do write(fi,dis^[i]^);
  close(fi);

  assign(fr,Nome+'.DTR');rewrite(fr);
  for i:=1 to ulttronco do write(fr,dati^[i]^);
  close(fr);

  assign(fp,Nome+'.pzz');rewrite(fp);
  for i:=1 to ultpezzo do write(fp,Vpezzi^[i]^);
  close(fp);

  assign(fconf,Nome+'.con');
  rewrite(fconf);
  write(fconf,conf^);
  close(fconf);

  with RisultCalc^ Do
     begin
     SL_Xsup:=L_Xsup;
     SL_Xinf:=L_Xinf;
     SL_YSup:=L_YSup;
     SL_YInf:=L_YInf;
     SXsup:=Xsup;
     SXinf:=Xinf;
     SYSup:=YSup;
     SYInf:=YInf;
     SZInf:=ZInf;
     SZSup:=ZSup;
     Ssezione:=sezione;
     end;
  if Vuoto then RisultCalc^.Origine:=0;
  assign(fRisult,Nome+'.ris');
  rewrite(fRisult);
  write(fRisult,RisultCalc^);
  close(fRisult);
  if naggdis >1 then
  begin
  assign(fnd,driveprog+nomeprog+'.DDD');
  rewrite(fnd);
  for i:=1 to naggdis do write(fnd,vaicoldim^[i]);
  close(fnd);
  end;
end;




end.