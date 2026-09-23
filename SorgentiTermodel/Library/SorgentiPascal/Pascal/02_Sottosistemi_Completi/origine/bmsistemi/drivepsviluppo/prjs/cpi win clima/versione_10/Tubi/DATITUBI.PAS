
Unit datitubi;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  printer,
  utilitie,
  definiz,
  iotubi,
  wp,
  DEFUTI,
  win_uti,
  winprocs,
  inituti,
  u_winput,
  wintypes,
  main_res,
  key,fc_tubi,inizamb;


 PROCEDURE GEST_MENU(var uscita:integer);

 procedure LoadValv(nome:string);

{ Procedure Load_Term(Nome:string);
 Procedure PulisciTerm(Nome:string);
 procedure Ordina;}
 Procedure salvaterm;
{ Procedure CaricaTerm;}
 Procedure PreparaFancoil;


{===========================================================================}

Implementation
var     chiave1:integer;

{-------------------------------  GEST_MENU  ---------------------------------}





procedure LoadValv(nome:string);
var i:integer;
    j:integer;
    f:file of elvalv;
begin
   if exist(nome)then
   begin
     assign(f,nome);
     reset(f);
     read(f,valv_D^);
     close(f);
   end
   else
   for i:=1 to Maxcod do
    with valv_D^[i] do
     begin
        Cod  :='';
        dmin :=0;
        dmax :=0;
        for j:=1 to maxtacche do
        tacche[j].cod:='';
        tacche[j].kv1:=0;
        tacche[j].kv2:=0;
        tacche[j].kv3:=0;
     end;
end;


procedure canclgen;far;
begin
end;

procedure savegen;far;
begin
TRANSFER_GENERALITA(DRIVEPROG+NumeroProg+'.GEN','S');
end;



VAR
  ftext:text;
  Scelta:INTEGER;



{-------------------------------  GENERALITA  --------------------------------}
PROCEDURE GENERALITA;
VAR
  Campo,Chiave:INTEGER;
BEGIN
  ar_ins^[12].ncampo:=12;
  ar_ins^[12].nfile:=drivearc+'\valvole.ins';
  initproc;
  PROCARR[11]:=canclgen;
  procarr[12]:=savegen;
  tab_testo:=true;
  posx:=0;
  W_UsaMaskera(Generalita_D^,'GEN.MSK',procarr,true,code,fill_listagen,nil);
END;    { PROC. GENERALITA }


procedure AggiornaTubaz;
var i:integer;
begin
   for i:=1 to MaxTubaz do
    with Tubaz_D^[i] do
     begin
        Descr:=fin^[i].Descr;
        Cod  :=fin^[i].Cod;
        Dens :=fin^[i].Dens;
        Rug  :=fin^[i].Rug;
     end;
end;
procedure cancltub;far;
begin

end;
procedure savetub;far;
begin
  aggiornatubaz;
  TRANSFER_TUBAZ(DRIVEARC+'Archivio.TBZ','S');
  dispose(fin);
end;

procedure tubf3;far;
var riga:integer;
begin
  riga:=getriga('eltubaz');
  MESS^[1]:=fin^[Riga].Cod;
  initproc;
  st_8:='eltubaz';
  a_w:=numerotabella(st_8,hd,2);
  tab_testo:=true;
  posx:=0;
  w_iotabella(Tubaz_D^[riga].sez,MaxSez,10,4,'tubaz.msk',false,procarr,true,code,fill_listagen,tabellacorrente^[a_w].self);
  setdata:=false;
end;


{------------------------------  Eltubaz   ---------------------------------}

Procedure Init_Tubaz(riga:integer);
var i:integer;
begin
with Tubaz_D^[riga] do
  begin
  Cod  :='';
  Descr:='';
  Dens :=0;
  Rug  :=0;
  for i:=1 to maxsez do
    begin
    sez[i].Dnom:='';
    sez[i].Dint:=0;
    sez[i].spes:=0;
    sez[i].form:=0;
    end
  end;
end;


procedure CancTub;far;
var riga:integer;
    i:integer;
begin
   riga:=getriga('eltubaz');
   if not riga<=maxtubaz then exit;
   for i:=Riga to MaxTubaz-1 do
    Tubaz_D^[i]:=Tubaz_D^[i+1];
   Init_Tubaz(MaxTubaz);
end;


procedure InserTub;far;
var riga:integer;
    i:integer;
begin
   ins_data:=false;
   riga:=getriga('eltubaz');
   if not riga<=maxtubaz then exit;
   for i:=MaxTubaz downto Riga+1 do
   Tubaz_D^[i]:=Tubaz_D^[i-1];
   Init_Tubaz(Riga);
   setdata:=true;
end;



PROCEDURE Eltubaz;
var i,Campo,Chiave,CF,Riga,Riga1,PrimoCampo,Modo:integer;

    InitMask1,InitMenu1:boolean;
    Tab1:^TabellaRec;
    Map1:^tabellaMap;
    PrCampo,UltCampo:integer;


procedure CaricaFin;
var i:integer;
begin
   for i:=1 to MaxTubaz do
    with fin^[i] do
     begin
        Descr:=Tubaz_D^[i].Descr;
        Cod  :=Tubaz_D^[i].cod;
        dens :=Tubaz_D^[i].dens;
        rug  :=Tubaz_D^[i].rug;
     end;
end;



procedure Cancella(Riga:integer);
var i:integer;
begin
   for i:=Riga to MaxTubaz-1 do
    Tubaz_D^[i]:=Tubaz_D^[i+1];
   Init_Tubaz(MaxTubaz);
end;


procedure Inserisci(Riga:integer);
var i:integer;
begin
   for i:=MaxTubaz downto Riga+1 do
   Tubaz_D^[i]:=Tubaz_D^[i-1];
   Init_Tubaz(Riga);
end;
(*
{$ifdef win}

procedure CancTub;
var riga:integer;
    i:integer;
begin
   riga:=getriga('eltubaz');
   for i:=Riga to MaxTubaz-1 do
    Tubaz_D^[i]:=Tubaz_D^[i+1];
   Init_Tubaz(MaxTubaz);
end;


procedure InserTub;
var riga:integer;
    i:integer;
begin
   riga:=getriga('eltubaz');
   for i:=MaxTubaz downto Riga+1 do
   Tubaz_D^[i]:=Tubaz_D^[i-1];
   Init_Tubaz(Riga);
end;

{$endif }

*)

