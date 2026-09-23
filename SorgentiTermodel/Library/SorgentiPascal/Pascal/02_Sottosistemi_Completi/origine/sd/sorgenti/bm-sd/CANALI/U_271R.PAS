

unit U_271R;

interface

Procedure D_271R;
Procedure D_261R;
Procedure D_281R;
Procedure D_271C;
Procedure D_281C;
Procedure D_41R1;
Procedure D_42C1;


implementation

uses crt,dos,definiz,definizcan,U_VARPEZZI,interf3d;


procedure SetUscit(W1,H1,W2,H2:real);

{ 1 ingresso 2 uscite quando si usano riduzioni
  1 uscite 2 ingresso quando si usano allargamenti }

 begin

    case ColoreLinea of

     1:begin  { concentrica }
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=0;          Y3A:=W2/2;
          X4A:=0;          Y4A:=-W2/2;
       end;
     2:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=0;          Y3A:=-W1/2+W2;
          X4A:=0;          Y4A:=-W1/2;
       end;
     3:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=0;          Y3A:=W1/2;
          X4A:=0;          Y4A:=W1/2-W2;
       end;
     4:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=-H1/2+H2/2; Y3A:=W2/2;
          X4A:=-H1/2+H2/2; Y4A:=-W2/2;
       end;
     7:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=H1/2-H2/2;  Y3A:=W2/2;
          X4A:=H1/2-H2/2;  Y4A:=-W2/2;
       end;
     5:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=-H1/2+H2/2; Y3A:=-W1/2+W2;
          X4A:=-H1/2+H2/2; Y4A:=-W1/2;
       end;
     8:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=H1/2-H2/2;  Y3A:=-W1/2+W2;
          X4A:=H1/2-H2/2;  Y4A:=-W1/2;
       end;
     6:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=-H1/2+H2/2; Y3A:=W1/2;
          X4A:=-H1/2+H2/2; Y4A:=W1/2-W2;
       end;
     9:begin
          X1A:=0;          Y1A:=W1/2;
          X2A:=0;          Y2A:=-W1/2;
          X3A:=H1/2-H2/2;  Y3A:=W1/2;
          X4A:=H1/2-H2/2;  Y4A:=W1/2-W2;
       end;
    end;
    Case Orient of
     5:begin
          if TypeAll then Z2:=-Lung
          else Z1:=-Lung;
       end;
     6:begin
          if TypeAll then Z2:=Lung
          else Z1:=-Lung;
       end;
    end;
 end;


Procedure VistaSezR(B1,B2,H1,H2:real);
var TL:integer;
    DX,DY:real;

