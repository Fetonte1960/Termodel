
Unit datiDuct;

Interface

Uses
    {$Ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  {$endif}
  {$Ifdef Win}
  WinDos, {Unit found in TURBO.TPL}
  winprocs,
  wintypes,
  {$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  utilitie,
  defuti,
  definiz,
  ioDuct,
  def_win,
  graph,
  key;
  {$Ifdef Win}
{ Procedure datiprg1;
 procedure datiprg2;}
   {$endif}
 PROCEDURE GEST_MENU(var Uscita:integer);

{===========================================================================}

Implementation

{-------------------------------  GEST_MENU  ---------------------------------}


FUNCTION Elev(a, x : REAL) : REAL;
        { a = base ; x = esponente }
      BEGIN
        IF a > 0 THEN Elev := EXP(x*LN(a)) ELSE Elev := 0;
      END;

{$Ifdef Win}


procedure W_transfer_misure;far;

begin
  transfer_misure(DRIVEArc+'Misure.ark','S');
end;

procedure canclmis;far;
begin
  arcmisure:=true;
end;
procedure canclcost;far;
begin
  costantididis:=true;
end;

procedure canclrid;far;
begin
  arcriduz:=true;
end;

procedure canclpiante;far;
begin
  piantecl:=true;
end;
procedure canclsezioni;far;
begin
  sezionicl:=true;
end;

procedure canclerr;far;
begin
  erroricl:=true;
end;

procedure cancldatigen1;far;
begin
  datigen1:=true;
end;

procedure cancldatigen2;far;
begin
  datigen2:=true;
end;

procedure W_transfer_gen1;far;
begin
  TRANSFER_DATIPROG1(DRIVEPROG+ Numeroprog+'.GN1','S');
end;
procedure W_transfer_gen2;far;
begin
  TRANSFER_DATIPROG2(DRIVEPROG+ Numeroprog+'.GN2','S');
end;


procedure Leggi_p;far;
begin
  copiapianta('Piante',0);
end;

procedure leggi_s;far;
begin
copiapianta('sezioni',0);
end;

procedure datiprg2;
var ke,Kt,Kh:real;

 CONST
   ViscBase = 0.0181598; DensBase = 1.204;
var hd:hwnd;
    nt:st8;
begin
  WITH Dpr1^ DO
  begin
    KE := Elev(1-(2.2557*0.00001)*AltSulMare, 4.73);
    KT := Elev(293/(TempAria+273), 0.825);
    KH := 1;
  end;
  WITH Dpr2^ DO
  BEGIN
    Dens := KT*KE*KH*DensBase;
    Visc := KT*ViscBase;
  END;
  procarr[11]:=cancldatigen2;
  procarr[12]:=W_transfer_gen2;
  st_8:='PRNRIF1';
  a_w:=numerotabella(st_8,hd,2);
  tab_testo:=true;
  posx:=0;
  W_UsaMaskera(Dpr2^,'PRNRIF2.MSK',procarr,true,code,fill_listagen,tabellacorrente^[a_w].self);
  setdata:=false;
end;
procedure W_transfer_costanti;far;
begin
  transfer_costanti(DRIVEarc+'costanti.ark','S');
end;

procedure W_transfer_riduz;far;
begin
  TRANSFER_RIDUZIONI(DRIVEARC+'Riduzioni.ark','S');
end;

procedure W_transfer_piante;far;
begin
  TRANSFER_ElencoPiante(DRIVEPLT+'work.PNT','S');
  el_win[1].ridis_w:=true;
  ridisegna;
  el_win[2].ridis_w:=false;
end;

procedure W_transfer_sezioni;far;
begin
  TRANSFER_Sezioni(DRIVEPLT+'work.SEZ','S');
  el_win[1].ridis_w:=true;
  ridisegna;
  el_win[2].ridis_w:=false;
end;

procedure piantestup;far;
begin
  with tabellacorrente^[a_w].dialog^ do
  begin
    setdlgitemtext(hwindow,17,'Imp_PLT');
  end;
end;



  {$endif}
PROCEDURE GEST_MENU(var Uscita:integer);

VAR
  ftext   :text;
  Scelta  :INTEGER;


{ -------------------------------  MISURE --------------------------------- }


Procedure MISURE;

 {$Ifdef dos}
 VAR
  Chiave,Riga,Campo : INTEGER;
  {$endif}
  {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}

BEGIN
  TRANSFER_MISURE(DRIVEARC+'Misure.ark','L');
  procarr[12]:=W_transfer_misure;
  procarr[11]:=canclmis;
  tab_testo:=true;
  posx:=0;
  W_IOTabella(Mis^,MaxMIS,10,2,'misure.msk',false,procarr,true,code,fill_listagen,nil);
END;    { PROC. MISURE }

{ ------------------------------  COSTANTI -------------------------------- }

Procedure COSTANTI;

VAR
  Chiave,Riga,Campo : INTEGER;

  {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}

BEGIN
  TRANSFER_COSTANTI(DRIVEARC+'Costanti.ark','L');
  procarr[11]:=canclcost;
  procarr[12]:=W_transfer_costanti;
  tab_testo:=true;
  posx:=0;
  W_UsaMaskera(Costant^,'Costanti.msk',procarr,true,code,fill_listagen,nil);
END;    { PROC. MISURE }

{ ------------------------------  RIDUZIONI ------------------------------- }
Procedure RIDUZIONI;
VAR
  Chiave,Riga,Campo : INTEGER;

  {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}
BEGIN
  TRANSFER_RIDUZIONI(DRIVEARC+'Riduzioni.ark','L');

  procarr[11]:=canclrid;
  Procarr[12]:=W_transfer_riduz;
  tab_testo:=true;
  posx:=0;
  W_UsaMaskera(Riduz^,'Riduz.msk',procarr,true,code,fill_listagen,nil);

END;    { PROC. riduzioni}

{----------------------------- DatiProgetto1 -----------------------------}


Procedure Datiprogetto;
 CONST
   ViscBase = 0.0181598; DensBase = 1.204;
var
  Campo,Pag : integer;
  ke,Kt,Kh:real;


 {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}


begin

   TRANSFER_DATIPROG1(DRIVEPROG+ Numeroprog+'.GN1','L');
   TRANSFER_DATIPROG2(DRIVEPROG+ Numeroprog+'.GN2','L');

   Pag:=1;
  procarr[11]:=cancldatigen1;
  procarr[12]:=W_transfer_gen1;
  procarr[2]:=datiprg2;
  tab_testo:=true;
  posx:=0;
  W_UsaMaskera(Dpr1^,'PRNRIF1.MSK',procarr,true,code,fill_listagen,nil);
end;

function eliminadir(dir:string):string;
var i:integer;

begin
  eliminadir:=dir;
  for i:=1 to length(dir) do
  if dir[i]='\' then eliminadir:=copy(dir,i+1,length(dir))
end;



{-------------------------- ElencoPiante -----------------------------}
Procedure ElencoPiante;
var Riga,Campo ,i: integer;

  {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}
Begin

  TRANSFER_ElencoPiante(DRIVEPLT+'work.PNT','L');
  procarr[12]:=W_transfer_piante;
  procarr[11]:=Canclpiante;
  procarr[7]:=leggi_p;
  procarr[23]:=piantestup;
  tab_testo:=true;
  posx:=0;
  W_IOTabella(EPt^,MaxEPiante,10,3,
            'piante.msk',false,procarr,true,code,fill_listagen,nil);

end;


{-------------------------- ElencoSezioni -----------------------------}
Procedure ElencoSezioni;
var Riga,Campo ,i: integer;


  {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}

Begin
  TRANSFER_Sezioni(DRIVEplt+'work.SEZ','L');
  procarr[12]:=W_transfer_sezioni;
  procarr[11]:=Canclsezioni;
  procarr[23]:=piantestup;
  procarr[7]:=leggi_s;
  tab_testo:=true;
  posx:=0;
  W_IOTabella(Sez^,MaxSez,10,3,
                'sezioni.msk',false,procarr,true,code,fill_listagen,nil);

end;

{---------------------------- ERRORI ---------------------------------}


procedure errori;
var
    f         :file of TErrori;
    initmenu  :boolean;
    campo,chiave,riga   :integer;
    initmask  :boolean;
    i         :integer;

  {$Ifdef Win}
  var hd:hwnd;
    nt:st8;
  {$endif}
begin
   for i:=1 to nprogetti do
    with ErroreInp^[i] do
     begin
        DaNodo:=0;
        Anodo:=0;
        Quota:=0;
        NPezzo:=0;
        Cod:='';
        DescrEr:='';
     end;
   if Exist(driveprog+'errori.dat') then
    begin
       assign(f,driveprog+'errori.dat');
       reset(f);
       read(f,ErroreInp^);
       close(f);
    end;
   InitMask:=true;
   InitMenu:=true;
   procarr[12]:=generica;
   procarr[11]:=canclerr;
   tab_testo:=true;
   posx:=0;
   W_IOTabella(ErroreInp^,nprogetti,10,6,
            'conerror.msk',false,procarr,true,code,fill_listagen,nil);

 end;




{---------------------------- START GESTMENU ---------------------------------}


BEGIN

      CASE uscita OF

        22:MISURE;
        23:COSTANTI;
        24:RIDUZIONI;
        31:DATIPROGETTO;
        32:ERRORI;
        43:ELENCOPIANTE;
        44:ELENCOSEZIONI;
      end;
      uscita:=Scelta;

END;  { PROC. GEST_MENU }


End.
