{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}

Unit SelCampo;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,printer,WM,demo,sel_line;

Procedure Genera;

Procedure SelectCampo(Nome:String;Campo:Integer;var lineains,postins:string);

Function NomeLista(Nome:string;Campo:integer):string;




Implementation
uses utilitie;




Procedure ReadKbd(Var ch:Char);
Begin
if play then
  begin
  repeat until timecorr >Nastro.Tempo;
  ch:=nastro.car;
  if not eof(fnastro) then
    begin
    read(fnastro,nastro);
    NumStep:=NumStep+1;
    end
  else closeplay;
  end
else
  begin
  if rec then
  if Not(Composto) then nastro.tempo:=timecorr;
  READKBD(CH);
  if rec then
    begin
    If (ord(ch)=27)and(keypressed) then composto:=true else composto:=false;
    nastro.car:=ch;
    nastro.mouse:=false;
    write(fnastro,nastro);
    end;
  end;
end;



function keypressed_n:boolean;
begin

  if play and keypressed then
    begin
    clrscr;
    halt;
    end;
  if play then keypressed_n:= (nastro.tempo<=timecorr) and (not nastro.mouse)
  else  keypressed_n:=keypressed;
end;


Procedure Genera;

Type Opzioni=Record
                Descr:STRING[64];
                Valore:String[16];
             end;

var BufOpz :Opzioni;
    Fopz   :File of Opzioni;
    i:integer;

begin
With BufOpz Do
  begin
  str(15,Descr);
  str(0,Valore);
  end;
assign(FOpz,'Ventzona.L9');
rewrite(FOpz);
write(fopz,BufOpz);
for i:=1 to 50 do
With BufOpz Do
  begin
  str(i,Descr);
  descr:='Descrizione '+Descr;
  str(i,Valore);
  write(fopz,BufOpz);
  end;
close(FOpz);
end;

Function NomeLista(Nome:string;Campo:integer):string;
Var StCampo:String;
begin
if ar_ins^[campo].ncampo=0 then
begin
NOME:=DRIVEMASK+NOME;
IF NOT EXIST(NOME) THEN
NOME:=ELIMINADIR(NOME);
Str(Campo,StCampo);
Nome:=Copy(Nome,1,Length(Nome)-3)+'L'+StCampo;
NomeLista:=Nome;
end
else
IF EXIST(ar_ins^[campo].nfile) THEN nomelista:=ar_ins^[campo].nfile
ELSE nomelista:='';
{Gotoxy(1,22);write(Nome);clreol;}
end;



Const Altmax=10;
      XCen=40;
      ycen=10;

Type Opzioni=Record
                Descr:String[64];
                Valore:String[16];
             end;

var BufOpz :Opzioni;
    Fopz   :File of Opzioni;
    Elenco :array[1..AltMax]of Opzioni;
    StCampo:String;
    errore :Integer;
    Larg   :Integer;
    LargVal:Integer;
    Largdesc:integer;
    Vuoto  :String;
    BrSin  :Integer;
    BrSup  :Integer;
    Posiz  :Integer;
    Indice :Integer;
    NumRg  :Integer;
    Car    :Char;
    Alt    :Integer;
    inizioF:Boolean;
    FineF  :Boolean;
    LungF  :Integer;
    Dato   :string;
    StartPos:integer;
    F       :boolean;
    ExitChar:Char;
    ym,i    :integer;
    oldpos  :integer;
    sali,scendi:boolean;

Function CompRag(Rag:string):string;

var j,k,l,Lung:integer;
    Pass:boolean;

begin

  l:=1;

  Rag:=Formst(Rag);
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
  until (l=Lung-1) or Pass;

  Rag:=SetLeft(SetRight(Rag));
  CompRag:=Rag;
end;




function TrovaPos(dato:string):integer;
var Trovato:boolean;
    i,k:integer;
    Rag,cella:string;
begin

   Trovato:=false;
   reset(Fopz);
   i:=0;
   dato:=CompRag(dato);
   while (not eof(FOpz)) and (not Trovato) do
    begin
       i:=i+1;
       Read(Fopz,BufOpz);
       Rag:=CompRag(BufOpz.Descr);
       k:=1;
       while not Trovato and (k < (Length(Rag)-Length(Dato)+2)) do
        begin
           Cella:=Copy(Rag,k,Length(Dato));
           Trovato:=Dato=Cella;
           k:=k+1;
        end;
    end;

   if not Trovato then
    begin
{       WriteMessage('carterm.msg',1);}
       write(chr(7));
       TrovaPos:=1;
    end
   else TrovaPos:=i-1;

