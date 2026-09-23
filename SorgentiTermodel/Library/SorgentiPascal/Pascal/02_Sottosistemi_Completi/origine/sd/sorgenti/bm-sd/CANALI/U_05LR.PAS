

unit U_05LR;

interface

Procedure D_05LR;
Procedure D_05LC;
Procedure D_04LR;
Procedure D_04LC;
Procedure D_06LC;

implementation


uses definizcan,definiz,U_VARPEZZI;


procedure Serr_30(Lato:real);
var Dx,Larg:real;
 begin
    if Lung > 0 then Larg:=Lung*2
    else Larg:=Lato*Costant^.C47;
       case orient of

        1,3,2,4:begin

                 Dx:=(Larg/4)*sin(pi/4);

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=Lato/2;
                     X2:=Larg/4;           Y2:=Lato/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=-Lato/2;
                     X2:=Larg/4;           Y2:=-Lato/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=Lato/4;
                     R:=Costant^.C12;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=-Lato/4;
                     R:=Costant^.C12;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Dx;              Y1:=Lato/4-Dx;
                     X2:=Dx;               Y2:=Lato/4+Dx;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Dx;               Y1:=-Lato/4-Dx;
                     X2:=-Dx;              Y2:=-Lato/4+Dx;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Larg/4;           Y1:=Lato/2;
                     X2:=Larg/4;           Y2:=-Lato/2;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 Y3A:=0;
                 Y4A:=0;

              end;
       end;
 end;



Procedure D_05LR;
var Angolo:real;
    i,j:integer;
    Sp1,Sp2:real;
    Sp3:real;  { serve se si usa una serranda }
 begin

    if CodPezzo='05SR' then Sp3:=B1/4
    else Sp3:=0;
       case Orient of
     1,3,2,4:begin
                Sp1:=Costant^.C62;
                Sp2:=Costant^.C63;

                if CodPezzo='05SR' then
                 begin
                    Serr_30(B1);
                    i:=8;
                 end
                else i:=1;

                if Sp1 > 0 then
                 begin
                    FrecciaU(Sp3+B1*Sp1,B1/4,B1*Sp2,Ang,i);
                    FrecciaU(Sp3+B1*Sp1,0,B1*Sp2,Ang,i);
                    FrecciaU(Sp3+B1*Sp1,-B1/4,B1*Sp2,Ang,i);
                 end;
                if CodPezzo<>'05SR' then
                 begin
                    Y1A:=B1/2;
                    X1A:=0;
                    Angolo:=Ang/180*pi;
                    ModiCord(X1A,Y1A,0,0,Angolo);
                    Y2A:=-B1/2;
                    X2A:=0;
                    ModiCord(X2A,Y2A,0,0,Angolo);
                    Y3A:=0;
                    Y4A:=0;
                 end;
             end;

         5,6:begin
                Sp1:=Costant^.C35;
                Sp2:=Costant^.C36;
                Angolo:=ArcTan(B1/H1);
                i:=1;

                FrecciaU(((H1/2)/cos(Angolo)+15),0,B1*Sp2,0,i);

                for i:=1 to 3 do
                 begin
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,Angolo);
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,Angolo);
                 end;


                for i:=4 to 6 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-3].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-3].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi-(ANGOLO*2));
                    DisPezzo^[i].X2:=DisPezzo^[i-3].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-3].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi-(ANGOLO*2));
                 end;

                for i:=7 to 9 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-6].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-6].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi);
                    DisPezzo^[i].X2:=DisPezzo^[i-6].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-6].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi);
                 end;

                for i:=10 to 12 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-9].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-9].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,-ANGOLO*2);
                    DisPezzo^[i].X2:=DisPezzo^[i-9].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-9].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,-ANGOLO*2);
                 end;

                if orient = 6 then
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-H1/2;            Y1:=B1/2;
                        X2:=H1/2;             Y2:=B1/2;
                     end;
                    with DisPezzo^[14] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=H1/2;             Y1:=B1/2;
                        X2:=H1/2;             Y2:=-B1/2;
                     end;
                    with DisPezzo^[15] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=H1/2;             Y1:=-B1/2;
                        X2:=-H1/2;            Y2:=-B1/2;
                     end;
                    with DisPezzo^[16] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-H1/2;            Y1:=-B1/2;
                        X2:=-H1/2;            Y2:=B1/2;
                     end;

                    i:=17;
                    j:=1;
                    BoccRet(B1,H1,i,j);

                 end
                else
                 begin
                    i:=13;
                    j:=2;
                    BoccRet(B1,H1,i,j);
                 end;


                Y1A:=B1/2;
                X1A:=0;
                ModiCord(X1A,Y1A,0,0,Ang);
                Y2A:=-B1/2;
                X2A:=0;
                ModiCord(X2A,Y2A,0,0,Ang);
                Y3A:=0;
                Y4A:=0;
             end;
       end;
 end;
