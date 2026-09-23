{$A+,B-,D+,E-,F+,I+,L+,N-,O+,R+,S+,V+}

{$C DEMANDLOAD}
unit dimplt;

interface

uses definiz,angoli,genproc,globfunz,diseg,esiste,percento;


procedure plTizza(sp,dim:integer;fs:real;nome:string);


implementation

type dimrecdis=record mov:char;x,y:integer end;
  {   dimrecdisV=array[1..nhpgl]of dimrecdis;}

type qdimrecdis = record
                   setta :integer;
                   x,y   :integer;
                   valore:string[10];
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

{************************** arcptl ***********************************}
procedure arcplt(var f:fdimrecdis; xa1,ya1,ang1,ang2,r:real;tr:boolean;
                     dim:integer;fs:real);
const raggio=1200;
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





{************************** PARCP ****************************}

Procedure PArcP(var F:fdimrecdis; fs :real);

const Ndiv=20;
var i:integer;
    angpr,xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
begin
  with Vettore Do
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

    with buf1 do
    begin
    mov:='1';
    x  :=round(real1*fs);
    y  :=round(real2*fs);
    end;

    write(f,buf1);
       {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;
    (*converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);*)
   { write(f,u,a,round(real1*fs),',',round(real2*fs),';');}


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
      with buf1 do
      begin
        mov:='0';
        x  :=round(real1*fs);
        y  :=round(real2*fs);
      end;

      write(f,buf1);
         {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;
      (*converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);*)
{      write(f,a,round(real1*fs),',',round(real2*fs),';');}
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


 Const UZ   ='PZ';
 VAR   FC,FCT,FQ:fdimrecdis;
       fqq : file of qdimrecdis;
       qbuf: qdimrecdis;
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
   Iz1:=round(Vettore.z1);
   Iz2:=round(Vettore.z2);
   if not ( ( (Iz1=cPrecz1) and (Iz2=cPrecz2) ) or
            ( (Iz1=cPrecz2) and (Iz2=cPrecz1) )
          )
   then
      begin
       with buf1 do
       begin
        mov:='Z';
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
 Procedure Mettiqz;

 var  Iz1,Iz2 : integer;
  begin
   Iz1:=round(Vettore.z1);
   Iz2:=round(Vettore.z2);
   if not ( ( (Iz1=Precqz1) and (Iz2=Precqz2) ) or
            ( (Iz1=Precqz2) and (Iz2=Precqz1) )
          )
   then
      begin
       qbuf.valore:='ZZZ';
       qbuf.setta :=round(vettore.y2);
       qbuf.x:=Iz1;
       qbuf.y:=Iz2;
       write(fqq,qbuf);
       contq:=contq+1;
       If contq=NHPGl Then contq:=0;
       precqz1:=Iz1;
       precqz2:=Iz2;
      end;
 end;

 Procedure CasoL(var f:fdimrecdis);
 Begin
 {  write(f,'SP',vplot.penne[colp[vettore.colore]],';');}
 {  Mettiz(f);}

   real1:=(Vettore.x1)-A0X;
   real2:=(Vettore.y1)-A0Y;

   with buf1 do
   begin
    mov:='1';
    x  :=round(real1*fs);
    y  :=round(real2*fs);
   end;

   write(f,buf1);
      {read(confronto,buf2);}

       contl:=contl+1;
       If contl=NHPGl Then contl:=0;

   real3:=(Vettore.x2)-A0X;
   real4:=(Vettore.y2)-A0Y;

   with buf1 do
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
                   if vettore.entita[1]<>'*' then
                   begin

                     k:=0;
     {                write(f,'SP',vplot.penne[colp[vettore.colore]],';');}
                     pxi3:=(Vettore.x1)-A0X;
                     pyi3:=(Vettore.y1)-A0Y;

                    with buf1 do
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
                           real1:=(Vettore.x1)-A0X;
                           real2:=(Vettore.y1)-A0Y;

                           with buf1 do
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

                           real1:=(Vettore.x1)-A0X;
                           real2:=(Vettore.y1)-A0Y;

                           with buf1 do
                           begin
                             mov:='0';
                             x  :=round(real1*fs);
                             y  :=round(real2*fs);
                           end;

                           write(f,buf1);
                              {read(confronto,buf2);}

                           contl:=contl+1;
                           If contl=NHPGl Then contl:=0;


                           with buf1 do
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


                  real1:=((Vettore.x1)-A0X);
                  real2:=((Vettore.y1)-A0Y);
                  real3:=((Vettore.R));
                  real4:=(Vettore.x2);
                  real5:=(Vettore.y2);
                  arcplt(f,real1,real2,real4,real5,real3,false,dim,fs);
 end;

 Procedure CasoC(var f:fdimrecdis)   ;
 Begin
{                  Mettiz(f);}


                  real1:=(Vettore.x1)-A0X;
                  real2:=(Vettore.y1)-A0Y;
                  real3:=(Vettore.R);
                  real4:=0;
                  real5:=2*pi;
                  arcplt(f,real1,real2,real4,real5,real3,false,dim,fs);
 end;

BEGIN

