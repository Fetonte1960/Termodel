program convmask;
uses defuti;
var W_Uio:boolean;

FUNCTION SETRIGHT(ST:STRING):STRING;
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

END;
FUNCTION SETLEFT(ST:STRING):STRING;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;
function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;
Function FormST(ST:STRING):String;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt:=UpString(St);
end;

function numerolum(ch:char):integer;

 begin
   case ch  of
   'L':  numerolum:=1;
   'S':  numerolum:=2;
   'l':  numerolum:=3;
   'K':  numerolum:=4;
   'D':  numerolum:=5;
   'J':  numerolum:=6;
   'Q':  numerolum:=7;
   'W':  numerolum:=8;
   'w':  numerolum:=9;
   'M':  numerolum:=10;
   'm':  numerolum:=11;
   'P':  numerolum:=12;
   'V':  numerolum:=13;
   'v':  numerolum:=14;
  end;
 end;


function Exist(Nome:string):boolean;
 var i:integer;
 s:tsearchrec;
 var f:file;
    begin
    exist:=false;
    i:=findfirst(nome,faAnyFile,s);
    exist:=i=0;
 end;
function eliminadir(dir:string):string;
var i:integer;

begin
  eliminadir:=dir;
  for i:=1 to length(dir) do
  if dir[i]='\' then eliminadir:=copy(dir,i+1,length(dir))
end;
procedure initprogram;
var i:integer;
begin
tab_testo:=true;
stampe_word:=false;
drive_lingua:='';
stampprn:=exist('stampe.pin');
FlagStampa:=true;
UnMistemperatura:=1;
tabellaaggiornata:=false;
new(vcomandi);
new(tabella);
new(tabmista);
new(ar_ins);
ncampimista:=false;
new(umlav);
new(arkum);
new(info);
new(info1);
new(infoum);
new(messum);
new(mappa);
new(mappaMista);
new(bufopz);
new(mess);
for i:=1 to maxinfo do mess^[i]:='';
{$ifdef win}
cancloseok:=true;
new(tabellacorrente);
new(postab);
fillchar(postab^,sizeof(postab^),0);
ulttab:=1;
if exist('postab.dat') then
begin
  assign(fpostab,'postab.dat');
  reset(fpostab);
  while not eof(fpostab) do
  begin
    read(fpostab,postab^[ulttab]);
    inc(ulttab);
  end;
  close(fpostab);
end
else ulttab:=0;
initproc;
dueres:=false;
for i :=1 to maxtabelle do
with tabellacorrente^[i] do
begin
  nome:='';
  dialog:=nil;
  maniglia:=0;
end;
posx:=20;
posy:=70;
getdata:=true;
numcampitab:=0;
new(elstr);
fillchar(elstr^,sizeof(elstr^),0);
a_w:=0;
{$endif}
end;
function SpaceTab(InADDR:word):integer;
  var OfsAddr:word;i:integer;
  begin
     if dimtab=0 then
     begin
     with Tabella^[UltimoCampo] do
      begin
         OfsAddr:=OAddr-InADDR;
         case Tipo of
          '$','s':OfsAddr:=OfsAddr+L+1;
          'C','c':OfsAddr:=OfsAddr+L;
          'R','r',
          'T','t':OfsAddr:=OfsAddr+6;
          'I','i':OfsAddr:=OfsAddr+2;
         end;
      end;
     SpaceTab:=OfsAddr;
     end
     else
     spacetab:=dimtab;
  end;
 procedure InitTabella;
  var i:integer;
  begin

     for i:=1 to MaxCampi do
     with Tabella^[i] do
       begin
          Flag:=false;
          Tipo:='n';
          L:=0;
          x:=0;y:=0;
          BAddr:=0;OAddr:=0;
          CifreInt:=0;CifreDec:=0;
          help:=0;
          NCampoTab:=i;
          modificato:=false;
          nlineum:=0;
          num:=0;
          subtipo:=' ';
          {$ifdef win}
          p:=nil;
          pcb:=nil;
          pck:=nil;
          {$endif}
       end;
  end;