Procedure D_05LC;
var Angolo:real;
    i,j:integer;
    Sp1,Sp2:real;
 begin
       case Orient of
       1,3,2,4:begin
                 Sp1:=Costant^.C62;
                 Sp2:=Costant^.C63;
                 if Sp1 > 0 then
                  begin
                     i:=1;
                     FrecciaU(D1*Sp1,D1/4,D1*Sp2,Ang,i);
                     FrecciaU(D1*Sp1,0,D1*Sp2,Ang,i);
                     FrecciaU(D1*Sp1,-D1/4,D1*Sp2,Ang,i);
                  end;
                 Y1A:=D1/2;
                 X1A:=0;
                 Angolo:=Ang/180*pi;
                 ModiCord(X1A,Y1A,0,0,Angolo);
                 Y2A:=-D1/2;
                 X2A:=0;
                 ModiCord(X2A,Y2A,0,0,Angolo);
                 Y3A:=0;
                 Y4A:=0;
              end;
         5,6:begin
                Sp1:=Costant^.C35;
                Sp2:=Costant^.C36;

                i:=1;

                FrecciaU((D1/2+D1*Sp1),0,D1*Sp2,0,i);

                for i:=1 to 3 do
                 begin
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi/4);
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi/4);
                 end;

                for i:=4 to 6 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-3].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-3].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi/2);
                    DisPezzo^[i].X2:=DisPezzo^[i-3].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-3].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi/2);
                 end;

                for i:=7 to 9 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-6].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-6].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi);
                    DisPezzo^[i].X2:=DisPezzo^[i-6].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-6].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi);
                 end;

                for i:=10 to 12 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-9].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-9].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,-pi/2);
                    DisPezzo^[i].X2:=DisPezzo^[i-9].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-9].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,-pi/2);
                 end;

                if Orient = 6 then
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='C';          TLinea:=1;
                        X1:=0;                Y1:=0;
                        R:=D1/2;
                     end;

                    with DisPezzo^[14] do
                     begin
                        Entita:='C';          TLinea:=1;
                        X1:=0;                Y1:=0;
                        R:=D1/2*1.2*Costant^.C60;
                     end;
                    i:=15;
                    j:=1;
                    BoccCirc(D1,i,j);
                 end
                else
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='C';          TLinea:=1;
                        X1:=0;                Y1:=0;
                        R:=D1/2*1.2*Costant^.C60;
                     end;
                    i:=14;
                    j:=2;
                    BoccCirc(D1,i,j);
                 end;


                Y1A:=D1/2;
                X1A:=0;
                ModiCord(X1A,Y1A,0,0,Ang);
                Y2A:=-D1/2;
                X2A:=0;
                ModiCord(X2A,Y2A,0,0,Ang);
                Y3A:=0;
                Y4A:=0;
             end;
       end;
 end;

