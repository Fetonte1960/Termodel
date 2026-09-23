{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$E-}

unit pezzi;

interface


procedure disegnapezzo(Xcodpezzo:string;XB1,XH1,XB2,XH2,XB3,XH3,XB4,XH4,XD1,XD2,XD3,XD4:real;
                   XOrient:integer;XAng,XCurv,XLung,XRap,XRap1,XVarie:real;ColLinea:integer;var XX1A,XY1A,XX2A,XY2A,
                   XX3A,XY3A,XX4A,XY4A,XX5A,XY5A,XX6A,XY6A,XX7A,XY7A,XX8A,XY8A,XZ1,XZ2,XZ3,XZ4:real);


implementation


uses Printer,crt,dos,definiz,U_VARPEZZI,U_3733,U_079R,U_31CC,U_271R,U_10RA,U_362R,U_3722,U_3710,
     U_13CB,U_05LR,U_13RBT,U_15RBT,U_180R,crdummy,interf3d;  { ,U_358 }

(* uses Printer,crt,dos,definiz,U_VARPEZZI,U_3733*,U_079R*,U_31CC*,U_271R*,U_10RA*,U_362R*,U_3722*,U_3710*,
     U_13CB*,U_05LR*,U_358*,U_13RBT*,U_15RBT*,crlib; *)

procedure  InitTabP;
 var i:integer;
begin
InitTab3d;
   for i:=1 to 30 do
    with DisPezzo^[i] do
     begin
        entita[1]:=' ';   TLinea:=0;
        X1:=0;            Y1:=0;
	X2:=0;            Y2:=0;
	R:=0;		  R1:=0;
     end;
end;


procedure disegnapezzo(Xcodpezzo:string;XB1,XH1,XB2,XH2,XB3,XH3,XB4,XH4,XD1,XD2,XD3,XD4:real;
                   XOrient:integer;XAng,XCurv,XLung,XRap,XRap1,XVarie:real;ColLinea:integer;var XX1A,XY1A,XX2A,XY2A,
                   XX3A,XY3A,XX4A,XY4A,XX5A,XY5A,XX6A,XY6A,XX7A,XY7A,XX8A,XY8A,XZ1,XZ2,XZ3,XZ4:real);



procedure AssignVar;
 begin
    codpezzo:=XCodPezzo;
    B1:=XB1;  H1:=XH1;  B2:=XB2;  H2:=XH2;  B3:=XB3;  H3:=XH3;
    B4:=XB4;  H4:=XH4;  D1:=XD1;  D2:=XD2;  D3:=XD3;  D4:=XD4;
    Orient:=XOrient;   Ang:=XAng;    Lung:=XLung; Rap:=XRap; Rap1:=XRap1; Varie:=XVarie;
    X1A:=XX1A;  Y1A:=XY1A;  X2A:=XX2A;  Y2A:=XY2A;  X3A:=XX3A;
    Y3A:=XY3A;  X4A:=XX4A;  Y4A:=XY4A;  X5A:=XX5A;  Y5A:=XY5A;
    X6A:=XX6A;  Y6A:=XY6A;  X7A:=XX7A;  Y7A:=XY7A;  X8A:=XX8A;
    Y8A:=XY8A;  {Imb:=Costant^.C1}; ColoreLinea:=ColLinea;

    if XCurv > 0 then Curv:=XCurv
    else
     begin
        if Codpezzo='3722' then Curv:=1
        else Curv:=1.5;
     end;

 end;

procedure AssignAtt;
 begin
    XX1A:=X1A;  XY1A:=Y1A;  XX2A:=X2A;  XY2A:=Y2A;  XX3A:=X3A;
    XY3A:=Y3A;  XX4A:=X4A;  XY4A:=Y4A;  XX5A:=X5A;  XY5A:=Y5A;
    XX6A:=X6A;  XY6A:=Y6A;  XX7A:=X7A;  XY7A:=Y7A;  XX8A:=X8A;
    XY8A:=Y8A;  XZ1:=Z1;    XZ2:=Z2;    XZ3:=Z3;    XZ4:=Z4;
 end;

begin
   {writeln(lst,XCodpezzo,'  Ori:',XOrient,' A:',XB1);}
   AssignVar;
   InitTabP;
   Speculare:=false;
   TypeRid:=false;
   TypeAll:=false;
   TypeRot:=false;
   IniziaPezzo3d(orient);


   if B1<>0 then
    begin
       Y1A:=B1/2;
       Y2A:=-B1/2;
       Y3A:=B1/2;
       Y4A:=-B1/2;
    end
   else
    begin
       Y1A:=D1/2;
       Y2A:=-D1/2;
       Y3A:=D1/2;
       Y4A:=-D1/2;
    end;
   X1A:=0;  X2A:=0;  X3A:=0;  X4A:=0;
   X5A:=0;  Y5A:=0;  X6A:=0;  Y6A:=0;
   X7A:=0;  Y7A:=0;  X8A:=0;  Y8A:=0;
   Z1:=0;   Z2:=0;   Z3:=0;   Z4:=0;


   if CodPezzo='3722'   then D_3722;
   if CodPezzo='3722D'  then D_3723;
   if CodPezzo='3733'   then D_3733;
   if CodPezzo='3733D'  then D_3733;
   if CodPezzo='3736'   then D_3736;


   if CodPezzo='3410'   then D_3410;

   if CodPezzo='3735R'  then D_3735R;
   if CodPezzo='3734R'  then D_3734R;
   if CodPezzo='220R'   then D_220R;
   if CodPezzo='200R'   then D_200R;
   if CodPezzo='19ER'   then D_19ER;
