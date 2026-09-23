{$A+,B-,D+,E-,F+,I+,L+,N-,O+,R+,S+,V+}

{$C DEMANDLOAD}
unit novitplt;

interface

uses definiz,angoli,genproc,globfunz,diseg,esiste,percento,wm;


procedure plTizza(sp,dim:integer;fs:real;nome:string);


implementation

{type Possibilita =('L','Q','A','C');}



type ldimrecdis=record mov:char;x,y:integer end;
  {   dimrecdisV=array[1..nhpgl]of dimrecdis;}

type qdimrecdis = record
                   setta :integer;
                   x,y   :integer;
                   valore:string[10];
                  end;

type cdimrecdis = record
                   raggio:integer;
                   x,y   :integer;
                  end;

type adimrecdis = record
                   raggio:integer;
                   x,y   :integer;
                   alfa1,alfa2 :integer;
                  end;

type Zdimrecdis = record
                   x,y   :integer;
                  end;

type Sdimrecdis = record {setta colore e tipo di linea}
                   x,y   :integer;
                  end;

type dimrecdis=record
                Case Tipo : char{Possibilita} of

                      'L' : (linea:ldimrecdis);
                      'Q' : (quota:qdimrecdis);
                      'A' : (arco :adimrecdis);
                      'C' : (Cerchio:cdimrecdis);
                      'Z' : (piano:zdimrecdis);
                      'S' : (cambia:sdimrecdis);
               end;

type fdimrecdis = file of dimrecdis;

var buf1: dimrecdis;
{var confronto : fdimrecdis;}
{var buf2: dimrecdis;}
var
    adattato:boolean;
    st2:string;
    A0,alzata:BOOLEAN;
    ch:char;

var Ii,k,v:integer;
  {  f:text; }
    pxi3,pyi3,xt,yt:real;
    real5:real;
    spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2,xinfp,yinfp,xsupP,ysupP:real;
    fp,fx:real;
    fr:integer;
    tratt:boolean;
    AltN,AltNC:real;
    A0X,A0Y:REAL;
    contl : integer;


const a='PA';
      d='PD;';
      u='PU;';
      i='IP;';
      p='SP';
      fct=0.018;



{***************************  exist      *******************************}

 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;