BEGIN

   if Orient = 6 then
    case ColoreLinea of
     6 : ColoreLinea:=9;
     4 : ColoreLinea:=7;
     5 : ColoreLinea:=8;
     9 : ColoreLinea:=6;
     7 : ColoreLinea:=4;
     8 : ColoreLinea:=5;
    end;

   if (CodPezzo = '023R') or (CodPezzo = '021R') or (CodPezzo = '013R') or
      (CodPezzo = '358' ) or (CodPezzo = '3512') or (CodPezzo = '3510') or
      (CodPezzo = '3511') or (CodPezzo = '359' ) or (CodPezzo = '338' ) or
      (CodPezzo = '011R') or (CodPezzo = '033R') or (CodPezzo = '031R') then TypeAll:=true;

   if (CodPezzo = '271R') or (CodPezzo = '273R') or (CodPezzo = '261R') or
      (CodPezzo = '263R') or (CodPezzo = '281R') or (CodPezzo = '283R') then TypeRid:=true;

   if (CodPezzo = '441R') or (CodPezzo = '443R') or (CodPezzo = '431R') or
      (CodPezzo = '433R') or (CodPezzo = '451R') or (CodPezzo = '453R') then TypeRot:=true;

  SetUscit(B1,H1,B2,H2);

 case ColoreLinea of
       1:begin

            case Orient of

            5:begin

               if TypeAll then TL:=1
               else TL:=2;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=H2/2;             Y2:=B2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=-H2/2;            Y2:=-B2/2;
                  end;

               if TypeRot then TL:=1;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=H2/2;             Y2:=-B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=-H2/2;            Y2:=B2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H2/2;            Y2:=B2/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=B2/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=H2/2;             Y2:=-B2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-H2/2;            Y2:=-B2/2;
                  end;

              end;
            6:begin

                 if TypeAll then TL:=2
                 else TL:=1;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H2/2;            Y2:=B2/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=B2/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=H2/2;             Y2:=-B2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-H2/2;            Y2:=-B2/2;
                  end;

               if TypeRot then TL:=2;

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=B1/2;
                  end;
              end;
            end;
         end;

 2,3,4,7:begin


            if ColoreLinea in[4,7] then
             begin
                DY:=B1;    DX:=B2;
                B1:=H1;    B2:=H2;
                H1:=DY;    H2:=DX;
             end;

            case orient of

            5:begin
                 TL:=1;
                 DY:=(B1-B2)/2;
                 if TypeAll or (TypeRot and (ColoreLinea in[2,3])) then
                  begin
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H1/2;             Y1:=-B1/2;
                         X2:=H2/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=-H2/2;            Y1:=-B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                  end;

                 if not(TypeAll or TypeRot) then TL:=2;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2;             Y1:=-DY+B2/2;
                     X2:=H2/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=-B1/2;
                     X2:=-H2/2;            Y2:=Y1+B2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2;             Y1:=-DY+B2/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=-DY+B2/2;
                     X2:=-H1/2;            Y2:=B1/2;
                  end;

                if TypeRot  and (ColoreLinea in[2,3]) then TL:=2;

                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=-DY+B2/2;
                     X2:=H2/2;             Y2:=-DY+B2/2;
                  end;

              end;

            6:begin

                 DY:=(B1-B2)/2;
                 {if TypeRid then}
                 if TypeRid or (TypeRot and (ColoreLinea in[4,7])) then
                  begin
                     TL:=1;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H1/2;             Y1:=-B1/2;
                         X2:=H2/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=-H2/2;            Y1:=-B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                  end
                 else TL:=2;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=B1/2;
                  end;

                if TypeRot then TL:=1;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=-DY+B2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H2/2;            Y2:=-DY+B2/2;
                  end;

               if TypeRot and (ColoreLinea in[4,7]) then
                begin
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H2/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H2/2;            Y1:=B1/2;
                     X2:=H2/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;

                end;

              end;
            end;

            Case ColoreLinea of
              3:Speculare:=true;
              4:Rotaz;
              7:begin
                   Rotaz;
                   SpecchioX;
                end;
            end;

         end;


 5,8,6,9:begin

            case orient of


            5:begin

                 DX:=(H1-H2)/2;
                 DY:=(B1-B2)/2;
                 if TypeAll or TypeRot then
                  begin
                     TL:=1;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H1/2;             Y1:=-B1/2;
                         X2:=-H1/2+H2;         Y2:=-B1/2;
                      end;

                     if TypeAll then
                      with DisPezzo^[5] do
                       begin
                          Entita:='L';          TLinea:=TL;
                          X1:=-H1/2;            Y1:=-DY+B2/2;
                          X2:=-H1/2;            Y2:=B1/2;
                       end;

                  end
                 else TL:=2;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2+H2;         Y1:=-DY+B2/2;
                     X2:=X1;               Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=-DX+H2/2;         Y2:=-DY+B2/2;
                  end;

                if TypeRot then TL:=2;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=-DY+B2/2;
                     X2:=X1+H2;            Y2:=-DY+B2/2;
                  end;

              end;
            6:begin
                 DX:=(H1-H2)/2;
                 DY:=(B1-B2)/2;
                 if TypeRid or TypeRot then
                  begin
                     TL:=1;
                     with DisPezzo^[4] do
                     begin
                        Entita:='L';          TLinea:=TL;
                        X1:=-H1/2;            Y1:=-DY+B2/2;
                        X2:=-H1/2;            Y2:=B1/2;
                     end;
                     if TypeRid then
                      with DisPezzo^[5] do
                       begin
                          Entita:='L';          TLinea:=TL;
                          X1:=H1/2;             Y1:=-B1/2;
                          X2:=-H1/2+H2;         Y2:=-B1/2;
                       end;
                  end
                 else TL:=2;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=-DX+H2/2;         Y2:=-DY+B2/2;
                  end;

                if TypeRot then TL:=2;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;

              end;

            end;

            Case ColoreLinea of
              6:Speculare:=true;
              8:SPECCHIOX;
              9:begin
                   SpecchioX;
                   SPECULARE:=TRUE;
                end;
            end;

         end;
  end;