end;




procedure pallino(pos:integer);
var
    y,x:integer;
begin
  if larg mod 2 =0 then x:=XCen+(Larg Div 2-1)+2
  else x:=XCen+(Larg Div 2)+2;
  if OldPos > 0 then
   begin
      textbackground(col[12]);
      gotoxy(x,oldpos);
      write(' ');
   end;
  if alt>1 then y:=round((alt/Lungf)*pos)+YCen-alt Div 2
  else y:=ycen;
  GotoXY(x,y);
  textcolor(col[13]);
  write('ş');
  oldpos:=y;
end;




Procedure Scrivi(Riga:Integer;Evidenzia:Boolean);
var stringa:String;




begin
if evidenzia then
  begin
  textbackground(Col[14]);
  textcolor(col[15]);
  end
else
  begin
  textbackground(Col[12]);
  textcolor(col[13]);
  end;

with Elenco[Riga] do
if Largval>0 then stringa:=format(Descr,LargDesc)+':'+format(Valore,LargVal)
else stringa:=format(Descr,Larg);

gotoxy(XCen-Larg div 2,YCen-Alt div 2+Riga-1);
write(Stringa);


end;

{--------- I QUADRO ------------}


Procedure Quadro;
Var i:Integer;
    Linea,Linea1:String;

Begin
U_XMin:=XCen-Larg Div 2-1;
U_YMIn:=YCen-alt Div 2-1;
U_XMax:=XCen-Larg Div 2+Larg+2;
U_YMax:=YCen-(alt Div 2)+alt+2;  { +2}
Vuoto:=
 '                                                                          ';
        Vuoto:=copy(Vuoto,1,larg);
Linea:=
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ';
Linea:=copy(Linea,1,larg);
Linea1:=
'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ';
Linea1:=copy(Linea1,1,larg);
Textbackground(Col[12]);
textcolor(col[13]);
GotoXY(XCen-Larg Div 2-1,YCen-alt Div 2-1);
Write('Ú'+Linea+'ÂÄ¿');
for i:=1 to alt do
  begin
  GotoXY(XCen-Larg Div 2-1,YCen-alt Div 2-1+i);
  {if i=1 then Write('³'+Vuoto+'³ş³')
  else
  if i=alt then Write('³'+Vuoto+'³ş³')
  else }
  Write('³'+Vuoto+'³ ³');
end;
GotoXY(XCen-Larg Div 2-1,YCen-(alt Div 2)+alt);
Write('Ã'+Linea1+'ÁÄ´');
GotoXY(XCen-Larg Div 2-1,YCen-(alt Div 2)+alt+1);
Write('³'+Vuoto+'  ³');
GotoXY(XCen-Larg Div 2-1,YCen-(alt Div 2)+alt+2);
Write('À'+Linea1+'ÄÄÙ');
end;

{--------- F QUADRO ------------}


{-- I Carica --}


procedure generaindice(Var nforig:string;lineains,nomedientrata:string;var insmisto:boolean);
var fo,fd:file of opzioni;
    vo,vd:opzioni;
    l_d,v:integer;
begin
  insmisto:=false;
  if nforig <> 'indins.ins' then
  begin
    assign(fo,nforig);
    reset(fo);
    assign(fd,'indins.ins');
    rewrite(fd);
    read(fo,vo);
    write(fd,vo);
    while not eof(fo) do
    begin
      read(fo,vo);
      if vo.descr[1]='-' then
      begin
        write(fd,vo);
        insmisto:=true;
      end;
    end;
    close(fd);
    close(fo);
   end
   else
   begin
     insmisto:=false;
     assign(fo,nomedientrata);
     reset(fo);
     read(fo,vo);
     assign(fd,'elenins.ins');
     rewrite(fd);
     write(fd,vo);
     while (not eof(fo)) and (vo.descr<>lineains) do read(fo,vo);
     if not eof(fo) then
     begin
       write(fd,vo);
       read(fo,vo);
       while (not eof(fo)) and (vo.descr[1]<>'-') do
       begin
       write(fd,vo);
       read(fo,vo);
       end;
       nforig:='elenins.ins';
     end;
     close(fo);
     close(fd);
   end;
end;



Function Carica:Integer;

