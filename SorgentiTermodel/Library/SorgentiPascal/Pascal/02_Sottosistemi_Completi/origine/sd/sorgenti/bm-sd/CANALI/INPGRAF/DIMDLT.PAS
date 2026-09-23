
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{F+}

Unit dimdlt{vedi piante};

Interface

uses definiz,esiste;

Procedure DimInDlt(Nome:string);

Implementation

{---------------------------------------------------------------------------}
Procedure DimInDlt(Nome:string);

type dimrecdis=record mov:char;x,y:integer end;  { cippo Inserito x velocizzare}
     dimrecdisV=array[1..nhpgl]of dimrecdis;{ cippo dimensionato. mov e'  }
var  dimhpgl:^dimrecdisV;                   { char anziche boolean      }
{mov='0'=PU=true mov='1'=Pd=false mov='Z'=> x=z1 e y=z2
 mov='C=setcolor(x)=setcnstyle(y) cippo }
TYpe PltCTQuo =record
                estensio : string[4];
                valore   : Char;
                colore   : integer;
                stile    : integer;
               end;

 var f        :text;
     st1,st2,p:string;
     v        :integer;
     xt,yt    :integer;
     alzata   :boolean;
     ch       :char;
     fdis     :file of dimrecdis;
     buf      :dimrecdis;
     PCQ      :array[1..3] of PltCtQuo;
     i        :integer ;

 Procedure leggiplt;
{type dimrecdis=record mov:char;x,y:integer end;  { cippo Inserito x velocizzare}
{     dimrecdisV=array[1..nhpgl]of dimrecdis;{ cippo dimensionato. mov e'  }
{var  dimhpgl:^dimrecdisV;                   { char anziche boolean      }
{mov='0'=PU=true mov='1'=Pd=false mov='Z'=> x1=z1 e x2=z2
 mov='C=setcolor(x1) =setlnstyle(x2) cippo }
 begin
  st1:='';
  st2:='';
  xt:=0;
  yt:=0;
  v:=8;

  while not eof(f) do
  begin
    read(f,ch);

    case ch of

     'U':begin
           alzata:=true;
           REPEAT
           repeat
             read(f,ch);
             if not (ch in[';',',','P']) then st1:=st1+ch;
           until (ch=',') or (ch=';') OR (CH='P');
           if not(ch in[';','P']) then
           begin
             repeat
               read(f,ch);
               if not (ch in[';',',','P','L']) then st2:=st2+ch;
             until (ch=';') or  (ch='P')or (ch=',')or (ch='L');
             val(st2,yt,v);
             val(st1,xt,v);
             st1:='';
             st2:='';
             if alzata then
             buf.mov:='1'{true}
             else buf.mov:='0';{false};
             buf.x:=xt;buf.y:=yt;
             write(fdis,buf);
             CONTLINE:=CONTLINE+1;
             If ContLine=NHPGl Then ContLine:=0;
           end;
           UNTIL (CH=';') OR (CH='P')
         end;

     'D':begin
           alzata:=false;
           REPEAT
           repeat
             read(f,ch);
             if not (ch in [',',';','F','P']) then st1:=st1+ch;
           until (ch=',')or(ch=';')or (ch='F') or (ch='P');

           if not (ch in ['F',';','P']) then
           begin
             repeat
               read(f,ch);
               if not (ch in[';',',','P','L']) then st2:=st2+ch;
             until (ch=';') or (ch='P')or (ch=',')or (ch='L');
             val(st2,yt,v);
             val(st1,xt,v);
             st1:='';
             st2:='';
             if alzata then
             buf.mov:='1'{true}
             else buf.mov:='0'{false};
             buf.x:=xt;buf.y:=yt;
             write(fdis,buf);
             CONTLINE:=CONTLINE+1;
             If ContLine=NHPGl Then ContLine:=0;
           end
           else if ch='F' then alzata:= not alzata;
           UNTIL (CH=';') OR (CH='P')
         end;

     'A':begin
           repeat
             read(f,ch);
             if ch<>','then st1:=st1+ch;
           until ch=',';
           repeat
             read(f,ch);
             if ch <>';' then st2:=st2+ch;
           until (ch=';') or (eoln(f))or (ch='P');
           val(st2,yt,v);
           val(st1,xt,v);
           st1:='';
           st2:='';
           if alzata then
           buf.mov:='1'{true}
           else buf.mov:='0'{false};
           buf.x:=xt;buf.y:=yt;
           write(fdis,buf);
           CONTLINE:=CONTLINE+1;
           If ContLine=NHPGl Then ContLine:=0;
         end;
     'Z':begin
           repeat
             read(f,ch);
             if ch<>','then st1:=st1+ch;
           until ch=',';
           repeat
             read(f,ch);
             if ch <>';' then st2:=st2+ch;
           until (ch=';') or (eoln(f))or (ch='P');
           val(st2,yt,v);
           val(st1,xt,v);
           st1:='';
           st2:='';
           buf.mov:='Z';{true}
           buf.x:=xt;buf.y:=yt;
           write(fdis,buf);
           CONTLINE:=CONTLINE+1;
           If ContLine=NHPGl Then ContLine:=0;
         end;
    end;
  end;

 end;
BEGIN    {************* M A I N ***************}

if Not sezione Then
 begin
     Assign(FDiS,DataDrive+NomeProg+'.DLP');
     Rewrite(Fdis);
 End
else
 begin
     Assign(FDiS,DataDrive+NomeProg+'.DLS');
     Rewrite(Fdis);
 End;


PCQ[1]. estensio :='.plt';
PCQ[1]. valore   :='C'   ;
PCQ[1]. colore   :=Costant.colcan;
PCQ[1]. stile    :=1;
PCQ[2]. estensio :='.QUO';
PCQ[2]. valore   :='C'   ;
PCQ[2]. colore   :=Costant.colQ;
PCQ[2]. stile    :=1;
PCQ[3]. estensio :='.CT ';
PCQ[3]. valore   :='C'   ;
PCQ[3]. colore   :=Costant.colcan;
PCQ[3]. stile    :=2;

  contline:=0;

for i:= 1 to 3  do
 begin
  If exist(DataDrive+NomeProg+PCQ[i]. estensio)
  then begin
       Assign(f,DataDrive+NomeProg+PCQ[i]. estensio);
       reset(f);
       with buf do
         begin
          mov :=PCQ[i].valore;
          x   :=PCQ[i].colore;
          y   :=PCQ[i].STILE;
         end;
         write(FDis,buf);
         CONTLINE:=CONTLINE+1;
         If ContLine=NHPGl Then ContLine:=0;
         leggiplt;
         Close(f);
         Erase(f);
      end
  else Begin  CLose(FDis); halt;  end;

 end;

       with buf do
         begin
          mov :=PCQ[1].valore;
          x   :=PCQ[1].colore;
          y   :=PCQ[1].STILE;
         end;
         write(FDis,buf);
         CONTLINE:=CONTLINE+1;
         If ContLine=NHPGl Then ContLine:=0;

 with buf do
     begin
          mov :='H';
          x   := 0;
          y   := 0;
     end;
 WHILE CONTLINE MOD nhpgl <>0 DO
    BEGIN
    CONTLINE:=CONTLINE+1;
    write(fdis,buf);
    END;


CLose(FDis);
END;
end.