procedure LeggiMask(NomeF:st80;nlinea:integer);
  const
     x=#157;
     xcb=#158;
     xrb=#155;
     inf=#168;
     infum=#159;
  var
     f,fhp:text;
     ch:char;
     variabile:String[240];
     I,J,Cx,Cy,cyn:integer;
     flag1:integer;
     buff:String;
     NCP:integer;
     stNcp:String;
     nCifre,error:integer;
     CampiTab,NumHelp:Integer;
     mescor:integer;
     num2:integer;


  begin
     mescor:=0;
     Nom_mask:=NomeF;
     NOMEF:=DRIVEMASK+NOMEF;
     IF NOT EXIST(NOMEF) THEN
     NOMEF:=ELIMINADIR(NOMEF);
     IF NOT EXIST(NOMEF) THEN
     BEGIN
     {
     WRITE('FILE INSISTENTE ',NOMEF);
     HALT;
     }
     END;
     assign(fhp,copy(NomeF,1,length(nomef)-3)+'lhp');
     rewrite(fhp);
     NumHelp:=0;
     ninfo:=0;
     ninfoum:=0;
     CampiTab:=0;
     UltimoAccesso:=0;
     I:=0;Cx:=0;Cy:=1;
     assign(f,NomeF);
     reset(f);
     if nlinea>0 then
     for j:=1 to nlinea do readln(f,buff);
     while not(eof(f)) do
     if (cy<=23) then     {-- Help --}
      begin
         read(f,ch);
         Cx:=Cx+1;
         if (ch = x) or (ch=xcb) or (ch=xrb)  then
          begin
             I:=I+1;
             with Tabella^[I] do
              begin
                 if (ch=xcb) then subtipo:='B';
                 if (ch=xrb) then subtipo:='R';
                 read(f,Tipo);
                 x:=Cx;y:=Cy;
                 Cx:=Cx+1;
                 variabile:='';
                 if tipo in ['i','I','r','R','$','s','C','c','T','t'] then
                 begin
                   repeat
                      read(f,ch);
                      Cx:=Cx+1;
                      if ch in ['0'..'9'] then variabile:=variabile+ch;
                   until not(ch in['0'..'9']);
                   flag1:=0;
                   val(variabile,L,flag1);

                   if (flag1 <> 0) or (length(variabile) = 0) then L:=2;

                  if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                        read(f,ch);
                        Cx:=Cx+1;
                        if ch in ['0'..'9'] then variabile:=variabile+ch;
                     until not(ch in['0'..'9']);
                     flag1:=0;
                     val(variabile,CifreDec,flag1);
                     if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
                  end;
                 end
                 else
                 begin
                   mescor:=mescor+1;
                   variabile:='';
                   read(f,ch);
                   Cx:=Cx+1;
                   if ch in ['0'..'9'] then variabile:=variabile+ch;
                   flag1:=0;
                   val(variabile,L,flag1);
                   if (flag1 <> 0) or (length(variabile) = 0) then L:=0;
                   read(f,ch);
                   Cx:=Cx+1;
                   variabile:='';
                   read(f,ch);
                   Cx:=Cx+1;
                   if ch in ['0'..'9'] then variabile:=variabile+ch;
                   flag1:=0;
                   val(variabile,num,flag1);
                   if (flag1 <> 0) or (length(variabile) = 0) then num:=0;
                   nlineum:=numerolum(tipo);
                   case num of
                   1:tipo:='R';
                   2:begin
                      num:=1;
                      tipo:='r';
                     end;
                  3:BEGIN
                     tipo:='R';
                     num:=2;
                    END;
                  4:begin
                      num:=2;
                      tipo:='r';
                     end;
                  end;
                  cifredec:=arkum^[nlineum].um[num].dec;
                 end;
                 BAddr:=BaseMask;OAddr:=OffSetMask;
                 case Tipo of
                   'I','i':
                     begin
                        CifreInt:=L;
                        OffSetMask:=OffSetMask+2;
                        Flag:=(Tipo = 'I');
                     end;
                   'R','r':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'R');
                     end;
                   'T','t':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'T');
                     end;
                   '$','s':
                     begin
                        OffSetMask:=OffSetMask+L+1;
                        Flag:=(Tipo = '$');
                     end;
                   'C','c':
                     begin
                        OffSetMask:=OffSetMask+L;
                        Flag:=(Tipo = 'C');
                     end;
                   else
                 end;
