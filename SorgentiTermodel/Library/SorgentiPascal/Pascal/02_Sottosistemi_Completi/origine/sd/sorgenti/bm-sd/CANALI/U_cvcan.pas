
Unit U_CvCan;

Interface

uses
{$Ifdef Windef}
  Dummyfunction,sysutils ,
{$else}
  Crt,
  Dos,
{$endif}
definizcan,definiz,varcarichi,Angoli,LOad_d,WM,defuti,init_cca,load_p,disperrori,UGestpezzi,copialibreriagenerale;

Procedure Cvcan(Var IndErr:integer);
FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;


Implementation
//uses UMain_calctubi;
{--------------------------------  SETLEFT  ----------------------------------}
FUNCTION SETLEFT(ST:ST126):ST126;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }

{--------------------------------  SETright  ----------------------------------}
FUNCTION SETRIGHT(ST:ST126):ST126;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }

{------------------------RICERCA-------------------------}

FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      Codice:= UPString(Codice);
      Codice:= SetLeft(SetRight(Codice));

      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
           Archivio^[i].CodPezzo:= UPString(Archivio^[i].CodPezzo);
           Archivio^[i].CodPezzo:= SetLeft(SetRight(Archivio^[i].CodPezzo));
           Trovato := (Archivio^[I].CodPezzo = Codice);
           IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN FIND_ARCHIVIO := 0
      ELSE FIND_ARCHIVIO := I;

    END;
    (*
Procedure Indpezzo(Codice : ST5) : INTEGER;
begin
result:=find_archivio(codice);
end;  *)

{---------------------------------------------------------------------------}

Procedure Cvcan(Var IndErr:integer);

(*
const
   Ltabramo=16;
   NPezzi = 260;

Type

    RigaRamo = RECORD
                 CodPezzo : STRING[5];
                 Descr : STRING[40];
                 CHFlag : CHAR;
                 Portata, Perdita : REAL;
                 A_D : INTEGER;
                 H, W, Ang, Phi : INTEGER;
                 L, R, ComVal : REAL;
                 C0, X, Y : REAL;
               END;

    Link    =^TabRamo;

    TabRamo = RECORD
                T : ARRAY[0..LTabRamo] OF RigaRamo;
                Ps, Pd, Pc : LINK;
                TR : BOOLEAN;
                CodTab : INTEGER;
              END;


type  oldint=shortint;


    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : string[41];
                 CodDis : OldInt;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez :STRING[5];// ST5;
                 NUscite : oldint;
               END;

    T_ARCHIVIO = ARRAY[1..NPezzi] OF RigaArch;
 *)
 type 
  RecErrori=record
               DaNodo,Anodo:integer;
               Quota:real;
               NPezzo:integer;
               Cod:string[30];
               DescrEr:string[48];
            end;
   TErrori=array[1..50] of RecErrori;


   st126=string[126];

var Tab      : Link;//TabRamo
    //Fcan     :file of tabramo;
    //P0       :link;
    //Archivio :^T_archivio;
    fArc      : file of RigaArch;
    orient,NUsc,UltNodo:integer;
    vrt   :recVert;
    c_Dir,c_DirZ:real;
    CanVert:Boolean;
    Trovato        :Boolean;
    TabErrori:^TErrori;


  procedure InitErrori;
  var i:integer;
   begin
      UltNodo:=0;
      IndErr:=1;
      for i:=1 to 50 do
       with TabErrori^[i] do
       begin
          DaNodo:=0;  Anodo:=0;
          Quota:=0;   NPezzo:=0;
          Cod:='';    DescrEr:='';
       end;
   end;

 procedure WriteErrori;
 var i:integer;
 // f:file of TErrori;
  begin
 //    assign(f,driveProg+'Errori.dat');
     if IndErr <> 1 then
      begin
      For i:=1 to inderr do
      with TabErrori^[i] do
      RWRITE_E(cod+' '+DescrEr)
//         rewrite(f);
//         write(f,TabErrori^);
//         close(f);
//         textcolor(15);
//         gotoxy(5,10); writeln(W_M(131));
        { '!!! DATI DI INPUT ERRATI !!! CONTROLLARE L''ELENCO ERRORI NEL MENU DEI DATI ');}
         //gotoxy(5,12); writeln(W_M(132));
         {(' premere un tasto per continuare ');}
        // repeat until keypressed;
      end ;