Var NumRighe,I:Integer;
begin
Posiz:=1;
Indice:=1;
Numrighe:=0;
While (not eof(Fopz))and(Numrighe<altMax) Do
  begin
  NumRighe:=NumRighe+1;
  read(FOPz,elenco[Numrighe])
  end;

InizioF:=true;
FineF:=eof(Fopz);
LungF:=FileSize(FOpz)-1;

Alt:=NumRighe;


if Numrighe>0 then
  begin
  Quadro;
  SCrivi(1,True);
  For i:=2 to alt do Scrivi(i,False);
  end;

Carica:=Numrighe;
end;




Procedure Nuovariga(NPos,Tipo:Integer);
Var I:integer;

Begin
{
gotoxy(1,21);
write('Lungf:',Lungf,' ind:',Indice,' Posiz:',Posiz,' NPos:',NPos);
clreol;
}

if (NPos<1)or(NPos>alt) then
  begin
  if ((Not FineF)and(NPos>Alt))or((Not InizioF)and(NPos<1)) then
    begin
    if Indice+Npos-1 > LungF then
      begin
      {write(chr(7));}
      NPos:=LungF-indice+1;
      fineF:=true;
      end
    else
      begin
      if NPos+indice-1 < 1 then
        begin
        {write(chr(7));}
        inizioF:=true;
        NPos:=-indice+2;
        end;
      end;
    If Npos<1 then
      begin
      {write(chr(7));}
      FineF:=false;
      indice:=Indice+Npos-1;
      if indice=1 then inizioF:=true;
      POsiz:=1;
      end
    else
      begin
      inizioF:=false;
      Indice:=Indice+Npos-alt;
      Posiz:=alt;
      end;
    reset(FOpz);
    Seek(Fopz,Indice);
    For i:=1 to Alt Do
      begin
      Read(Fopz,Elenco[i]);
      scrivi(i,i=Posiz);
      end;
    pallino(indice);
    end
  end
else
  begin
     pallino(indice);
    if Tipo = 0 then
     begin
       { gotoxy(1,19); clreol;
       gotoxy(1,19); write(' posiz 1',posiz); delay(1000);}
        scrivi(Posiz,false);
        Posiz:=Npos;
       { gotoxy(1,20); clreol;
        gotoxy(1,20); write(' posiz 1',posiz); delay(1000);}
        scrivi(Posiz,true);
     end
    else
     begin
        reset(Fopz);
        Read(Fopz,BufOpz);
        Posiz:=Npos;
        indice:=1;
        For i:=1 to Alt Do
        begin
          Read(Fopz,Elenco[i]);
          scrivi(i,i=Posiz);
        end;
        {gotoxy(1,18); clreol;
        gotoxy(1,18); write(' posiz ',posiz); delay(1000);}
     end;
  end;

{
gotoxy(1,22);
write('Lungf:',Lungf,' ind:',Indice,' Posiz:',Posiz,' InizioF:',Iniziof,' Finef:',FineF);
clreol;
}
end;
(*
procedure freccia(var i:integer);
begin

  if i<1 then
  begin
    GotoXY(XCen+Larg Div 2+2,yCen+alt Div 2-1);
    write(chr(24));
    repeat
    Dato:=LINE_INPUT(U_Xmin+1,U_YMax-1,Larg,
                              StartPos,' ',Dato,3,ExitChar,FALSE,F,0,'',F);
    if exitchar=chr(123)then
    begin
      delay(200);
      nuovariga(posiz-alt,0);
      i:=5;
    end;
    until (ord(exitchar)=123)or (ord(exitchar)=122)
  end
  else
  begin
    GotoXY(XCen+Larg Div 2+2,yCen+alt Div 2-1);
    write(chr(25));
    repeat
    Dato:=LINE_INPUT(U_Xmin+1,U_YMax-1,Larg,
                              StartPos,' ',Dato,3,ExitChar,FALSE,F,0,'',F);
    if exitchar=chr(123)then
    begin
      delay(200);
      nuovariga(posiz+alt,0);
      i:=5;
    end;
    until (ord(exitchar)=123) or (ord(exitchar)=122)
  end;
end; *)

procedure freccia(i:integer);

