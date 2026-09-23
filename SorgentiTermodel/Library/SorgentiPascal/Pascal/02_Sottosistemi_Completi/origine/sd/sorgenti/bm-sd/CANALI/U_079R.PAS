
unit U_079R;

interface

Procedure D_079R(Codice:string);
Procedure D_069R(Codice:string);
Procedure D_079C;
Procedure D_069C;
Procedure D_089C;
procedure D_3410;


implementation

uses crt,dos,definiz,definizcan,U_VARPEZZI,interf3d;


procedure Ang45(H,B:real);
 begin
    with DisPezzo^[1] do
     begin
        Entita:='L';         TLinea:=1;
        X1:=-((Curv*H)*tan(Ang/2));  Y1:=B/2;
        X2:=(((Curv*H)+(H/2))*cos((pi/2)-Ang))-abs(X1);
        Y2:=B/2;
     end;
    with DisPezzo^[2] do
     begin
        Entita:='L';         TLinea:=1;
        X1:=-((Curv*H)*tan(Ang/2));  Y1:=-B/2;
        X2:=(((Curv*H)+(H/2))*cos((pi/2)-Ang))-abs(X1);
        Y2:=-B/2;
     end;

    X1A:=DisPezzo^[1].X1;
    Y1A:=B/2;
    X2A:=DisPezzo^[1].X1;
    Y2A:=-B/2;
    X3A:=DisPezzo^[1].X2;
    Y3A:=B/2;
    X4A:=DisPezzo^[1].X2;
    Y4A:=-B/2;
    Case Orient of
      2:Z2:=((Curv*H)*sin((pi/2)-Ang))-abs(Curv*H);
      4:Z2:=-((Curv*H)*sin((pi/2)-Ang))+abs(Curv*H);
      5:begin
           Z1:=(Curv*H)*(tan(Ang/2));
           Z2:=-((Curv*H)*sin((pi/2)-Ang))+abs(Curv*H);
        end;
      6:begin
           Z1:=-(Curv*H)*(tan(Ang/2));
           Z2:=((Curv*H)*sin((pi/2)-Ang))-abs(Curv*H);
        end;
    end;
 end;

procedure Ang45A(H,B:real);
 begin
    with DisPezzo^[1] do
     begin
        Entita:='L';         TLinea:=1;
        X1:=-H*Costant^.C45;  Y1:=B/2;
        X2:=(H/2)*tan(Ang/2)+abs(H*Costant^.C45+(H/2)*tan(Ang/2))*cos(Ang);
        Y2:=B/2;
     end;
    with DisPezzo^[2] do
     begin
        Entita:='L';         TLinea:=1;
        X1:=DisPezzo^[1].X1;  Y1:=-B/2;
        X2:=DisPezzo^[1].X2;  Y2:=-B/2;
     end;

    X1A:=DisPezzo^[1].X1;
    Y1A:=B/2;
    X2A:=DisPezzo^[1].X1;
    Y2A:=-B/2;
    X3A:=DisPezzo^[1].X2;
    Y3A:=B/2;
    X4A:=DisPezzo^[1].X2;
    Y4A:=-B/2;
    Case Orient of
      2:Z2:=(H1/2-abs(H1*Costant^.C45+(H1/2)*tan(Ang/2))*sin(Ang))-H1/2*cos(Ang);
      4:Z2:=-(H1/2-abs(H1*Costant^.C45+(H1/2)*tan(Ang/2))*sin(Ang))+H1/2*cos(Ang);
      5:begin
           Z1:=H1*Costant^.C45;
           Z2:=-ABS((H1/2)*tan(Ang/2)+abs(H1*Costant^.C45+(H1/2)*tan(Ang/2))*cos(Ang)-H1/2*sin(Ang));
        end;
      6:begin
           Z1:=-H1*Costant^.C45;
           Z2:=ABS((H1/2)*tan(Ang/2)+abs(H1*Costant^.C45+(H1/2)*tan(Ang/2))*cos(Ang)-H1/2*sin(Ang));
        end;
    end;
 end;


