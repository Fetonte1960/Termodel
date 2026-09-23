
unit Load_p;

INTERFACE

uses sysutils,varcarichi,definiz,definizcan,dummyfunction,globfunzcan,genproccan,Angoli,{Gruti,halotp4,graph,Ridis_U,}
     {ImpTerm,}WM{,diseg,esiste,controll,WINPROCS,def_win,utilitie,defuti,inituti };

Procedure IterLoad(tr:integer;Var LungMax:real;Var TipoC:char;C_Tutti:boolean;UltDir:real);



{---------------------------------------------------------------------------}
implementation


Type LM=Array[1..3] of real;
     TCT=Array[1..3] of char;
Var  V_usc:RecVert;
     inverti:boolean;
     Errore:string;
     portdef,perdDef:real;
     portst,perdSt :string;

{***************************  TrovaPerd        *******************************}

Procedure TrovaPerd(tr,col:integer;segna:boolean;lungm:Lm;CT:TCT;Var LtTronco:real;Var TCAn:char;Ultdir:real);

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CodAng          *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function CodAng(Var ValA:Real;Curva:boolean):String;

var Codice:string;
    Coderr:integer;
    Diff,ang1,ang:real;

begin

if ValA>pi then ValA:=-(2*pi-ValA);
if ValA<-pi then ValA:=(2*pi+ValA);
if ValA<0 then ValA:=-ValA;

ang:=ValA;

ang1:=pi/9;
diff:=abs(ang-ang1);
if (abs(ang-pi/12)<diff)and(not(curva)) then
  begin
  ang1:=pi/12;
  diff:=abs(ang-ang1);
  end;
if abs(ang-pi/6)<diff then
  begin
  ang1:=pi/6;
  diff:=abs(ang-ang1);
  end;
if abs(ang-pi/4)<diff then
  begin
  ang1:=pi/4;
  diff:=abs(ang-ang1);
  end;
if abs(ang-pi/3)<diff then
  begin
  ang1:=pi/3;
  diff:=abs(ang-ang1);
  end;
if abs(ang-5*pi/12)<diff then
  begin
  ang1:=5*pi/12;
  diff:=abs(ang-ang1);
  end;
if abs(ang-pi/2)<diff then
  begin
  ang1:=pi/2;
  diff:=abs(ang-ang1);
  end;

ang:=ang1;

ValA:=ValA*180/pi;

Ang:=Ang*180/pi;
str(Ang:2:0,codice);

codice:=setleft(codice);
Codice:=Copy(codice,1,1);
CodAng:=Codice;
end;

{+-+-+-+-+-+-+-+-+-+-+-+-+-+-  Ex_Tappo     +-+-+-+-+-+-+-+-+-+-+-+-+}

Function Ex_Tappo(Tronco:integer):Integer;

var Tappo:integer;
    ind,indprec,Orient:integer;
    Dir,DirZ:real;
    Vert:Boolean;

begin
Tappo:=0;
if Dati^[tronco]^.pros[1]=0 then
  begin
  indprec:=dati^[tronco]^.Ti;
  ind:=Dis^[indprec]^.Nlinea;

  While Ind<>0 do
    begin
    if Dis^[ind]^.Nlinea=0 then
      begin
      CalcAng(IndPrec,ind,Dir,DirZ,orient,Vert,0);
      if (Ug(Abs(Dir),Pi/2,1))or(Ug(Abs(DirZ),Pi/2,1)) then Tappo:=Ind;
      end;


    IndPrec:=Ind;
    ind    :=Dis^[ind]^.Nlinea;

    end;
  end;

Ex_Tappo:=Tappo;

end;


{+-+-+-+-+-+-+-+-+-+-+-+-+-+-  Main  Loadpezzi     +-+-+-+-+-+-+-+-+-+-+-+-+}

var i,j,k,l,np,conta,iprec      :integer;
    trovato,Dev,CanVert,inverti :boolean;
    ang1,angar                  :real;
    Vert,Orto                   :Boolean;
    Vert1                       :recvert;
    Dirz,UltAng,rapp            :real;
    Orient,Main,Br1,Br2,IndTappo:integer;
    TipoC,TipoC1,indDer         :integer;
    DirBr,DirBrZ                :array[1..3] of real;
    LTronco                     :real;
    Main_VD                     :boolean;
    UltDir1                     :real;
    Err1,st1                        :String;