END;


Procedure VistaSezC(D1,D2:real);

BEGIN

   if Orient = 6 then
    case ColoreLinea of
     6 : ColoreLinea:=9;
     4 : ColoreLinea:=7;
     5 : ColoreLinea:=8;
     9 : ColoreLinea:=6;
     7 : ColoreLinea:=4;
     8 : ColoreLinea:=5;
    end;


   if (CodPezzo = '023C') or (CodPezzo = '021C') or
      (CodPezzo = '033C') or (CodPezzo = '031C') then TypeAll:=true;

   if (CodPezzo = '271C') or (CodPezzo = '273C') or (CodPezzo = '327C') or
      (CodPezzo = '281C') or (CodPezzo = '283C') then TypeRid:=true;

   SetUscit(D1,D1,D2,D2);
 case ColoreLinea of
       1:begin
            Case Orient of
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';
                     if TypeAll then TLinea:=1
                     else TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D2/2;
                  end;
              end;

            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';
                     if TypeAll then TLinea:=2
                     else TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D1/2;
                  end;
              end;
           end;
         end;
 2,3,4,7:begin
            case Orient of
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';
                     if TypeAll then TLinea:=1
                     else TLinea:=2;
                     X1:=0;                Y1:=-(D1-D2)/2;
                     R:=D2/2;

                  end;

              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';
                     if TypeAll then TLinea:=2
                     else TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D1/2;
                  end;

              end;
            end;

            Case ColoreLinea of
              3:Speculare:=true;
              4:Rotaz;
              7:begin
                   Rotaz;
                   SpecchioX;
                end;
            end;

         end;

 5,8,6,9:begin
            case Orient of
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';
                     if TypeAll then TLinea:=1
                     else TLinea:=2;
                     X1:=-(D1-D2)/2;        Y1:=-(D1-D2)/2;
                     R:=D2/2;
                  end;

              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';
                     if TypeAll then TLinea:=2
                     else TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D1/2;
                  end;

              end;
            end;

            Case ColoreLinea of
              6:Speculare:=true;
              8:SpecchioX;
              9:begin
                   SpecchioX;
                   Speculare:=true;
                end;
            end;

         end;

 end;



END;


procedure  D_271R;
var  TL:integer;
 begin
    if (CodPezzo = '271R') OR (CodPezzo = '021R') OR (CodPezzo = '441R')  then Lung:=800;
    {Trasforma(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real)}

    Trasforma1(orient,1,B1,H1,1,B2,H2,0,0,Lung,0,0,0,0);

    case orient of
      1,3,2,4:begin
                 if (CodPezzo = '271R') or (CodPezzo = '273R') or (CodPezzo = '441R') or (CodPezzo = '443R') then
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-Lung;            Y1:=B1/2;
                         X2:=0;                Y2:=B2/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-Lung;            Y1:=-B1/2;
                         X2:=0;                Y2:=-B2/2;
                      end;

                     X1A:=-Lung;
                     Y1A:=B1/2;
                     X2A:=-Lung;
                     Y2A:=-B1/2;
                     X3A:=0;
                     Y3A:=B2/2;
                     X4A:=0;
                     Y4A:=-B2/2;
                  end
                 else
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=0;                Y1:=B1/2;
                         X2:=Lung;             Y2:=B2/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=0;                Y1:=-B1/2;
                         X2:=Lung;             Y2:=-B2/2;
                      end;

                     X1A:=0;
                     Y1A:=B1/2;
                     X2A:=0;
                     Y2A:=-B1/2;
                     X3A:=Lung;
                     Y3A:=B2/2;
                     X4A:=Lung;
                     Y4A:=-B2/2;
                  end
              end;

          5,6:VistaSezR(B1,B2,H1,H2);

       end;
    end;