procedure D_079R(Codice:string);
 begin

       if Curv=0 then Curv:=1;
       Ang:=Ang/180*pi;

       curva3d1(ang,orient,1,(curv*b1-b1/2),b1,b1,h1,0,0,0);

       if (abs(Ang-pi/2)>0.1) then
       if (Orient in[2,4..6]) then
        begin
           Ang45(H1,B1);
           exit;
        end;




       case orient of
            1:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=-Curv*B1;        X1:=((-Curv*B1)*tan(Ang/2));
                     X2:=(pi/2)-Ang;      Y2:=pi/2;
                     R:=ABS((-CURV*B1)+(B1/2));
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=-Curv*B1;        X1:=(-Curv*B1)*tan(Ang/2);
                     X2:=(pi/2)-Ang;      Y2:=pi/2;
                     R:=ABS((-Curv*B1)-(B1/2));
                  end;


                 if (Codice='347A') or (Codice='347C') then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='A';         TLinea:=2;
                         Y1:=-Curv*B1;        X1:=(-Curv*B1)*tan(Ang/2);
                         X2:=(pi/2)-Ang;      Y2:=pi/2;
                         R:=Curv*B1;
                      end;
                     if Codice='347C' then
                      begin
                         with DisPezzo^[4] do
                          begin
                             Entita:='A';         TLinea:=2;
                             Y1:=-Curv*B1;        X1:=(-Curv*B1)*tan(Ang/2);
                             X2:=(pi/2)-Ang;      Y2:=pi/2;
                             R:=Curv*B1+B1/4;
                          end;
                         with DisPezzo^[5] do
                          begin
                             Entita:='A';         TLinea:=2;
                             Y1:=-Curv*B1;        X1:=(-Curv*B1)*tan(Ang/2);
                             X2:=(pi/2)-Ang;      Y2:=pi/2;
                             R:=Curv*B1-B1/4;
                          end;
                      end;
                  end;

                 if Codice='347B' then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='A';         TLinea:=2;
                         Y1:=-Curv*B1;        X1:=(-Curv*B1)*tan(Ang/2);
                         X2:=(pi/2)-Ang;      Y2:=pi/2;
                         R:=Curv*B1+(B1/2)/3;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='A';         TLinea:=2;
                         Y1:=-Curv*B1;        X1:=(-Curv*B1)*tan(Ang/2);
                         X2:=(pi/2)-Ang;      Y2:=pi/2;
                         R:=Curv*B1-(B1/2)/3;
                      end;
                  end;

                  X1A:=(-Curv*B1)*(tan(Ang/2));
                  Y1A:=B1/2;
                  X2A:=X1A;
                  Y2A:=-B1/2;
                  X3A:=(((Curv*B1)+(B1/2))*cos((pi/2)-Ang))-abs(X1A);
                  Y3A:=(((Curv*B1)+(B1/2))*sin((pi/2)-Ang))-abs(Curv*B1);
                  X4A:=(((Curv*B1)-(B1/2))*cos((pi/2)-Ang))-abs(X1A);
                  Y4A:=(((Curv*B1)-(B1/2))*sin((pi/2)-Ang))-abs(Curv*B1);
              end;
            3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=Curv*B1;         X1:=((-Curv*B1)*tan(Ang/2));
                     X2:=-pi/2;            Y2:=Ang-(pi/2);
                     R:=ABS((-CURV*B1)+(B1/2));
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=Curv*B1;         X1:=(-Curv*B1)*tan(Ang/2);
                     X2:=-pi/2;           Y2:=Ang-(pi/2);
                     R:=ABS((-Curv*B1)-(B1/2));
                  end;
                 if (Codice='347A') or (Codice='347C') then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='A';         TLinea:=2;
                         Y1:=Curv*B1;         X1:=((-Curv*B1)*tan(Ang/2));
                         X2:=-pi/2;           Y2:=Ang-(pi/2);
                         R:=Curv*B1;
                      end;
                     if Codice='347C' then
                      begin
                         with DisPezzo^[4] do
                          begin
                             Entita:='A';         TLinea:=2;
                             Y1:=Curv*B1;         X1:=((-Curv*B1)*tan(Ang/2));
                             X2:=-pi/2;           Y2:=Ang-(pi/2);
                             R:=Curv*B1+B1/4;
                          end;
                         with DisPezzo^[5] do
                          begin
                             Entita:='A';         TLinea:=2;
                             Y1:=Curv*B1;         X1:=((-Curv*B1)*tan(Ang/2));
                             X2:=-pi/2;           Y2:=Ang-(pi/2);
                             R:=Curv*B1-B1/4;
                          end;
                      end;
                  end;
                if Codice='347B' then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='A';         TLinea:=2;
                         Y1:=Curv*B1;         X1:=((-Curv*B1)*tan(Ang/2));
                         X2:=-pi/2;           Y2:=Ang-(pi/2);
                         R:=Curv*B1+(B1/2)/3;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='A';         TLinea:=2;
                         Y1:=Curv*B1;         X1:=((-Curv*B1)*tan(Ang/2));
                         X2:=-pi/2;           Y2:=Ang-(pi/2);
                         R:=Curv*B1-(B1/2)/3;
                      end;
                  end;


                  X1A:=(-Curv*B1)*(tan(Ang/2));
                  Y1A:=B1/2;
                  X2A:=X1A;
                  Y2A:=-B1/2;
                  X4A:=(((Curv*B1)+(B1/2))*cos((pi/2)-Ang))-abs(X1A);
                  Y4A:=-(((Curv*B1)+(B1/2))*sin((pi/2)-Ang))+abs(Curv*B1);
                  X3A:=(((Curv*B1)-(B1/2))*cos((pi/2)-Ang))-abs(X1A);
                  Y3A:=-(((Curv*B1)-(B1/2))*sin((pi/2)-Ang))+abs(Curv*B1);
              end;
            2:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*H1)*tan(Ang/2));  Y1:=B1/2;
                     X2:=(((Curv*H1)+(H1/2))*cos((pi/2)-Ang))-abs(X1);
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*H1)*tan(Ang/2));  Y1:=-B1/2;
                     X2:=(((Curv*H1)-(H1/2))*cos((pi/2)-Ang))-abs(((Curv*H1)*tan(Ang/2)));
                     X2:=(((Curv*H1)+(H1/2))*cos((pi/2)-Ang))-abs(X1);
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';
                     if orient=2 then TLinea:=2
                      else TLinea:=1;
                     X1:=(((Curv*H1)-(H1/2))*cos((pi/2)-Ang))-abs(((Curv*H1)*tan(Ang/2)));
                     Y1:=B1/2;
                     X2:=(((Curv*H1)-(H1/2))*cos((pi/2)-Ang))-abs(((Curv*H1)*tan(Ang/2)));
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=DisPezzo^[1].X2;     Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;     Y2:=-B1/2;
                  end;