var CodTub,CodTub1,Trasf,prosPez:string;
    ProsRag,angloc:real;
    fb:text;
    bb:boolean;

Function flessibile(Bocchetta:string):Boolean;
begin
Flessibile:=(Upstring(Bocchetta)='05SC')or(Upstring(Bocchetta)='05TC');
end;

begin


Err1:='';
Main_VD:=false;
inverti:=false;

    {-- Creazione tratto 0 --}

if Dati^[tr]^.Pezzi[0]=0 then
  begin
  Dati^[tr]^.Pezzi[0]:=NewPezzo;
  end;

InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[0]]^);
{fillchar(VPezzi^[Dati^[tr]^.Pezzi[0]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[0]]^),0);}

    {-- Individua il tipo di circuito --}

{M}if upcase(conf^.manRip[1])=CH40 then
TipoC:=1
else TipoC:=3;

TipoC1:=TipoC;    { serve nei terminali }

if Dati^[tr]^.Pros[1]=0 then  {-- Terminale --}
  begin
  IndTappo:=Ex_Tappo(Tr);
  i:=dati^[tr]^.ti;
  while Dis^[i]^.Nlinea <>0 do i:=Dis^[i]^.Nlinea;

  if (Dis^[i]^.X1=Dis^[i]^.X2)and(Dis^[i]^.Y1=Dis^[i]^.Y2) then {-- Bocc Vert --}
    begin
{R}    if upcase(conf^.BocVert.TipoBoc[1])=CH43 then TipoC1:=TipoC1+1;
    vert:=true;
    end
  else
    begin
{R}    if upcase(conf^.BocOriz.TipoBoc[1])=CH43 then TipoC1:=TipoC1+1;
    Vert:=false;
    end
  end
else
  begin
  IndTappo:=0;
{R}  if UpCase(conf^.CircRet[1])=CH43 then TipoC1:=TipoC1+1;
  end;

{R}if UpCase(conf^.CircRet[1])=CH43 then TipoC:=TipoC+1;

if IndTappo=0 then TipoC:=TipoC1;

  case TipoC of
  1,3:begin
      CodTub:='310C';
{C}      TCan:=CH42;
      end;
  2,4:begin
      CodTub:='310R';
{R}      TCan:=CH43;
      end
  end;

 if (Dati^[tr]^.Pros[1]=0)and(indtappo=0)and(Flessibile(conf^.Bocoriz.codboc[TipoC1]))
 then CodTub:='310F';

  case TipoC1 of
  1,3:if Flessibile(conf^.Bocoriz.codboc[TipoC1]) then CodTub1:='310F'
      else CodTub1:='310C';
  2,4:CodTub1:='310R';
  end;


        {-- Stacchi definiti a valle --}

ProsPez:='';
for i:=1 to 3 do
if prospez='' then
if Dati^[tr]^.pros[i]<>0 then
if Dati^[Dati^[tr]^.pros[i]]^.Pezzi[0]<>0 then
if VPezzi^[Dati^[Dati^[tr]^.pros[i]]^.Pezzi[0]]^.Codice<>'' then
if VPezzi^[Dati^[Dati^[tr]^.pros[i]]^.Pezzi[0]]^.Codice<>'     ' then
  begin
  ProsPez:=VPezzi^[Dati^[Dati^[tr]^.pros[i]]^.Pezzi[0]]^.Codice;
  Prosrag:=VPezzi^[Dati^[Dati^[tr]^.pros[i]]^.Pezzi[0]]^.Rag;
  prospez:=SetLeft(ProsPez);
  end;

