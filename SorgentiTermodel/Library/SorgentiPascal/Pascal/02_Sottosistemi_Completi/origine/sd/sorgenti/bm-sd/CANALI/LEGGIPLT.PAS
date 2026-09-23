{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{F+}

program leggiplt;


uses crt,dos;

type recdis=record mov:boolean;x,y:integer end;


var f        :text;
    st1,st2,p:string;
    v        :integer;
    xt,yt    :integer;
    alzata   :boolean;
    ch       :char;
    nome     :string;
    fdis     :file of recdis;
    buf      :recdis;

begin
  write('Nome del file da convertire(senza estensione):');readln(nome);
  st1:='';
  st2:='';
  xt:=0;
  yt:=0;
  v:=8;
  assign(f,nome+'.plt');
  reset(f);
  assign(fdis,nome+'.dlt');
  rewrite(fdis);
  while not eof(f) do
  begin
    read(f,ch);

    case ch of

     'U':alzata:=true;

     'D':alzata:=false;

     'A':begin
           repeat
             read(f,ch);
             if ch<>','then st1:=st1+ch;
           until ch=',';
           repeat
             read(f,ch);
             if ch <>';' then st2:=st2+ch;
           until ch=';';
           val(st2,yt,v);
           val(st1,xt,v);
           st1:='';
           st2:='';
           if alzata then
           buf.mov:=true
           else buf.mov:=false;
           buf.x:=xt;buf.y:=yt;
           write(fdis,buf);
         end;
    end;
  end;
  close(f);
  close(fdis);
end.