(*                 if Ang=pi/2 then
                  begin
		     i:=5;        j:=2;
                     Spicchio(B1,H1,i,j);
                  end;*)

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2-H1/2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2-H1/2;
                 Y4A:=-B1/2;
                 Z2:=((Curv*H1)*sin((pi/2)-Ang))-abs(Curv*H1);
              end;

            4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*H1)*tan(Ang/2));  Y1:=B1/2;
                     X2:=(((Curv*H1)-(H1/2))*cos((pi/2)-Ang))-abs(((Curv*H1)*tan(Ang/2)));
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*H1)*tan(Ang/2));  Y1:=-B1/2;
                     X2:=(((Curv*H1)-(H1/2))*cos((pi/2)-Ang))-abs(((Curv*H1)*tan(Ang/2)));
                     Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
                 Z2:=-((Curv*H1)*sin((pi/2)-Ang))+abs(Curv*H1);
              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=H1/2;            Y1:=B1/2;
                     X2:=X1+(Curv*H1-H1/2)-(Curv*H1-H1/2)*sin(pi/2-Ang);
                     Y2:=B1/2;
                  end;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-B1/2;
                  end;


                 i:=3;        j:=2;
                 BoccRet(B1,H1,i,j);

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-B1/2;
                 Z1:=(Curv*H1)*(tan(Ang/2));
              end;

            6:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';           TLinea:=2;
                     X1:=H1/2;              Y1:=B1/2;
                     X2:=X1;                Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-H1/2;           Y1:=B1/2;
                     X2:=H1/2+(Curv*H1-H1/2)-(Curv*H1-H1/2)*sin(pi/2-Ang);
                     Y2:=B1/2;
                  end;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[2].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[2].X2;  Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[2].X1;  Y1:=B1/2;
                     X2:=X1;              Y2:=-B1/2;
                  end;

                 i:=5;        j:=2;
                 BoccRet(B1,H1,i,j);

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-B1/2;
                 Z1:=-(Curv*H1)*(tan(Ang/2));
              end;
       end;
 end;