np:=0;
conta:=0;
ltronco:=0;
LTTronco:=0;
i:=dati^[tr]^.ti;
while i<>0 do
  begin
    case dis^[i]^.entita[1] of
    'L':begin
          conta:=conta+1;
          Dis^[i]^.NPezzo:=0;
        end;
    end;
  if (conta>1)and(dis^[i]^.entita[1]='L')then
    begin
    CalcAng(iprec,i,ang1,DirZ,orient,Vert,UltDir1);
    if Not((UG(ang1,0,1)and(UG(Dirz,0,1))))or(Dis^[iprec]^.Rid<>'')then
      begin
      if ltronco>0 then
        begin
        np:=np+1;
        if Err1='' then Err1:=NuovoPezzo(tr,np);
        if Err1='' then
          begin
          InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[np]]^);
          {fillchar(VPezzi^[Dati^[tr]^.Pezzi[np]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[np]]^),0);}
          with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
            begin
            Codice:=codtub;
            lung  :=Ltronco;
            LTTronco:=LTTronco+LTronco;
            Ltronco:=0;
            
            //A:=0;
            A:=400;
            end
          end;
        end;

      np:=np+1;

      if Err1='' then Err1:=NuovoPezzo(tr,np);
      if Err1='' then
        begin
        InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[np]]^);
   {     fillchar(VPezzi^[Dati^[tr]^.Pezzi[np]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[np]]^),0);}
        if Dis^[iprec]^.Rid='' then

          begin

          {-- Calcolo Angolo Curva --}
          //mette comunque i dati della curva (diego 2006)
          with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
            begin

            end;
           { TODO -oDiego -cNavigazione canali : lavoro qui }
          with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
          //if (IndTappo<>i) Then
            begin
            bb:=UG(Ang1,0,1);
            if bb then angloc:=Dirz
            else angloc:=ang1;
            Codice:=CodAng(angloc,true);
            Codice:=Copy(conf^.curve[TipoC],1,2)+Codice+Copy(conf^.curve[TipoC],4,4);
            VPezzi^[Dati^[tr]^.Pezzi[np]]^.Ang:=angloc;
            //assign(fb,'pippo.sce');
            //rewrite(fb);
            //writeln(fb,conf^.curve[TipoC]);
            //close(fb);
            if riDuz^.RagCurv > 0 then Rag:=riDuz^.RagCurv
            else Rag:=1;
            end;
          //else  { C'e unTappo }
           with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
           if (IndTappo=i) Then
            begin
                   {-- Circ -> Circ --}

            if (tipoC=1)and((CodTub1='310C')or(CodTub1='310F')) Then Codice:='11CAT';
            if (tipoC=3)and((CodTub1='310C')or(CodTub1='310F')) Then Codice:='11CBT';

                   {-- Rett -> Rett --}

            if (tipoC=2)and(CodTub1='310R') Then Codice:='10RAT';
            if (tipoC=4)and(CodTub1='310R') Then Codice:='10RBT';

                   {-- Circ -> Rett --}

            if (tipoC=1)and(CodTub1='310R') Then Codice:='336F';
            if (tipoC=3)and(CodTub1='310R') Then Codice:='328F';

                   {-- Rett -> Circ --}

            if (tipoC=2)and((CodTub1='310C')or(CodTub1='310F')) Then Codice:='11RAT';
            if (tipoC=4)and((CodTub1='310C')or(CodTub1='310F')) Then Codice:='11RBT';

            CodTub:=CodTub1;
            TipoC :=TipoC1;

            end;
          end
        else VPezzi^[Dati^[tr]^.Pezzi[np]]^.Codice:=Dis^[iprec]^.Rid;

        end;


      Dis^[iprec]^.NPezzo:=np
      end;

    end;
  if dis^[i]^.Entita='L' then
  ltronco:=ltronco+
  sqrt(sqr(dis^[i]^.y2-dis^[i]^.y1)+
       sqr(dis^[i]^.x2-dis^[i]^.x1)+
       sqr(dis^[i]^.z2-dis^[i]^.z1))*
  conf^.Altnum/40000;
  iprec:=i;
  i:=dis^[i]^.nlinea;

  end; {-- While --}