(*                 writeln('ultimoCampo ',ultimocampo);delay(1000);*)
                 UltimoCampo:=I;
                 if Tipo in ['$','R','I','C','T'] then UltimoAccesso:=I;
             end;
          end;

         if ch = chr(13) then
          begin
             Cy:=Cy+1;
             Cx:=-1;
          end;

         if (ch <> #13) and (ch <> ' ') and (ch <> #10)  then
          begin
          if ch=inf then
            begin
            ninfo:=ninfo+1;
            with info^[ninfo] do
              begin
              ix:=cx;iy:=cy;
              end
            end
          else
          if ch=infum then
            begin
            ninfoum:=ninfoum+1;
            with infoum^[ninfoum] do
              begin
              ix:=cx;iy:=cy;
              read(f,ch);
              Cx:=Cx+1;
              if ch<>'T' then
              begin
                messum^[ninfoum].n1:=numerolum(ch);
                variabile:='';
                read(f,ch);
                Cx:=Cx+1;
                if ch in ['0'..'9'] then variabile:=variabile+ch;
                flag1:=0;
                val(variabile,num2,flag1);
                if (flag1 <> 0) or (length(variabile) = 0) then num2:=0;
                messum^[ninfoum].n2:=num2;
              end
              else
              begin
                messum^[ninfoum].n1:=0;
                messum^[ninfoum].n2:=1;
              end;
              end
            end
          else

{            write(lst,' cy  ',cy,'  cx  ',cx);}
            if W_Uio then Mappa^[Cy][Cx]:=ch;
          end;
      end
    else
      begin            {--- stringa di help ---}
      readln(f,Buff);
      if length(buff)>2 then
        begin
        if buff[1]=Chr(13) then Buff:=copy(Buff,2,length(Buff));
        stncp:='';
        NCifre:=1;
        while (Buff[NCifre]<>':')and(NCifre<length(Buff)) do
          begin
          stncp:=stncp+buff[ncifre];
          NCifre:=NCifre+1;
          end;
        val(stncp,NCP,error);
        if (error=0)and(copy(Buff,NCifre+1,Length(Buff))='TAB') then
        Campitab:=NCP
        else
          begin
          if error=0 then
            begin
            NumHelp:=NumHelp+1;
            Tabella^[NCP].Help:=NumHelp;
            writeln(fhp,copy(Buff,NCifre+1,Length(Buff)));
            if CampiTab<>0 then
            for i:=1 to ultimocampo do
            if ((i mod Campitab)=Ncp)or(((i mod Campitab)=0)and(ncp=Campitab))
            then
              begin
              Tabella^[i].Help:=NumHelp;
              Tabella^[i].NCampoTab:=NCP;
              end;
            end;
          end;
        end;
      end;

     close(f);
     close(fhp);
     If CampiTab<>0 then NumCampiTab:=CampiTab
     else CampiTab:=UltimoCampo;

     for i:=Cy+1 to 25 do Mappa^[i]:='';


  end;


procedure leggi2mask(nomef:st80);
var linea:string;
    i,nlinea,k:integer;
    ch:char;
    f:text;
    variabile:String[240];
    J:integer;
    flag1:integer;
    oscurato:boolean;
    conta : integer;
    buff:String;
     NCP:integer;
     stNcp:String;
     nCifre,error:integer;
     CampiTab,NumHelp:Integer;
     exfile:BOOLEAN;
    OFFSETTEMP:INTEGER;
const x='';
      xb='ž';

begin

  dimtab:=0;
  ncampscuri:=0;
  ncampimista:=false;
  exfile:=false;
  NOMEF:=DRIVEMASK+NOMEF;
  nomef:=formst(nomef);

  exfile:=EXIST(NOMEF);

  IF NOT exfile THEN
  NOMEF:=ELIMINADIR(NOMEF);

  exfile:= EXIST(NOMEF);

  IF NOT EXfile THEN
  BEGIN
    WRITE('FILE INSISTENTE ',NOMEF);
    HALT;
  END;

  tabellamista:=false;

  assign(f,NomeF);
  reset(f);
  readln(f,linea);
  linea:=setleft(setright(linea));
  nlinea:=1;
  I:=0;
  if upstring(linea)='MISTA' then
  begin
    offsettemp:=offsetmask;
    while not(upstring(linea)='FINEMISTA') do
      begin
         readln(f,linea);
         linea:=setleft(setright(linea));
         nlinea:=nlinea+1;
         j:=0;
         if linea>'' then
         repeat
         j:=j+1;
         if (linea[j] = x) or (linea[j] = xb)   then
          begin
             I:=I+1;
             with Tabella^[I] do
              begin
                 j:=j+1;
                 Tipo:=linea[j];
                 variabile:='';
                 if tipo in ['i','I','r','R','$','s','C','c'] then
                 begin
                   repeat
                      j:=j+1;
                      ch:=linea[j];
                      if ch in ['0'..'9'] then variabile:=variabile+ch;
                   until not(ch in['0'..'9']);
                   flag1:=0;
                   val(variabile,L,flag1);

                   if (flag1 <> 0) or (length(variabile) = 0) then L:=2;

                  if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                         j:=j+1;
                         ch:=linea[j];
                        if ch in ['0'..'9'] then variabile:=variabile+ch;
                     until not(ch in['0'..'9']);
                     flag1:=0;
                     val(variabile,CifreDec,flag1);
                     if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
                  end;
                 end;
                 BAddr:=BaseMask;OAddr:=OffSetMask;
                 case Tipo of
                   'I','i':
                     begin
                        CifreInt:=L;
                        OffSetMask:=OffSetMask+2;
                        Flag:=(Tipo = 'I');
                     end;
                   'R','r':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'R');
                     end;
                   'T','t':
                     begin
                        if L > 0 then L:=L+1;
                        OffSetMask:=OffSetMask+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'T');
                     end;
                   '$','s':
                     begin
                        OffSetMask:=OffSetMask+L+1;
                        Flag:=(Tipo = '$');
                     end;
                   'C','c':
                     begin
                        OffSetMask:=OffSetMask+L;
                        Flag:=(Tipo = 'C');
                     end;
                   else
                 end;
             end;
          end;
          UltimoCampo:=I;
          until j>=length(linea);
      end;
      readln(f,Buff);
      nlinea:=nlinea+1;
      if length(buff)>2 then
      begin
        if buff[1]=Chr(13) then Buff:=copy(Buff,2,length(Buff));
        stncp:='';
        NCifre:=1;
        while (Buff[NCifre]<>':')and(NCifre<length(Buff)) do
        begin
          stncp:=stncp+buff[ncifre];
          NCifre:=NCifre+1;
        end;
        val(stncp,NCP,error);

        if (error=0)and(copy(Buff,NCifre+1,Length(Buff))='TAB') then
        Campitab:=NCP;

        if CampiTab<>0 then
        for i:=1 to ultimocampo do

        if (((i mod Campitab)=0)and(ncp=Campitab))
        then Tabella^[i].NCampoTab:=NCP
        else tabella^[i].NCampoTab:=(i mod campiTab);

      end;
     fillchar(campivis,sizeof(campivis),0);
     while upstring(linea)<>'CAMPI' do
     begin
       readln(f,linea);
       linea:=setleft(setright(linea));
       nlinea:=nlinea+1;
     end;
     while upstring(linea)<>'FINECAMPI' do
     begin
       readln(f,linea);
       linea:=setleft(setright(linea));
       nlinea:=nlinea+1;
       j:=0;
       i:=0;
       if (linea>'') and (upstring(linea)<>'CAMPI') AND (upstring(linea)<>'FINECAMPI') then
       repeat
         variabile:='';
         repeat
           j:=j+1;
           ch:=linea[j];
           if ch<>',' then variabile:=variabile+ch;
         until (ch=',') or (ch=' ');
         i:=i+1;
         flag1:=0;
         val(variabile,campivis[i],flag1);
         if flag1<>0 then
         campivis[i]:=0 else
         ncampscuri:=i;
         ncampimista:=true;
       until j>=length(linea);

     end;
     ultimocampomista:=ultimocampo;
     i:=spacetab(offsettemp);
     dimtab:=i;
     tabmista^:=tabella^;
     mappamista^:=mappa^;
     tabellamista:=true;
     inittabella;
     offsetmask:=offsettemp;
     close(f);
     NOMEF:=ELIMINADIR(NOMEF);
     leggimask(nomef,nlinea);
     k:=0;
     for i:=1 to ultimocampomista do
     with tabmista^[i] do
     begin
       oscurato:=false;
       j:= 1;
       While (j<= maxcampivis) and not oscurato do
       begin
         if campivis[j]=ncampotab then oscurato:=true;
         j:=j+1;
       end;
       if not oscurato then
       begin
         k:= k+1;
         tabella^[k].oaddr:=tabmista^[i].oaddr;
       end;
     end;
  end
  else
  begin
    close(f);
    NOMEF:=ELIMINADIR(NOMEF);
    leggimask(nomef,0);
  end;
