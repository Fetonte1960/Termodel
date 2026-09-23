
program ordina;

uses do

const
   NPuntiFaccia = 4;

type
   punto  = record
               X,Y,Z : real;
            end;
   faccia = array[1..NPuntiFaccia] of punto;

   RigaTab = record
                Codice : string[20];
                Punti  : Faccia   ;
             end;

var buf:rigatab;

  const
     x='ù';
     inf='®';

  var
     f:file of rigatab;
     ch:char;
     variabile:String[240];
     I,J,Cx,Cy:integer;
     flag1,ncar:integer;
     larga,alta:real;
  begin
     int1:=1;int2:=1;int3:=0;int4:=1;
     settext(@int1,@int2,@int3,@int4);
     int1:=7;
     int2:=0;
     settextclr(@int1,@int2);

     ninfo:=0;
     UltimoAccesso:=0;
     I:=0;Cx:=0;Cy:=1;
     assign(f,NomeF);
     reset(f);
     while not(eof(f)) do
      begin
         read(f,buf);
         with buf do
         if (codice='L')or (codice='D')or(codice='DX')or (codice='END') then
         begin
         if codice='L' then
           begin
           setcolor(@col[2]);
           real1:=punti[1].x+dx;
           real2:=punti[1].y+dy;
           real3:=punti[2].x+dx;
           real4:=punti[2].y+dy;
           movabs(@real1,@real2);
           lnabs(@real3,@real4);
           end;
         if codice='D' then
           begin
           larga:=punti[2].x;
           alta:=punti[3].y;
           int1:=1;
           setcolor(@int1);
           real1:=dx+larga;
           real2:=dy+alta;
           real3:=dx;
           real4:=dy;
           bar(@real3,@real4,@real1,@real2);
           end
         end
         else
         begin
          if codice[1]= x then
          begin
             I:=I+1;
             with Tabella[I] do
              begin
                 Tipo:=codice[2];
                 x:=round(punti[1].x)+dx;
                 y:=round(punti[1].y)+dy;
                 ncar:=2;
                 variabile:='';
                 repeat
                    ncar:=ncar+1;
                    ch:=codice[ncar];
                    if ch in ['0'..'9'] then variabile:=variabile+ch;
                 until not(ch in['0'..'9']);

                 flag1:=0;
                 val(variabile,L,flag1);
                 if (flag1 <> 0) or (length(variabile) = 0) then L:=0;

                 if ch = ':' then
                  begin
                     variabile:='';
                     repeat
                        ncar:=ncar+1;
                        ch:=codice[ncar];
                        if ch in ['0'..'9'] then variabile:=variabile+ch;
                     until not(ch in['0'..'9']);
                     flag1:=0;
                     val(variabile,CifreDec,flag1);
                     if (flag1 <> 0) or (length(variabile) = 0) then CifreDec:=0;
                  end;

                 BAddr:=Base;OAddr:=OffSet;
                 case Tipo of
                   'I','i':
                     begin
                        CifreInt:=L;
                        OffSet:=OffSet+2;
                        Flag:=(Tipo = 'I');
                     end;
                   'R','r':
                     begin
                        if L > 0 then L:=L+1;
                        OffSet:=OffSet+6;
                        CifreInt:=L;
                        Flag:=(Tipo = 'R');
                     end;
                   '$','s':
                     begin
                        OffSet:=OffSet+L+1;
                        Flag:=(Tipo = '$');
                     end;
                   'C','c':
                     begin
                        OffSet:=OffSet+L;
                        Flag:=(Tipo = 'C');
                     end;
                   else
                 end;
                 UltimoCampo:=I;
                 if Tipo in ['$','R','I','C'] then UltimoAccesso:=I;
             end;
          end
          else
            begin
              real1:=punti[1].x+dx;
              real2:=punti[1].y+dy;
              G_textcolor(col[2]);
              G_textbackground(col[1]);
              movtcurabs(@real1,@real2);
              text1(@codice);
            end
         end
        end;


     close(f);


  end;