if ltronco>0 then
            begin

            np:=np+1;
            if Err1='' then Err1:=NuovoPezzo(tr,np);
            if Err1='' then
              begin
              InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[np]]^);
             { fillchar(VPezzi^[Dati^[tr]^.Pezzi[np]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[np]]^),0);}
              with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
                begin
                Codice:=codtub;
                lung  :=Ltronco;
                LTTronco:=LTTronco+LTronco;
                
                //A:=0;
                A:=400;
                Ltronco:=0;
                end
              end
            end;

np:=np+1;
Dis^[iprec]^.NPezzo:=NP;

if Err1='' then Err1:=NuovoPezzo(tr,np);
if Err1='' then
  begin

  if Dati^[tr]^.pros[1]=0 then
    begin
    if Dati^[tr]^.Pezzi[np]=0 then Dati^[tr]^.Pezzi[np]:=NewPezzo;
    InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[np]]^);
    {fillchar(VPezzi^[Dati^[tr]^.Pezzi[np]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[np]]^),0);}
    with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
      begin
      if Vert then Codice:=conf^.BocVert.CodBoc[TipoC]
      else Codice:=conf^.BocOriz.CodBoc[TipoC];
      Perd:=perddef;
      Port:=portdef;
      end
    end
  else
    begin

    if Dati^[tr]^.Pezzi[np]=0 then Dati^[tr]^.Pezzi[np]:=NewPezzo;
    InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[np]]^);
    {fillchar(VPezzi^[Dati^[tr]^.Pezzi[np]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[np]]^),0);}

    ultAng:=0;
    Orient:=0;
    Vert:=False;

    for k:=1 to 3 do
    if Dati^[tr]^.pros[k]<>0 then
    CalcAng(iprec,Dati^[Dati^[tr]^.pros[k]]^.Ti,DirBr[k],DirBrZ[k],Orient,Vert,UltAng);


    if Dati^[tr]^.pros[3]=0 then  {-- TEE --}
      begin
      SETBRANCH(iprec,2,Main,Br1,Br2,Orient,Vert1,UltDir,Inverti,V_Usc,Main_VD);

              {-- Derivazioni Trasformate --}