Procedure D_04LR;
var Angolo:real;
    i,j:integer;
    Sp1,Sp2:real;
    Sp3:real;  { serve se si usa una serranda }
 begin

    if CodPezzo='04SR' then Sp3:=B1/4
    else Sp3:=0;
       case Orient of
     1,3,2,4:begin
                Sp1:=Costant^.C62;
                Sp2:=Costant^.C63;
                if CodPezzo='04SR' then
                 begin
                    Serr_30(B1);
                    i:=8;
                 end
                else i:=1;
                if Sp1 > 0 then
                 begin
                    FrecciaE(Sp3+B1*Sp1,B1/4,B1*Sp2,Ang,i);
                    FrecciaE(Sp3+B1*Sp1,0,B1*Sp2,Ang,i);
                    FrecciaE(Sp3+B1*Sp1,-B1/4,B1*Sp2,Ang,i);
                 end;
                if CodPezzo<>'04SR' then
                 begin
                    Y1A:=B1/2;
                    X1A:=0;
                    Angolo:=Ang/180*pi;
                    ModiCord(X1A,Y1A,0,0,Angolo);
                    Y2A:=-B1/2;
                    X2A:=0;
                    ModiCord(X2A,Y2A,0,0,Angolo);
                    Y3A:=0;
                    Y4A:=0;
                 end;
             end;

         5,6:begin
                Sp1:=Costant^.C35;
                Sp2:=Costant^.C36;
                Angolo:=ArcTan(B1/H1);
                i:=1;

                FrecciaE(((H1/2)/cos(Angolo)+15),0,B1*Sp2,0,i);

{Angolo:=ArcTan(H1/B1);}

                for i:=1 to 3 do
                 begin
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,Angolo);
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,Angolo);
                 end;


                for i:=4 to 6 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-3].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-3].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi-(ANGOLO*2));
                    DisPezzo^[i].X2:=DisPezzo^[i-3].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-3].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi-(ANGOLO*2));
                 end;

                for i:=7 to 9 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-6].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-6].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi);
                    DisPezzo^[i].X2:=DisPezzo^[i-6].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-6].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi);
                 end;

                for i:=10 to 12 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-9].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-9].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,-ANGOLO*2);
                    DisPezzo^[i].X2:=DisPezzo^[i-9].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-9].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,-ANGOLO*2);
                 end;

                if orient = 6 then
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-H1/2;            Y1:=B1/2;
                        X2:=H1/2;             Y2:=B1/2;
                     end;
                    with DisPezzo^[14] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=H1/2;             Y1:=B1/2;
                        X2:=H1/2;             Y2:=-B1/2;
                     end;
                    with DisPezzo^[15] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=H1/2;             Y1:=-B1/2;
                        X2:=-H1/2;            Y2:=-B1/2;
                     end;
                    with DisPezzo^[16] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-H1/2;            Y1:=-B1/2;
                        X2:=-H1/2;            Y2:=B1/2;
                     end;

                    i:=17;
                    j:=1;
                    BoccRet(B1,H1,i,j);

                 end
                else
                 begin
                    i:=13;
                    j:=2;
                    BoccRet(B1,H1,i,j);
                 end;




                Y1A:=B1/2;
                X1A:=0;
                ModiCord(X1A,Y1A,0,0,Ang);
                Y2A:=-B1/2;
                X2A:=0;
                ModiCord(X2A,Y2A,0,0,Ang);
                Y3A:=0;
                Y4A:=0;
             end;
       end;
 end;
