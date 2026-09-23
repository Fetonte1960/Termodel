Unit Percento;
interface
uses
{$ifdef windef}
 dummyfunction,
 textc
{$endif}
{$ifdef dos}
 crt
{$endif}
;
type Forcent = record
                  xx         :integer;

                  current    :longint;
                  finale     :longint;
                  scrittura  :string;
                  incremento :integer;
                  Trattidis  :integer;
               end;
var percentuale : Forcent;

Procedure initperc(fine:longint; incr:integer; scritta:string;
                   xxx:integer);
{initperc si puo usare :
       1- fine        -> filesize del file
       2- incremento  -> sizeof record
       3- scrittura da visualizzare
       4- xxx ascissa scrittura

       1- fine        -> numero di record
       2- incremento  -> 1
       3- scrittura da visualizzare
       4- xxx ascissa scrittura
                                    }

Procedure percentu;

implementation
Procedure initperc(fine:longint; incr:integer; scritta:string;
                   xxx:integer);
begin
With percentuale do
 begin

  current:=0;
  finale:=fine;
  incremento:=incr;
  scrittura :=scritta;
  xx:=xxx;
  Trattidis:=0;

 end;

end;

Procedure percentu;
var quanti,jj : integer;
    real1,real2,real3:real;
begin
if percentuale.finale<> 0 then
 if percentuale.current=0 then
  Begin
  window(1,3,80,25);
  clrscr;
  {$ifdef dos}
  gotoxy(2,percentuale.xx+0);
  Write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
  gotoxy(5,percentuale.xx);
  write(percentuale.scrittura);
  gotoxy(2,percentuale.xx+1);
  write('³                                                                       ³');
  gotoxy(2,percentuale.xx+2);
  write('³                                                                       ³');
{  gotoxy(2,percentuale.xx+5);
  write('³                                                                       ³');}
  gotoxy(2,percentuale.xx+3);
  Write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
  {$endif}

  {$ifdef Win}
  gotoxy(2,percentuale.xx+0);
  Write('=========================================================================');
  gotoxy(5,percentuale.xx);
  write(percentuale.scrittura);
  gotoxy(2,percentuale.xx+1);
  write('                                                                         ');
  gotoxy(2,percentuale.xx+2);
  write('                                                                         ');
{  gotoxy(2,percentuale.xx+5);
  write('³                                                                       ³');}
  gotoxy(2,percentuale.xx+3);
  Write('=========================================================================');
  {$endif}
  end;



   with percentuale do
   begin
   current:=current+incremento;
   real1:=current;
   real2:=finale;
   real3:=real1*100/real2;
   quanti:=trunc(real3);
   if quanti<=100 then
   begin
     gotoxy(35,xx+1);
    write(quanti:3,'%');
    gotoxy(3+trattidis,xx+2);
    quanti:=trunc(quanti*7/10)-trattidis;
    Trattidis:=Trattidis+quanti;
    for jj:=1 to quanti do
     {$ifdef dos}
     write('Ş');
     {$else}
     write('Š');
     {$endif}
   end;
   end;
 end;
end.