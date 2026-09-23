{*************************************************************}
Function CampoDb_Campi:Integer;
Begin
  Case CampoCor of
  -1:CampoCor:=campoCor;//Per fare compilare i case vuoti
  1:Result:=2;
  2:Result:=3;
  3:Result:=4;
  4:Result:=5;
  5:Result:=6;
  6:Result:=7;
  7:Result:=8;
  8:Result:=9;
  9:Result:=10;
  10:Result:=11;
  11:Result:=12;
  12:Result:=13;
  13:Result:=14;
  14:Result:=15;
  15:Result:=16;
  16:Result:=17;
  17:Result:=18;
  18:Result:=19;
  19:Result:=20;
  End;
End;
{*************************************************************}
Function CampoDb_Rec:Integer;
Begin
  Case CampoCor of
  -1:CampoCor:=campoCor;//Per fare compilare i case vuoti
  1:Result:=1;
  2:Result:=2;
  3:Result:=3;
  4:Result:=4;
  5:Result:=5;
  6:Result:=6;
  7:Result:=7;
  End;
End;