{C}      if (UpString(CodTub)='310R')and(Ct[Br1]=CH42) then
        begin
{M}        if Upstring(conf^.Manrip)=CH40 then Trasf:='11RA'
        else Trasf:='11RB'
        end
      else
        begin
{R}        if ( (UpString(CodTub)='310C')or(UpString(CodTub)='310F') ) and(Ct[Br1]=CH41) then
          begin
{M}          if Upstring(conf^.Manrip)=CH40 then Trasf:='13CA'
          else Trasf:='13CB'
          end
        else
          begin
          Trasf:='';
          end
        end;

      if prospez<>'' then
        begin
        VPezzi^[Dati^[tr]^.Pezzi[np]]^.Codice:=ProsPez;
        VPezzi^[Dati^[tr]^.Pezzi[np]]^.Rag:=ProsRag;
        end
      else
        begin
        if Lungm[br1]<>0 then
        Rapp:=Lungm[Main]/Lungm[br1]
        else Rapp:=10E6;
        IndDer:=1;
        Trovato:=false;

        orto:=false;
          if ug(DirBrZ[br1],0,1) then
            begin
            ang1:=DirBr[br1];
            if (ug(abs(DirBr[br1]),Pi/2,1)) then orto:=true
            end
          else
            begin
            ang1:=DirBrZ[br1];
            if (ug(abs(DirBrZ[br1]),Pi/2,1)) then orto:=true
            end;

        if (Ug(DirBr[Main],0,1))and(Ug(DirBrZ[Main],0,1)) then {- Diramazione -}
          begin


          if orto then
            begin
            if riDuz^.RagStac > 0 then VPezzi^[Dati^[tr]^.Pezzi[np]]^.Rag:=riDuz^.RagStac
            else VPezzi^[Dati^[tr]^.Pezzi[np]]^.Rag:=1;
            if trasf<>'' then VPezzi^[Dati^[tr]^.Pezzi[np]]^.Codice:=Trasf
            else
              begin

              while not(trovato) do
                begin
                if IndDer=3 then trovato:=true
                else
                if (conf^.Br90[indDer+1].RapLung>Rapp)or
                   (conf^.Br90[indDer+1].RapLung=0) then Trovato:=true;

                if not(trovato) then IndDer:=IndDer+1;
                end;

              VPezzi^[Dati^[tr]^.Pezzi[np]]^.Codice:=conf^.Br90[indDer].CodCan[TipoC];
              end
            end
          else
            begin
            while not(trovato) do
                begin
                if IndDer=3 then trovato:=true
                else
                if (conf^.BrD90[indDer+1].RapLung>Rapp)or
                   (conf^.BrD90[indDer+1].RapLung=0) then Trovato:=true;
                if not(trovato) then IndDer:=IndDer+1;
                end;
            with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
              begin
              Codice:=conf^.BrD90[IndDer].CodCan[TipoC];
              ang:=ang1;
              St1:=CodAng(ang,false);
              if riDuz^.RagStac > 0 then Rag:=riDuz^.RagStac
              else Rag:=1;
              end;
            end
          end
        else
          begin
          with VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
            begin
            Codice:=conf^.TEE[TipoC];
            ang:=ang1;
            St1:=CodAng(ang,false);
            if (NOT (ug(ang,90,1)))and(TipoC IN [2,4]) then Codice:='3734R'
            else
              begin
              if riDuz^.RagTee > 0 then Rag:=riDuz^.RagTee
              else Rag:=1;
              end;
            end;
          end
        end
      end
    else
      begin

      SETBRANCH(iprec,3,Main,Br1,Br2,Orient,Vert1,UltDir,Inverti,V_usc,Main_VD);

      if prospez<>'' then VPezzi^[Dati^[tr]^.Pezzi[np]]^.Codice:=ProsPez
      else
        begin
        orto:=false;
        if ug(DirBrZ[br1],0,1) then
          begin
          ang1:=DirBr[br1];
          if (ug(abs(DirBr[br1]),Pi/2,1)) then orto:=true
          end
        else
          begin
          ang1:=DirBrZ[br1];
          if (ug(abs(DirBrZ[br1]),Pi/2,1)) then orto:=true
          end;

        if orto then
          begin
          VPezzi^[Dati^[tr]^.Pezzi[np]]^.Codice:=conf^.Croce[TipoC];
          if riDuz^.RagStac > 0 then VPezzi^[Dati^[tr]^.Pezzi[np]]^.Rag:=riDuz^.RagStac
          else VPezzi^[Dati^[tr]^.Pezzi[np]]^.Rag:=1;
          end
        else
          begin
          With VPezzi^[Dati^[tr]^.Pezzi[np]]^ do
            begin
            If CodTub='310R' then
            Codice:='3735R'
            else Codice:='3735C';
            ang:=Ang1;
            St1:=CodAng(ang,false);
            end
          end;
        end

      end;

    end

  end

else
  begin
  if (errore='') and (err1<>'') then
    begin
    errore:=err1;
    write(chr(7));
    Marca(tr,1,False);
    richiesta(errore);
    end;
  for i:=0 to PezziTr do
    begin
    if Dati^[tr]^.Pezzi[i]<>0 then
      begin
      VPezzi^[Dati^[tr]^.Pezzi[i]]^.Codice:='';
      Dati^[tr]^.Pezzi[i]:=0;
      end;
    end;
  end
end;

{***************************  CancPezzi       *******************************}

Procedure CancPezzi(trn:integer);

var i:integer;

begin
for i:=0 to Pezzitr do
if Dati^[trn]^.Pezzi[i]<>0 then
  begin
  VPezzi^[Dati^[trn]^.Pezzi[i]]^.Codice:='';
  Dati^[trn]^.Pezzi[i]:=0;
  end;

end;

{***************************  Load_Pezzi     *******************************}

Procedure IterLoad(tr:integer;Var LungMax:real;Var TipoC:char;C_Tutti:boolean;UltDir:real);

{+-+-+-+-+-+-+-+-+-+-+-+-+-+-  carica_conf     +-+-+-+-+-+-+-+-+-+-+-+-+}
Procedure carica_conf;
Var ind_tubo:integer;
    codice_t:string;