{__________ prova_____________}
{assign(Confronto,'tumma.dlp');
reset(Confronto);}

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
  PCQ[1]. colore   :=Costant.colcan;
  PCQ[1]. stile    :=1;
  PCQ[2]. estensio :='.QUO';
  PCQ[2]. valore   :='C'   ;
  PCQ[2]. colore   :=Costant.colQ;
  PCQ[2]. stile    :=1;
  PCQ[3]. estensio :='.CT ';
  PCQ[3]. valore   :='C'   ;
  PCQ[3]. colore   :=Costant.colcan;
  PCQ[3]. stile    :=2;


  {write(fc,UZ,Precz1,',',Precz2);}
  assign(fct,nome+'.CT');
  rewrite(fct);
  assign(fq,nome+'.quo');
  rewrite(fq);



 { FileTraduz:='DUCT';}

   if Not sezione Then
     begin
       Assign(Fdim,nome+'.dim');
       Reset(Fdim);
       InitPerc(filesize(FDim),1{sizeof(vettore)}
                ,w_ m(150){'Collegamento tra pezzi rettilinei e pezzi speciali'}
                ,10);
       assign(fqq,nome+'.qqp');
       rewrite(fqq);
       assign(fc,nome+'.dlp');
       rewrite(fc);
     End
   else
     begin
       Assign(Fdim,nome+'.szz');
       Reset(Fdim);
       assign(fqq,nome+'.qqs');
       rewrite(fqq);
       assign(fc,nome+'.dls');
       rewrite(fc);
     End;

      contq := 0;
      contl := 0;
      qbuf.valore:='ZZZ';
       qbuf.setta :=1;
       qbuf.x:=0;
       qbuf.y:=0;
       write(fqq,qbuf);
       contq:=contq+1;
       If contq=NHPGl Then contq:=0;

       with buf1 do
         begin
          mov :=PCQ[1].valore;
          x   :=PCQ[1].colore;
          y   :=PCQ[1].STILE;
         end;
         write(Fc,buf1);
         {read(confronto,buf2);}
         CONTL:=CONTL+1;
         If ContL=NHPGl Then ContL:=0;

       with buf1 do
       begin
        mov:='Z';
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
      read(Fdim,Vettore);
      Percentu;
      Case Vettore.Entita[1] of
       'L':begin
            if (vettore.colore=costant.colcan) and (vettore.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoL(FC)
                 end
            else if vettore.colore=costant.colq
                 then begin mettiz(fq,preclqz1,preclqz2);
                            CasoL(Fq)
                      end
                  else if (vettore.colore=costant.colcan)
                       then begin mettiz(fct,prectz1,prectz2);
                                   CasoL(Fct);
                            end;
           end;

   'F','*':begin
            if (vettore.colore=costant.colcan) and (vettore.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoF(FC)
                 end
            else if vettore.colore=costant.colq
                 then begin mettiz(fq,preclqz1,preclqz2);
                            CasoF(Fq)
                      end
                  else if (vettore.colore=costant.colcan)
                       then begin mettiz(fct,prectz1,prectz2);
                                   CasoF(Fct);
                            end;
           end;

      'A':begin
           if (vettore.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoA(FC)
                 end
            else begin mettiz(fct,prectz1,prectz2);
                       CasoA(FCT);
                 end;
          end;

      'C':begin
           if (vettore.tlinea=1)
            then begin mettiz(fc,precz1,precz2);
                       CasoC(FC)
                 end
            else begin mettiz(fct,prectz1,prectz2);
                       CasoC(Fct);
                 end;
          end;

      'P':begin
           if (vettore.tlinea=1)
            then begin mettiz(FC,precz1,precz2); PArcP(FC,fs) end
            else begin mettiz(FCT,prectz1,prectz2); PArcP(FCT,fs) end;
          end;

      'Q':begin
                    mettiqz;
                    qbuf.valore:=outtextN(vettore.r,vettore.x2);
                    qbuf.setta :=round(vettore.y2);
                    qbuf.x:=round((Vettore.x1)-A0X);
                    qbuf.y:=round((Vettore.y1)-A0Y);
                    write(fqq,qbuf);
                    contq:=contq+1;
                    If contq=NHPGl Then contq:=0;
                {   mettiz(fq);
                   st1:=outtextN(vettore.r,vettore.x2);
                   s_String(fq,st1,vettore.x1,vettore.y1,round(vettore.y2),
                            costant.altQuo*40,dim,fs);}

          end;
   END;
 end;
       qbuf.valore:='ZZZ';
       qbuf.setta :=0;
       qbuf.x:=0;
       qbuf.y:=0;
 WHILE contq MOD nhpgl <>0 DO
    BEGIN
    contq:=contq+1;
    write(fqq,qbuf);
    END;

  close(fdim);
  close(FCT);
  close(FQ);
  close(FQq);

{================================}
for i:= 2 to 3  do
 begin
{  If exist(DataDrive+NomeProg+PCQ[i]. estensio)
  then begin  }
       Assign(fct,DataDrive+NomeProg+PCQ[i]. estensio);
       reset(fct);
       with buf1 do
         begin
          mov :=PCQ[i].valore;
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



   with buf1 do
   begin
    mov:='Z';
    x  :=0;
    y  :=0;
   end;

 WHILE contl MOD nhpgl <>0 DO
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