Procedure D_261R;
var DY:real;
    TL:integer;
begin
    if (CodPezzo = '261R') or (CodPezzo = '011R') OR (CodPezzo = '431R')  then Lung:=800;
     case orient of
          1,3:begin
                 if (CodPezzo = '261R') or (CodPezzo = '263R') or (CodPezzo = '431R') or (CodPezzo = '433R') then
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=B1/2;
                        X2:=0;                Y2:=-B1/2+B2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=-B1/2;
                        X2:=0;                Y2:=-B1/2;
                     end;

                    X1A:=-Lung;
                    Y1A:=B1/2;
                    X2A:=-Lung;
                    Y2A:=-B1/2;
                    if Orient=1  then
                     begin
                        X3A:=0;
                        Y3A:=-B1/2+B2;
                        X4A:=0;
                        Y4A:=-B1/2;
                     end
                    else
                     begin
                        Speculare:=true;
                        X3A:=0;
                        Y3A:=B1/2;
                        X4A:=0;
                        Y4A:=B1/2-B2;
                     end;
                 end
                else
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=B1/2;
                        X2:=Lung;             Y2:=-B1/2+B2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=-B1/2;
                        X2:=Lung;             Y2:=-B1/2;
                     end;

                    X1A:=0;
                    Y1A:=B1/2;
                    X2A:=0;
                    Y2A:=-B1/2;
                    if Orient=1  then
                     begin
                        X3A:=Lung;
                        Y3A:=-B1/2+B2;
                        X4A:=Lung;
                        Y4A:=-B1/2;
                     end
                    else
                     begin
                        Speculare:=true;
                        X3A:=Lung;
                        Y3A:=B1/2;
                        X4A:=Lung;
                        Y4A:=B1/2-B2;
                     end;
                 end;
              end;

          2,4:begin
                 if (CodPezzo = '261R') or (CodPezzo = '263R') or (CodPezzo = '431R') or (CodPezzo = '433R') then
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=B1/2;
                        X2:=0;                Y2:=B2/2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=-B1/2;
                        X2:=0;                Y2:=-B2/2;
                     end;

                    X1A:=-Lung;
                    Y1A:=B1/2;
                    X2A:=-Lung;
                    Y2A:=-B1/2;
                    X3A:=0;
                    Y3A:=B2/2;
                    X4A:=0;
                    Y4A:=-B2/2;
                 end
                else
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=B1/2;
                        X2:=Lung;             Y2:=B2/2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=-B1/2;
                        X2:=Lung;             Y2:=-B2/2;
                     end;

                    X1A:=0;
                    Y1A:=B1/2;
                    X2A:=0;
                    Y2A:=-B1/2;
                    X3A:=Lung;
                    Y3A:=B2/2;
                    X4A:=Lung;
                    Y4A:=-B2/2;
                 end
              end;

          5,6:VistaSezR(B1,B2,H1,H2);

       end;
    end;

Procedure D_281R;
var DX,DY:real;
    TL:integer;