(*
{************************** arcptl ***********************************}
procedure arcplt(var f:fdimrecdis; xa1,ya1,ang1,ang2,r:real;tr:boolean;
                     dim:integer;fs:real);
const raggio=2000;
      parti =120;
var
    xr,yr,angtemp:real;
    i:integer;
{    nparti : real;  }
    deang3 : real;
    nparti : integer;
{var buf1: dimrecdis;}

begin

  i:=0;
  if ang1>ang2 then
   begin
     ang2:=ang2+2*pi;
   end;
  if r>raggio then nparti:= round(parti*(ang2-ang1)/(2*pi))+1
              else nparti:= round(parti* (r/raggio) * ((ang2-ang1)/(2*pi)) ) +1;
   deang3:=(ang2-ang1)/nparti;
   xr:=r*COS(ang1)+xa1;
   yr:=r*SIN(ang1)+ya1;
   xr:=round(xr);
   yr:=round(yr);
   with buf1 do
   begin
    mov:='1';
    x  :=round(xr*fs);
    y  :=round(yr*fs);
   end;

   write(f,buf1);
   {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;

   for i:=0 to nparti do
   begin
     xr:=r*COS(ang1)+xa1;
     yr:=r*SIN(ang1)+ya1;
     ang1:=ang1+deang3;
     xr:=round(xr);
     yr:=round(yr);

     with buf1 do
     begin
      mov:='0';
      x  :=round(xr*fs);
      y  :=round(yr*fs);
     end;
     write(f,buf1);
        {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;
   end;
end;



*)

{************************** PARCP ****************************}

Procedure PArcP(var F:fdimrecdis; fs :real);

const Ndiv=20;
var i:integer;
    angpr,xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
begin
  with Vettore^ Do
  begin
    StepCos:=Pi/Ndiv;
    StepAng:=(y2-x2)/Ndiv;
    x2:=x2+2*pi;
    y2:=y2+2*pi;
    xpr:=X1+R*Cos(x2);
    ypr:=Y1+R*Sin(x2);
    xpr:=xpr;
    ypr:=ypr;
    real1:=xpr-A0X;
    real2:=ypr-A0Y;
    buf1.tipo:='L';
    with buf1.linea do
    begin
    mov:='1';
    x  :=round(real1*fs);
    y  :=round(real2*fs);
    end;

    write(f,buf1);
       {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;


    {write(f,d,'LT');}
    for i:=1 to Ndiv Do
    begin

      rcor:=R2-1/2*(R2-R)*(1+Cos(StepCos*i));

              {-- Sforamento --}

    if R2>R then
      begin
      angpr:=abs(StepAng*i);
      if angpr<PI/2-0.1 then
      if rcor > R/cos(angpr) then rcor:=R/cos(angpr);
      end
    else
      begin
      angpr:=abs(StepAng*(ndiv-i));
      if angpr<PI/2-0.1 then
      if rcor > R2/cos(angpr) then rcor:=R2/cos(angpr);
      end;
      xcor:=X1+rcor*Cos(x2+StepAng*i);
      ycor:=Y1+rcor*Sin(x2+StepAng*i);
      xcor:=xcor;
      ycor:=ycor;
      real1:=xcor-A0X;
      real2:=ycor-A0Y;
      buf1.tipo:='L';

      with buf1.linea do
      begin
        mov:='0';
        x  :=round(real1*fs);
        y  :=round(real2*fs);
      end;

      write(f,buf1);
         {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;

      XPr:=XCor;
      YPr:=YCor;
    end;
  end;
end;



     {+++++++++++++ PLTIZZA +++++++++++++++++++}
procedure plTizza(sp,dim:integer;fs:real;nome:string);
TYpe PltCTQuo =record
                estensio : string[4];
                valore   : Char;
                colore   : integer;
                stile    : integer;
               end;


{ Const UZ   ='PZ';}
 VAR   FC,FCT,FQ:fdimrecdis;
    {   fqq : file of qdimrecdis;}
       qbuf: {q}dimrecdis;
       Precz1,precz2 : integer;
       Prectz1,prectz2 : integer;
       Preclqz1,preclqz2 : integer;
       Precqz1,precqz2 : integer;
       contq :integer;
       PCQ      :array[1..3] of PltCtQuo;
       i        :integer ;

 Procedure Mettiz(var f:fdimrecdis;var cprecz1,cprecz2:integer);
 var  Iz1,Iz2 : integer;
    {  bufz    : dimrecdis;}
  begin
   Iz1:=round(Vettore^.z1);
   Iz2:=round(Vettore^.z2);
   if not ( ( (Iz1=cPrecz1) and (Iz2=cPrecz2) ) or
            ( (Iz1=cPrecz2) and (Iz2=cPrecz1) )
          )
   then
      begin
       buf1.Tipo:='Z';
       with buf1.piano do
       begin
{        mov:='Z';}
        x  :=Iz1;
        y  :=Iz2;
       end;
       write(f,buf1);
          {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;
       cprecz1:=Iz1;
       cprecz2:=Iz2;
      end;
 end;
{ Procedure Mettiqz;

 var  Iz1,Iz2 : integer;
  begin
   Iz1:=round(Vettore^.z1);
   Iz2:=round(Vettore^.z2);
   if not ( ( (Iz1=Precqz1) and (Iz2=Precqz2) ) or
            ( (Iz1=Precqz2) and (Iz2=Precqz1) )
          )
   then
      begin
       qbuf.tipo:='Q';
       qbuf.quota.valore:='ZZZ';
       qbuf.quota.setta :=round(Vettore^.y2);
       qbuf.quota.x:=Iz1;
       qbuf.quota.y:=Iz2;
       write(fqq,qbuf);
       contq:=contq+1;
       If contq=NHPGl Then contq:=0;
       precqz1:=Iz1;
       precqz2:=Iz2;
      end;
 end;}

 Procedure CasoL(var f:fdimrecdis);
 Begin
 {  write(f,'SP',vplot.penne[colp[Vettore^.colore]],';');}
 {  Mettiz(f);}

   real1:=(Vettore^.x1)-A0X;
   real2:=(Vettore^.y1)-A0Y;

   buf1.tipo:='L';
   with buf1.linea do
   begin
    mov:='1';
    x  :=round(real1*fs);
    y  :=round(real2*fs);
   end;

   write(f,buf1);
      {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;

   real3:=(Vettore^.x2)-A0X;
   real4:=(Vettore^.y2)-A0Y;

   buf1.tipo:='L';
   with buf1.linea do
   begin
    mov:='0';
    x  :=round(real3*fs);
    y  :=round(real4*fs);
   end;

   write(f,buf1);
      {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;


 end;

 Procedure CasoF(var f:fdimrecdis) ;
 Begin
{                   mettiz(f,precz1,precz2);}
                   if Vettore^.entita[1]<>'*' then
                   begin

                     k:=0;
     {                write(f,'SP',vplot.penne[colp[Vettore^.colore]],';');}
                     pxi3:=(Vettore^.x1)-A0X;
                     pyi3:=(Vettore^.y1)-A0Y;
                       buf1.tipo:='L';
                    with buf1.linea do
                    begin
                         mov:='1';
                         x  :=round(pxi3*fs);
                         y  :=round(pyi3*fs);
                    end;

                     write(f,buf1);
                        {read(confronto,buf2);}

                     contl:=contl+1;
                     If contl=NHPGl Then contl:=0;

                   end
                   else
                   begin
                     k:=k+1;
                     case k of
                     1,2:begin
                           real1:=(Vettore^.x1)-A0X;
                           real2:=(Vettore^.y1)-A0Y;
                           buf1.tipo:='L';
                           with buf1.linea do
                           begin
                             mov:='0';
                             x  :=round(real1*fs);
                             y  :=round(real2*fs);
                           end;

                           write(f,buf1);
                              {read(confronto,buf2);}

                           contl:=contl+1;
                           If contl=NHPGl Then contl:=0;


                         end;
                       3:begin

                           real1:=(Vettore^.x1)-A0X;
                           real2:=(Vettore^.y1)-A0Y;
                           buf1.tipo:='L';
                           with buf1.linea do
                           begin
                             mov:='0';
                             x  :=round(real1*fs);
                             y  :=round(real2*fs);
                           end;

                           write(f,buf1);
                              {read(confronto,buf2);}

                           contl:=contl+1;
                           If contl=NHPGl Then contl:=0;

                           buf1.tipo:='L';
                           with buf1.linea do
                           begin
                             mov:='0';
                             x  :=round(pxi3*fs);
                             y  :=round(pyi3*fs);
                           end;

                           write(f,buf1);
                              {read(confronto,buf2);}

                           contl:=contl+1;
                           If contl=NHPGl Then contl:=0;

                         end;

                     end;
                   end;
 end;

 Procedure CasoA(var f:fdimrecdis)  ;

 Begin
            {      Mettiz(f);}
                  buf1.tipo:='A';

                  with buf1.arco do
                  begin
                   x:=round(Vettore^.x1-A0X);
                   y:=round(Vettore^.y1-A0Y);
                   raggio:=round(Vettore^.R-A0X);
                   alfa1:=round(Vettore^.x2*180/pi);
                   alfa2:=round(Vettore^.y2*180/pi)-1;
                   if (alfa1>360) then alfa1:=alfa1-360;
                   if (alfa1<-360) then alfa1:=alfa1+360;
                   if (alfa2>360) then alfa2:=alfa2-360;
                   if (alfa2<-360) then alfa2:=alfa2+360;
                   if alfa1<0 then alfa1:=alfa1+360;
                   if alfa2<0 then alfa2:=alfa2+360;
                  end;

                  write(f,buf1);
      {read(confronto,buf2);}

                  contl:=contl+1;
                  If contl=NHPGl Then contl:=0;



 end;

 Procedure CasoC(var f:fdimrecdis)   ;
 Begin

{                  Mettiz(f);}
                  buf1.tipo:='C';

                  with buf1.cerchio do
                  begin
                   x:=round(Vettore^.x1-A0X);
                   y:=round(Vettore^.y1-A0Y);
                   raggio:=round(Vettore^.R-A0X);
                  end;

                  write(f,buf1);
      {read(confronto,buf2);}

                  contl:=contl+1;
                  If contl=NHPGl Then contl:=0;





 end;

BEGIN



  A0X:=22717;
  A0Y:=17937;
  precz1:=0;
  precz2:=0;
  prectz1:=0;
  prectz2:=0;
  preclqz1:=0;
  preclqz2:=0;
  precqz1:=0;
  precqz2:=0;
  a0:=true;

  PCQ[1]. estensio :='.plt';
  PCQ[1]. valore   :='C'   ;
  PCQ[1]. colore   :=Costant^.colcan;
  PCQ[1]. stile    :=1;
  PCQ[2]. estensio :='.QUO';
  PCQ[2]. valore   :='C'   ;
  PCQ[2]. colore   :=Costant^.colQ;
  PCQ[2]. stile    :=1;
  PCQ[3]. estensio :='.CT ';
  PCQ[3]. valore   :='C'   ;
  PCQ[3]. colore   :=Costant^.colcan;
  PCQ[3]. stile    :=2;


  assign(fct,nome+'.CT');
  rewrite(fct);
  assign(fq,nome+'.quo');
  rewrite(fq);




   if Not sezione Then
     begin
       Assign(Fdim,nome+'.dim');
       Reset(Fdim);
       {$IFDEF NEWCR}
       {$ELSE}
       InitPerc(filesize(FDim),1{sizeof(Vettore^)}
                ,w_m(153){'Collegamento tra pezzi rettilinei e pezzi speciali'}
                ,10);
      {$ENDIF}


     {  assign(fqq,nome+'.qqp');
       rewrite(fqq);}
       assign(fc,nome+'.dlp');
       rewrite(fc);
     End
   else
     begin
       Assign(Fdim,nome+'.szz');
       Reset(Fdim);
{       assign(fqq,nome+'.qqs');
       rewrite(fqq);}
       assign(fc,nome+'.dls');
       rewrite(fc);
     End;

      contq := 0;
      contl := 0;
{      qbuf.quota.valore:='ZZZ';
       qbuf.quota.setta :=1;
       qbuf.quota.x:=0;
       qbuf.quota.y:=0;
       write(fqq,qbuf);
       contq:=contq+1;
       If contq=NHPGl Then contq:=0;}
       buf1.tipo:='S';
       with buf1.cambia do
         begin
{          mov :=PCQ[1].valore;}
          x   :=PCQ[1].colore;
          y   :=PCQ[1].STILE;
         end;
         write(Fc,buf1);
         {read(confronto,buf2);}
         CONTL:=CONTL+1;
         If ContL=NHPGl Then ContL:=0;
       buf1.tipo:='Z';
       with buf1.piano do
       begin
{        mov:='Z';}
        x  :=0;
        y  :=0;
       end;
       write(fc,buf1);
       write(Fct,buf1);
       write(Fq,buf1);
                {read(confronto,buf2);}

       contl:=contl+3;
       If contl=NHPGl Then contl:=0;



{  Assign(Fdim,nome+'.dim');
  Reset(Fdim);}
  While not(eof(Fdim)) do
   begin
      read(Fdim,Vettore^);
      {$ifdef newcr}
      {$ELSE}
      Percentu;
      {$ENDIF}
      Case Vettore^.Entita[1] of
       'L':begin
            if (Vettore^.colore=Costant^.colcan) and (Vettore^.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoL(FC)
                 end
            else if Vettore^.colore=Costant^.colq
                 then begin mettiz(fq,preclqz1,preclqz2);
                            CasoL(Fq)
                      end
                  else if (Vettore^.colore=Costant^.colcan)
                       then begin mettiz(fct,prectz1,prectz2);
                                   CasoL(Fct);
                            end;
           end;

   'F','*':begin
            if (Vettore^.colore=Costant^.colcan) and (Vettore^.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoF(FC)
                 end
            else if Vettore^.colore=Costant^.colq
                 then begin mettiz(fq,preclqz1,preclqz2);
                            CasoF(Fq)
                      end
                  else if (Vettore^.colore=Costant^.colcan)
                       then begin mettiz(fct,prectz1,prectz2);
                                   CasoF(Fct);
                            end;
           end;

      'A':begin
           if (Vettore^.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoA(FC)
                 end
            else begin mettiz(fct,prectz1,prectz2);
                       CasoA(FCT);
                 end;
          end;

      'C':begin
           if (Vettore^.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoC(FC)
                 end
            else begin mettiz(fct,prectz1,prectz2);
                       CasoC(Fct);
                 end;
          end;

      'P':begin
           if (Vettore^.tlinea=1)
            then begin mettiz(FC,precz1,precz2); PArcP(FC,fs) end
            else begin mettiz(FCT,prectz1,prectz2); PArcP(FCT,fs) end;
          end;

      'Q':begin
                    mettiz(fq,preclqz1,preclqz2);
                    {mettiqz;}
                    qbuf.tipo:='Q';
                    with qbuf.quota do
                    begin
                    valore:=outtextN(Vettore^.r,Vettore^.x2);
                    setta :=round(Vettore^.y2);
                    x:=round((Vettore^.x1)-A0X);
                    y:=round((Vettore^.y1)-A0Y);
                    write(fq,qbuf);
                    contq:=contq+1;
                    If contq=NHPGl Then contq:=0;
                    end;
                {   mettiz(fq);
                   st1:=outtextN(Vettore^.r,Vettore^.x2);
                   s_String(fq,st1,Vettore^.x1,Vettore^.y1,round(Vettore^.y2),
                            Costant^.altQuo*40,dim,fs);}

          end;
   END;
 end;
{       qbuf.quota.valore:='ZZZ';
       qbuf.quota.setta :=0;
       qbuf.quota.x:=0;
       qbuf.quota.y:=0;
 WHILE contq MOD nhpgl <>0 DO
    BEGIN
    contq:=contq+1;
    write(fqq,qbuf);
    END;}

  close(fdim);
  close(FCT);
  close(FQ);
 { close(FQq);}

{================================}
for i:= 2 to 3  do
 begin
{  If exist(DataDrive+NomeProg+PCQ[i]. estensio)
  then begin  }
       Assign(fct,DriveProg+NomeProg+PCQ[i]. estensio);
       reset(fct);
       buf1.tipo:='S';
       with buf1.cambia do
         begin
{          mov :=PCQ[i].valore;}
          x   :=PCQ[i].colore;
          y   :=PCQ[i].STILE;
         end;
       write(Fc,buf1);
       CONTL:=CONTL+1;
       If ContL=NHPGl Then ContL:=0;
       While not eof(Fct) do
       Begin
        Read(Fct,buf1);
        Write(Fc,Buf1);
       end;
       Close(fct);
       Erase(fct);
  {    end
  else Begin  CLose(FDis); halt;  end;}

 end;


   buf1.tipo:='Z';
   with buf1.piano do
   begin
{    mov:='Z';}
    x  :=0;
    y  :=0;
   end;

 WHILE (contl+contq) MOD nhpgl <>0 DO
    BEGIN
    contl:=contl+1;
    write(fc,buf1);
    END;

{  write(fC,U,P,'0;');
  write(fCt,U,P,'0;');
  write(fq,U,P,'0;');}
  close(FC);
{  close(confronto);}

(*  dispose(ind);
  dispose(linech);*)
END;

end.