begin
codice_t:=Uppercase(Dati^[tr]^.Tipo);
Ind_tubo:=1;
while (ind_tubo<Ntipirete)and(codice_t<>tipirete_d^[ind_tubo].Cod)do inc(ind_tubo);
with tipirete_d^[ind_tubo] do
  begin
  conf^.CircRet:=TpTip[1];
  conf^.Bocoriz.TipoBoc:=TpUTOr[1];
  end;
end;

{+-+-+-+-+-+-+-+-+-+-+-+-+-+-  LungTr     +-+-+-+-+-+-+-+-+-+-+-+-+}

Function LungTr(trn:integer):Real;

var i:integer;
    Temp_l:real;

begin
TEmp_l:=0;
i:=Dati^[trn]^.Ti;
repeat
with Dis^[i]^ do
Temp_l:=Temp_l+sqrt(sqr(x2-x1)+sqr(y2-y1)+sqr(z2-z1));
i:=Dis^[i]^.NLinea;
until i=0;
LungTr:=Temp_l;
end;


var i       :integer;
    LungMax1:Lm;
    LTR     :real;
    CT      :TCT;
    Inv     :Boolean;
    stnum   :string[4];

begin
carica_conf;
portdef:=0.1;
perddef:=10;
str(tr:4,stnum);
real1:=1;
real2:=15;
//movtcurabs1(@real1,@real2);
//text1(@stnum);
inv:=False;
Set_Ud(tr,UltDir,Inv);

LungMax:=0;
for i:=1 to 6 do
with Dati^[tr]^ do
if Pros[i]<>0 then
  begin
  IterLoad(Pros[i],LungMax1[i],CT[i],C_Tutti,UltDir);
  if LungMax1[i]>LungMax Then LungMax:=LungMax1[i];
  end;
if Dati^[tr]^.Pezzi[1]<>0 then
  begin
  if C_tutti then
    begin
    CancPezzi(tr);
    TrovaPerd(tr,4,False,LungMax1,CT,LTR,TipoC,UltDir);
    end
  else LTR:=LungTr(tr);
  end
else
  begin
  CancPezzi(tr);
  TrovaPerd(tr,4,False,LungMax1,CT,LTR,TipoC,UltDir);
  end;
LungMax:=LungMax+LTR;
end;

{***************************  LoadBoc     *****************************}

Procedure LoadBoc;

var UltPort,UltPerd,st1:string;
    Cod,Cod1,PosPezzo:integer;
    Trovato:boolean;

begin
UltPort:='';
UltPerd:='';

  repeat
  richiesta(W_M(113)); {'Selezionare Terminale');}
  St1:='';
  //readcord(x,y,cod,scelta,ST1,9);

  if cod<>130 then
    begin
    PosPezzo:=0;
    Trovato:=false;
      repeat
      with Dati^[Dis^[trattosel]^.tronco]^ do
        begin
        PosPezzo:=posPezzo+1;
        if PosPezzo=Pezzitr then trovato:=true
        else if Pezzi[PosPezzo+1]=0 then trovato:=true;
        end
      until Trovato;

      PosPezzo:=Dati^[Dis^[trattosel]^.tronco]^.Pezzi[PosPezzo];

      repeat
      if UnMis=1 then
        begin
        str(VPezzi^[PosPezzo]^.Port:6:3,UltPort);
        //st1:=readCom(W_M(40),UltPort,0); {Portata [mc/s]',UltPort,0);}
        end
      else
        begin
        str(VPezzi^[PosPezzo]^.Port*UnMis:6:1,UltPort);
        //st1:=readCom(W_M(41),UltPort,0); {Portata [mc/h]',UltPort,0);}
        end;
      val(st1,VPezzi^[PosPezzo]^.Port,Cod1);
      VPezzi^[PosPezzo]^.Port:=VPezzi^[PosPezzo]^.Port/UnMis;
      until Cod1=0;


      repeat
      str(VPezzi^[PosPezzo]^.Perd:4:1,UltPerd);
      //st1:=readCom(W_M(42),UltPerd,0); {'Perdita [Pa]'}
      val(st1,VPezzi^[PosPezzo]^.Perd,Cod1);
      until Cod1=0;

    setLcolor(Trattosel);
    //DisBoc(Trattosel);

    end;

  until Cod=130;