procedure D_069R(Codice:string);
var Int:integer;
 begin
       Ang:=Ang/180*pi;
       if (Ang<>pi/2) AND (Orient in[2,4..6]) then
        begin
           Ang45A(H1,B1);
           exit;
        end;

       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-B1*Costant^.C45;    Y1:=B1/2;
                     if Ang=pi/2 then X2:=B1/2
                     else X2:=(B1/2)*tan(Ang/2);
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=B1/2;
                     X2:=X1+abs(B1*Costant^.C45+X1)*cos(Ang);
                     Y2:=B1/2-abs(B1*Costant^.C45+X1)*sin(Ang);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X2-B1*sin(Ang);
                     Y1:=DisPezzo^[2].Y2-B1*cos(Ang);
                     X2:=-DisPezzo^[1].X2;
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X2;   Y1:=-B1/2;
                     X2:=-B1*Costant^.C45;          Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X2;   Y1:=DisPezzo^[3].Y2;
                     X2:=DisPezzo^[1].X2;   Y2:=DisPezzo^[1].Y2;
                  end;

                 if (Codice='348') or (Codice='349') then
                  begin
                     with DisPezzo^[6] do
                      begin
                         Entita:='A';          TLinea:=2;
                         X1:=DisPezzo^[3].X2;   Y1:=DisPezzo^[3].Y2;
                         if Orient = 1 then
                          begin
                             X2:=(pi/2)-Ang;       Y2:=pi/2;
                          end
                         else
                          begin
                             X2:=-pi/2;            Y2:=Ang-(pi/2);
                          end;
                         R:=B1/5*Costant^.C34;
                      end;
                     with DisPezzo^[7] do
                      begin
                         Entita:='A';          TLinea:=1;
                         Inters(X1,Y1,Int,DisPezzo^[5].X1,DisPezzo^[5].X2,-B1,B1,
                                DisPezzo^[5].Y1,DisPezzo^[5].Y2,-B1/2+B1/5,-B1/2+B1/5);
                         if Int<>1 then write(Chr(7));
                         if Orient = 1 then
                          begin
                             X2:=(pi/2)-Ang;       Y2:=pi/2;
                          end
                         else
                          begin
                             X2:=-pi/2;            Y2:=Ang-(pi/2);
                          end;
                         R:=B1/5*Costant^.C34;
                      end;
                     with DisPezzo^[8] do
                      begin
                         Entita:='A';          TLinea:=1;
                         Inters(X1,Y1,Int,DisPezzo^[5].X1,DisPezzo^[5].X2,-B1,B1,
                                DisPezzo^[5].Y1,DisPezzo^[5].Y2,-B1/2+B1*(2/5),-B1/2+B1*(2/5));
                         if Int<>1 then write(Chr(7));
                         if Orient = 1 then
                          begin
                             X2:=(pi/2)-Ang;       Y2:=pi/2;
                          end
                         else
                          begin
                             X2:=-pi/2;            Y2:=Ang-(pi/2);
                          end;
                         R:=B1/5*Costant^.C34;
                      end;
                     with DisPezzo^[9] do
                      begin
                         Entita:='A';          TLinea:=1;
                         Inters(X1,Y1,Int,DisPezzo^[5].X1,DisPezzo^[5].X2,-B1,B1,
                                DisPezzo^[5].Y1,DisPezzo^[5].Y2,-B1/2+B1*(3/5),-B1/2+B1*(3/5));
                         if Int<>1 then write(Chr(7));
                         if Orient = 1 then
                          begin
                             X2:=(pi/2)-Ang;       Y2:=pi/2;
                          end
                         else
                          begin
                             X2:=-pi/2;            Y2:=Ang-(pi/2);
                          end;
                         R:=B1/5*Costant^.C34;
                      end;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[4].X2;
                 Y2A:=DisPezzo^[4].Y2;

                 if Orient=1 then
                  begin
                     X3A:=DisPezzo^[2].X2;
                     Y3A:=DisPezzo^[2].Y2;
                     X4A:=DisPezzo^[3].X1;
                     Y4A:=DisPezzo^[3].Y1;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[3].X1;
                     Y3A:=-DisPezzo^[3].Y1;
                     X4A:=DisPezzo^[2].X2;
                     Y4A:=-DisPezzo^[2].Y2;
                  end;

              end;
            2:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-H1*Costant^.C45;    Y1:=B1/2;
                     if Ang=pi/2 then R:=H1/2
                     else R:=(H1/2)*tan(Ang/2);
                     X2:=R+abs(H1*Costant^.C45+R)*cos(Ang);
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y1:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';         TLinea:=2;
                     X1:=-DisPezzo^[1].R;  Y1:=B1/2;
                     X2:=-DisPezzo^[1].R;  Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=DisPezzo^[1].X2;     Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;     Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2-H1/2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2-H1/2;
                 Y4A:=-B1/2;
                 Z2:=(H1/2-abs(H1*Costant^.C45+(H1/2))*sin(Ang))-H1/2*cos(Ang);
              end;
            4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-H1*Costant^.C45;    Y1:=B1/2;
                     if Ang=pi/2 then X2:=-H1/2
                     else X2:=-(H1/2)*tan(Ang/2);
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
                 Z2:=-(H1/2-abs(H1*Costant^.C45+(H1/2))*sin(Ang))+H1/2*cos(Ang);
              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     if Ang=pi/2 then X1:=H1/2
                     else X1:=(H1/2)*tan(Ang/2);
                     X1:=-X1+abs(H1*Costant^.C45+X1)*SIN(Ang);
                     X2:=H1/2;
                     Y1:=B1/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-B1/2;
                  end;


                 i:=3;        j:=2;
                 BoccRet(B1,H1,i,j);

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=-B1/2;
                 Z1:=H1*Costant^.C45;
              end;

            6:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';           TLinea:=2;
                     X1:=H1/2;              Y1:=B1/2;
                     X2:=X1;                Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-H1/2;
                     Y1:=B1/2;
                     if Ang=pi/2 then R:=H1/2
                     else R:=(H1/2)*tan(Ang/2);
                     X2:=-R+abs(H1*Costant^.C45+R)*SIN(Ang);
                     Y2:=B1/2;
                  end;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[2].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[2].X2;
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[2].X1;  Y1:=B1/2;
                     X2:=X1;              Y2:=-B1/2;
                  end;

                 i:=5;        j:=2;
                 BoccRet(B1,H1,i,j);

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-B1/2;
                 Z1:=-H1*Costant^.C45;
              end;

       end;
 end;