begin
    if (CodPezzo = '281R') or (CodPezzo = '031R') or (CodPezzo = '451R') then Lung:=800;
      case orient of
        1,3,2,4:begin
                   if (CodPezzo = '281R') or (CodPezzo = '283R') or (CodPezzo = '451R') or (CodPezzo = '453R') then
                   begin
                      with DisPezzo^[1] do
                       begin
                          Entita:='L';          TLinea:=1;
                          X1:=-Lung;            Y1:=B1/2;
                          X2:=0;                Y2:=-B1/2+B2;
                       end;
                      with DisPezzo^[2] do
                       begin
                          Entita:='L';          TLinea:=1;
                          X1:=-Lung;            Y1:=-B1/2;
                          X2:=0;                Y2:=-B1/2;
                       end;

                      X1A:=-Lung;
                      Y1A:=B1/2;
                      X2A:=-Lung;
                      Y2A:=-B1/2;
                      if Orient in[1,2] then
                       begin
                          X3A:=0;
                          Y3A:=-B1/2+B2;
                          X4A:=0;
                          Y4A:=-B1/2;
                       end
                      else
                       begin
                          Speculare:=true;
                          X3A:=0;
                          Y3A:=B1/2;
                          X4A:=0;
                          Y4A:=B1/2-B2;
                       end;
                   end
                  else
                   begin
                      with DisPezzo^[1] do
                       begin
                          Entita:='L';          TLinea:=1;
                          X1:=0;                Y1:=B1/2;
                          X2:=Lung;             Y2:=-B1/2+B2;
                       end;
                      with DisPezzo^[2] do
                       begin
                          Entita:='L';          TLinea:=1;
                          X1:=0;                Y1:=-B1/2;
                          X2:=Lung;             Y2:=-B1/2;
                       end;

                      X1A:=0;
                      Y1A:=B1/2;
                      X2A:=0;
                      Y2A:=-B1/2;
                      if Orient in[1,2] then
                       begin
                          X3A:=Lung;
                          Y3A:=-B1/2+B2;
                          X4A:=Lung;
                          Y4A:=-B1/2;
                       end
                      else
                       begin
                          Speculare:=true;
                          X3A:=Lung;
                          Y3A:=B1/2;
                          X4A:=Lung;
                          Y4A:=B1/2-B2;
                       end;
                   end;

              end;


          5,6:VistaSezR(B1,B2,H1,H2);

       end;
    end;

procedure D_281C;
 begin
    if (CodPezzo = '281C') or (CodPezzo = '031C') then Lung:=800;
       case orient of
          1,3:begin
                 if (CodPezzo='281C') or (CodPezzo='283C') then
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=D1/2;
                        X2:=0;                Y2:=-D1/2+D2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=-D1/2;
                        X2:=0;                Y2:=-D1/2;
                     end;
                 end
                else
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=D1/2;
                        X2:=Lung;             Y2:=-D1/2+D2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=-D1/2;
                        X2:=Lung;             Y2:=-D1/2;
                     end;
                 end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 if (Orient = 1) then
                  begin
                     X3A:=DisPezzo^[1].X2;
                     Y3A:=DisPezzo^[1].Y2;
                     X4A:=DisPezzo^[2].X2;
                     Y4A:=DisPezzo^[2].Y2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[2].X2;
                     Y3A:=-DisPezzo^[2].Y2;
                     X4A:=DisPezzo^[1].X2;
                     Y4A:=-DisPezzo^[1].Y2;
                  end;
              end;
          2,4:begin
                 if (CodPezzo='281C') or (CodPezzo='283C') then
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=D1/2;
                        X2:=0;                Y2:=D2/2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=-D1/2;
                        X2:=0;                Y2:=-D2/2;
                     end;
                 end
                else
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=D1/2;
                        X2:=Lung;             Y2:=D2/2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=-D1/2;
                        X2:=Lung;             Y2:=-D2/2;
                     end;
                 end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

              end;
          5,6:VistaSezC(D1,D2);
       end;
 end;