Procedure D_04LC;
var Angolo:real;
    i,j:integer;
    Sp1,Sp2:real;
    Sp3:real;  { serve se si usa una serranda }
 begin
    if CodPezzo='04SC' then Sp3:=D1/4
    else Sp3:=0;
       case Orient of
     1,3,2,4:begin
                Sp1:=Costant^.C62;
                Sp2:=Costant^.C63;
                if CodPezzo='04SC' then
                 begin
                    Serr_30(D1);
                    i:=8;
                 end
                else i:=1;
                if Sp1 > 0 then
                 begin
                    FrecciaE(Sp3+D1*Sp1,D1/4,D1*Sp2,Ang,i);
                    FrecciaE(Sp3+D1*Sp1,0,D1*Sp2,Ang,i);
                    FrecciaE(Sp3+D1*Sp1,-D1/4,D1*Sp2,Ang,i);
                 end;
                if CodPezzo <> '04SC' then
                 begin
                    Y1A:=D1/2;
                    X1A:=0;
                    Angolo:=Ang/180*pi;
                    ModiCord(X1A,Y1A,0,0,Angolo);
                    Y2A:=-D1/2;
                    X2A:=0;
                    ModiCord(X2A,Y2A,0,0,Angolo);
                    Y3A:=0;
                    Y4A:=0;
                 end;
              end;
         5,6:begin
                Sp1:=Costant^.C35;
                Sp2:=Costant^.C36;

                i:=1;

                FrecciaE((D1/2+D1*Sp1),0,D1*Sp2,0,i);

                for i:=1 to 3 do
                 begin
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi/4);
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi/4);
                 end;

                for i:=4 to 6 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-3].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-3].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi/2);
                    DisPezzo^[i].X2:=DisPezzo^[i-3].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-3].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi/2);
                 end;

                for i:=7 to 9 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-6].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-6].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi);
                    DisPezzo^[i].X2:=DisPezzo^[i-6].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-6].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi);
                 end;

                for i:=10 to 12 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-9].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-9].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,-pi/2);
                    DisPezzo^[i].X2:=DisPezzo^[i-9].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-9].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,-pi/2);
                 end;

                if Orient = 6 then
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='C';          TLinea:=1;
                        X1:=0;                Y1:=0;
                        R:=D1/2;
                     end;

                    with DisPezzo^[14] do
                     begin
                        Entita:='C';          TLinea:=1;
                        X1:=0;                Y1:=0;
                        R:=D1/2*1.2*Costant^.C60;
                     end;
                    i:=15;
                    j:=1;
                    BoccCirc(D1,i,j);
                 end
                else
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='C';          TLinea:=1;
                        X1:=0;                Y1:=0;
                        R:=D1/2*1.2*Costant^.C60;
                     end;
                    i:=14;
                    j:=2;
                    BoccCirc(D1,i,j);
                 end;

                Y1A:=D1/2;
                X1A:=0;
                ModiCord(X1A,Y1A,0,0,Ang);
                Y2A:=-D1/2;
                X2A:=0;
                ModiCord(X2A,Y2A,0,0,Ang);
                Y3A:=0;
                Y4A:=0;
             end;
       end;
 end;

Procedure D_06LC;
 VAR
    A,B,C,DxA:real;
    TL,ii:integer;

procedure Riduz(X:real);

begin
   Ang:=pi/12;
   Lung:=abs(((B-D1)/2)/tan(Ang/2));

   case orient of
      1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung-A/2;        Y1:=D1/2;
                     X2:=-A/2;             Y2:=X/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung-A/2;        Y1:=-D1/2;
                     X2:=-A/2;             Y2:=-X/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung-A/2;        Y1:=0;
                     X2:=-A/2;             Y2:=X/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung-A/2;        Y1:=0;
                     X2:=-A/2;             Y2:=-X/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';                 TLinea:=1;
                     X1:=-Lung-A/2-Costant^.C69;   Y1:=-D1/2;
                     X2:=-Lung-A/2;               Y2:=-D1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';                 TLinea:=1;
                     X1:=-Lung-A/2-Costant^.C69;   Y1:=D1/2;
                     X2:=-Lung-A/2;               Y2:=D1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';                 TLinea:=1;
                     X1:=-Lung-A/2-Costant^.C69;   Y1:=D1/2;
                     X2:=X1;                      Y2:=-D1/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';                 TLinea:=1;
                     X1:=-Lung-A/2;               Y1:=D1/2;
                     X2:=X1;                      Y2:=-D1/2;
                  end;

                 X1A:=-Lung-A/2-Costant^.C69;
                 Y1A:=D1/2;
                 X2A:=-Lung-A/2-Costant^.C69;
                 Y2A:=-D1/2;
                 ii:=8;
              end;
   end;