procedure D_3410;
 begin
       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-(B2/2+((B1/2)*Costant^.C41));
                     Y1:=B1/2;
                     X2:=B2/2;               Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=B2/2;               Y1:=B1/2;
                     X2:=B2/2;               Y2:=-(B1/2+((B1/2)*Costant^.C41));
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-B2/2;              Y1:=-(B1/2+((B1/2)*Costant^.C41));
                     X2:=-B2/2;              Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-B2/2;              Y1:=-B1/2;
                     X2:=DisPezzo^[1].X1;     Y2:=-B1/2;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=DisPezzo^[4].Y2;

                 if Orient=1 then
                  begin
                     X3A:=DisPezzo^[2].X2;
                     Y3A:=DisPezzo^[2].Y2;
                     X4A:=DisPezzo^[3].X1;
                     Y4A:=DisPezzo^[3].Y1;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[3].X1;
                     Y3A:=-DisPezzo^[3].Y1;
                     X4A:=DisPezzo^[2].X2;
                     Y4A:=-DisPezzo^[2].Y2;
                  end;

              end;

            2:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-(H2/2+((H1/2)*Costant^.C41));
                     Y1:=B1/2;
                     X2:=H2/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';         TLinea:=2;
                     X1:=-H2/2;           Y1:=B1/2;
                     X2:=-H2/2;           Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=H2/2;               Y1:=B1/2;
                     X2:=H2/2;               Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
              end;
            4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-(H2/2+((H1/2)*Costant^.C41));
                     Y1:=B1/2;
                     X2:=-H2/2;           Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=H2/2+(H1/2)*Costant^.C41;
                     X2:=H1/2;
                     Y1:=B1/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-B1/2;
                  end;


                 i:=3;        j:=2;
                 BoccRet(B1,H1,i,j);

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=-B1/2;

                 Z1:=(H2/2+((H1/2)*Costant^.C41));

              end;

            6:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';           TLinea:=2;
                     X1:=H1/2;              Y1:=B1/2;
                     X2:=X1;                Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-H1/2;
                     Y1:=B1/2;
                     X2:=H1/2+((H1/2)*Costant^.C41);
                     Y2:=B1/2;
                  end;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[2].X1;  Y1:=-B1/2;
                     X2:=DisPezzo^[2].X2;
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[2].X1;  Y1:=B1/2;
                     X2:=X1;              Y2:=-B1/2;
                  end;

                 i:=5;        j:=2;
                 BoccRet(B1,H1,i,j);

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-B1/2;

                 Z1:=-(H2/2+((H1/2)*Costant^.C41));
              end;

       end;
 end;