procedure D_271C;
 begin
    if (CodPezzo = '271C') or (CodPezzo = '021C') then Lung:=800;
    case orient of
      1,3,2,4:begin
                 if (CodPezzo='271C') or (CodPezzo='273C') or (CodPezzo='327C') then
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=D1/2;
                        X2:=0;                Y2:=D2/2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-Lung;            Y1:=-D1/2;
                        X2:=0;                Y2:=-D2/2;
                     end;
                 end
                else
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=D1/2;
                        X2:=Lung;             Y2:=D2/2;
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=0;                Y1:=-D1/2;
                        X2:=Lung;             Y2:=-D2/2;
                     end;
                 end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;
              end;
          5,6:VistaSezC(D1,D2);

       end;
    end;


procedure D_41R1;
 begin

    if (CodPezzo = '41R1') then Lung:=800;
    if (CodPezzo = '361B') then
     begin
        Ang:=Ang/180*pi;
        if Ang=pi then Lung:=0
        else Lung:=abs(((B1-B2)/2)/tan(Ang/2));
     end;

       case orient of
      1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=D1/2;
                     X2:=0;                Y2:=B2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=-D1/2;
                     X2:=0;                Y2:=-B2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=0;
                     X2:=0;                Y2:=B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=0;
                     X2:=0;                Y2:=-B2/2;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=H2/2;             Y2:=B2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=H2/2;             Y2:=-B2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=-H2/2;            Y2:=-B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=-H2/2;            Y2:=B2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=0;                Y2:=B2/2-(B2-D1)/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=-H2/2+(H2-D1)/2;  Y2:=0;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=0;                Y2:=B2/2-(B2-D1)/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=H2/2-(H2-D1)/2;   Y2:=0;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=H2/2-(H2-D1)/2;   Y2:=0;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=0;                Y2:=-B2/2+(B2-D1)/2;
                  end;
                 with DisPezzo^[11] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=0;                Y2:=-B2/2+(B2-D1)/2;
                  end;
                 with DisPezzo^[12] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=-H2/2+(H2-D1)/2;   Y2:=0;
                  end;


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=B2/2;
                 X4A:=0;
                 Y4A:=-B2/2;
                 Z1:=Lung;
              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';          TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=0;                Y2:=B2/2-(B2-D1)/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=-H2/2+(H2-D1)/2;  Y2:=0;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=0;                Y2:=B2/2-(B2-D1)/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=H2/2-(H2-D1)/2;   Y2:=0;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=H2/2-(H2-D1)/2;   Y2:=0;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=0;                Y2:=-B2/2+(B2-D1)/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=0;                Y2:=-B2/2+(B2-D1)/2;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=-H2/2+(H2-D1)/2;   Y2:=0;
                  end;


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=B2/2;
                 X4A:=0;
                 Y4A:=-B2/2;
                 Z1:=-Lung;
            end;
       end;
    end;

procedure D_42C1;
 begin

    if (CodPezzo = '42C1') or (CodPezzo = '363') then Lung:=800;

       case orient of
      1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=B1/2;
                     X2:=0;                Y2:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=-B1/2;
                     X2:=0;                Y2:=-D2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=B1/2;
                     X2:=0;                Y2:=0;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung;            Y1:=-B1/2;
                     X2:=0;                Y2:=0;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=0;                Y2:=D2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-D2/2;            Y2:=0;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=0;                Y2:=D2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=D2/2;             Y2:=0;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=D2/2;             Y2:=0;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=0;                Y2:=-D2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=0;                Y2:=-D2/2;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-D2/2;            Y2:=0;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;
                 Z1:=Lung;
              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=0;                Y2:=D2/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-D2/2;            Y2:=0;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=0;                Y2:=D2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=D2/2;             Y2:=0;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=D2/2;             Y2:=0;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=0;                Y2:=-D2/2;
                  end;
                 with DisPezzo^[11] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=0;                Y2:=-D2/2;
                  end;
                 with DisPezzo^[12] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-D2/2;            Y2:=0;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;
                 Z1:=-Lung;
              end;
       end;
    end;


end.


