{$ifdef free}
{$define SPROTETTO}
{$undef PROTETTO}
{$ENDIF}


unit Piante;

interface
uses crt,dos;

{---------------------------------------------------------------------------}

Procedure leggiplt(Nome:string);

implementation

Procedure leggiplt(Nome:string);

CONST NHPGL =100;
type {$IFDEF FREE}
     recdis=record mov:boolean;x,y:integer;free:boolean; end;
     {$ELSE}
     recdis=record mov:boolean;x,y:integer end;
     {$ENDIF}
     recdisV=array[1..nhpgl]of recdis;
var  hpgl:^recdisV;
     contline :integer;


var f        :text;
    st1,st2,p:string;
    v        :integer;
    xt,yt    :integer;
    alzata   :boolean;
    ch       :char;
    fdis     :file of recdis;
    buf      :recdis;
    coordx,coordy,xcorr,ycorr:integer;
    primap,assoluta,valido,num1,isnumero:boolean;
const el=chr(10);

procedure esegui;
begin
  if alzata then
  buf.mov:=true
  else buf.mov:=false;
  if assoluta then
  begin
   buf.x:=coordx;
   buf.y:=coordy;
  end
  else
  begin
    buf.x:=xcorr+coordx;
    buf.y:=ycorr+coordy;
  end;
  xcorr:=buf.x;
  ycorr:=buf.y;
  write(fdis,buf);
  CONTLINE:=CONTLINE+1;
  If ContLine=NHPGl Then ContLine:=0;
end;

begin
  assoluta:=true;
  isnumero:=false;
  {PRIMAP:=FALSE;}
  ALZATA:=TRUE;
  contline:=0;
  xt:=0;
  yt:=0;
  v:=8;
  st2:='';
  assign(f,nome+'.plt');
  reset(f);
  assign(fdis,nome+'.dlt');
  rewrite(fdis);
  num1:=true;
  st1:='';
  while not eof(f) do
  begin
    read(f,ch);
    st2:=st2+ch;
    case ch of
    'P':begin
          valido:=false;
          primap:=true;
          if (not num1) and isnumero then
          begin
            val(st1,coordy,v);
            esegui;
            num1:=true;
            st1:='';
            isnumero:=false;
            valido:=false;
          end;
        end;
    'U':if primap  then
        begin
          alzata:=true;
          valido:=true;
        end
        else valido:=false;
    'D':if primap then
        begin
          alzata:=false;
          valido:=true;
        end
        else valido:=false;
    'A':if primap then
        begin
          Assoluta:=true;
          valido:=true;
        end
        else valido:=false;
    'R':if primap then
        begin
          assoluta:=false;
          valido:=true;
        end
        else valido:=false;
'-','0'..'9':if valido then
             begin
               st1:=st1+ch;
               isnumero:=true;
             end;
' ',',',';',el:if valido and isnumero then
           begin
             if num1 then
             begin
               val(st1,coordx,v);
               num1:=false;
               st1:='';
               isnumero:=false;
             end
             else
             begin
               val(st1,coordy,v);
               esegui;
               num1:=true;
               st1:='';
               isnumero:=false;
               {valido:=false;}
             end;

           end
        else IF ch<>' ' then valido:=false;
      else valido:=false;
    end;
    if ch<>'P' then primap:=false;
  end;

  WHILE CONTLINE MOD nhpgl <>0 DO
    BEGIN
    buf.mov:=true;
    BUF.X:=0;
    BUF.Y:=0;
    CONTLINE:=CONTLINE+1;
    write(fdis,buf);
    END;
  close(f);
  close(fdis);
end;

end.