procedure D_079C;
 begin
       if Curv=0 then Curv:=1;
       Ang:=Ang/180*pi;

       curva3d1(ang,orient,1,(curv*d1-d1/2),d1,d1,0,0,0,0);
       
       if (Ang<>pi/2) AND (Orient in[2,4..6]) then
        begin
           Ang45(D1,D1);
           exit;
        end;

        case orient of
            1:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=-Curv*D1;        X1:=((-Curv*D1)*tan(Ang/2));
                     X2:=(pi/2)-Ang;      Y2:=pi/2;
                     R:=ABS(-CURV*D1+D1/2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=-Curv*D1;        X1:=-Curv*D1*tan(Ang/2);
                     X2:=(pi/2)-Ang;      Y2:=pi/2;
                     R:=ABS(-Curv*D1-D1/2);
                  end;
                  X1A:=(-Curv*D1)*(tan(Ang/2));
                  Y1A:=D1/2;
                  X2A:=X1A;
                  Y2A:=-D1/2;
                  X3A:=(((Curv*D1)+D1/2)*cos((pi/2)-Ang))-abs(X1A);
                  Y3A:=(((Curv*D1)+D1/2)*sin((pi/2)-Ang))-abs(Curv*D1);
                  X4A:=(((Curv*D1)-D1/2)*cos((pi/2)-Ang))-abs(X1A);
                  Y4A:=(((Curv*D1)-D1/2)*sin((pi/2)-Ang))-abs(Curv*D1);
              end;
            3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=Curv*D1;         X1:=((-Curv*D1)*tan(Ang/2));
                     X2:=-pi/2;           Y2:=Ang-(pi/2);
                     R:=ABS((-Curv*D1)+(D1/2));
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='A';         TLinea:=1;
                     Y1:=Curv*D1;         X1:=(-Curv*D1)*tan(Ang/2);
                     X2:=-pi/2;           Y2:=Ang-(pi/2);
                     R:=ABS((-Curv*D1)-D1/2);
                  end;
                  X1A:=(-Curv*D1)*(tan(Ang/2));
                  Y1A:=D1/2;
                  X2A:=X1A;
                  Y2A:=-D1/2;
                  X4A:=(((Curv*D1)+D1/2)*cos((pi/2)-Ang))-abs(X1A);
                  Y4A:=-(((Curv*D1)+D1/2)*sin((pi/2)-Ang))+abs(Curv*D1);
                  X3A:=(((Curv*D1)-D1/2)*cos((pi/2)-Ang))-abs(X1A);
                  Y3A:=-(((Curv*D1)-D1/2)*sin((pi/2)-Ang))+abs(Curv*D1);
              end;
            2:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=D1/2;
                     X2:=0;                        Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=-D1/2;
                     X2:=0;                        Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=0;               Y1:=0;
                     X2:=-pi/2;           Y2:=pi/2;
                     R:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';         TLinea:=2;
                     X1:=0;               Y1:=0;
                     X2:=pi/2;            Y2:=-pi/2;
                     R:=D1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
              end;
            4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=D1/2;
                     X2:=0;                        Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=-D1/2;
                     X2:=0;                        Y2:=-D1/2;

                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
              end;
(*            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=0;               Y1:=D1/2;
                     X2:=D1/2+(Curv*D1-D1/2)-(Curv*D1-D1/2)*sin(pi/2-Ang);
{                     X2:=((Curv*D1)*tan(Ang/2));}
                     Y2:=D1/2;
                  end;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-D1/2;
                  end;



                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D1/2;
              end;*)

          5,6:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=0;               Y1:=D1/2;
                     X2:=D1/2+(Curv*D1-D1/2)-(Curv*D1-D1/2)*sin(pi/2-Ang);
{                     X2:=(Curv*D1)*tan(Ang/2);}
                     Y2:=D1/2;
                  end;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=0;               Y1:=0;
                     X2:=pi/2;            Y2:=-pi/2;
                     R:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';         TLinea:=2;
                     X1:=0;               Y1:=0;
                     X2:=-pi/2;           Y2:=pi/2;
                     R:=D1/2;
                  end;

                 i:=5;        j:=2;
                 BoccCirc(D1,i,j);

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-D1/2;

                 if Orient = 5 then Z1:=(Curv*D1)*(tan(Ang/2))
                 else Z1:=-(Curv*D1)*(tan(Ang/2))
              end;

       end; { case }
 end;

Procedure D_069C;
 begin
       Ang:=Ang/180*pi;
       if (Ang<>pi/2) AND (Orient in[2,4..6]) then
        begin
           Ang45A(D1,D1);
           exit;
        end;

        case orient of
           1,3:begin
                  with DisPezzo^[1] do
                   begin
                      Entita:='L';            TLinea:=1;
                      X1:=-D1*Costant^.C45;            Y1:=D1/2;
                      if Ang=pi/2 then X2:=D1/2
                      else X2:=(D1/2)*tan(Ang/2);
                      Y2:=D1/2;
                   end;
                  with DisPezzo^[2] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=DisPezzo^[1].X2;   Y1:=D1/2;
                      X2:=X1+abs(D1*Costant^.C45+X1)*cos(Ang);
                      Y2:=D1/2-abs(D1*Costant^.C45+X1)*sin(Ang);
                   end;
                  with DisPezzo^[3] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=DisPezzo^[2].X2-D1*sin(Ang);
                      Y1:=DisPezzo^[2].Y2-D1*cos(Ang);
                      X2:=-DisPezzo^[1].X2;
                      Y2:=-D1/2;
                   end;
                  with DisPezzo^[4] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=DisPezzo^[3].X2;   Y1:=-D1/2;
                      X2:=-D1*Costant^.C45;          Y2:=-D1/2;
                   end;
                  with DisPezzo^[5] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=DisPezzo^[3].X2;   Y1:=DisPezzo^[3].Y2;
                      X2:=DisPezzo^[1].X2;   Y2:=DisPezzo^[1].Y2;
                   end;

                  X1A:=DisPezzo^[1].X1;
                  Y1A:=DisPezzo^[1].Y1;
                  X2A:=DisPezzo^[4].X2;
                  Y2A:=DisPezzo^[4].Y2;

                  if Orient=1 then
                   begin
                      X3A:=DisPezzo^[2].X2;
                      Y3A:=DisPezzo^[2].Y2;
                      X4A:=DisPezzo^[3].X1;
                      Y4A:=DisPezzo^[3].Y1;
                   end
                  else
                   begin
                      Speculare:=true;
                      X3A:=DisPezzo^[3].X1;
                      Y3A:=-DisPezzo^[3].Y1;
                      X4A:=DisPezzo^[2].X2;
                      Y4A:=-DisPezzo^[2].Y2;
                   end;

               end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-D1*Costant^.C45;         Y1:=D1/2;
                     if Ang=pi/2 then X2:=D1/2
                     else X2:=(D1/2)*tan(Ang/2)+abs(D1*Costant^.C45+X1)*cos(Ang);
                     Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-D1/2;
                  end;
(*                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=0;               Y1:=0;
                     X2:=-pi/2;           Y2:=pi/2;
                     R:=D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=2;
                     X1:=0;               Y1:=0;
                     X2:=pi/2;            Y2:=-pi/2;
                     R:=D1/2;
                  end;*)

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D1/2;
              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=0;               Y1:=D1/2;
                     if Ang=pi/2 then X2:=D1/2
                     else X2:=(D1/2)*tan(Ang/2);
                     X2:=-D1/2+abs(D1*Costant^.C45+X2)*sin(Ang)+D1*cos(Ang);;
                     Y2:=D1/2;
                  end;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-D1/2;
                  end;

                 i:=3;        j:=2;
                 BoccCirc(D1,i,j);


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D1/2;
                 Z1:=D1*Costant^.C45;
              end;

            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=0;               Y1:=D1/2;
                     if Ang=pi/2 then X2:=D1/2
                     else X2:=(D1/2)*tan(Ang/2);
                     X2:=-D1/2+abs(D1*Costant^.C45+X2)*sin(Ang)+D1*cos(Ang);;
                     Y2:=D1/2;
                  end;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=0;               Y1:=0;
                     X2:=pi/2;            Y2:=-pi/2;
                     R:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';         TLinea:=2;
                     X1:=0;               Y1:=0;
                     X2:=-pi/2;           Y2:=pi/2;
                     R:=D1/2;
                  end;

                 i:=5;        j:=2;
                 BoccCirc(D1,i,j);


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-D1/2;
                 Z1:=-D1*Costant^.C45;
              end;

        end; { case }
 end;

Procedure D_089C;
 var
   i,Spicchi:integer;
   PX,PY,Angolo:real;
 begin
    if Varie = 0 then Spicchi:=5
    else Spicchi:=Trunc(Varie);
    Ang:=Ang/180*pi;
    Angolo:=Ang/Spicchi;

    if Curv=0 then Curv:=1;
    if (Ang<>pi/2) AND (Orient in[2,4..6]) then
     begin
        Ang45(D1,D1);
        exit;
     end;

       case orient of
           1,3:begin
                  PX:=((-Curv*D1)*tan(Ang/2));  PY:=D1/2;
                  for i:=1 to Spicchi do
                  with DisPezzo^[i] do
                   begin
                      Entita:='L';                  TLinea:=1;
                      X1:=PX;                       Y1:=PY;
                      X2:=(((Curv*D1)+D1/2)*cos((pi/2)-i*Angolo))-abs(-Curv*D1)*(tan(Ang/2));
                      Y2:=(((Curv*D1)+D1/2)*sin((pi/2)-i*Angolo))-abs(Curv*D1);
                      PX:=X2;                       PY:=Y2;
                   end;
                  PX:=((-Curv*D1)*tan(Ang/2));  PY:=-D1/2;
                  for i:=1 to Spicchi do
                  with DisPezzo^[Spicchi+i] do
                   begin
                      Entita:='L';                  TLinea:=1;
                      X1:=PX;                       Y1:=PY;
                      X2:=(((Curv*D1)-D1/2)*cos((pi/2)-i*Angolo))-abs(-Curv*D1)*(tan(Ang/2));
                      Y2:=(((Curv*D1)-D1/2)*sin((pi/2)-i*Angolo))-abs(Curv*D1);
                      PX:=X2;                       PY:=Y2;
                   end;
                  for i:=1 to Spicchi-1 do
                  with DisPezzo^[2*Spicchi+i] do
                   begin
                      Entita:='L';                  TLinea:=1;
                      X1:=DisPezzo^[i].X2;           Y1:=DisPezzo^[i].Y2;
                      X2:=DisPezzo^[Spicchi+i].X2;   Y2:=DisPezzo^[Spicchi+i].Y2;
                   end;



                  X1A:=DisPezzo^[1].X1;
                  Y1A:=DisPezzo^[1].Y1;
                  X2A:=DisPezzo^[Spicchi+1].X1;
                  Y2A:=DisPezzo^[Spicchi+1].Y1;

                  if Orient=1 then
                   begin
                      X3A:=DisPezzo^[Spicchi].X2;
                      Y3A:=DisPezzo^[Spicchi].Y2;
                      X4A:=DisPezzo^[2*Spicchi].X2;
                      Y4A:=DisPezzo^[2*Spicchi].Y2;
                   end
                  else
                   begin
                      Speculare:=true;
                      X3A:=DisPezzo^[2*Spicchi].X2;
                      Y3A:=-DisPezzo^[2*Spicchi].Y2;
                      X4A:=DisPezzo^[Spicchi].X2;
                      Y4A:=-DisPezzo^[Spicchi].Y2;
                   end;

               end;
            2:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=D1/2;
                     X2:=0;                        Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=-D1/2;
                     X2:=0;                        Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=0;               Y1:=0;
                     X2:=-pi/2;           Y2:=pi/2;
                     R:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';         TLinea:=2;
                     X1:=0;               Y1:=0;
                     X2:=pi/2;            Y2:=-pi/2;
                     R:=D1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
              end;
            4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=D1/2;
                     X2:=0;                        Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=-((Curv*D1)*tan(Ang/2));  Y1:=-D1/2;
                     X2:=0;                        Y2:=-D1/2;

                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
              end;
          5,6:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=0;               Y1:=D1/2;
                     X2:=D1/2+(Curv*D1-D1/2)-(Curv*D1-D1/2)*sin(pi/2-Ang);
                     Y2:=D1/2;
                  end;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';         TLinea:=1;
                     X1:=DisPezzo^[1].X1;  Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;  Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=0;               Y1:=0;
                     X2:=pi/2;            Y2:=-pi/2;
                     R:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';         TLinea:=2;
                     X1:=0;               Y1:=0;
                     X2:=-pi/2;           Y2:=pi/2;
                     R:=D1/2;
                  end;

                 i:=5;        j:=2;
                 BoccCirc(D1,i,j);

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-D1/2;

                 if Orient = 5 then Z1:=(Curv*D1)*(tan(Ang/2))
                 else Z1:=-(Curv*D1)*(tan(Ang/2))
              end;

        end; { case }
 end;
end.


(*                 with DisPezzo^[1] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-(B2/2+((B1/2)*Costant^.C45));
                     Y1:=B1/2;
                     X2:=B2/2;               Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=B2/2;               Y1:=B1/2;
                     X2:=B2/2;               Y2:=-B1*Costant^.C45;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-B2/2;              Y1:=-B1*Costant^.C45;
                     X2:=-B2/2;              Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=-B2/2;              Y1:=-B1/2;
                     X2:=DisPezzo^[1].X1;     Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X1;   Y1:=DisPezzo^[4].Y2;
                     X2:=DisPezzo^[1].X2;   Y2:=DisPezzo^[1].Y2;
                  end; *)