unit Varcarichi;

interface
Type
TyHM=ARRAY[0..23,1..12] OF REAL;

var meseinizio:integer=1;
    mesefine:integer=12;
    R1,R2,R3,
    //TE,
    IDN:^tyhm;
{$I Typedef}
procedure Init_punt;
Implementation
procedure Init_punt;
{$I NewPun}
begin
new(r1);
new(r2);
new(r3);
new(IDN);
initpuntatori;
end;
end.
