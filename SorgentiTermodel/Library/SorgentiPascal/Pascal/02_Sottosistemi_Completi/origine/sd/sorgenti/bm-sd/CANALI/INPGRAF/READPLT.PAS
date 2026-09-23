{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{F+}

program leggiplt;

interface



uses crt,dos;


{$I halotp4.p}


procedure leggiplotter(nome:string);


implementation


procedure leggiplotter(nome:string);



type coordplot=record
                   x1,y1,x2,y2:integer;
                   end;

     lplot=array[1..8190] of coordplot;

type coordplot1=record
                   x1,y1,x2,y2:integer;
                   end;

     lplot1=array[1..8190] of coordplot;

    recdis:record tipo:boolean;dx,dy:integer end;

var f:text;
    vlplot:^lplot;
    vlplot1:^lplot1;
    st1,st2,p:string;
    i,v,j,k:integer;
    xt,yt,r1,r2,r3,r4:real;
    alzata,stato :boolean;
    ch:char;


begin
  st1:='';
  st2:='';
  xt:=0;
  yt:=0;
  j:=1;
  k:=8;
  setcolor(@k);
  new(vlplot);
  new(vlplot1);
  k:=1;
  assign(f,nome);
  reset(f);
  i:=1;

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
           if xt<=0 then xt:=567.9450-((xt/-22717)*567.9450)else xt:=567.9450+((xt/22717)*567.9450);
           if yt<=0 then yt:=448.44-((yt/-17937)*448.44) else yt:=448.44+((yt/17937)*448.44);

           if alzata then
           begin
             if j<=8190 then
             begin
                vlplot^[j].x1:=round(xt);
                vlplot^[j].y1:=round(yt);
                stato:=true;
             end else
             begin
                vlplot^[k].x1:=round(xt);
                vlplot^[k].y1:=round(yt);
                stato:=true;
             end;
           end else
           begin
             if stato then
             begin
               if j<=8190 then
               begin

               vlplot^[j].x2:=round(xt);
               vlplot^[j].y2:=round(yt);
               j:=j+1;

               stato:=false;
               end else
               begin
               vlplot1^[k].x2:=round(xt);
               vlplot1^[k].y2:=round(yt);
               k:=k+1;
               r1:=10;r2:=590;
               movtcurabs(@r1,@r2);
               str(k,p);
               text1(@p);
               stato:=false;
               end;
             end else
             begin
               if j<=8190 then
               begin
                 vlplot^[j].x1:=vlplot^[j-1].x2;
                 vlplot^[j].y1:=vlplot^[j-1].y2;
                 vlplot^[j].x2:=round(xt);
                 vlplot^[j].y2:=round(yt);
                 j:=j+1;
                 r1:=10;r2:=600;
                 movtcurabs(@r1,@r2);
                 str(j,p);
                 text1(@p);
                 end else
                 begin
                   if k>1 then vlplot1^[k].x1:=vlplot1^[k-1].x2 else vlplot1^[k].x1:=vlplot^[j-1].x2;
                   if k>1 then vlplot1^[k].y1:=vlplot1^[k-1].y2 else vlplot1^[k].y1:=vlplot^[j-1].y2;
                   vlplot1^[k].x2:=round(xt);
                   vlplot1^[k].y2:=round(yt);
                   k:=k+1;
                   r1:=10;r2:=590;
                   movtcurabs(@r1,@r2);
                   str(k,p);
                   text1(@p);
                 end
             end;
           end;
         { if alzata then movabs(@xt,@yt) else lnabs(@xt,@yt)}
         end;
     end;
    end;
    close(f);
    for i:=1 to j do
    begin
      with vlplot^[i] do
      begin
      r1:=x1;r2:=y1;r3:=x2;r4:=y2;
      movabs(@r1,@r2);
      lnabs(@r3,@r4);
      end;
    end;
    if k>1 then
    begin
    for i:=1 to k-1 do
    begin
      with vlplot1^[i] do
      begin
      r1:=x1;r2:=y1;r3:=x2;r4:=y2;
      movabs(@r1,@r2);
      lnabs(@r3,@r4);
      end;
    end;
    end;
  dispose(vlplot);
  dispose(vlplot1);
  end;
  end.