end;

{*************************** setdefault ********************************}

procedure setdefault;
var cod1:integer;
    st1:string;
begin

   repeat
   if UnMis=1 then
     begin
     str(portdef:6:4,portst);
     //st1:=readCom(W_M(43),portst,0); {'Portata ai terminali [mc/s]',portst,0);}
     end
   else
     begin
     str(portdef*UnMis:6:1,PortSt);
     //st1:=readCom(W_M(44),PortSt,0); {'Portata ai terminali [mc/h]',PortSt,0);}
     end;

   val(st1,Portdef,Cod1);
   Portdef:=Portdef/UnMis;
   until Cod1=0;

   repeat
   str(PerdDef:4:1,PerdSt);
   //st1:=readCom(W_M(45),Perdst,0); {'Perdita ai terminali [Pa]',Perdst,0);}
   val(st1,PerdDef,Cod1);
   until Cod1=0;

end;



procedure copia2;
Var i,tr:integer;
type   Acati=array[1..pezzitr]of integer;
var  cati:^ACati;
begin
(*
  tr:=Dis^[trattosel]^.tronco;
  for i:=0  to pezzitr do
  if (cati^[i].codice<>'')and(Dati^[tr]^.pezzi[i]<>0) then
    begin
    Vpezzi^[Dati^[tr]^.pezzi[i]]^:=cati^[i];
    Vpezzi^[Dati^[tr]^.pezzi[i]]^.Port:=cati^[i].Port/UnMis;
    end;
 {$ifdef win}
 marca(tr,8,true);
 {$endif}
*)
end;



{*************************** DATITRONCO ********************************}

Procedure datitronco;

type plocrec=record
             n:integer;
             s:string[8];
             end;


var i,campo,chiave,riga,tr,res:integer;
    initmask:boolean;
    ChiediCord:boolean;
    risp,st1:string;
    LMT :real;
    TCR :char;
    LungUsc:LM;
    TUsc   :TCT;
    Redraw :boolean;
    NomeMsk:string;


procedure copia1;
var i:integer;
begin
(*
  for i:=0  to pezzitr do
  if Dati^[tr]^.pezzi[i]<>0 then
    begin
    NumPezzi:=i+1;
    cati^[i]:=Vpezzi^[Dati^[tr]^.pezzi[i]]^;
    cati^[i].Port:=Vpezzi^[Dati^[tr]^.pezzi[i]]^.Port*UnMis;
    end
  else initpezzo(cati^[i]);
*)
  {fillchar(cati^[i],sizeof(cati^[i]),0);}
  {
  i:=Dati^[tr].Ti;
  while i<>0 do
    begin
    writeln(lst,Dis^[i].Npezzo,' ',Dis^[i].Rid);
    i:=dis^[i].NLinea;
    end;
  }
end;




begin
{new(cati^);}
portdef:=0.1;
portst:='';
perddef:=10;
perdst:='';
errore:='';

For i:=1 to 3 do
  begin
  LungUsc[i]:=1;
  TUsc[i]:=' ';
  end;
campo:=1;
chiave:=61;
riga:=1;
initmask:=true;
Redraw:=false;
if UnMis=1 then NomeMsk:='Icona2' else NomeMsk:='Icona2a';

Repeat
//{S} risp:=ReadCom(W_M(46),CH23,0); {'Seleziona tronco / Carica tutti / Aggiorna / Terminali','S',0);}
risp:=upstring(risp);
{S,C,A,T} until   (risp[1] IN [CH23,CH24,CH25,CH26])or(risp='');

if risp='' then chiave:=27
else
  begin

{C,A,T}  if risp[1] IN [CH24,CH25,CH26] then
    begin
    if risp =CH24 then
      begin
      {Write(Chr(7));}
      Repeat