begin
  case i of
  1:
  begin
    GotoXY(XCen+Larg Div 2+2,yCen-alt Div 2);
    write(chr(24));
    sali:=true;
    delay(200);
  end;
  2:
  begin
    GotoXY(XCen+Larg Div 2+2,yCen+alt Div 2-1);
    write(chr(25));
    scendi:=true;
    delay(200);
  end;
  0:begin
     textbackground(col[12]);
     GotoXY(XCen+Larg Div 2+2,yCen+alt Div 2-1);
     write(' ');
     GotoXY(XCen+Larg Div 2+2,yCen-alt Div 2);
     write(' ');
     scendi:=false;
     sali:=false;
    end;
  end;
end;

{--------- Main -----------}
procedure SelectCampo1(Nome:String;Campo:Integer;var lineains,linedescr:string);
begin
cursoron(false);
oldpos:=0;


ym:=0;
if (Exist(nome))  then
  begin
  assign(FOpz,Nome);
  reset(Fopz);
  if not eof(FOpz) then
    begin
    Read(Fopz,BufOpz);
    Val(BufOpz.Descr,LargDesc,errore);
    if errore=0 then
      begin
      Val(BufOpz.Valore,LargVal,errore);
      if largval<> 0 then Larg:=Largdesc+LargVal+1
      else larg:=Largdesc;
      if (errore=0)and(larg<=78) then
        begin
        NumRg:=Carica;
        If NumRG>0 then
         begin
            pallino(1);
            sali:=false;
            scendi:=false;
            i:=1;
            repeat
             dato:='';  {U_Xmin+1,U_YMax-1,Larg,}
             StartPos:=0;
             Dato:=sel_line.LINE_INPUT(U_Xmin+1,U_YMax-1,Larg,
                              StartPos,' ',Dato,3,ExitChar,FALSE,F,0,'',F);
             Car:=ExitChar;

             if dato > '' then
              begin
                 scrivi(Posiz,false);
                 Nuovariga(posiz+(-Posiz+TrovaPos(Dato)),1);
                 Car:=#15;  { un tasto qualsiasi tranne l' enter }
                 textbackground(col[12]);
                 gotoxy(U_Xmin+1,U_YMax-1);
                 Dato:=Copy(Fill,1,larg); write(dato);
              end;

             if sali and (ord(Car) = 123) then Car:=#73;
             if scendi and (ord(Car) = 123) then Car:=#81;
             if sali and (ord(Car) = 122) then Car:=#72;
             if scendi and (ord(Car) = 122) then Car:=#80;


             case ord(Car) of
               80:Nuovariga(Posiz+1,0);
               72:Nuovariga(Posiz-1,0);
               81:Nuovariga(Posiz+alt,0);
               73:Nuovariga(Posiz-alt,0);
              120:begin
                    ym:=round(m_y*(alt+2)/25);
                    case ym of
                    0:if indice > 1 then freccia(1);
                1..10:begin
                        freccia(0);
                        nuovariga(ym,0);
                      end;
                11,12:if indice+alt < lungf then freccia(2);
                    end;
                  end;
             end;
            until Ord(Car) IN [27,13,123,122];
            if (ord(car)=13) or (ord(car)=122) then
            begin
             if (Elenco[Posiz].Valore>'') OR (largval>0) then
             begin
               if Elenco[Posiz].Valore>'' then lineains:=Elenco[Posiz].Valore
               else
               lineains:=' ';
             end
             else lineains:=Elenco[Posiz].descr;
             linedescr:=Elenco[Posiz].descr;
           end
           else
           begin
             lineains:='';
             linedescr:='';
           end;
        end;
      end
    end
    else lineains:='';
  Close(FOpz);
  end;
  cursoron(true);;
end;
end;
procedure SelectCampo(Nome:String;Campo:Integer;var lineains,postins:string);
var insmisto:boolean;
    nomedientrata,nomeins,linetemp:string;

begin
  Nome:=NomeLista(Nome,Campo);
  generaindice(nome,'','',insmisto);
  if not insmisto then SelectCampo1(Nome,Campo,lineains,postins) else
  begin
    nomeins:='indins.ins';
    SelectCampo1(nomeins,Campo,lineains,linetemp);
    if lineains>'' then
    begin
      textbackground(col[3]);
      textcolor(col[4]);
      StampaMappa1(U_XMin,U_YMIN,U_XMax,U_YMax,7);
      textcolor(col[4]);
      WriteCampi1(U_XMin,U_YMIN,U_XMax,U_YMax);
      generaindice(nomeins,linetemp,nome,insmisto);
      SelectCampo1(nomeins,Campo,lineains,postins);
    end;
  end;
end;

end.