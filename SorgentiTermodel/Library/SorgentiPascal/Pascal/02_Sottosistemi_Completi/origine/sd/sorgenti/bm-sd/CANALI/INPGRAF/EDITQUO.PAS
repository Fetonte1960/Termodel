{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit Editquo;

INTERFACE

uses definiz,genproc,wm,globfunz,halotp4,graph,disdim,
     ut_deb,angoli,esiste,controll;

Function SelezDis(var Numlinea,oldgruppo:integer;Var M_er:string):integer;
Function Controlla_form(str_in:string;Var V_cod:st5;Var V_r,V_a,V_b:real;var V_Flag:st_1):string;
Function Tipo_Pezzo(cod:string;Var descpezzo:string):integer;
Procedure Editquote;

{============================================================================}

Implementation

Function Tocca(Vettore:VetDim):integer;
Var res:integer;
    Dir_p,Dir_pz,a1,a2:real;
begin
res:=0;
        if(
           ((Vettore.z1>=Zmin_p)and(Vettore.z1<=Zmax_p))or
           ((Vettore.z2>=Zmin_p)and(Vettore.z2<=Zmax_p))) then
          with vettore do
          Case Vettore.Entita[1] of
  'L','F','*':begin
              inters(real1,real2,res,xg(x1,y1),xg(x2,y2),x+5,x-5,yg(y1,z1),yg(y2,z2),y+5,y-5,0.001);
              if res=0 then
              inters(real1,real2,res,xg(x1,y1),xg(x2,y2),x-5,x+5,yg(y1,z1),yg(y2,z2),y+5,y-5,0.001);
              end;
          'A':begin

              real1:=xg(Vettore.x1,Vettore.y1);
              real2:=yg(Vettore.y1,Vettore.z1);

              If Not Sezione Then
              real3:=xg(Vettore.R,0)-Xg(0,0)
              else real3:=Yg(0,-Vettore.R)-Yg(0,0);
              if Abs(sqrt(sqr(x-real1)+sqr(y-real2))-real3)<=5 then
                begin
                a1:=Vettore.x2;
                a2:=Vettore.y2;

                While (a1<0)or(a1>2*pi) do
                  begin
                  if a1<0    then a1:=a1+2*pi;
                  if a1>2*PI then a1:=a1-2*pi;
                  end;

                While (a2<0)or(a2>2*pi) do
                  begin
                  if a2<0    then a2:=a2+2*pi;
                  if a2>2*PI then a2:=a2-2*pi;
                  end;

                Calc_d(real1,real2,0,x,y,0,Dir_p,Dir_pZ);
                dir_p:=Pi/2-dir_p;
                While (Dir_p<0)or(Dir_p>2*pi) do
                  begin
                  if Dir_p<0    then Dir_p:=Dir_p+2*pi;
                  if Dir_p>2*PI then Dir_p:=Dir_p-2*pi;
                  end;


                if a2>a1 then
                  begin
                  if (Dir_p>=a1)and(Dir_p<=a2) then res:=1;
                  end
                else
                  begin
                  if (Dir_p>=a1)or(Dir_p<=a2) then res:=1;
                  end

                end;

              end;
           'P':begin
               real1:=xg(Vettore.x1,Vettore.y1);
               real2:=yg(Vettore.y1,Vettore.z1);

               If Not Sezione Then
               real3:=xg(Vettore.R,0)-Xg(0,0)
               else real3:=Yg(0,-Vettore.R)-Yg(0,0);
               If Not Sezione Then
               real4:=xg(Vettore.R2,0)-Xg(0,0)
               else real4:=Yg(0,-Vettore.R2)-Yg(0,0);

               if Abs(sqrt(sqr(x-real1)+sqr(y-real2))-(real3+real4)/2)<=
                  abs(real4-real3)/2+5 then
                 begin
                 a1:=Vettore.x2;
                 a2:=Vettore.y2;

                 While (a1<0)or(a1>2*pi) do
                   begin
                   if a1<0    then a1:=a1+2*pi;
                   if a1>2*PI then a1:=a1-2*pi;
                   end;

                 While (a2<0)or(a2>2*pi) do
                   begin
                   if a2<0    then a2:=a2+2*pi;
                   if a2>2*PI then a2:=a2-2*pi;
                   end;

                 Calc_d(real1,real2,0,x,y,0,Dir_p,Dir_pZ);
                 dir_p:=Pi/2-dir_p;
                 While (Dir_p<0)or(Dir_p>2*pi) do
                   begin
                   if Dir_p<0    then Dir_p:=Dir_p+2*pi;
                   if Dir_p>2*PI then Dir_p:=Dir_p-2*pi;
                   end;


                 if a2>a1 then
                   begin
                   if (Dir_p>=a1)and(Dir_p<=a2) then res:=1;
                   end
                 else
                   begin
                   if (Dir_p>=a1)or(Dir_p<=a2) then res:=1;
                   end

                 end;

              end;
           'C':begin
              real1:=xg(Vettore.x1,Vettore.y1);
              real2:=yg(Vettore.y1,Vettore.z1);
              If Not Sezione Then
              real3:=xg(Vettore.R,0)-Xg(0,0)
              else real3:=Yg(0,-Vettore.R)-Yg(0,0);
              if Abs(sqrt(sqr(x-real1)+sqr(y-real2))-real3)<=5 then res:=1;
              end;
           'Q':begin
              {setlnstyle(@Vettore.tlinea);
              setcolor(Vettore.colore);
              real1:=xg1(Vettore.x1,Vettore.y1);
              real2:=yg1(Vettore.y1,Vettore.z1);
              movTcurabs(@real1,@real2);
              int1:=round(Vettore.y2);
              real1:=xg1(costant.altquo*70,0)-Xg1(0,0);
              real2:=1;
              st1:=OutTextN(Vettore.R,Vettore.X2);
              SetSText(@real1,@real2,@Int1);
              SText(@st1);}
              end;

          end;
tocca:=res;
end;


{**************************** SelezLinea ***********************************}

Function SelezDis(var Numlinea,oldgruppo:integer;Var M_er:string):integer;

Var i,res,grupposel:integer;
    Rigadis:Vetdim;
    Fdim1:File of vetdim;
    Selezd:integer;
    st1:string;
begin
NumLinea:=0;
richiesta('');



if ((exist(DriveProg+NomeProg+'.DIM'))and(Not Sezione))Or
       ((exist(DriveProg+NomeProg+'.qqq'))and(Sezione)) then
  begin
  If Sezione Then Assign(Fdim1,DriveProg+NomeProg+'.qqq')
  ELse Assign(Fdim1,DriveProg+NomeProg+'.DIM');

  if oldgruppo<>0 then
    begin
    reset(Fdim1);
    setclip(@xw1,@yw1,@xw2,@yw2); {cippo}

    While not(eof(Fdim1)) do
      begin
      read(Fdim1,rigadis);
      if (Oldgruppo=rigadis.Gruppo) then
      disegna_dim(Rigadis,0);
      end;
    end;

  repeat
  Reset(Fdim1);

  richiesta(M_er+'Selezionare disegno');  {*TR*}
  M_er:='';
  st1:='';
  readcord(x,y,cod,scelta,st1,3);
  delbox;
  {delay(200);}

    case cod of

    132:begin
        delbox;
        res:=0;
        While (not(eof(Fdim1)))and(res=0) do
          begin
          read(Fdim1,rigadis);
          res:=tocca(rigadis);
          end;
        if res<>0 then
          begin
          NumLinea:=rigadis.codpezzo;
          Grupposel:=rigadis.Gruppo;
          Oldgruppo:=grupposel;
          setclip(@xw1,@yw1,@xw2,@yw2); {cippo}
          reset(Fdim1);
          While not(eof(Fdim1)) do
            begin
            read(Fdim1,rigadis);
            if (NumLinea=rigadis.codpezzo)and
               (Grupposel=rigadis.Gruppo) then
            disegna_dim(Rigadis,5);
            end;
          end
        else
          begin
          numlinea:=0;
          {$ifdef win}
          cod:=130;
          selezdis:=130;
          {$else}
          cod:=125;
          {$endif}
          M_er:='Nessun disegno selezionato, '  {*TR*}
          end;

        end;

    else Selezdis:=130;
    end;
  until Cod In [130,132];

  close(fdim1);
  end

else

  begin
  Selezdis:=130;
  NumLinea:=0;
  end

end;

{---------------------------------------------------------------------------}


Function Tipo_Pezzo(cod:string;Var descpezzo:string):integer;

Const
      MCurve90=19;

      Curve90:Array[1..MCurve90]of string[5]=

      ('079R','079C','089C','069C' ,'328F' ,'336F' ,'069R' ,'347A' ,'347B' ,
       '347C','348' ,'349' ,'3410' ,'10RAT','10RBT','11RAT','11RBT','12RAT',
       '12RBT');

      {----------}

      MCurve75=5;

      Curve75:Array[1..MCurve75]of string[5]=

      ('077R','077C','087C','067C' ,'067R');

      {----------}

      MCurve60=5;

      Curve60:Array[1..MCurve60]of string[5]=

      ('076R','076C','086C','066C' ,'066R');

      {----------}

      MCurve45=5;

      Curve45:Array[1..MCurve45]of string[5]=

      ('074R','074C','084C','064C' ,'064R');

      {----------}

      MCurve30=5;

      Curve30:Array[1..MCurve30]of string[5]=

      ('073R','073C','083C','063C' ,'063R');

      {----------}

      MCurve20=5;

      Curve20:Array[1..MCurve20]of string[5]=

      ('072R','072C','082C','062C' ,'062R');

{     RiduzCC:Array[1..6]of string[5]=

      ('271C','273C','281C','283C' ,'362C','327C');

      AllaCC:Array[1..5]of string[5]=

      ('021C','023C','031C','033C' ,'352');

      TrasfCR:Array[1..4]of string[5]=

      ('361B','41R1','41R3','357CR');

      TrasfRC:Array[1..4]of string[5]=

      ('42C1','42C3','363','327R');}

      {----------}

      MDer90=24;

      Der90:Array[1..MDer90]of string[5]=

      ('3710','3717','31CA','10CB','31CD','13CB','13CA','10CB','31CB','3722',
       '11RA','10RA','12RA','31RA','39RA','11RB','10RB','31RD','39RD','12RB',
       '379' ,'31RB','39RB','3722D');

      {----------}

      MDer=6;

      Der:Array[1..MDer]of string[5]=

      ('3723C','31CC','3723R','31RC','39RC','3724');

      {----------}

      MDer45=3;

      Der45:Array[1..MDer45]of string[5]=

      ('3711','372','375');

      {----------}

      MTEE=2;

      TEE:Array[1..MTEE]of string[5]=

      ('3734C','3734R');

      {----------}

      MCroce45=2;

      CROCE45:Array[1..MCroce45]of string[5]=

      ('3735C','3735R');

      {----------}

      MCroce90=22;

      CROCE90:Array[1..MCroce90]of string[5]=

      ('3736C','15CA' ,'16CA' ,'3736C','15CB' ,'16CB' ,'3736R','15RA' ,'17RA' ,
       '15RB' ,'17RB' ,'16RAT','16RBT','15RAT','15RBT','15RAC','15RBC','15CAT',
       '15CBT','13CAT','13CBT','3736');

      {----------}

      MTEE90=8;

      TEE90:Array[1..MTEE90]of string[5]=

      ('3733','3733D','13RAT','13RBT','13RAC','13RBC','14RAT','14RBT');

      {----------}

      Mbocc=13;

      BoCC:Array[1..Mbocc]of string[5]=

      ('04CC','04CR','04LC','04LR','04SC','04SR','05CC','05CR','05LC','05LR',
       '05SC','05SR','05TC');

Var j,TipoPezzo:integer;

begin
TipoPezzo:=0;
{cippo}
if cod='' then tipopezzo:=-1;
j:=0;
repeat j:=j+1 until (j=MCurve90)or(cod=Curve90[j]);
if cod=Curve90[j] then TipoPezzo:=1
else
  begin
  j:=0;
  repeat j:=j+1 until (j=MCurve75)or(cod=Curve75[j]);
  if cod=Curve75[j] then TipoPezzo:=2
  else
    begin
    j:=0;
    repeat j:=j+1 until (j=MCurve60)or(cod=Curve60[j]);
    if cod=Curve60[j] then TipoPezzo:=3
    else
      begin
      j:=0;
      repeat j:=j+1 until (j=MCurve45)or(cod=Curve45[j]);
      if cod=Curve45[j] then TipoPezzo:=4
      else
        begin
        j:=0;
        repeat j:=j+1 until (j=MCurve30)or(cod=Curve30[j]);
        if cod=Curve30[j] then TipoPezzo:=5
        else
          begin
          j:=0;
          repeat j:=j+1 until (j=MCurve20)or(cod=Curve20[j]);
          if cod=Curve20[j] then TipoPezzo:=6
          else
            begin
            j:=0;
            repeat j:=j+1 until (j=Mder90)or(cod=der90[j]);
            if cod=der90[j] then TipoPezzo:=7
            else
              begin
              j:=0;
              repeat j:=j+1 until (j=Mder)or(cod=der[j]);
              if cod=der[j] then TipoPezzo:=8
              else
                begin
                j:=0;
                repeat j:=j+1 until (j=Mder45)or(cod=der45[j]);
                if cod=der45[j] then TipoPezzo:=9
                else
                  begin
                  j:=0;
                  repeat j:=j+1 until (j=MTEE)or(cod=TEE[j]);
                  if cod=TEE[j] then TipoPezzo:=10
                  else
                    begin
                    j:=0;
                    repeat j:=j+1 until (j=MCroce45)or(cod=Croce45[j]);
                    if cod=Croce45[j] then TipoPezzo:=11
                    else
                      begin
                      j:=0;
                      repeat j:=j+1 until (j=MCroce90)or(cod=Croce90[j]);
                      if cod=Croce90[j] then TipoPezzo:=12
                      else
                        begin
                        j:=0;
                        repeat j:=j+1 until (j=MTEE90)or(cod=TEE90[j]);
                        if cod=TEE90[j] then TipoPezzo:=13
                        else
                          begin
                          j:=0;
                          repeat j:=j+1 until (j=MBocc)or(cod=Bocc[j]);
                          if cod=Bocc[j] then TipoPezzo:=14
                          end
                        end
                      end;
                    end;
                  end
                end
              end
            end
          end;
        end
      end
    end;
  end;

  Case TipoPezzo of
  0 :DescPezzo:='Pezzo generico senza variazione di direzione';{*TR*}
  1 :DescPezzo:='curva a 90ø';{*TR*}
  2 :DescPezzo:='curva a 75ø';{*TR*}
  3 :DescPezzo:='curva a 60ø';{*TR*}
  4 :DescPezzo:='curva a 45ø';{*TR*}
  5 :DescPezzo:='curva a 30ø';{*TR*}
  6 :DescPezzo:='curva a 20ø';{*TR*}
  7 :DescPezzo:='derivazione a 90ø';{*TR*}
  8 :DescPezzo:='derivazione ';{*TR*}
  9 :DescPezzo:='derivazione a 45ø';{*TR*}
  10:DescPezzo:='TEE';{*TR*}
  11:DescPezzo:='croce a 45ø';{*TR*}
  12:DescPezzo:='croce a 90ø';{*TR*}
  13:DescPezzo:='TEE a 90ø';{*TR*}
  14:DescPezzo:='pezzo terminale';{*TR*}
  end;

Tipo_pezzo:=TipoPezzo;

end;



Function Controlla_form(str_in:string;Var V_cod:st5;Var V_r,V_a,V_b:real;var V_Flag:st_1):string;

Var i,Pos_a:integer;
    St_Temp:string;
    T_a,T_b:real;
    errore:integer;
    Trov_a:boolean;
    lung:integer;

begin
errore:=0;
Trov_a:=false;

st_temp:=str_in;
str_IN:='';
for i:=1 to length(st_temp) do
if st_temp[i]<>' ' then
Str_in:=str_in+st_temp[i];
Pos_a:=1;

lung:=length(Str_in);

if (str_in<>'')and(not(upcase(str_in[1]) In['I','C','R'])) then
for i:=1 to lung  do
if errore=0 then
  begin
  if Str_in[i] In ['x','X','*',','] then
    begin
    if Trov_a then errore:=1
    else
      begin
      val(copy(str_in,1,i-1),T_a,errore);
      Trov_a:=true;
      Pos_a:=i+1;
      end;
    end;
  if (i=lung)and(errore=0) then
    begin
    val(copy(str_in,Pos_a,lung-pos_a+1),T_b,errore);
    if errore=0 then
    if trov_a then
      begin
      V_cod:='310R';
      V_a:=T_a;
      V_b:=T_b;
      v_r:=0;
      end
    else
      begin
      V_cod:='310C';
      V_r:=T_b;
      V_a:=0;
      v_b:=0;
      end;
    end;
  end;

if (Str_in<>'')and(errore=0) then
  case Upcase(str_in[1]) Of
  'C':begin       {*TR*}
      V_flag:='';
      V_cod :='310C';
      v_a:=0;
      v_b:=0;
      end;
  'R':begin       {*TR*}
      V_flag:='';
      V_cod :='310R';
      v_r:=0;
      end;
  'I':begin       {*TR*}
      end;
  else
    begin
    V_flag:='*';
    end;
  end;


if (errore=0) then controlla_form:=''
else Controlla_form:='Formato non correto, digitare A*B oppure D ';{*TR*}
end;


{---------------------------------------------------------------------------}

Procedure Editquote;


Var Pezzosel:integer;
    Okkay:boolean;
    Cod_p:string[5];
    Stric,sttemp,stdef,risp:string;
    Mes_er:string;
    Oldg:integer;
    TipoPrec,NuovoT:integer;
    DescrPrec,NuovaDesc,Nuovocod:string;
    M_a,M_b,M_r:real;
    M_flag:st_1;

{--------------------}


{-------------------------}

begin
Mes_er:='';
oldg:=0;

  repeat
  Okkay:=SelezDis(Pezzosel,oldg,Mes_er)<>130;
  if Okkay then
    begin
    Okkay:=false;
    if (Pezzosel<>0)and(pezzosel<=Ultpezzo) then
      begin
      if VPezzi^[Pezzosel]^.Codice<>'' then
        begin
        okkay:=true;
        with VPezzi^[Pezzosel]^ do
          begin
          Codice:=setright(setleft(Upstring(codice)));
          if (codice='310R')or(codice='310C') then
            begin
              stric:=Codice+Flag+'(';
              If codice='310C' then
                begin
                stric:=stric+'D';
                str(R:1:0,Sttemp);
                end
              else
                begin
                str(A:1:0,Sttemp);
                stric:=stric+sttemp+'*';
                str(B:1:0,Sttemp);
                end;


              stric:=Stric+sttemp+')Misure/Invariato/Circ/Rett';{*TR*}

              repeat
              risp:=readcom(Stric,'Invariato',0); {*TR*}
              stric:=Controlla_form(risp,Codice,r,a,b,Flag);
              until stric='';

              if (risp<>'')and(upcase(risp[1])<>'I') then  {*TR*}
                begin
                M_a:=a;
                M_b:=b;
                M_flag:=Flag;
                  repeat
                  Mes_er:='Altri pezzi con le stesse misure, '; {*TR*}
                  Okkay:=SelezDis(Pezzosel,oldg,Mes_er)<>130;
                  if (okkay)and(Mes_er='') then
                    begin
                    VPezzi^[Pezzosel]^.A:=M_a;
                    VPezzi^[Pezzosel]^.b:=M_b;
                    VPezzi^[Pezzosel]^.r:=M_r;
                    VPezzi^[Pezzosel]^.flag:=M_flag;
                    end;
                  until not((okkay)and(Mes_er=''));
                okkay:=true;
                end;
            end
          else
            begin
            Mes_er:='Nuovo codice';
            TipoPrec:=Tipo_Pezzo(codice,DescrPrec);
              repeat
              NuovoCod:=readcom(Mes_er,Codice,0);{*TR*}
              NuovoCod:=setright(setleft(Upstring(Nuovocod)));
              NuovoT:=Tipo_Pezzo(Nuovocod,NuovaDesc);
              Mes_er:='';
              if Nuovot=Tipoprec then Codice:=NuovoCod
              else Mes_er:='Inserire codice del tipo "'+DescrPrec+'"';{*TR*}
              until Mes_er='';
            end;
          end;
        end;
      end;
    if not(okkay) then
      begin
      write(chr(7));
      richiesta('Disegno dimensionato non aggiornato'); {*TR*}
      end;
    end;
  until Not(okkay);
richiesta('');
end;

end.