//{N}        risp:=ReadCom(W_M(47),CH2,0); {'Cancello tutti i dati !!! S/N','N',0);}
        risp:=upstring(risp);
{S,N}      until (risp=CH1)or(risp=CH2)or(risp='');
{S}      if risp=CH1 then

        begin
        setdefault;
        richiesta(''); {'Caricamento Pezzi in corso');}
        IterLoad(RisultCalc^.Origine,LMT,TCR,true,0);
        if errore='' then
          begin
          //Errore:=assegnacod;
          if errore='' then richiesta('');
          end;
        end;
      end
    else
      begin
{A}      if Risp=CH25 then
        begin
        setdefault;
        richiesta(W_M(48)); {'Caricamento Pezzi in corso');}
        IterLoad(RisultCalc^.Origine,LMT,TCR,False,0);
        {$IFDEF NEWCR}
       { Minicalcolo;}
        {$ENDIF}

        if errore='' then
        begin
          //Errore:=assegnacod;
          if errore='' then richiesta('');
          end;
        end
      else
        begin
        LoadBoc;
        end;

      end;
    chiave:=27;
    end
  else
    begin
    real1:=0;real2:=80;real3:=900;real4:=750;
    //setclip(@real1,@real2,@real3,@real4);
    end
  end;

//Max_WX:=883;

repeat

 case chiave of

 61:begin

    {delay(400);}
    //Cod:=SelezLinea(Linesel);
    trattosel:=linesel;
    if Cod<>130 then
      begin
      Redraw:=true;
      with Dis^[Linesel]^ do
      tr:=tronco;
      marca(tr,1,false);
      real1:=0;real2:=0;real3:=1000;real4:=750;
      //setclip(@real1,@real2,@real3,@real4);
      //ntronco:=tr;
      st1:='';
      //delbox;
      {if dati^[tr].Pezzi[1]=0 then TrovaPerd(tr,4,False,LungUsc,TUsc,LMT,TCR,0);}
      if dati^[tr]^.Pezzi[1]=0 then IterLoad(RisultCalc^.Origine,LMT,TCR,False,0);
      if errore='' then
        begin
        copia1;
         {$ifdef win}
        If Uti_Primavolta and not dueres then
        begin
          initproc;
          procarr[1]:=copia2;
          Uti_Primavolta:=false;
          iconat:=true;
          posx:=larg_scheda-120;
          posy:=alt_scheda-360;
          posres:=true;
          tab_testo:=false;
          w_iotabella(cati^,NumPezzi+1,1,11,NomeMsk+'.msk',false,procarr,false,cod,fill_listagen,nil);
        end
        else
        IF not dueres then
        begin
          aggTab(NomeMsk,numpezzi+1,true);
        end
        else
        begin
          aggTab(NomeMskw,numpezzi+1,true);
        end;
        {$ifdef testo}
        SendMessage(pmainwin^.HWindow,am_DrawStatusLine, A_W, 0);
        {$else}
        SendMessage(pmainwin^.HWindow,am_DrawStatusLine1, A_W, 0);
        {$endif}
        chiave:=27;
        {$else}

        riga:=1;

        //IOTabella(seg(cati^),OfS(cati^),NumPezzi+1,1,11,Chiave,Riga,
        //          NomeMsk+'.prv',true,initmask,not(initmask),884,0);
        //if chiave=61 then richiesta(W_M(49));  {'Selezionare tronco');}

        real1:=0;real2:=80;real3:=883;real4:=750;
        //setclip(@real1,@real2,@real3,@real4);
        marca(tr,8,true);
        //deltcur;
        {delay(200);}
        initmask:=false;
        copia2;
        {$endif}
        end
      else {Delay(800)};
      errore:=''
      end;

    end;
 end
until (chiave=27)or(cod=130);
//Max_wx:=1000;
real1:=0;real2:=0;real3:=1000;real4:=750;
//setclip(@real1,@real2,@real3,@real4);
if redraw then
  begin
 { if stored then PutImage(Ximage,YImage,Buf_Image,0)
  else} {$Ifdef Win}
        {$Else}
         //ridis;
        {$Endif}
  end
else
  begin
  if errore='' then Richiesta('');
  end;
{dispose(cati^);}
end;
end.