BEGIN    {#############  Tubaz    ###############}
  new(fin);
  caricafin;
  initproc;
  procarr[11]:=cancltub;
  procarr[12]:=savetub;
  procarr[3]:=tubf3;
  procarr[5]:=CancTub;
  procarr[6]:=InserTub;
  tab_testo:=true;
  posx:=0;
  W_IOTABella(fin^,MaxTubaz,10,4,'Eltubaz.msk',false,procarr,true,code,fill_listagen,nil);
  if code=id_ok then m_tubo^.caricaliste;
END;   { PROC. eltubaz }
{------------------------------  valvole       ----------------------------}



Procedure Init_Valv1(riga:integer);
var i:integer;
begin
with VValv^[riga] do
  begin
   Cod  :='';
   Descr:='';
  end;
end;


 procedure CancFile(NomeFile:st80);
  var f:file;
  begin
     if Exist (NomeFile) then
      begin
         assign(f,NomeFile);
         Erase(f);
      end;
  end;

procedure EraseValv(NumValv:st80);

 begin
    GOTOXY(1,21);
    write(w_m(127),' ',numvalv); { Cancellazione valvola }
    CancFile(NumValv);
    {textbackground(col[1]);}
    gotoxy(1,21);clreol;
END;


procedure LoadArch;
type recarcv=record
                descr:string[50];
                cod  :string[8];
                end;
{arvalv=array[1..10]of recarcv;}

 var i:integer;
 var f:file of archvalv;
     f1:file of recarcv;
     {vv:^arvalv;}
     vv:^RecArcV;
 begin
    if Exist(drivearc+'valvole.ark') then
     begin
        {$I-}
        assign(f,drivearc+'valvole.ark');
        reset(f);
        read(f,VValv^);
        close(f);
        {$I+}
        if ioresult<>0 then
        begin
          assign(f1,drivearc+'valvole.ark');
          reset(f1);
          new(vv);
          fillchar(vv^,sizeof(vv^),0);
          fillchar(VValv^,sizeof(VValv^),0);
          i:=1;
          while not eof(f1) do
           begin
              read(f1,vv^);
              VValv^[i].Descr:=VV^.Descr;
              VValv^[i].Cod:=VV^.Cod;
              inc(i);

           end;

          close(f1);
          dispose(vv);
        end;
     end
    else
     begin
        for i:=1 to maxvalv do
         with VValv^[i] do
          begin
             Descr:='';
             COD:='';
          end;
      end;
  end;

(*
procedure LoadArch;
 var i:integer;
 var f:file of archvalv;
 begin
    if Exist(drivearc+'valvole.ark') then
     begin
        assign(f,drivearc+'valvole.ark');
        reset(f);
        read(f,VValv^);
        close(f);
     end
    else
     begin
        for i:=1 to maxvalv do
         with VValv^[i] do
          begin
             Descr:='';
             COD:='';
          end;
      end;
  end;
*)


procedure SaveArch;far;
var f:file of archvalv;
begin
   assign(f,drivearc+'valvole.ark');
   rewrite(f);
   write(f,VValv^);
   close(f);
   generains(1,'arkvalv.msk',Drivearc+'valvole.ark',Maxvalv,10,2,2,1,8,50);
end;





procedure SaveValv(nome:string);
var f:file of elvalv;
begin
  assign(f,nome);
  rewrite(f);
  write(f,valv_D^);
  close(f);
end;


procedure Cancella(Riga:integer);
var i:integer;
begin
   if Conferma('tubi.msg',' '+VValv^[riga].cod+w_m(52),3) then   { Conferma ? (S/N) }
   begin
     erasevalv(drivearc+VValv^[riga].cod+'.vlv');
     for i:=Riga to Maxvalv-1 do
     VValv^[i]:=VValv^[i+1];
     Init_Valv1(MaxValv);
   end;
end;


procedure Inserisci(Riga:integer);
var i:integer;
begin
   for i:=MaxValv downto Riga+1 do
   VValv^[i]:=VValv^[i-1];
   Init_Valv1(Riga);
end;


procedure canclarkvalv;far;
begin

end;
procedure salvavalv;far;

begin

end;

procedure valvf3;far;
var riga:integer;
begin
  initproc;
  riga:=getriga('arkvalv');
  if VValv^[Riga].Cod > '' then
  begin
    mess^[1]:=VValv^[Riga].Cod;
    if exist(drivearc+VValv^[Riga].Cod+'.vlv')then
    Loadvalv(drivearc+VValv^[Riga].Cod+'.vlv')
    else fillchar(Valv_D^,sizeof(Valv_D^),0);
    tab_testo:=true;
    posx:=0;
    W_IOTABella(Valv_D^,MaxCod,1,43,'valvole.msk',false,procarr,true,code,fill_listagen,tabellacorrente^[a_w].self);
    savevalv(drivearc+VValv^[riga].Cod+'.vlv');
  end
  else
  writemessage('tubi.msg',6);
  setdata:=false;
end;

PROCEDURE Elvalvole;
BEGIN    {#############  valvole    ###############}
  new(VValv);
  LoadArch;
  initproc;
  procarr[3]:=valvf3;
  tab_testo:=true;
  posx:=0;
  W_IOTABella(VValv^,Maxvalv,10,2,'arkvalv.msk',false,procarr,true,code,fill_listagen,nil);
  savearch;
  dispose(vvalv);
END;   { PROC. valv }

procedure canclperd;far;
begin

end;

procedure saveperd;far;
begin
  TRANSFER_Perd(DRIVEARC+'Archivio.PRD','S');
  generains(3,'Perdconc.msk',Drivearc+'\archivio.prd',MaxPerd,10,5,1,2,8,20);
end;

{------------------------------- Perdite -------------------------------------}
PROCEDURE Perdite;
var
  Chiave,Riga,campo:integer;
  Sct:boolean;


BEGIN    {############# Perdite  ###############}

  begin

    initproc;
    procarr[11]:=canclperd;
    procarr[12]:=saveperd;
    tab_testo:=true;
    posx:=0;
    W_IOTabella(Perd_D^,MaxPerd,10,5,'Perdconc.msk',false,procarr,true,code,fill_listagen,nil);
  end


END;   { PROC. Perdite }


{------------------------------- Terminali ---------------------------------}


Const MaxZone=30;
      



type  VentZone = Array[1..MaxZone] of real;
      Vent     = ARRAY[1..MaxAmbienti] OF REAL;
      ResTabZ1 = ARRAY[0..23,1..MaxZone] OF REAL;

var

  PVentZona : ^VentZone         ;
  PVent     : ^Vent;
  FV        : File of real;
  fg        : file of VentZone ;
  percSens  : real;
  PercLat   : Real;

Function CompRag(Rag:string):string;

var j,k,l,Lung:integer;
    Pass:boolean;

begin

  l:=1;

  Rag:=UpString(Rag);
  Rag:=setleft(setright(Rag));
  Lung:=length(Rag);
  repeat
    Pass:=true;
    for j:=1 to Lung-1 do
     begin
        if ((Rag[j] < 'A') or (Rag[j] > 'Z')) and
           ((Rag[j] < '0') or (Rag[j] > '9')) then
         begin
            Pass:=false;
            for k:=j to Lung-1 do Rag[k]:=Rag[k+1];
            Rag[Lung]:=' ';
         end;
     end;
    l:=l+1;
  until (l=Lung) or Pass;

  Rag:=SetLeft(SetRight(Rag));
  CompRag:=Rag;
end;

function ExistCalc(scelta:integer):boolean;
var ft:text;
    buf:st80;
    Drive1:st50;
    startpos,i: integer;
    ExitChar  : char;
    modflag   : boolean;
    pp        : text;
    RIDIS:BOOLEAN;
begin

   if exist(DriveExeCart+'calcok.tst') then
    begin
       Assign(ft,DriveExeCart+'calcok.tst');
       reset(ft);
       readln(ft,buf);
       buf:=FORMST(buf);
       NOMECOMMESSA:=FORMST(NOMECOMMESSA);
       if buf<>NOMECOMMESSA then
        begin
           ExistCalc:=false;
           WriteMessage('Carterm.msg',9)
        end
       else
         begin
            if (scelta = 65) and (not exist(DriveExeCart+'EREst.DAT')) and (not exist(DriveExeCart+'LatEff.DAT')) then
             begin
                ExistCalc:=false;
                WriteMessage('Carterm.msg',9)
             end
            else
             begin
                ExistCalc:=true;
                assign(fg,DriveExeCart+'VentZone.mic');
                reset(fg);
                read(fg,PVentZona^);
                close(fg);
                {.. lettura PVentZona ...}

                assign(fv,DriveExeCart+'Vent.mic');
                reset(fv);
                i:=0;
                while not eof(fv) do
                 begin
                   i:=i+1;
                   read(fv,PVent^[i]);
                 end;
                close(fv);
                {.. lettura PVent ...}

                if Scelta in[60,61,65] then
                 begin
                    Inp_real(Pmainwin,percsens,'Percentuale di sensibile','Valore in[%]',0,100);  (*tr*)
                    PercSens:=PercSens/100;
                    gotoxy(2,21);clreol;
                 end;
                if Scelta=65 then
                 begin

                    Inp_real(Pmainwin,perclat,'Percentuale di latente','Valorein[%]',0,100);(*tr*)
                    PercLat:=PercLat/100;
                    gotoxy(2,21);clreol;
                 end;
             end;
         end;
       close(ft);
    end
   else
    begin
       ExistCalc:=false;
       WriteMessage('Carterm.msg',9)
    end
end;



procedure CaricaPotenza(TipoScelta:integer);
type
      RecAmb=RECORD
           NPersone:INTEGER;      { N persone=ROUND(Affollamento/Superficie) }
           ProfiloOccupaz:INTEGER;{ Profilo Occupazione            [Cod]     }
           RicambioPersona:REAL;  { Ricambio per Persona                     }
           SensibilePersona:REAL; { Sensibile per Persona                    }
           LatentePersona:REAL;   { Latente per Persona                      }

           IlluminazFissa:REAL;   { Densita` di illuminazione parte fissa    }
           IlluminazVar:REAL;     { Densita` di illuminazione parte variabile}
           TipoIlluminaz:INTEGER; { Tipo di illuminazione          [Cod]     }
           ProfiloIlluminaz:INTEGER;{Profilo Illuminazione         [Cod]     }

           SensApparecch:REAL;    { Sensibile per Apparecchiature            }
           LatenteApparecch:REAL; { Latente per Apparecchiature              }
           RappRS:REAL;           { Radiante/sensibile [%]                   }
           ProfiloApparecch:INTEGER;{Profilo Apparecchiature       [Cod]     }


           InfInv,InfEst:REAL;     { Infiltrazioni estive e invernali        }
           Ventilazione:REAL;      { Ventilazione Meccanica                  }
           CircolazAria:INTEGER;   { Codice nel range 1..5                   }

           inf_risc    :real; { aggiunti x legge 10 }
           alfaSerra   :real; { aggiunti x legge 10 }
           alloggio    :integer; { aggiunti x disp }
           PotenzaWatt :real; { aggiunti x disp }

           CodNum:real;
           Denom:STring[20];
           Zona:INTEGER;
           Superficie:REAL;      { Superficie in pianta                      }
           HSoffitto:REAL;       { Altezza Soffitto                          }
           AmbientiUguali:INTEGER;{ Numero ambienti uguali                   }
         END; { RecAmb }


var i,j,y,x,ind:integer;
    Potenza:real;
   StLoc:string;
   Loca,Rad,Zon:integer;
   VarCom:real;
   famb                  : file of recamb;
   rigaamb               : recamb;
   amb                   : real;
   NA                    : integer;
   trovato               :boolean;

   var

      stzona                     : string[2];
      pian                       : integer;
      vval:integer;
      codice:string[8];


   Function PotAmb(P,A,Z:Integer):Real;






   type


       TyHM=ARRAY[0..23,1..12] OF REAL;

   VAR  M,H                   : integer;
        Sens,Lat,sapr,lapr    : TyHM;
        f1,f3,f4,f2           : file of TyHM;
        MaxPot                : Real;
        Drive1                : string[50];
        Rapporto              : real;
        RappSens,RappLat      : Real;

   begin
      assign(famb,DriveProgCart+'work.tub');
      reset(famb);
      trovato:=false;
      na:=0;
      while not eof(famb) and not trovato do
      begin
        read(famb,rigaamb);
        na:=na+1;
        amb:=p*1000+a;
        trovato:=rigaamb.codnum=amb;
      end;
      close(famb);
      if trovato then
      begin
      a:=na;
      assign(f1,DriveExeCart+'EREst.DAT');
      assign(f2,DriveExeCart+'LatEff.DAT');
      reset(f1);
      reset(f2);
      seek(f1,A-1);
      read(F1,Sens);
      seek(f2,A-1);
      read(F2,Lat);
      if (PVent^[A] <> 0) and (PVentZona^[z] <> 0) then rapporto:=PVent^[A]/PVentZona^[z]
      else rapporto:=0;
      assign(f3,DriveExeCart+'sapramb.dAT');
      assign(f4,DriveExeCart+'Lapramb.DAT');
      reset(f3);
      reset(f4);
      seek(f3,Z-1);
      read(F3,Sapr);
      seek(f4,Z-1);
      read(F4,Lapr);
      MaxPot:=0;
      For H:=0 to 23 do
       for m:=1 to 12 do
        begin
        if sapr[h,m]<0 then Rappsens:=Rapporto*PercSens
        else Rappsens:=Rapporto;

        if lapr[h,m]<0 then RappLat:=Rapporto*PercLat
        else RappLat:=Rapporto;

        if Sens[h,m]+Lat[h,m]+sapr[h,m]*RappSens+lapr[h,m]*rapplat>MaxPot Then
         begin
           MaxPot:=Sens[h,m]+Lat[h,m]+sapr[h,m]*RappSens+lapr[h,m]*rappLat;
          {if MaxPot <> 0 then S_T:=(Sens[h,m]+sapr[h,m]*rappsens)/MaxPot;}  { ***** }
         end;
        end;
      close(f1);
      Close(f2);
      close(f3);
      close(f4);
      PotAmb:=MaxPot;
      end else potamb:=0;
   end;

{+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+}

Function PotAmb_I(P,A,z:Integer):Real;

type

   TyH =ARRAY[0..23] OF REAL;

VAR  H           : integer;
     Sens        : TyH;
     f1          : file of TyH;
     MaxPot      : Real;
     Maxpot1     : Real;
     Drive1      : string[50];
     Rapporto    : Real;
     SaprI       : ResTabZ1;
     FSaprI      : File of ResTabZ1;
     RappSens    :Real;

begin
assign(famb,DriveProgCart+'work.tub');
reset(famb);
trovato:=false;
na:=0;
while not eof(famb) and not trovato do
begin
  read(famb,rigaamb);
  na:=na+1;
  amb:=p*1000+a;
  trovato:=rigaamb.codnum=amb;
end;
close(famb);
if trovato then
begin
a:=na;
assign(f1,DriveExeCart+'ERinv.DAT');
reset(f1);
seek(f1,A-1);
read(F1,Sens);
if (PVent^[A] <> 0) and (PVentZona^[z] <> 0) then rapporto:=PVent^[A]/PVentZona^[z]
else rapporto:=0;
assign(fsaprI,DriveExeCart+'sapriamb.Mic');
reset(fsaprI);
read(FsaprI,SaprI);
close(Fsapri);
MaxPot:=0;
MaxPot1:=0;
For H:=0 to 23 do
  begin
  if SaprI[h,z]<0 then Rappsens:=Rapporto*PercSens
  else Rappsens:=Rapporto;
  if Sens[h] > MaxPot1 Then
    begin
    MaxPot:=Sens[h]+SaprI[h,z]*Rappsens;
    MaxPot1:=Sens[h];
    end;
  end;
close(f1);
PotAmb_I:=MaxPot;
end else PotAmb_I:=0;
end;

Procedure Carica(Var i,j:Integer);
var StCod:string[10];
begin

   j:=-1;  { parto da meno uno perche uso un for per il caricamento;}
   Repeat
     StCod:=copy(Term_D^[i].Cod,1,6);
     i:=i+1;
     j:=j+1;
   Until (I > MaxTerm) or (StCod <> copy(Term_D^[i].Cod,1,6));
   if StCod='' then i:=MaxTerm+1;
end;

begin
   if not existcalc(tiposcelta) then exit;
   i:=1;
   repeat
      if Term_D^[i].Cod = ''then exit;
      y:=i;
      Carica(y,j);
      codice:=Term_D^[i].Cod;
      if Codice <> '-*-*-*-*'then
      begin
        val(Codice[1],Pian,vval);
        if vval <> 0 then Pian:=ord(Codice[1])-55;

        val(CompRag(copy(Codice,7,2)),Rad,vval);
        if vval <> 0 then exit;

        val(CompRag(copy(Codice,2,2)),zon,vval);
        if vval <> 0 then exit;

        val(CompRag(copy(Codice,4,3)),Loca,vval);
        if vval <> 0 then exit;
        str(zon,stzona);

        case tiposcelta of
        60,61:Potenza:=PotAmb_I(pian,Loca,zon);
           65:Potenza:=PotAmb(pian,Loca,zon);
        end;
      end;
      if j <> 0 then Potenza:=Potenza/(j+1);

      if Init_Fc then
       begin
          new(Zone_D);
          fillchar(Zone_D^,sizeof(Zone_D^),0);
          TRANSFER_ZONE(DriveProgCart+'work.ZON','L');
       end;
      Ind:=pos_ins(get_drive+'\carterm\disp\zone',2,Zone_D^[zon].TipoImpianto);
      if (Ind <> 3) and (Ind <> 4) then
      for x:=i to i+j do Term_D^[x].Pot:=Potenza;
      i:=y;
   until (i > MaxTerm);
end;

procedure Ordina;

 var Cella:RecTerm;
     Trovato:boolean;
     i,j:integer;
begin
   j:=1;
   repeat
     i:=1;
     Trovato:=false;

     while (Term_D^[i+1].Cod  > '') and (i < MaxTerm-1) do
      begin
         if Term_D^[i].Cod > Term_D^[i+1].Cod then
          begin
             Cella:=Term_D^[i];
             Term_D^[i]:=Term_D^[i+1];
             Term_D^[i+1]:=Cella;
             Trovato:=true;
          end;
         i:=i+1;
      end;

     j:=j+1;

  until (j>MaxTerm) or not Trovato;
end;
(*
Function Ult_Term(Nome:string{;var Trovato:boolean}):integer;
  var Ult,j:integer;
      Trovato:boolean

  begin
     Ult:=MaxTerm;
     while (Term_D^[Ult].Cod = '') and (Ult > 1) do Ult:=Ult-1;
     j:=1;
     repeat
       Trovato:=UpString(Term_D^[j].Cod)=UpString(Nome);
       if Not Trovato then j:=j+1;
     until Trovato or (j > Ult);

     if j > 1 then
      if Term_D^[j-1].Cod='' then j:=j-1;

     if not Trovato then Ult_Term:=j
     else Ult_Term:=MaxTerm+1;
  end;
*)

(*Procedure CaricaTerm;far;
const NProgetti = MaxSot;

var i:integer;
    f:file of Archivio;
    Trovato,Pieno,flag10:boolean;

 Function Controllo(Nome:string;var Trovato:boolean):integer;
  var Ult,j:integer;
  begin
     Ult:=MaxTerm;
     while (Term_D^[Ult].Cod = '') and (Ult > 1) do Ult:=Ult-1;
     j:=1;
     repeat
       Trovato:=UpString(Term_D^[j].Cod)=UpString(Nome);
       if Not Trovato then j:=j+1;
     until Trovato or (j > Ult);

     if j > 1 then
      if Term_D^[j-1].Cod='' then j:=j-1;

     if not Trovato then Controllo:=j;
  end;

 Procedure LeggiTerm(Nome:string;Pieno:boolean);
  var Punt:integer;
      Gt:RecGTerm;
      i:integer;
      flag11:boolean;
  begin
     if Nome <> ''then
      begin
         if exist(Nome+'.ter') then
          begin
             assign(fGT,Nome+'.ter');reset(fgt);
             while not(eof(fgt)) do
              begin
                 read(fgt,GT);

                 if (GT.cod<>'') then
                 begin
                   flag11:=true;
                   for i:=1 to Nprogetti do
                   begin
                     if vprog^[i].nome>'' then
                     if (upstring(gt.cod)=upstring(vprog^[i].nome)) then  flag11:=false;
                   end;
                   if flag11 then
                   begin
                     Punt:=Controllo(GT.cod,Trovato);
                     if not Trovato then
                     if Punt <= MaxTerm then Term_D^[Punt].Cod:=UpString(GT.cod)
                     else
                     begin
                       Writemessage('Carterm.msg',19);
                       Pieno:=true;
                       exit;
                     end;
                   end;
                 end;
              end;
             close(fgt);
          end;
      end;
      setdata:=true;
  end;
begin
   Pieno:=false;
   flag10:=false;
   if Conferma('tubi.msg',' '+w_m(52),4) then Init_term;
   if exist(DRIVEPROG+NumeroProg+'.SOT') then
    begin
       assign(f,DRIVEPROG+NumeroProg+'.SOT');
       reset(f);
       read(f,VProg^);
       close(f);
       for i:=1 to Nprogetti do
        begin
           if formst(vprog^[i].nome)>'' then
           LeggiTerm(DRIVEPROG+VProg^[i].Nome,Pieno);
           if Pieno then exit;
        end;
   end
   else fillchar(Vprog^,sizeof(vprog^),0);
   flag10:=true;
   if not Pieno then
   LeggiTerm(DRIVEPROG+NumeroProg,Pieno);

   Ordina;
end;
*)


 Procedure ClearTerm(ZonaCart:integer);
  var
    i,ZonaF,vval:integer;

  begin
     for i:=1 to MaxTerm do
      begin
       val(CompRag(copy(Term_D^[i].Cod,2,2)),ZonaF,vval);
       if vval = 0 then
        if (ZonaCart=ZonaF) then  Term_D^[i].Cod:='';
      end;
     TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','S');
     TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','L');
  end;


 Function Controllo(Nome:string;var Trovato:boolean):integer;
  var Ult,j:integer;
  begin
     Ult:=MaxTerm;
     while (Term_D^[Ult].Cod = '') and (Ult > 1) do Ult:=Ult-1;
     j:=1;
     repeat
       Trovato:=formst(Term_D^[j].Cod)=formst(Nome);
       if Not Trovato then j:=j+1;
     until Trovato or (j > Ult);

     if j > 1 then
      if Term_D^[j-1].Cod='' then j:=j-1;

     if not Trovato then Controllo:=j;
  end;



Procedure CaricaTerm;


const NProgetti = MaxSot;

var i,Punt:integer;
    f:file of Archivio;
    Trovato,Pieno:boolean;
    ff:file of RecCalcFanP;
    RigaFan:RecCalcFanP;
    n_z1:string[5];

(*
 Function Controllo(Nome:string;var Trovato:boolean):integer;
  var Ult,j:integer;
  begin
     Ult:=MaxTerm;
     while (Term_D^[Ult].Cod = '') and (Ult > 1) do Ult:=Ult-1;
     j:=1;
     repeat
       Trovato:=formst(Term_D^[j].Cod)=formst(Nome);
       if Not Trovato then j:=j+1;
     until Trovato or (j > Ult);

     if j > 1 then
      if Term_D^[j-1].Cod='' then j:=j-1;

     if not Trovato then Controllo:=j;
  end; *)

 Procedure LeggiTerm(Nome:string;Pieno:boolean);
  var Punt:integer;
      Gt:RecGTerm;
      i:integer;
      flag11:boolean;
  begin
     if Nome <> ''then
      begin
         if exist(Nome+'.ter') then
          begin
             assign(fGT,Nome+'.ter');reset(fgt);
             while not(eof(fgt)) do
              begin
                 read(fgt,GT);

                 if (GT.cod<>'') then
                 begin
                   flag11:=true;
                   for i:=1 to Nprogetti do
                   begin
                     if vprog^[i].nome>'' then
                     if (formst(gt.cod)=formst(vprog^[i].nome)) then  flag11:=false;
                   end;
                   if flag11 then
                   begin
                     Punt:=Controllo(GT.cod,Trovato);
                     if not Trovato then
                     if Punt <= MaxTerm then
                      begin
                         Term_D^[Punt].Cod:=formst(GT.cod);
                         {CaricaPerd(Term_D^[Punt].Cod);}
                      end
                     else
                     begin
                       Writemessage('Carterm.msg',19);
                       Pieno:=true;
                       close(fgt);
                       exit;
                     end;
                   end;
                 end;
              end;
             close(fgt);
          end;
      end;
      setdata:=true;
  end;

begin
   Pieno:=false;
   if Conferma('tubi.msg',' '+w_m(52),4) then Init_term;
   if exist(DRIVEPROG+NumeroProg+'.SOT') then
    begin
       assign(f,DRIVEPROG+NumeroProg+'.SOT');
       reset(f);
       read(f,VProg^);
       close(f);
       for i:=1 to Nprogetti do
        begin
           if formst(vprog^[i].nome)>'' then
           LeggiTerm(DRIVEPROG+VProg^[i].Nome,Pieno);
           if Pieno then exit;
        end;
    end
   else fillchar(Vprog^,sizeof(vprog^),0);
   if not Pieno then
   LeggiTerm(DRIVEPROG+NumeroProg,Pieno);
   Ordina;
end;

procedure LoadIntMc4(NFile:string);
var f:file of RecIntMc4;
    i:integer;
begin
    fillchar(PunMc4^,sizeof(PunMc4^),0);
    if exist(NFile) then
     begin
        assign(f,NFile);
        reset(f);
        i:=0;
        while not eof(f) do
         begin
            i:=i+1;
            read(f,PunMc4^[i]);
         end;
        close(f);
     end;
end;

 Function ControlloPerd(Nome:string):integer;
  var Ult,j:integer;
      Trovato:boolean;
  begin
     Ult:=MaxPerd;
     while (Perd_D^[Ult].Cod = '') and (Ult > 1) do Ult:=Ult-1;
     j:=1;
     repeat
       Trovato:=formst(Perd_D^[j].Cod)=Formst(Nome);
       if Not Trovato then j:=j+1;
     until Trovato or (j > Ult);

     if j > 1 then
      if Perd_D^[j-1].Cod='' then j:=j-1;

     ControlloPerd:=j;
  end;

function TrovaInArchivio(Nome,Ditta:string):integer;
var
   i:integer;
   trovato:boolean;
begin
   i:=1;
   repeat
      Trovato:=Formst(Nome)=Formst(Ditta+PunMc4^[i].Codice);
      if not trovato then i:=i+1;
   until Trovato or (i > maxmc4);
   if Trovato then TrovaInArchivio:=i
   else TrovaInArchivio:=0;
end;


 Procedure CaricaPerd(Nome,Ditta:string);
  var P:integer;
      i,j:integer;

  begin

     P:=ControlloPerd(Nome);
     if P <= MaxPerd then
      begin
         Perd_D^[P].Cod:=Nome;
         j:=TrovaInArchivio(Nome,Ditta);
         if j > 0 then
          begin
             Perd_D^[P].Leq:=PunMc4^[j].PortInv;
             Perd_D^[P].Zeta:=PunMc4^[j].Perd;
          end;
      end

  end;



function LeggiZonaTerm(Nome:string;Riga:integer):boolean;
  var
      Gt:RecGTerm;
      i,zon,vval:integer;
      Trovato:boolean;
      Codice:st10;
  begin
     Trovato:=false;
     if exist(Nome+'.ter') then
      begin
         assign(fGT,Nome+'.ter');reset(fgt);
         while (not(eof(fgt))) and (not Trovato) do
          begin
             read(fgt,GT);
             if (GT.cod<>'') then
              begin
                 Codice:=formst(GT.cod);
                 val(CompRag(copy(Codice,2,2)),zon,vval);
                 if vval <> 0 then exit;
                 if Zon=Riga then Trovato:=true;
              end;
          end;
      end;
     LeggiZonaTerm:=Trovato;
  end;



procedure CaricaTermFancoil;
var ind,i,Punt,riga,TipoPort,j:integer;
    Trovato,uscita:boolean;
    ff:file of RecCalcFanP;
    RigaFan:RecCalcFanP;
    n_z1:string[5];

begin
 {new(PunMc4);} {spostato}
 if not exist(DriveProgCart+'work.ZON') then exit;

 if Init_Fc then new(Zone_D);
 fillchar(Zone_D^,sizeof(Zone_D^),0);
 TRANSFER_ZONE(DriveProgCart+'work.ZON','L');

 Trovato:=false;
 for i:=1 to MaxZone do
  begin
     Ind:=pos_ins(get_drive+'\carterm\disp\zone',2,Zone_D^[i].TipoImpianto);
     Trovato:=Trovato or (Ind=3) or (Ind=4);
  end;
 if Init_Fc then dispose(Zone_D);

 if not Trovato then exit;
 if Init_Fc then Init_fancoil;

  ControllaLettura;

  Uscita:=false;
  Riga:=1;
  repeat
   j:=1;
   Ind:=pos_ins(get_drive+'\carterm\disp\zone',2,Zone_D^[riga].TipoImpianto);
   if ((Ind = 3) or (ind =4))and(formst(Conf^.CodTerm)='N') then
   repeat
     {Trovato:=Formst(TabZoneFan^[j].ProgTubi)=Formst(NumeroProg);}
     Trovato:=(TabZoneFan^[j].ZonaCart=Riga) and(Formst(TabZoneFan^[j].ProgTubi)=Formst(NumeroProg));
     if Trovato then
      if TabZoneFan^[j].DataCalc <> DataCalc then
       begin
         CalcoloFancoil;
         Uscita:=true;
      end;
      if not Trovato then j:=j+1;
   until (j>MaxZone) or Trovato;
   if not Trovato then
    begin
       if LeggiZonaTerm(DRIVEPROG+NumeroProg,Riga) then
        begin
          CalcoloFancoil;
          Uscita:=true;
        end;
    end;
   Riga:=Riga+1;
  until (Riga > MaxZone) or Uscita;
  {in questo modo testa i calcoli solo delle zona che mi servono }

 new(PunMc4);
 Riga:=1;
 TipoPort:=pos_ins(get_drive+'\tubi\inpgraf\definfan',20,Deffan^.QualePort);
 repeat
     Ind:=pos_ins(get_drive+'\carterm\disp\zone',2,Zone_D^[riga].TipoImpianto);
    { if (Ind=3) or (Ind=4) then}
     if ((Ind = 3) or (ind =4))and(formst(Conf^.CodTerm)='N') then
      begin
        if AggCalcPort = 0 then
         begin
          if Term_D^[1].PortEff > 0 then AggCalcPort:=2
          else AggCalcPort:=1;
         end;
        ClearTerm(Riga);
        trovato:=false;
        for j:=1 to maxzone do
         begin
           trovato:=(TabZoneFan^[j].ZonaCart=Riga) and(Formst(TabZoneFan^[j].ProgTubi)=Formst(NumeroProg));
           if Trovato then
            begin
               {AggCalc:=true;}
               str(TabZoneFan^[j].ZonaCart,N_Z1);
               NProgFan:=DriveProgCart+TabZoneFan^[j].ProgTubi+'.F'+N_Z1;
               LoadIntMc4(DRIVEARCI+TabZoneFan^[j].Costruttore+'.AFC');
               {Punt:=Ult_Term('******',Trovato);
               if Punt > MaxTerm then exit;}
               if exist(nprogfan) then
               begin
               assign(ff,NProgFan);
               reset(ff);
               while (not eof(ff)){ and (Punt <= MaxTerm)} do
                begin
                   read(ff,RigaFan);
                   Punt:=Controllo(RigaFan.CodFan,Trovato);
                   if not Trovato then
                   if Punt <= MaxTerm then
                   begin
                   with Term_D^[Punt] do
                    begin
                      Cod:=RigaFan.CodFan;
                      case TipoPort of
                       1:Port:=RigaFan.PoEst;
                       2:Port:=RigaFan.Poinv;
                       3:Port:=RigaFan.QEst;
                       4:Port:=RigaFan.QInv;
                      else Port:=RigaFan.PoEst;
                      end;
                      if Port < 0.0001 then Port:=0.0001;
                      CodPerd:=RigaFan.Codice;
                      CaricaPerd(CodPerd,TabZoneFan^[j].Costruttore);
                    end;
                   end;
                   {Punt:=Punt+1;}
                end;
               close(ff);
               end;
            end;
         end;
      end;
  Riga:=Riga+1;
 until (Riga > MaxZone);
 Ordina;
 dispose(PunMc4);
 TRANSFER_Perd(DRIVEARC+'Archivio.PRD','S');
end;


Procedure CalcPort;far;
var i:integer;
begin

if FluM_d^.Deltat>0 then
  begin
  if FluM_D^.Calsp>0 then
    begin
    if FluM_D^.Dens>0 then
      begin
      for i:=1 to MaxTerm do
      if Term_D^[i].Pot<>0 then
      Term_D^[i].Port:=term_D^[i].Pot   /
                          Flum_D^.Calsp /
                           FluM_D^.Dens /
                         FluM_d^.Deltat
      end
    else Writemessage('Carterm.msg',15);
    end
  else Writemessage('Carterm.msg',14);
  end
else Writemessage('Carterm.msg',13);
setdata:=true;
end;


procedure canclterm;far;
begin

end;

procedure saveterm;far;
begin
  TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','S');
  dispose(pvent);
  dispose(pventzona);
end;

procedure termf2;far;
begin
  CaricaPotenza(60);

  setwinactive('elterm');

  setdata:=true;
end;
procedure termf7;far;
begin
  CaricaPotenza(65);

  setwinactive('elterm');

  setdata:=true;
end;


procedure termf8;far;
begin
  if conferma('tubi.msg','',4) then
  begin
    transfer_term(DRIVEARC+'UFFICI.TRM','L');
  end;
  SETDATA:=TRUE;
end;

procedure termf9;far;
begin
  if conferma('tubi.msg','',4) then
  begin
    transfer_term(DRIVEARC+'ABITAZ.TRM','L');
  end;
  SETDATA:=TRUE;
end;

Procedure CaricaTerminali;
var xx:integer;
begin
   CaricaTerm;
   xx:=a_w;
   CaricaTermFancoil;
   a_w:=xx;
end;


PROCEDURE Terminali;
var
  campo     :integer;
  Chiave,Riga:integer;
  Sct:boolean;

BEGIN    {############# Terminali  ###############}
 pdw^.salva_dis;
 {caricaterm;}
 ar_ins^[6].ncampo:=6;
 ar_ins^[6].nfile:=drivearc+'\perdconc.ins';
 new(pvent);
 new(pventzona);
 initproc;
 transfer_term(DRIVEPROG+NumeroProg+'.TRM','L');
 procarr[11]:=canclterm;
 procarr[12]:=saveterm;
 procarr[2]:=termf2;
 procarr[7]:=termf7;
 procarr[1]:=Caricaterminali;
 procarr[4]:=calcport;
 procarr[8]:=termf8;
 procarr[9]:=termf9;
 tab_testo:=true;
 posx:=0;
 W_IOTabella(Term_D^,MaxTerm,10,6,'ElTerm.msk',false,procarr,true,code,fill_listagen,nil);
 if code=id_ok then c_nomesimb^.caricaliste;
 END;   { PROC. Terminali }

{------------------------------- Montaggi ---------------------------------}

procedure canclmont;far;
begin

end;
procedure savemont;far;
begin
  TRANSFER_Mont(DRIVEARC+'Archivio.MNT','S');
end;

PROCEDURE Montaggi;
var
  Chiave,Riga,campo:integer;
  Sct:boolean;
BEGIN    {############# Montaggi  ###############}
  begin
    initproc;
    procarr[11]:=canclmont;
    procarr[12]:=savemont;
    tab_testo:=true;
    posx:=0;
    W_IOTabella(Mont_D^,MaxMont,10,10,'Mont.msk',false,procarr,true,code,fill_listagen,nil);
    if code=id_ok then m_mont^.caricaliste;
  end

END;   { PROC. Montaggi }

{------------------------------- Fluidi ---------------------------------}

procedure canclfluidi;far;
begin

end;

procedure savefluidi;far;
begin
  TRANSFER_Flu(DRIVEARC+'Archivio.FLU','S');
  generains(3,'Flu.msk',Drivearc+'\archivio.flu',MaxFlu,10,8,2,1,8,8);
end;


PROCEDURE Fluidi;
var
  Chiave,Riga,campo:integer;
  Sct:boolean;


BEGIN    {############# Fluidi  ###############}
  begin

    initproc;
    procarr[11]:=canclfluidi;
    procarr[12]:=savefluidi;
    tab_testo:=true;
    posx:=0;
    W_IOTabella(Flu_D^,MaxFlu,10,8,'Flu.msk',false,procarr,true,code,fill_listagen,nil);
  end

END;   { PROC. Fluidi }
{---------------------------------  fluido  --------------------------------}

type
  RigaFlu = RECORD
               cod:string[8];
               tm,pm:real;
               dens,visc,calsp,pesmol:real;
               callat:real;
             END;


{-------------------------------RICERCA---------------------------------------}
procedure FIND_ARCHIVIO(nome:st8;temp:real;var Elem:Rigaflu);
{ Cerca all'interno di ARCHIVIO il fluido e restituisce la posi_
  zione in tabella (indice dell'array ARCHIVIO) }
VAR
  I,j:INTEGER;
  Trovato,trovato1:boolean;
  Dato:st25;
  f:file of Rigaflu;
  elem1:rigaflu;

BEGIN
  with elem do
  begin
  cod:='';
  tm:=0;
  pm:=0;
  dens:=0;
  visc:=0;
  calsp:=0;
  pesmol:=0;
  CalLat:=0;
  end;
  nome:=upstring(nome);
  I:=1;   Trovato:=false;
  trovato1:=false;
  assign(f,drivearc+'archivio.flu');
  reset(f);
  WHILE not eof(f) and not Trovato1 do
   begin
      read(f,Elem1);
      Dato:=upstring(Elem1.cod);

      Trovato:=Dato=nome;
      if trovato then
      begin
        Elem:=Elem1;
        Trovato1:=(Temp=Elem1.tm);
      end;
   end;
  close(f);

END;


procedure fluidof10;far;
var Elem:RigaFlu;
begin
  with FluM_D^ do
  begin
    Find_Archivio(cod,tm,Elem);
    if elem.cod<>'' then cod:=Elem.cod;
    tm:=Elem.tm;
    pm:=Elem.pm;
    dens:=elem.dens;
    visc:=Elem.visc;
    calsp:=Elem.calsp;
    pesmol:=Elem.pesmol;
    callat:=elem.callat;
  end;
end;

procedure canclfluido;far;
begin

end;

procedure savefluido;far;
begin
  TRANSFER_FLUM(DRIVEPROG+NumeroProg+'.FLU','S');
end;

PROCEDURE fluido;

VAR
  Campo,Chiave,Error:INTEGER;
  CH:CHAR;


BEGIN
  ar_ins^[1].ncampo:=1;
  ar_ins^[1].nfile:=drivearc+'\flu.ins';
  ar_ins^[1].ncampoagg:=2;
  ar_ins^[1].ncampiriga:=2;
  begin
  initproc;
  procarr[10]:=fluidof10;
  procarr[11]:=canclfluido;
  procarr[12]:=savefluido;
  tab_testo:=true;
  posx:=0;
  W_UsaMaskera(FluM_D^,'FLUIDO.MSK',procarr,true,code,fill_listagen,nil);
  end
  
END;    { Fluido }
var esci:boolean;
{---------------------------- ERRORI ---------------------------------}
procedure canclerrori;far;
begin
  dispose(erroriv);
end;
procedure viserrori;
var f:file of elerrore;
    initmenu:boolean;
    campo,chiave,riga:integer;
    initmask:boolean;
    i:integer;
begin
 initproc;

 begin
 new(erroriv);
 for i:=1 to maxerrori do
with erroriv^[i] do
begin
  sottorete:='';
  terminale:='';
  tronco:='';
  descr:='';
end;
if exist(drivetubi+'errori.dat') then
begin
   assign(f,drivetubi+'errori.dat');
   reset(f);
   read(f,erroriv^);
   close(f);
end;
 procarr[12]:=canclerrori;
 tab_testo:=true;
 posx:=0;
 W_IOTabella(erroriv^,maxerrori,10,4,'conerror.msk',false,procarr,true,code,fill_listagen,nil)
 end
end;

procedure InitCopie;
var i : integer;

begin
   with buffer^ do
   begin
      for i:=1 to 4 do  Scelte[i]:=0;
      NCopie := 1;
   end;
end;

{ ---------------------------- EseguiStampa --------------------------------- }

Procedure ESEGUISTAMPA(var BufferOK : boolean);
begin

 BufferOk := false;

 BufferOk := ( (Buffer^.scelte[1] >= 0) AND (Buffer^.scelte[1] <=4) AND
               (Buffer^.scelte[2] >= 0) AND (Buffer^.scelte[2] <=4) AND
               (Buffer^.scelte[3] >= 0) AND (Buffer^.scelte[3] <=4) AND
               (Buffer^.scelte[4] >= 0) AND (Buffer^.scelte[4] <=4) AND
               (Buffer^.NCopie >=0 ) );

end;

{ ---------------------------- StampeTotali --------------------------------- }

procedure StampeTotali(var Chiave1: integer);

var ok,InitMask : boolean;
    campo       : integer;
    f:file of stampa;

begin
   InitCopie;
   ok := true;
   repeat
     if not ok then writemessage('tubi.msg',7);
     tab_testo:=true;
     posx:=0;
     w_usamaskera(Buffer^,'stampe.msk',procarr,true,code,fill_listagen,nil);
     case code of
     id_ok:chiave1:=27;
     id_cancel:chiave1:=59;
     end;

     if chiave1 = 59 then exit;{annulla stampe}
     EseguiStampa(Ok);

   until OK ;
   assign(f,drivetubi+'Buffer.dat');
   rewrite(f);
   write(f,Buffer^);
   close(f);
end;

Procedure salvaterm;
begin
   TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','S');
end;

 (*

 Procedure Load_Term(Nome:string);
  var Punt:integer;
      Gt:RecGTerm;
      f:file of Archivio;
      i:integer;
      Trovato:boolean;
  begin
     if Nome <> ''then
      begin
         if exist(Nome+'.ter') then
          begin
             if exist(DRIVEPROG+NumeroProg+'.SOT') then
              begin
                 assign(f,DRIVEPROG+NumeroProg+'.SOT');
                 reset(f);
                 read(f,VProg^);
                 close(f);
              end
             else fillchar(Vprog^,sizeof(vprog^),0);

             assign(fGT,Nome+'.ter');reset(fgt);
             while not(eof(fgt)) do
              begin
                 read(fgt,GT);

                 if (GT.cod<>'') then
                 begin
                   Trovato:=true;
                   for i:=1 to MaxSot{Nprogetti} do
                   begin
                     if vprog^[i].nome>'' then
                     if (upstring(gt.cod)=upstring(vprog^[i].nome)) then  Trovato:=false;
                   end;
                   if Trovato then
                   begin
                     Punt:=Ult_Term(GT.cod,Trovato);
                     if not Trovato then
                     if Punt <= MaxTerm then Term_D^[Punt].Cod:=UpString(GT.cod)
                     else
                     begin
                       Writemessage('Carterm.msg',19);
                       exit;
                     end;
                   end;
                 end;
              end;
             close(fgt);
          end;
      end;
      setdata:=true;
  end;


 Procedure PulisciTerm(Nome:string);
  var Gt:RecGTerm;
      i:integer;
  begin
     if Nome <> ''then
      begin
         if exist(Nome+'.ter') then
          begin
             assign(fGT,Nome+'.ter');reset(fgt);
             while not(eof(fgt)) do
              begin
                 read(fgt,GT);

                 if (GT.cod<>'') then
                 begin
                   for i:=1 to MaxTerm do
                   begin
                     if (upstring(gt.cod)=upstring(Term_D^[i].Cod)) then  Term_D^[i].Cod:='';
                   end;
                 end;
              end;
             close(fgt);
             TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','S');
             TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','L');
          end;
      end;
  end;
*)

procedure prepstampa;
begin
end;
{---------------------------- START GESTMENU ---------------------------------}
PROCEDURE GEST_MENU(var uscita:integer);
BEGIN
  esci:=false;
  REPEAT

      CASE uscita OF
       31:GENERALITA;
       22:ELTUBAZ;
       23:PERDITE;
       33:TERMINALI;
       24:MONTAGGI;
       25:FLUIDI;
       26:ELVALVOLE;
       32:FLUIDO;
       56:VISERRORI;
       60:stampetotali(chiave1);
       else esci:=true;
      end;
       if (numeroprog='')and(chiave1>=30)and(chiave1<>70)then
          begin
          writemessage('carterm.msg',10);
          chiave1:=21;
          esci:=true;
          end;
       uscita:=chiave1;
  UNTIL esci;
END;  { PROC. GEST_MENU }

Procedure PreparaFancoil;
begin
  if Term_D=NIL then
   begin
      Init_Term;
      TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','L');
   end;
  CaricaTermFancoil;
  TRANSFER_Term(DRIVEPROG+NumeroProg+'.TRM','S');

end;


End.

(*  salvataggio caricafancoil
begin
 new(ZonaC);
 new(ZoneFan);
 new(PunMc4);
 if not exist(DriveProgCart+'work.ZON') then exit;
 TRANSFER_ZoneF(DriveProgCart+'work','L');
 if not exist(DriveProgCart+'work.FAN') then CalcoloFancoil;
 assign(fl,DriveProgCart+'work.ZON');
 reset(Fl);
 Riga:=0;
 readDef;
 TipoPort:=pos_ins(get_drive+'\tubi\inpgraf\definfan',20,Deffan^.QualePort);
{ TipoPort:=TipoPort+1;} {da togliere quando metto a posto l'ins}
 while not (eof(fl)) do
  begin
     read(fl,ZonaC^);
     Riga:=Riga+1;
     Ind:=pos_ins(get_drive+'\tubi\inpgraf\zone',2,ZonaC^.TipoImpianto);
     if (Ind=3) or (Ind=4) then
    { if (ZonaC^.TipoImpianto='FANCOIL') then}
      begin
        ClearTerm(Riga);
        trovato:=false;
        assign(Fx,DriveProgCart+'work.FAN');
        reset(Fx);
        while not(EOF(Fx)) DO
        begin
           READ(Fx,ZoneFan^);
           trovato:=(ZoneFan^.ZonaCart=Riga) and(Upstring(ZoneFan^.ProgTubi)=upstring(NumeroProg));
           if Trovato then
            begin
               str(ZoneFan^.ZonaCart,N_Z1);
               NProgFan:=DriveProgCart+ZoneFan^.ProgTubi+'.F'+N_Z1;
               LoadIntMc4(DRIVEARCI+ZoneFan^.Costruttore+'.AFC');
               Punt:=Ult_Term('******',Trovato);
               if Punt > MaxTerm then exit;
               if not exist(nprogfan) then exit;
               assign(ff,NProgFan);
               reset(ff);
               while (not eof(ff)) and (Punt <= MaxTerm) do
                begin
                   read(ff,RigaFan);
                   with Term_D^[Punt] do
                    begin
                      Cod:=RigaFan.CodFan;
                      case TipoPort of
                       1:Port:=RigaFan.PoEst;
                       2:Port:=RigaFan.Poinv;
                       3:Port:=RigaFan.QEst;
                       4:Port:=RigaFan.QInv;
                      else Port:=RigaFan.PoEst;
                      { if RigaFan.PoEst > RigaFan.Poinv then Port:=RigaFan.PoEst
                         else Port:=RigaFan.Poinv;}
                      end;
                      if Port < 0.0001 then Port:=0.0001;
                      CodPerd:=RigaFan.Codice;
                      CaricaPerd(CodPerd,ZoneFan^.Costruttore);
                    end;
                   Punt:=Punt+1;
                end;
               close(ff);
            end;
        end;
       close(fx);
      end;
  end;
 Ordina;
 dispose(ZonaC);
 dispose(ZoneFan);
 dispose(PunMc4);
 TRANSFER_Perd(DRIVEARC+'Archivio.PRD','S');
end;
*)


function LeggiZonaTerm(Nome:string;Riga:integer):boolean;
  var
      Gt:RecGTerm;
      i,zon,vval:integer;
      Trovato:boolean;
      Codice:st10;
  begin
     Trovato:=false;
     if exist(Nome+'.ter') then
      begin
         assign(fGT,Nome+'.ter');reset(fgt);
         while (not(eof(fgt))) or (not Trovato) do
          begin
             read(fgt,GT);
             if (GT.cod<>'') then
              begin
                 Codice:=formst(GT.cod);
                 val(CompRag(copy(Codice,2,2)),zon,vval);
                 if vval <> 0 then exit;
                 if Zon=Riga then Trovato:=true;
              end;
          end;
      end;
     LeggiZonaTerm:=Trovato;
  end;