end;

var
ls,NOMEM,NomeR,driveplt:string;
f1:text;
cx,cy,maxy,maxx,Lx,Ly,i,j:integer;
st,st_1,st_3,st_2:st8;
st_4:st8;
trovato:boolean;
begin
  initprogram;
  w_Uio:=true;
  trovato:=false;
  nomeM:=PARAMSTR(1)+'.MSK';
  NomeR:=PARAMSTR(1)+'.rc';
  inittabella;
  LEGGI2MASK(nomem);
  {i:=1;
  while (i<=25) and (not trovato) do
  begin
    j:=1;
    repeat j:=j+1 until (mappa[i,j]='')or (j=80);
  if j<80 then trovato:=true;
  i:=i+1;
  end;
  maxx:=j*8;
  maxy:=(i-1)*19;}
  assign(f1,nomeR);
  rewrite(f1);
  str(maxx,st);
  str(maxy,st_1);
  ls:=upstring(paramstr(3))+upstring(paramstr(1))+' DIALOG 1, 10, 350,250';
  writeln(f1,Ls);
  ls:='STYLE WS_POPUP | WS_VISIBLE | WS_CAPTION | WS_SYSMENU';
  writeln(f1,Ls);
  Ls:='CLASS "Bordlg"';
  writeln(f1,Ls);
  Ls:='CAPTION "'+paramstr(1)+'"';
  writeln(f1,Ls);
  Ls:='FONT 8, "Helv"';
  writeln(f1,Ls);
  Ls:='BEGIN';
  writeln(f1,Ls);
  for i:= 1 to ultimocampo do
  with tabella^[i] do
  if not (subtipo  in ['B','R']) then
  begin
    cx:=(x*5);
    cy:=(y*12);
    lx:=(L*4)+8;
    j:=100+i;
    str(cx,st);
    str(cy,st_1);
    str(lx,st_2);
    str(j,st_4);
    str(l,st_3);
    if tipo in ['I','R','$','C'] THEN
    ls:='CONTROL "'+st_3+'",'+st_4+' , "EDIT", ES_LEFT | WS_CHILD | WS_VISIBLE | WS_BORDER | WS_TABSTOP, '+
    st+', '+st_1+', '+st_2+ ',  12'
    ELSE
    ls:='CONTROL "'+st_3+'",'+st_4+' , "EDIT", ES_LEFT | WS_CHILD | WS_VISIBLE | WS_DISABLED | WS_BORDER | WS_TABSTOP, '+
    st+', '+st_1+', '+st_2+ ',  12';
    writeln(f1,ls);
  END
  else
  case subtipo of
  'B':
  begin
    cx:=(x*5);
    cy:=(y*12);
    lx:=(L*4)+8;
    j:=100+i;
    str(cx,st);
    str(cy,st_1);
    str(lx,st_2);
    str(j,st_4);
    str(l,st_3);
    if tipo in ['I','R','$','C'] THEN

    ls:='CONTROL "'+st_3+'",'+st_4+' , "COMBOBOX", CBS_DROPDOWNLIST | WS_CHILD | WS_VISIBLE | WS_VSCROLL | WS_TABSTOP, '+
    st+', '+st_1+', '+st_2+ ',  12'
    ELSE
    ls:='CONTROL "'+st_3+'",'+st_4+' , "COMBOBOX", CBS_DROPDOWNLIST | WS_CHILD | WS_VISIBLE | WS_VSCROLL | WS_TABSTOP , '+
    st+', '+st_1+', '+st_2+ ',  12';
    writeln(f1,ls);
  END
  end;
  if ninfo>0 then
  for i:=1 to ninfo do
  with info^[i] do
  begin
    str(351+i,st);
    str(ix*4,st_1);
    str(iy*12,st_2);
    ls:='LTEXT "", '+st+', '+st_1+', '+st_2+',60 , 10, WS_CHILD | WS_VISIBLE ';
    writeln(f1,ls);
  end;
  if upstring(paramstr(2))='T' then
  begin
    ls:='LTEXT "Pag 1", 351, 250, 30, 50, 10, WS_CHILD | WS_VISIBLE ';
    WRITELN(F1,Ls);
    ls:='SCROLLBAR 401, 240, 39, 10, 154, SBS_VERT | WS_CHILD | WS_VISIBLE';
    WRITELN(F1,Ls);
  end;
  ls:='END';
  WRITELN(F1,Ls);
  close(f1);
end.