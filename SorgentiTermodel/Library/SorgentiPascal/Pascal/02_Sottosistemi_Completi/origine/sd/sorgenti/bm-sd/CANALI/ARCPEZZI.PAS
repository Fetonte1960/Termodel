UNIT arcpezzi;

INTERFACE


Uses
    {$Ifdef dos}
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  {$endif}
  {$Ifdef Win}
  WinDos, {Unit found in TURBO.TPL}
  ostddlgs,
  WinTypes,
  WinProcs,
  Owindows,
  strings,
  {$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  definiz,
  utilitie,
  WM;

const
   NPezzi = 260;

type
    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;
      elpezzi= ARRAY[1..NPezzi] OF RigaArch;

var
  g        : text;
  ARCHpezzi :^elpezzi;
  {$ifdef win}
  VAR hd:hwnd;
      nt:st8;
  {$endif}

procedure arkPezzi(var scelta:integer);

IMPLEMENTATION

{=========================================================================}

procedure scrittura;far;
   var i:integer;
       f:file of rigaarch;
   begin       { scrittura }

      if Exist(Drivearc+'archivio.bak') then
       begin
          assign(f,Drivearc+'archivio.bak');
          Erase(f);
       end;

      if Exist(Drivearc+'archivio.can') then
       begin
          assign(f,Drivearc+'archivio.can');
          Rename(f,Drivearc+'archivio.bak');
       end;

      assign(f,Drivearc+'archivio.can');
      rewrite(f);

      for i:=1 to NPezzi do
        write(f,Archpezzi^[i]);
      close(f);
   end;        { scrittura }




procedure canclpezzi;far;
begin
   dispose(archpezzi);
   archiviopezzipc:=true;
end;


  PROCEDURE LeggiArk;
    PROCEDURE INIT_ARCHIVIO;
      VAR i : INTEGER;
      BEGIN                   { init Archivio }
        new(archpezzi);
        FOR i := 1 TO NPezzi DO
          WITH Archpezzi^[i] DO
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



    procedure TRANSFER_ARCHIVIO(FileName : ST80);
        { Serve per caricare la tabella 'ARCHIVIO.CAN' con le descrizioni relative ai
        codici dei pezzi }
      VAR i : INTEGER;
        F : FILE OF RigaArch;
      BEGIN                   { lettura }
        Init_Archivio;
        if Exist(DRIVEARC+'archivio.can') then
         begin
            ASSIGN(f, DRIVEARC+'archivio.can');
            RESET(f);
            i := 1;
            WHILE NOT EOF(f) DO
              BEGIN
                READ(f, Archpezzi^[i]);
                i := i+1;
              END;
            CLOSE(f);
          end;
      END;                    { proc. transfer_archivio }

    BEGIN
      INIT_ARCHIVIO;
      TRANSFER_ARCHIVIO('archivio');
    END;

  {--------------------------SCRITTURA FILE-----------------------------}


{------------------------RICERCA-------------------------}

  FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      while length(Codice)<5 do Codice:=Codice+' ';
      Codice := UPstring(Codice);
      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
          while length(Archpezzi^[i].CodPezzo) < 5 do Archpezzi^[i].CodPezzo:=Archpezzi^[i].CodPezzo+' ';
          Archpezzi^[i].CodPezzo := UPSTRING(Archpezzi^[i].CodPezzo);
          Trovato := Archpezzi^[I].CodPezzo = Codice;
          IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN FIND_ARCHIVIO := 0
      ELSE FIND_ARCHIVIO := I;

    END;


{$ifdef win}

procedure W_ricerca;far;

var inputtext,pc :array[0..5] of char;
    dato:string;
    rif,pag,riga:integer;
    st:string[5];
   stp:string[6];
   pac:array[0..6] of char;
   hd:hwnd;
   sthd:st8;
   domy,domy1:string[80];
   p1,p2:array [0..80] of char;
begin
    hd:=0;
    sthd:='ARCHIVIO';
    a_w:=numerotabella(STHD,hd,2);
    domy:=w_m(151);
    domy1:=w_m(152);
    with tabellacorrente^[a_w] do
    begin
    strpcopy(p1,domy);
    strpcopy(p2,domy1);
    rif:=0;
    fillchar(inputtext,sizeof(inputtext),0);
    if Application^.ExecDialog(New(PInputDialog,
      Init(Pmainwin, p1,p2,{'Ricerca pezzo speciale', 'Introduci il codice da ricercare:',}
      InputText, SizeOf(InputText)))) = id_OK then
    begin
      setfocus(maniglia);
      dato:=strpas(inputtext);
      Rif:=Find_Archivio(Dato);
      str(rif,st);
      strpcopy(pc,st);
      if rif>0 then
      with dialog^ do
      begin
        pag:=rif div 4;
        IF rif mod 4 <> 0 then pag:=pag+1;
        ofsettab:=ofsin+((pag-1)*dofs);
        numerolineatabella:=rif;
        scrolla^.setposition(rif);
        pg:=Pag;
        str(pg,stp);
        stp:='Pag:'+stp;
        strpcopy(pac,stp);
        st_pag^.settext(pac);
        transferdata(tf_setdata);
        riga:=((rif-((pg-1)*4))*9)-8;
        setfocus(getitemhandle(riga+100));
      end;
    end;
  end;
end;

{$endif}

{--------------------RICERCA ULTIMO ELEMENTO-----------------}

function Ultimo:integer;
var UltPezzo:integer;
begin
   UltPezzo:=NPezzi;
   while (Archpezzi^[UltPezzo].CodPezzo = '') and (UltPezzo > 1) do UltPezzo:=UltPezzo-1;
   Ultimo:=UltPezzo;
end;
(*
{--------------------ORDINAMENTO-----------------------------}

procedure Ordinamento;
var UltPezzo,i,j:integer;
    Temp:RigaArch;
begin
   UltPezzo:=Ultimo;
   for i:=1 to UltPezzo do
    begin
       for j:=i to UltPezzo do
        if Archivio[i].Nazione+Archivio[i].Localita > Archivio[j].Nazione+Archivio[j].Localita then
         begin
            Temp:=Archivio[i];
            Archivio[i]:=Archivio[j];
            Archivio[j]:=Temp;
         end;
    end;
end;

*)

{------------------------MASKERA------------------------------------}
   {$Ifdef dos}
 procedure maskera(var scelta:integer);
  var Rif,i,riga,chiave,StartPos,campo : integer;
      F,iwal,InitMenu                  : boolean;
      ExitChar                         : char;
      Dato                             : st5;
      Tab1                             : TabellaRec; {----}
      Map1                             : TabellaMap; {----}


  begin           { M_Iotabella }
      Riga :=1;
      InitMask:=true;
      InitMenu:=true;
      iwal:=false;
      repeat
         M_IOTabella(Seg(Archpezzi^),Ofs(Archpezzi^),NPezzi,4,9,Chiave,scelta,Riga,campo,
                       'archivio.msk','pm',false,InitMask,iwal,false,InitMenu);

           InitMask:=false;
           iwal:=true;

           case chiave of
               60:riga := 1;

               61:riga :=ultimo;

               59:begin
                     Dato:=''; StartPos:=1;
                     TextColor(col[4]);
                     textbackground(col[1]);
                     gotoxy(3,21);clreol;
                     gotoxy(3,21);
                     writeln(W_M(19));    {'Pezzo da ricercare: ');}
                     M_off;
                     Dato:=LINE_INPUT(26,21,25,StartPos,' ',Dato,3,ExitChar,FALSE,F,riga,'',f);
                     M_on;
                     Rif:=Find_Archivio(Dato);
                     if Rif > 0 then riga :=rif
                     else write(chr(7));
                     textbackground(col[1]);
                     gotoxy(3,21);clreol;
                  end;

           end; { case }

        until (chiave = 27) and (scelta <> 25);
    end;       {maskera}
  {$endif}
  {$Ifdef Win}
  {$endif}


procedure arkPezzi(var scelta:integer);

  var
  f        : file of RigaArch;
  InitMask : boolean;
  Titolo   : st80;

{---------------------------MAIN----------------------}

begin
   leggiark;
  {$Ifdef dos}
   maskera(scelta);
   scrittura;
  {$endif}
  {$Ifdef Win}
    IF archiviopezzipc then
    begin
    archiviopezzipc:=false;
    procarr[11]:=canclpezzi;
    procarr[12]:=scrittura;
    procarr[1]:=w_ricerca;
    W_iotabella(archpezzi^,NPezzi,4,9,'archivio.msk',false,procarr,false,code,fill_listagen,nil);
    end
    else
    begin
    nt:='ARCHIVIO';
    hd:=0;
    numerotabella(nt,hd,2);
    setfocus(hd);
   end;
  {$endif}
end;
end.