end;

 begin
      D2:=Costant^.C67*D1;
      A:=1.8*D2;
      B:=1.4*D1;
      C:=1.2*D1;
      DxA:=A*Costant^.C68;

       case orient of

        1,3:begin
               if CodPezzo='05SC' then Riduz(B)
               else
               begin
                 X1A:=-A/2;
                 Y1A:=D1/2;
                 X2A:=-A/2;
                 Y2A:=-D1/2;
                 ii:=0;
               end;

               with DisPezzo^[ii+1] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-A/2;             Y1:=A/2;
                   X2:=A/2;              Y2:=A/2;
                end;
               with DisPezzo^[ii+2] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-A/2;             Y1:=-A/2;
                   X2:=A/2;              Y2:=-A/2;
                end;
               with DisPezzo^[ii+3] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-A/2;             Y1:=A/2;
                   X2:=-A/2;             Y2:=-A/2;
                end;
               with DisPezzo^[ii+4] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=A/2;             Y1:=A/2;
                   X2:=A/2;             Y2:=-A/2;
                end;
               with DisPezzo^[ii+5] do
                begin
                   Entita:='C';          TLinea:=1;
                   X1:=0;                Y1:=0;
                   R:=D2/2;
                end;

               if Orient = 1 then TL:=2
                else TL:=1;

               with DisPezzo^[ii+6] do
                begin
                   Entita:='L';          TLinea:=TL;
                   X1:=D2/2*cos(pi/4);   Y1:=D2/2*sin(pi/4);
                   X2:=-D2/2*cos(pi/4);  Y2:=-D2/2*sin(pi/4);
                end;
               with DisPezzo^[ii+7] do
                begin
                   Entita:='L';          TLinea:=TL;
                   X1:=-D2/2*cos(pi/4);  Y1:=D2/2*sin(pi/4);
                   X2:=D2/2*cos(pi/4);   Y2:=-D2/2*sin(pi/4);
                end;
               if A<>DxA then
                begin
                   With DisPezzo^[ii+8] do
                    begin
                       Entita:='L';          TLinea:=1;
                       X1:=-DxA/2;           Y1:=DxA/2;
                       X2:=DxA/2;            Y2:=DxA/2;
                    end;
                  with DisPezzo^[ii+9] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=-DxA/2;           Y1:=-DxA/2;
                      X2:=DxA/2;            Y2:=-DxA/2;
                   end;
                  with DisPezzo^[ii+10] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=-DxA/2;           Y1:=DxA/2;
                      X2:=-DxA/2;           Y2:=-DxA/2;
                   end;
                  with DisPezzo^[ii+11] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=DxA/2;            Y1:=DxA/2;
                      X2:=DxA/2;            Y2:=-DxA/2;
                   end;
                end;


               X3A:=0;
               Y3A:=0;
               X4A:=0;
               Y4A:=0;

            end;

        2,4:begin

               if CodPezzo='05SC' then Riduz(D1)
               else
               begin
                 X1A:=-A/2;
                 Y1A:=D1/2;
                 X2A:=-A/2;
                 Y2A:=-D1/2;
                 ii:=0;
               end;

               with DisPezzo^[ii+1] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-A/2;             Y1:=C/2;
                   X2:=A/2;              Y2:=C/2;
                end;
               with DisPezzo^[ii+2] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-A/2;             Y1:=-C/2;
                   X2:=A/2;              Y2:=-C/2;
                end;
               with DisPezzo^[ii+3] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-A/2;             Y1:=C/2;
                   X2:=-A/2;             Y2:=-C/2;
                end;
               with DisPezzo^[ii+4] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=A/2;             Y1:=C/2;
                   X2:=A/2;             Y2:=-C/2;
                end;
               with DisPezzo^[ii+5]do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-D2/2;            Y1:=-C/2;
                   X2:=-D2/2;            Y2:=-C/2-Costant^.C70*D2;
                end;
               with DisPezzo^[ii+6] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=D2/2;             Y1:=-C/2;
                   X2:=D2/2;             Y2:=-C/2-Costant^.C70*D2;
                end;
               with DisPezzo^[ii+7] do
                begin
                   Entita:='L';          TLinea:=1;
                   X1:=-D2/2;            Y1:=-C/2-Costant^.C70*D2;
                   X2:=D2/2;             Y2:=-C/2-Costant^.C70*D2;
                end;


               X3A:=0;
               Y3A:=0;
               X4A:=0;
               Y4A:=0;

            end;

       end;
 end;




end.