//     else
//      if Exist(driveprog+'Errori.dat') then erase(f);
  end;


  PROCEDURE LeggiArk;
    PROCEDURE INIT_ARCHIVIO;
      VAR i : INTEGER;
      BEGIN                   { init Archivio }
        FOR i := 1 TO NPezzi DO
          WITH Archivio^[i] DO
            BEGIN             { with dato }
              CodPezzo := '';
              Descr := '';
              CodDis := 0;
              Main := ''; Branch := ''; Fonte := '';
              Varie := '';
              TipoSez := '';
              NUscite := 0;
            END;              { with }

      END;                    { proc. init_archivio }

type
oldint1=word;

RigaArch1 = RECORD
                 CodPezzo : ST5;
                 Descr : string[40];
                 a1,a2:byte;
                 //CodDis : OldInt;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez :STRING[5];// ST5;
                 //NUscite : oldint;
                 b1,b2:byte;
               END;


    procedure TRANSFER_ARCHIVIO;
        { Serve per caricare la tabella 'ARCHIVIO.CAN' con le descrizioni relative ai
        codici dei pezzi }
      VAR i ,j: INTEGER;
        F : FILE OF RigaArch1;
        archivio1:RigaArch1;
        wpas:Textfile;
        NcP,POstCod:String;
      Function TS(TU:char):char;
      begin
      if Tu='D' then TU:='C';
      if Tu='H' then TU:='R';
      if Tu='A' then TU:='R';
      result:=TU;
      end;

      BEGIN                   { lettura }
         (*
        Init_Archivio;
        assign(Wpas,'c:\sd\sorgenti\bm-sd\canali\def_archpezzi.pas');
        rewrite(Wpas);
        writeln(wPas,'Const archpezzi:array[1..241]of rigaarch=(');
        if Exist(DRIVEARC+'archivio.can') then
         begin
            ASSIGN(f, DRIVEARC+'archivio.can');
            RESET(f);
            i := 1;
            WHILE NOT EOF(f) DO
              BEGIN
                //READ(f, Archivio^[i]);

                READ(f, Archivio1);
                with  Archivio^[i] do
                  begin
                  CodPezzo :=Archivio1.Codpezzo;
                  Descr :=Archivio1.Descr;
                  for j:=1 to length(descr)do
                  if descr[j]='''' then descr[j]:=' ';

                  CodDis :=0;
                  Main:=Archivio1.Main;
                  Branch:=Archivio1.Branch;
                  Fonte:=Archivio1.Fonte;
                  Varie :=Archivio1.Varie;
                  TipoSez :=Archivio1.TipoSez;
                  NUscite := length(Archivio1.Tiposez)-1;
                  POstCod:='';
                  if codpezzo='310R' then
                    begin
                    Nuscite:=1;
                    POstCod:='CAN';
                    end;
                  if codpezzo='310C' then
                    begin
                    Nuscite:=1;
                    POstCod:='CAN';
                    end;
                  if (copy(codpezzo,1,3)='271')or
                     (copy(codpezzo,1,3)='261')or
                     (copy(codpezzo,1,3)='263')or
                     (copy(codpezzo,1,3)='273')or
                     (copy(codpezzo,1,3)='281')or
                     (copy(codpezzo,1,3)='283')
                  then POstCod:='RID';

                  if (copy(codpezzo,1,2)='06')or
                     (copy(codpezzo,1,2)='07')or
                     (copy(codpezzo,1,2)='08')
                  then POstCod:='CUR';

                  if copy(codpezzo,1,2)='05' then Nuscite:=0;
                  if copy(codpezzo,1,2)='04' then Nuscite:=0;
                  Ncp:=TipoSez[1];
                  if Ncp='D' Then Ncp:='C';
                  Ncp:=Ncp+Inttostr(Nuscite);
                  For j:=1 to Nuscite do Ncp:=Ncp+Ts(TipoSez[j+1]);

                  If POstCod<>''then NCp:=Ncp+'_'+POstCod;
                  if codpezzo<>'' then
                    begin
                    write(wpas,'(Codice:'''+NCP+''';');
                    write(wpas,'Codpezzo:'''+Codpezzo+''';');
                    write(wpas,'Descr:'''+Descr+''';');
                    write(wpas,'CodDis:'+inttostr(CodDis)+';');
                    write(wpas,'Main:'''+Main+''';');
                    write(wpas,'Branch:'''+Branch+''';');
                    write(wpas,'Fonte:'''+Fonte+''';');
                    write(wpas,'Varie:'''+Varie+''';');
                    write(wpas,'TipoSez:'''+TipoSez+''';');
                    write(wpas,'Nuscite:'+inttostr(Nuscite));

                    if NOT EOF(f) then writeln(Wpas,'),') else writeln(Wpas,'');
                    end;
                  end;
                i := i+1;
              END;
            CLOSE(f);
            writeln(WPas,');');
            close(Wpas);
          end;
         *)
      Init_Archivio;
      for i:=1 to 241 do archivio^[i]:=archpezzi[i];

      END;                    { proc. transfer_archivio }

    BEGIN
      INIT_ARCHIVIO;
      TRANSFER_ARCHIVIO;
    END;


{***************************  LoadNome         *******************************}

Procedure LoadNome;

Var FileNome:string;f:Text;



begin

if exist(driveprog+'prog.Can') then
  begin
  assign(f,driveprog+'prog.Can');
  reset(f);
  read(f,NomeProg);
  close(f);
  end
else HALT;

if NomeProg='' then Halt;

end;

 function UpString(St:st126):st126;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;



{-----------------------CONTROLLA ESISTENZA MATERIALE-----------------------}
procedure Controlla(i:integer;Riga:RigaRamo;Uscit,OldNodo,Nod:integer;Quota_N:real);
var j :integer;
 begin
    j:=Find_Archivio(Riga.CodPezzo);
    if j = 0 then
     begin
        with TabErrori^[IndErr] do
         begin
            DaNodo:=OldNodo;  Anodo:=Nod;
            Quota:=Quota_N;   NPezzo:=i+1;
            Cod:=Riga.CodPezzo;
            DescrEr:=W_M(133);
            {'PEZZO NON PRESENTE IN ARCHIVIO';}
            IndErr:=IndErr+1;
         end;
     end
    else
     begin
        if Uscit <> Archivio^[j].NUscite then
         begin
            with TabErrori^[IndErr] do
             begin

                DaNodo:=OldNodo;  Anodo:=Nod;;
                Quota:=Quota_N;   NPezzo:=i+1;
                //Cod:=Riga.CodPezzo;
                //DescrEr:=inttostr(uscit)+'<>'+inttostr(Archivio^[j].NUscite)+' '+W_M(134);
                Cod:=nuovocodice(Riga.CodPezzo);
                 { TODO -oDiego -cNavigazione canali : lavoro qui }
                DescrEr:=' ;'+W_M(134)+'('+inttostr(Archivio^[j].NUscite)+' uscite al posto di '+inttostr(uscit)+')';
                {'NUMERO USCITE ERRATO';}
                IndErr:=IndErr+1;
             end;
         end
        else
         if Uscit = 0 then
          if (Riga.Portata = 0) or (Riga.Perdita = 0) then
           begin
              with TabErrori^[IndErr] do
               begin
                  DaNodo:=OldNodo;  Anodo:=Nod;
                  Quota:=Quota_N;   NPezzo:=i+1;
                  Cod:=Riga.CodPezzo;
                  DescrEr:=W_M(135);
                  {'DATI USCITA BOCCHETTA ERRATI ( = 0)';}
                  IndErr:=IndErr+1;
               end;
           end;

       if Riga.CodPezzo='310R' then
        if (Riga.CHFlag = '*') and ((Riga.H=0) or (Riga.W=0)) then
         begin
            with TabErrori^[IndErr] do
             begin
                DaNodo:=OldNodo;  Anodo:=Nod;
                Quota:=Quota_N;   NPezzo:=i+1;
                Cod:=Riga.CodPezzo;
                DescrEr:=W_M(136);
                {'VALORI DI H O W ERRATI ( = 0)';}
                IndErr:=IndErr+1;
             end;
         end;
       if (Riga.CodPezzo='310C' )or(Riga.CodPezzo='310F')  then
        if (Riga.CHFlag = '*') and (Riga.A_D=0) then
         begin
            with TabErrori^[IndErr] do
             begin
                DaNodo:=OldNodo;  Anodo:=Nod;
                Quota:=Quota_N;   NPezzo:=i+1;
                Cod:=Riga.CodPezzo;
                DescrEr:=W_M(137);
                {'VALORE DEL DIAMERTOI ERRATO ( = 0)';}
                IndErr:=IndErr+1;
             end;
         end;
     end;
 end;


{***************************  SelectPhi      *******************************}

Function SelectPhi(tratto,tratto1:CadRec):integer;

Var x1o,y1o,z1o,x2o,y2o,z2o:real;
    var AngXY,AngYZ,AngXZ:integer;
    DirXY,DirYZ,DirXZ    :integer;

  FUNCTION Angolo(a, b : REAL) : INTEGER;
    VAR Phi : REAL;
    BEGIN
      IF a = 0 THEN
        BEGIN
          IF b > 0 THEN Angolo := -90
          ELSE Angolo := 90;
        END
      ELSE
        BEGIN
          Phi := -ARCTAN(b/a);
          Angolo := ROUND((180/PI)*PhI);
        END;
    END;


  FUNCTION ArcTg(a, b, a1, b1 : REAL) : INTEGER;
    VAR Phi : INTEGER;
    BEGIN
      a := INT(a*1000)/1000;
      a1 := INT(a1*1000)/1000;
      b := INT(b*1000)/1000;
      b1 := INT(b1*1000)/1000;
      Phi := Angolo(a1-a, b1-b);
      IF a1-a < 0 THEN Phi := Phi+180;
      Phi := (Phi+360) MOD 360;
      ArcTg := Phi;
    END;


  PROCEDURE Ruota(VAR a, b : REAL; Ang : INTEGER);
    VAR a1, b1 : REAL;
        ang1:real;
    BEGIN
      Ang1:=Ang*(Pi/180);
      a1 := a; b1 := b;
      a := a1*cos(Ang1)+b1*sin(Ang1);
      b := -a1*sin(Ang1)+b1*cos(Ang1);
    END;

begin

with Dis^[RisultCalc^.Origine]^ do
  begin
  DirXZ:=ArcTg(x1, y1, x2, y2);
  DirYZ:=(ArcTg(y1, z1, y2, z2)+270)mod 360;
  DirXY:=ArcTg(x1, y1, x2, y2);
  end;

(*

with tratto do
  begin
  Ruota(x1,z1,(360-DirXZ) mod 360);
  Ruota(x2,z2,(360-DirXZ) mod 360);

  Ruota(y1,z1,(360-DirYZ) mod 360);
  Ruota(y2,z2,(360-DirYZ) mod 360);

  Ruota(x1,y1,(360-DirXy) mod 360);
  Ruota(x2,y2,(360-DirXy) mod 360);
  end;

with tratto1 do
  begin
  Ruota(x1,z1,(360-DirXZ) mod 360);
  Ruota(x2,z2,(360-DirXZ) mod 360);

  Ruota(y1,z1,(360-DirYZ) mod 360);
  Ruota(y2,z2,(360-DirYZ) mod 360);

  Ruota(x1,y1,(360-DirXy) mod 360);
  Ruota(x2,y2,(360-DirXy) mod 360);
  end;

*)
with tratto do
  begin
  AngXZ := ArcTg(x1, z1, x2, z2);
  AngYZ := ArcTg(y1, z1, y2, z2);
  AngXY := ArcTg(x1, y1, x2, y2);
  end;

(*
writeln(lst,' angxz:',angxz,'  angyz:',angyz,'  angxy:',angxy);
with tratto1 do
writeln(lst,'tr1a  x1:',x1:6:2,'  y1:',y1:6:2,'  z1:',z1:6:2,' x2:',x2:6:2,'  y2:',y2:6:2,'  z2:', z2:6:2);
with tratto1 do
writeln(lst,'Tr1b dx:',x2-x1:6:2,' dy:',y2-y1:6:2,' dz:',z2-z1:6:2);
*)

with tratto1 do
  begin
  Ruota(x1,z1,(360-AngXZ) mod 360);
  Ruota(x2,z2,(360-AngXZ) mod 360);

  Ruota(y1,z1,(360-AngyZ) mod 360);
  Ruota(y2,z2,(360-AngyZ) mod 360);

  Ruota(x1,y1,(360-AngXy) mod 360);
  Ruota(x2,y2,(360-AngXy) mod 360);
  end;

with tratto1 do
writeln('Tr1b dx:',x2-x1:6:2,' dy:',y2-y1:6:2,' dz:',z2-z1:6:2);

with tratto1 do
SelectPhi:=(360-arctg(y1,z1,y2,z2))mod 360;

end;


{***************************  InitTab        *******************************}

Procedure InitTab(Var BufCan:TabRamo);

var i:integer;

begin
  for i:=0 to LTabRamo do
  with BufCan.T[i] do
    begin
    CodPezzo :='';
    Descr    :='';
    CHFlag   :=' ';
    Portata  :=0;
    Perdita  :=0;
    A_D      :=0;
    H        :=0;
    W        :=0;
    Ang      :=0;
    Phi      :=0;
    L        :=0;
    R        :=0;
    ComVal   :=0;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;
with BufCan do
  begin
  ps:=0;
  pc:=0;
  pd:=0;
  tr:=false;
  CodTab:=0;
  end;
end;
(*
 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;
*)

{-----------------------------------------------------------------------------}


{***************************  StartConvers     *****************************}

Procedure StartConvers;

var cont:integer;
    contat:integer;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Scambia        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Scambia(npezzo:integer;Var invers:boolean);

Var Temp:integer;

begin
if invers then
with Tab.T[NPezzo] do
  begin
  Temp:=H;
  H:=W;
  W:=temp;
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Converti     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Type RecDati=Record
     j,k,riga,Main,Br1,Br2:integer;
     Dir,DirZ:array[1..3]of real;
     canc:array[1..Pezzitr]of boolean;
     NewInd:array[1..Pezzitr]of integer;
     Inv_u:RecVert;
     Quota_N:real;
     indTab :integer;
     st_temp:string;
     End;

Procedure Num_er(ind,num:integer);
begin
TabErrori^[ind].Descrer:=W_m(num);
end;

Procedure Converti(tr1:integer;UltNodo:integer;UltDir1:real;Invert:Boolean;MainV_D,MainInv:Boolean);

Var P_dati:recdati;
    i:integer;

begin
//New(P_dati);
with P_dati do
begin
P0:=1;
gotoxy(10,12);
//write(W_M(53),tr1);{*TR*}
clreol;

{Writeln(lst,'nodo:',Dati^[tr1].Num);}

CanVert:=False;
For i:=1 to 3 Do Inv_U[i]:=false;

i:=Dati^[tr1]^.Ti;
Repeat
if Dis^[i]^.NLinea<>0 then i:=Dis^[i]^.NLinea;
until Dis^[i]^.NLinea=0;
Quota_N:=Dis^[i]^.Z2*Conf.altNum/40000;

NUsc:=1;

if Dati^[tr1]^.pros[2]<>0 then

  begin

  if dati^[tr1]^.pros[3]=0 then  {--- TEE ----}
    begin
    Nusc:=2;
    end

  else          {---- CROCE  ---}

    begin
    nusc:=3
    end;

  end;


For i:=1 to Pezzitr do
  begin
  Canc[i]:=true;
  NewInd[i]:=0;
  end;

   {-- Serve in Caso Di errore --}

Main:=0;
Br1:=0;
Br2:=0;
if Dati^[tr1]^.Pros[1]<>0 then Main:=1;
if Dati^[tr1]^.Pros[2]<>0 then Br1 :=2;
if Dati^[tr1]^.Pros[3]<>0 then Br2 :=3;

InitTab(Tab);

 {-- Copia pezzo 0 --}

if Dati^[tr1]^.Pezzi[0]<>0 then
with Tab.T[0] do
    begin
    St_temp :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Codice;
    Up_S(St_temp);
    CodPezzo:=St_temp;
    if VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Flag<>'' then
    CHFlag   :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Flag[1];
    Portata  :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Port;
    Perdita  :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Perd;
    A_D      :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.R);
    H        :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.B);
    W        :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.A);
    Ang      :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Ang);
    L        :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Lung;
    R        :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Rag;
    ComVal   :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Varie;
    indp     :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Indpezzo;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;


if tr1<>RisultCalc^.Origine then
  begin
  if MainV_D then Scambia(0,MainInv)
  else Scambia(0,invert);
  end;

indTab:=0;
for i:=1 to pezzitr Do
if Dati^[tr1]^.Pezzi[i]<>0 then
  begin

  indTab:=indTab+1;

    {- Serve piu di una tabella -}

  if IndTab>=LTabRamo then
    begin
    contat:=contat+1;
    Tab.CodTab:=Contat;
    Tab.Pc:=P0;
    //Write(Fcan,Tab);
    Add_TabCalc(Tab);
    InitTab(Tab);
    IndTab:=1;
    end;

  Main:=0;
  Br1:=0;
  Br2:=0;

  trovato:=false;

  k:=Dati^[tr1]^.Ti;

  repeat
  if dis^[k]^.NPezzo=i then trovato:=true;
  if not trovato then k:=dis^[k]^.Nlinea;
  until (trovato) or (k=0);

  if trovato then
    begin

    Tab.T[indtab].Phi:=0;

    if (NUsc>1)and(trovato)and(dis^[k]^.NLinea=0) then
      begin


      SETBRANCH(k,Nusc,Main,Br1,Br2,Orient,Vrt,UltDir1,Invert,inv_U,MainV_D);

      CalcDirez(k,C_dir,C_DirZ);
      if abs(abs(C_dirz)-Pi/2)>0.1 then UltDir1:=C_dir;

      if ( ( (orient IN [2,4]) or ((orient IN[ 5,6])and(inv_U[br1]=Invert))
           )and(not(invert))
         )or
         (
           ( not((orient IN [2,4])or((orient IN[ 5,6])and(inv_U[br1]=Invert)))
           )
           and(invert)
         )
      then Tab.T[indtab].Phi:=90;


               {-- Inverte l`ingresso degli stacchi --}

      MainInv:=Invert;

      J:=0;
      Repeat
      J:=J+1;
      if invert<>Inv_U[J] then
        begin
        MainInv:=Not(mainInv);
        Invert:=Not(Invert);
        end;
      Until (invert<>Inv_U[J])or(J=NUsc);

      end

    else
      begin
      Br1:=Dis^[k]^.Nlinea;
      if dis^[k]^.NLinea<>0 then
      CalcDirez1(k,Dis^[k]^.Nlinea,C_Dir,C_DirZ,UltDir1,true,CanVert,Invert);
      end

    end

  else Tab.T[indtab].Phi:=0;

  {writeln(lst,Tab.T[indtab].Phi);}

  with Tab.T[indtab] do
    begin
    St_temp :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Codice;
    Up_S(St_temp);
    CodPezzo:=St_temp;
    (*==>CodPezzo :=UpString(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Codice);*)
    if VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Flag<>'' then
    CHFlag   :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Flag[1];
    Portata  :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Port;
    Perdita  :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Perd;
    A_D      :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.R);
    H        :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.B);
    W        :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.A);
    Ang      :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Ang);
    L        :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Lung;
    R        :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Rag;
    ComVal   :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Varie;
    indp     :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Indpezzo;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;

  Scambia(indtab,invert);

    {-- Controllo errori --}

  if i < pezzitr then
   begin
      if Dati^[tr1]^.Pezzi[i+1] <> 0 then
        Controlla(i,Tab.T[indtab],1,UltNodo,Contat+1,Quota_N)
      else
      if Dati^[tr1]^.pros[1]=0 then
      Controlla(i,Tab.T[indtab],0,UltNodo,Contat+1,Quota_N)
      else Controlla(i,Tab.T[indtab],nusc,UltNodo,Contat+1,Quota_N)
   end
  else Controlla(i,Tab.T[indtab],NUsc,UltNodo,Contat+1,Quota_N)

  end;


 {-- Controllo errori --}

if Dati^[tr1]^.Pezzi[1]=0 then
 with TabErrori^[IndErr] do
  begin
     DaNodo:=UltNodo;  Anodo:=Contat+1;
     Quota:=Quota_N;   NPezzo:=0;
     Num_er(IndErr,138);
     (*====> DescrEr:=W_M(138);*)
    { 'TABELLA RAMO VUOTA';}
     IndErr:=IndErr+1;
  end;

Tab.Pc:=0;
Tab.Ps:=0;
Tab.Pd:=0;
if Main<>0 then Tab.Pc:=Dati^[tr1]^.pros[Main];
if Br2<>0 then  Tab.Ps:=Dati^[tr1]^.pros[Br2];
if Br1<>0 then  Tab.Pd:=Dati^[tr1]^.pros[Br1];

if (br2=0)and(br1<>0)then
  begin
  Tab.ps:=Tab.pd;
  Tab.pd:=0;
  br2:=br1;
  br1:=0;
  end;

contat:=contat+1;
dati^[tr1]^.Num:=Contat;
Tab.CodTab:=Contat;
//Write(Fcan,Tab);
Dati^[tr1].Indtabcalc:=Add_TabCalc(Tab);

UltNodo:=Contat;
int1:=br1;
int2:=br2;
int3:=main;
if Main<>0 then Converti(Dati^[tr1]^.pros[Main],UltNodo,UltDir1,Inv_u[Main],MainV_D,MainInv);
int1:=br1;
int2:=br2;
int3:=main;
if Br2 <>0 then Converti(Dati^[tr1]^.pros[Br2 ],UltNodo,UltDir1,Inv_u[Br2 ],MainV_D,MainInv);
int1:=br1;
int2:=br2;
int3:=main;


if (Br1 <>0) and (br1<=3) then Converti(Dati^[tr1]^.pros[Br1 ],UltNodo,UltDir1,Inv_u[Br1 ],MainV_D,MainInv)
else
if br1>0 then
begin
  writeln('Tronco errato: ',tr1);
  repeat until keypressed;
end;

with Tabcalc^[Dati^[tr1].Indtabcalc]^ do
  begin
  if Pc<>0 then Pc:=Dati^[Pc].Indtabcalc;
  if Ps<>0 then Ps:=Dati^[Ps].Indtabcalc;
  if Pd<>0 then Pd:=Dati^[Pd].Indtabcalc;
  end;
end;
//dispose(P_dati);
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*      MAIN     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}


begin
   Contat:=0;
   //New(P0);
   //Assign(FCan,'canali.can');
   //Rewrite(FCan);
   if RisultCalc^.Origine<>0 Then
   Converti(RisultCalc^.Origine,UltNodo,NotVert,False,false,false)
   //else
   //with TabErrori^[IndErr] do
   //  begin
     //DescrEr:=W_M(138);
     {'Non esiste il disegno unifilare ';}
   //  IndErr:=IndErr+1;
   //  end;
   //Close(FCan);
end;


{ TODO -oDiego -cNavigazione canali : Update pezzi }
function ug2(v1,v2:real):boolean;
begin
result:=round(v1*10)=round(v2*10)
end;
Procedure MarcaPezzi;
Var
    i,j,k:integer;
    tX1Ar,tY1Ar,tZ1Ar,tX2Ar,tY2Ar,tZ2Ar:real;
    CodTemp:string;
begin
for i:=1 to ulttronco do
with dati^[i]^ do
if dati^[i]^.ti<>0 then
  begin
  with dis^[ti]^ do
    begin
    tX1Ar:=x1;
    tY1Ar:=y1;
    tZ1Ar:=Z1;
    end;
  j:=ti;
  while dis^[j]^.Nlinea<>0 do j:=dis^[j]^.Nlinea;
  with dis^[j]^ do
    begin
    tX2Ar:=dis^[j]^.x2;
    tY2Ar:=dis^[j]^.y2;
    tZ2Ar:=dis^[j]^.Z2;
    end;
  for j:=1 to pezzitr do
  if pezzi[j]<>0 then
  with Vpezzi^[dati^[i]^.pezzi[j]]^ do
    begin
    Vpezzi^[dati^[i]^.pezzi[j]]^.indpezzo:=dati^[i]^.pezzi[j];
    X1Ar:=tX1Ar;
    Y1Ar:=tY1Ar;
    Z1Ar:=tZ1Ar;
    X2Ar:=tX2Ar;
    Y2Ar:=tY2Ar;
    Z2Ar:=tZ2Ar;
    for k:=1 to NUpdate do
    if Update_d^[k]^.prog=definizcan.NomeProg then
    if length(Update_d^[k]^.Codp)>=3 then
    if ug2(Update_d^[k]^.XA1,tx1ar)then
    if ug2(Update_d^[k]^.YA1,ty1ar)then
    if ug2(Update_d^[k]^.ZA1,tz1ar)then
    if ug2(Update_d^[k]^.XA2,tx2ar)then
    if ug2(Update_d^[k]^.YA2,ty2ar)then
    if ug2(Update_d^[k]^.ZA2,tz2ar) then
      begin
      codtemp:=Update_d^[k]^.Codp;
      if codtemp[3]=':' then
        begin
          case strtoint(codtemp[2]) of
          1:Vpezzi^[dati^[i]^.pezzi[j]]^.Flag:='';
          2,3,4:Vpezzi^[dati^[i]^.pezzi[j]]^.Flag:='*';
          end;
        azzeraidentif;
        leggiidentif1(codtemp);
        Vpezzi^[dati^[i]^.pezzi[j]]^.A:=str_tofloat(leggiidentif1(codtemp));
        Vpezzi^[dati^[i]^.pezzi[j]]^.B:=str_tofloat(leggiidentif1(codtemp));
        Vpezzi^[dati^[i]^.pezzi[j]]^.R:=str_tofloat(leggiidentif1(codtemp));
        end
      else
      if (Update_d^[k].indpezzo=indpezzo) then
      if (Cerca_ARCHIVIONuovo(codtemp)<>0) then
      Vpezzi^[dati^[i]^.pezzi[j]]^.codice:=archpezzi[Cerca_ARCHIVIONuovo(codtemp)].Codpezzo;
      end;
    end;
  end;
end;
var q,i,j:integer;
    Var fc:text;
     Var LungMax:real;TipoC:char;
Begin
//new(risultcalc);
New(archivio);
New(Taberrori);
textcolor(7);
textbackground(1);
window(1,3,80,25);
ClrScr;
gotoxy(10,10);
FILETRADUZ:='GESTDUCT';
write_M(W_M(52));{*TR*}
ulttabc:=0;


{assign(fc,'drive1.int');
reset(fc);
read(fc,datadrive);
close(fc);
DataDrive:=datadrive+'\DatiCCA\';
}

//LoadNome;

//if exist(Driveprog+NomeProg+'.Ret') then
  begin
//  new(dis);
//  new(dati);
  ultpezzo:=0;
//  for i:=1 to lungpezzi do Vpezzi^[i]:=nil;
//  for i:=0 to lungdis   do Dis^[i]:=nil;
//  new(dis^[0]);
//  for i:=1 to lungdati  do Dati^[i]:=nil;

  LeggiArk;
  InitErrori;
  grafica:=false;
  initconf;
  init_riduz;
  for i:=1 to ulttronco do
  for j:=0 to pezzitr do
  dati^[i].Pezzi[j]:=0;
  for i:=1 to ultriga do
  dis^[i].entita:='L';
  { TODO -oDiego -cNavigazione canali : Caricamento pezzi }
  IterLoad(RisultCalc^.Origine,LungMax,TipoC,true,0);
  MarcaPezzi;
//  LoadDis(Driveprog+Nomeprog);
//inderr:=1;
 StartConvers;

 WriteErrori;
//  if inderr<>1 then SaveDis(Driveprog+Nomeprog)
//  else
//    begin
//    for i:=1 to lungpezzi do if Vpezzi^[i]<>nil Then Dispose(Vpezzi^[i]);
//    for i:=0 to lungdis   do if Dis^[i]<>nil Then Dispose(Dis^[i]);
//    for i:=1 to lungdati  do if Dati^[i]<>nil Then Dispose(Dati^[i]);
//    dispose(dis);
//    dispose(dati);
//    dispose(Vpezzi);
//    dispose(archivio);
//    dispose(Taberrori);
//    end;
  end

end;

end.