(*   if CodPezzo='3510'   then D_3510;
   if CodPezzo='3511'   then D_3511;*)
   if CodPezzo='362R'   then D_362R;
   if CodPezzo='354'    then D_354;
   if CodPezzo='356'    then D_356;
   if CodPezzo='034R'   then D_034R;
   if CodPezzo='3410'   then D_3410;
   if (CodPezzo='05SC')or (CodPezzo='05TC') then D_06LC;

(*   if (CodPezzo='358') or (CodPezzo='3512') then D_358;
   if (CodPezzo='359') or (CodPezzo='338') then D_359; *)
   if (CodPezzo='230R') or (CodPezzo='230C') or (CodPezzo='210R') or
      (CodPezzo='210C') or (CodPezzo='388R') or (CodPezzo='388C') then D_230R;
   if (CodPezzo='24TR') or (CodPezzo='24TC') then D_24TR;
   if (CodPezzo='381') or (CodPezzo='382') or (CodPezzo='385') then D_382;
   if (CodPezzo='19CR') or (CodPezzo='19FR') then D_19CR;
   if (CodPezzo='180R') or (CodPezzo='180C') then D_180R;
   if (CodPezzo='05LR') or (CodPezzo='05CR') or (CodPezzo='05SR') or
      (CodPezzo='331R') then D_05LR;
   if (CodPezzo='05LC') or (CodPezzo='331C') or (CodPezzo='05CC') then D_05LC;
   if (CodPezzo='04CC') or (CodPezzo='04LC') or (CodPezzo='04SC') then D_04LC;
   if (CodPezzo='04CR') or (CodPezzo='04LR') or (CodPezzo='04SR') then D_04LR;
   if (CodPezzo='11RA') or (CodPezzo='11RB') then D_11RA;
   if (CodPezzo='250R') or (CodPezzo='250C') then D_250R;
   if (CodPezzo='30') or (CodPezzo='29') or (CodPezzo='24ER') or (CodPezzo='24IC') or
      (CodPezzo='24IR') or (CodPezzo='24RR') or (CodPezzo='24RC') or
      (CodPezzo='383') or (CodPezzo='384') or (CodPezzo='386') or
      (CodPezzo='387') or (CodPezzo='24EC') then D_30;
   if (CodPezzo='11RBT') or (CodPezzo='11RAT') then D_11RBT;
   if (CodPezzo='11CBT') or (CodPezzo='11CAT') or (CodPezzo='14CBT') or
      (CodPezzo='14CAT') then D_11CBT;
   if (CodPezzo='10RBT') or (CodPezzo='10RAT') or (CodPezzo='12RBT') or
      (CodPezzo='12RAT') then D_10RBT;
   if (CodPezzo='13RBT') or (CodPezzo='13RAT') or (CodPezzo='13CAT') or
      (CodPezzo='13CBT') or (CodPezzo='14RBT') or (CodPezzo='14RAT') or
      (CodPezzo='13RAC') or (CodPezzo='13RBC') then D_13RBT;
   if (CodPezzo='15RBT') or (CodPezzo='15RAT') or (CodPezzo='15CBT') or
      (CodPezzo='15CAT') or (CodPezzo='16RBT') or (CodPezzo='16RAT') or
      (CodPezzo='15RAC') or (CodPezzo='15RBC') then D_15RBT;
   if (CodPezzo='13CB') or (CodPezzo='13CA') then D_13CB;
   if (CodPezzo='328F') or (CodPezzo='336F') then D_328F;
   if (CodPezzo='15RA') or (CodPezzo='3736R') or (CodPezzo='17RA') or
      (CodPezzo='15RB') or (CodPezzo='17RB') then D_15RA;

   if (CodPezzo = '271R') or (CodPezzo = '021R') or
      (CodPezzo = '273R') or (CodPezzo = '023R') or
      (CodPezzo = '358' ) or (CodPezzo = '3512') or
      (CodPezzo = '3510') or (CodPezzo = '3511') or
      (CodPezzo = '441R') or (CodPezzo = '443R') then D_271R;
   if (CodPezzo = '261R') or (CodPezzo = '263R') or
      (CodPezzo = '011R') or (CodPezzo = '013R') or
      (CodPezzo = '359' ) or (CodPezzo = '338' ) or
      (CodPezzo = '431R') or (CodPezzo = '433R') then D_261R;
   if (CodPezzo = '281R') or (CodPezzo = '283R') or
      (CodPezzo = '031R') or (CodPezzo = '033R') or
      (CodPezzo = '451R') or (CodPezzo = '453R') then D_281R;

   if (CodPezzo='079R') or (CodPezzo='077R') or (CodPezzo='076R') or
      (CodPezzo='074R') or (CodPezzo='073R') or (CodPezzo='072R') or
      (CodPezzo='347A') or (CodPezzo='347B') or (CodPezzo='347C') then D_079R(CodPezzo);

   if (CodPezzo='069R') or (CodPezzo='067R') or (CodPezzo='066R') or
      (CodPezzo='064R') or (CodPezzo='063R') or (CodPezzo='062R') or
      (CodPezzo='348') or (CodPezzo='349')  then D_069R(CodPezzo);

   if (CodPezzo='41R1') or (CodPezzo='41R3') or (CodPezzo='357CR') or
      (CodPezzo='361B')  then D_41R1;
   if (CodPezzo='42C1') or (CodPezzo='42C3') or (CodPezzo='363') or
      (CodPezzo='327R') then D_42C1;

   if CodPezzo='3734C'  then D_3734C;
   if CodPezzo='3735C'  then D_3735C;
   if CodPezzo='3717'  then D_3717;
   if CodPezzo='362C'  then D_362C;
   if CodPezzo='352'  then D_352;
   if (CodPezzo='079C') or (CodPezzo='077C') or (CodPezzo='076C') or
      (CodPezzo='074C') or (CodPezzo='073C') or (CodPezzo='072C') then D_079C;
   if (CodPezzo='069C') or (CodPezzo='067C') or (CodPezzo='066C') or
      (CodPezzo='064C') or (CodPezzo='063C') or (CodPezzo='062C') then D_069C;
   if (CodPezzo='089C') or (CodPezzo='087C') or (CodPezzo='086C') or
      (CodPezzo='084C') or (CodPezzo='083C') or (CodPezzo='082C') then D_089C;
   if (CodPezzo='271C') or (CodPezzo='273C') or (CodPezzo='021C') or
      (CodPezzo='023C') or (CodPezzo='327C') then D_271C;
   if (CodPezzo='281C') or (CodPezzo='283C') or (CodPezzo='031C') or
      (CodPezzo='033C') then D_281C;
   if (CodPezzo='15CB') or (CodPezzo='16CB') or (CodPezzo='16CA') or
      (CodPezzo='15CA') or (CodPezzo='3736C') then D_15CB;

   if CodPezzo='3710'   then D_3710;
   if CodPezzo='3711'   then D_3711;

   if (CodPezzo = '31CC') or (CodPezzo = '3723C') then CodPezzo:='BragaCirc';

   if (CodPezzo = '10CB') or (CodPezzo = '31CD') or (CodPezzo = '31CA') or (CodPezzo = '31CB') then
    begin
       {in questo caso metto il valore degli angoli in gradi dato che nella procedura c'e` la conversione }
       CodPezzo:='BragaCirc';Ang:=90;
    end;
   if (CodPezzo = '372') or (CodPezzo = '375') then
    begin
       CodPezzo:='BragaCirc';Ang:=45;
    end;

   if CodPezzo='BragaCirc'  then D_31CC;


   if (CodPezzo = '10RA') or (CodPezzo = '10RB') or (CodPezzo = '31RD') or
      (CodPezzo = '39RD') then D_10RA('10RA');

   if (CodPezzo='31RA') or (CodPezzo='39RA') or
      (CodPezzo='31RB') or (CodPezzo='39RB') then D_10RA('31RA');

   if (CodPezzo = '12RA') or (CodPezzo = '12RB') or (CodPezzo = '379') or
      (CodPezzo = '14RA') then D_12RA;

   if (CodPezzo = '3723R') or (CodPezzo = '31RC') or (CodPezzo = '39RC') or
      (CodPezzo = '3724') then D_3723R;

    WritePezzoSpecialeCr(Codpezzo,Ang,Curv,Lung,Rap,Rap1,B1,H1,B2,H2,B3,H3,B4,H4,D1,D2,D3,D4);

    AssignAtt;
    FinePezzo3d(orient);

    if Speculare then Specchio;
end;
end.
(*   if (CodPezzo='13RBT') or (CodPezzo='13RAT') or (CodPezzo='15RBT') or
      (CodPezzo='15RAT') or (CodPezzo='14RBT') or (CodPezzo='14RAT') or
      (CodPezzo='16RBT') or (CodPezzo='16RAT') or (CodPezzo='15CAT') or
      (CodPezzo='15CBT') or (CodPezzo='13CAT') or (CodPezzo='13CBT') then D_13RBT;  *)