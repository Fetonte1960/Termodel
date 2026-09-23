Unit N_Disdim;

interface

uses  crt,dos,definiz,novitplt,pezzi,Angoli,Load_d,FunzDim,FunzOver,
      key,crdummy,intcr,RuotaSez{,dimplt vedi plot}{,dimdlt}{piantdim}
      ,wm,init_cca,U_310F,interf3d;


procedure main_dim;

implementation
{***************************  Dimensionato     *******************************}
var   conta : integer;


{$IFDEF NEWcR}

const
   S_Molulo='Modulo';
   S_Resto='Tratto rettilineo';
   S_RestoI='Tratto rett. ingresso';
   S_RestoU='Tratto rett. uscita';
   S_Main='Tratto uscita Main';
   S_Br1='Tratto uscita branch 1';
   S_Br2='Tratto uscita branch 2';
type

     DatiCan=object
             function Lung_Tr:real;
             function Tratto_Mim:real;
            end;
var
    PCan : ^datiCan;


function datiCan.Lung_Tr:real;
begin
   Lung_Tr:=1500/(Conf^.altNum/40);    {quote grafiche}
end;
function datiCan.Tratto_Mim:real;
begin
   Tratto_Mim:=500/(Conf^.altNum/40);
end;


Function RetDis(Tr1,indPezzo:integer):Boolean;

begin
RetDis:=false;
if indpezzo<>0 then
  begin
  if Dati^[tr1]^.Pezzi[IndPezzo]<>0 then
  with VPezzi^[Dati^[tr1]^.Pezzi[IndPezzo]]^ do
  if (Codice='310R')or(Codice='310C')or(Codice='310R ')or(Codice='310C ')
   or(Codice='310F')or(Codice='310F ') then RetDis:=true
  end;
end;



Function NumPezRet(Tr1,Pez:integer):integer;
var Ult,i,n:integer;
    Trovato:boolean;
begin
   N:=0;
   Ult:=1;
   repeat
      Trovato:=VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Descr=S_Molulo;
      if not Trovato then ult:=ult+1;
   until trovato or (ult > MaxD);
   if Trovato then val(VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Valor,N,i);
   NumPezRet:=N;
end;

Function NumTratRet(Tr1,Pez:integer):integer;
var Ult,i,n:integer;
    Trovato:boolean;
begin
   N:=0;
   Ult:=1;
   repeat
      Trovato:=VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Descr=S_Resto;
      if not Trovato then ult:=ult+1;
   until trovato or (ult > MaxD);
   if Trovato then val(VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Valor,N,i);
   NumTratRet:=N;
end;

Function NumS1(Tr1,Pez:integer):real;
var Ult,i,n:integer;
    Trovato:boolean;
begin
   N:=0;
   Ult:=1;
   repeat
      Trovato:=VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Descr=S_RestoU;
      if not Trovato then ult:=ult+1;
   until trovato or (ult > MaxD);
   if Trovato then val(VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Valor,N,i);
   NumS1:=N/Conf^.altNum/40;
end;

Function NumS2(Tr1,Pez:integer):real;
var Ult,i,n:integer;
    Trovato:boolean;
begin
   N:=0;
   Ult:=1;
   repeat
      Trovato:=VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Descr=S_RestoI;
      if not Trovato then ult:=ult+1;
   until trovato or (ult > MaxD);
   if Trovato then val(VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Valor,N,i);
   NumS2:=N/Conf^.altNum/40;
end;

Function UltPez(Tr1:integer):integer;
var Ult : integer;
begin
   Ult:=31;
   while (Dati^[tr1]^.Pezzi[Ult] = 0 ) and (Ult > 0) do Ult:=Ult-1;
   UltPez:=Ult+1;
end;

Function UltDesc(Tr1,Pez:integer):integer;
var Ult : integer;
begin
   Ult:=MaxD;
   while (VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[Ult].Descr = '') and (Ult > 1) do Ult:=Ult-1;
   UltDesc:=Ult+1;
end;


Procedure Dimensionato;

Type RecPU=record xa,ya,xb,yb:real end;
     Ar_pu=Array[0..3]of recpu;

Var X1A,X2A,y1A,y2A,Direz,DirezZ:real;

    PezzoMain,PezzoBr1,PezzoBr2:integer; {- CR Variabili di comodo --}
    crout:Boolean; {-- Attivazione intefaccia --}
    Xins_A1,Yins_A1,Zins_A1:real;    {-- Punto di inserimento ultimo pezzo     --}
    GruppoCor:integer;

   TempPU:RecPu;
   TempZU:Real;

{- prima erano dop distronco --}


var

    Dir,DirZ,L,H,Fi   :array[0..3]of real;
    orient            :integer;
    angrot            :real;
    main,br1,br2      :integer;
    Temp              :real;
    PU1,TPU           :ar_pu;
    TZU               :Array[0..3] of real;
    Intx,inty         :REAL;
    res               :integer;
    PrimaVolta        :Boolean;
    Pezzican,Pezzidis :Integer;
    ProsPezzo         :integer;
    Incrementa        :Boolean;
    UltPezzoDis       :integer;

    Vert1,CanVert     :Boolean;
    Deviaz            :Boolean;
    xrel,yrel,DirLn,DZ:real;
    Trat1             :integer;
    Rprec,Aprec,Bprec :real;

    Xins_A,Yins_A,Zins_A:real;    {-- Punto di inserimento ultimo pezzo     --}

Var inverti,boc,Boc_can {- Bocchetta su canale -}:boolean;
    pez    :integer;
    x1boc,y1boc,x2boc,y2boc:real;
    RapPort,RapPort1:real;
    riduz:boolean;
    InvCan:Boolean;
    Inv_U:RecVert;
    Main_VD:Boolean;
    L_sp,H_sp,Fi_sp:real;

             {-- Variabili CR --}


    NPDIS:integer;                {-- Ultimo pezzo disegnato                --}
    ind_Ult,ind_ult1:integer;     {-- Indice di elpezzi[] dell'ultimo pezzo --}
    LR_Prec:real;                 {-- Lunghezza ingresso ultimo pezzo       --}
    Indcroce:integer;             {-- Indice della diramazione              --}

    L_Eff1,L_Eff2 :real;          {-- Lunghezze dei pezzi ad una uscita     --}

(*
Procedure Spezza_canMc4(tr1,pez:integer;X1,X2,X3,X4,Y1,Y2,Y3,Y4,ZA,ZB,AngDirez:real);

{ X 1 2 ,..,.. = Punto di inserimento del pezzo a monte del canale
  X 3 4 ,..,.. = Punto di inserimento del pezzo a valle del canale }

var Lung,num,TR,S1,S2,resto,resto1:real;
    n,x,j:integer;
    {Lung_Tr,Tratto_Mim:real;}
    strx:string[5];
    bocca:boolean;
    X1Acr,Y1Acr,X2Acr,Y2Acr,X1S,Y1S,X2S,Y2S:real;

function PuntInt(A1,A2,L0,L1:real):real;
 begin
   PuntInt:=(L0*(A2-A1)/L1)+A1;
 end;

begin {quote in mm}
 { Lung_Tr:=1500;
  Tratto_Mim:=1000;}
  TR:=0;  S1:=0;  S2:=0;
  Lung:=sqrt(sqr(X3-X1)+sqr(Y3-Y1)+sqr(ZB-ZA)){*Conf^.altNum/40};
  if VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[1].Descr = '' then {se la tabella e'vuota la carico}
  BEGIN
   Bocca:=(dati^[tr1]^.pros[1]=0) and {--- Bocchette ----}
          (Dati^[tr1]^.Pezzi[Pez+2]=0);
   x:=0;
   num:=int(Lung/Pcan^.Lung_Tr);
  { str(Lung_Tr:5:0,Strx);}
   if Dati^[tr1]^.Pezzi[Pez] = 0 then exit;

   if num > 0 then
   with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
   begin
      x:=UltDesc(Tr1,Pez);
      TabDescr[x].Descr:=S_Molulo{ da '+strx};
      str(Num:5:0,TabDescr[x].valor);
      TabDescr[x].Attrib:='';
   end;

   Resto:=Lung-(Num*Pcan^.Lung_Tr);

   if Resto > 0 then
    begin
       if (Resto > (2*Pcan^.Tratto_Mim)) then {tratto rettilineo}
        begin
           with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
            begin
               x:=UltDesc(Tr1,Pez);
               TabDescr[x].Descr:=S_Resto;
               str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
               TabDescr[x].Attrib:='';
               TR:=Resto;
            end;
        end
       else
        begin
           if (Resto > Pcan^.Tratto_Mim) then {doppio sormonte}
            begin
               if Bocca or (Padre=0) then
                begin
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez);
                      TabDescr[x].Descr:=S_Resto;
                      str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      TR:=Resto;
                    end;
                end
               else
                begin
                   Resto1:=(Resto*(Conf^.altNum/40))/2;
                   if Pez=1 then  {sono sul primo tratto}
                    begin
                       case diram of
                        1:
                        2:
                        3:
                       end;

                    end
                   else
                   if Dati^[tr1]^.Pezzi[Pez-1]<>0 then
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez-1]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez-1);
                      TabDescr[x].Descr:=S_RestoU;
                      str(Resto1:5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      S1:=Resto/2;
                    end;
                   end;
                   if Dati^[tr1]^.Pezzi[Pez+1]<>0 then
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez+1]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez+1);
                      TabDescr[x].Descr:=S_RestoI;
                      str(Resto1:5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      S2:=Resto/2;
                    end;
                end;
            end
           else  {unico sormonte}
            begin
               if Bocca and (Padre=0) then
                begin
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez);
                      TabDescr[x].Descr:=S_Resto;
                      str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      TR:=Resto;
                    end;
                end
               else
               begin
               if Bocca then j:=Pez-1
               else j:=Pez+1;
               if Dati^[tr1]^.Pezzi[j]<>0 then
               with VPezzi^[Dati^[tr1]^.Pezzi[j]]^ do
                begin
                   x:=UltDesc(Tr1,j);
                   if Bocca then
                    begin
                       TabDescr[x].Descr:=S_RestoU;
                       S1:=Resto;
                    end
                   else
                    begin
                       TabDescr[x].Descr:=S_RestoI;
                       S2:=Resto;
                    end;
                   str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                   TabDescr[x].Attrib:='';
                end;
               end;
            end;
        end;
    end;
  END
 else
  begin  {se la tabella e'carica prendo solo i valori}
     Num:=NumPezRet(tr1,Pez);
     Tr:=NumTratRet(tr1,Pez);
     if Dati^[tr1]^.Pezzi[Pez-1] <> 0 then S1:=NumS1(tr1,Pez-1);
     if Dati^[tr1]^.Pezzi[Pez+1] <> 0 then S2:=NumS2(tr1,Pez+1);
  end;

     GruppoCor:=gruppocor+1;
     Vettore^.Gruppo:=Gruppocor;
     Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez];
     Vettore^.entita:='L';
     Vettore^.TLinea:=1;
     Vettore^.Colore:=Costant^.colcan;
     Vettore^.R:=0;

     X1Acr:=X1;
     Y1Acr:=Y1;
     X2Acr:=X2;
     Y2Acr:=Y2;

     if S1 > 0 then
      begin
        Vettore^.X1:=X1Acr;
        Vettore^.Y1:=Y1Acr;
        Vettore^.X2:=PuntInt(X1Acr,X3,S1,Lung);
        Vettore^.Y2:=PuntInt(Y1Acr,Y3,S1,Lung);
        RaddrizzaDis(0);

        X1Acr:=Vettore^.X2;
        Y1Acr:=Vettore^.Y2;

        Vettore^.X1:=X2Acr;
        Vettore^.Y1:=Y2Acr;
        Vettore^.X2:=PuntInt(X2Acr,X4,S1,Lung);
        Vettore^.Y2:=PuntInt(Y2Acr,Y4,S1,Lung);
        RaddrizzaDis(0);

        X2Acr:=Vettore^.X2;
        Y2Acr:=Vettore^.Y2;
      end;

      x:=trunc(Num);
      for j:=1 to x do
      begin
         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=PuntInt(X1Acr,X3,Pcan^.Lung_Tr,Lung);
         Vettore^.Y2:=PuntInt(Y1Acr,Y3,Pcan^.Lung_Tr,Lung);
         RaddrizzaDis(0);

         X1S:=Vettore^.X1;
         Y1S:=Vettore^.Y1;
         X1Acr:=Vettore^.X2;
         Y1Acr:=Vettore^.Y2;

         Vettore^.X1:=X2Acr;
         Vettore^.Y1:=Y2Acr;
         Vettore^.X2:=PuntInt(X2Acr,X4,Pcan^.Lung_Tr,Lung);
         Vettore^.Y2:=PuntInt(Y2Acr,Y4,Pcan^.Lung_Tr,Lung);
         Vettore^.R:=0;
         RaddrizzaDis(0);

         X2S:=Vettore^.X1;
         Y2S:=Vettore^.Y1;
         X2Acr:=Vettore^.X2;
         Y2Acr:=Vettore^.Y2;

         Lung:=Lung-Pcan^.Lung_Tr;

         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=X2Acr;
         Vettore^.Y2:=Y2Acr;
         Vettore^.R:=0;
         RaddrizzaDis(0);

         Vettore^.X1:=X1S;
         Vettore^.Y1:=Y1S;
         Vettore^.X2:=X2S;
         Vettore^.Y2:=Y2S;
         Vettore^.R:=0;
         RaddrizzaDis(0);
      end;


      if S2 > 0 then
      begin
        Vettore^.X1:=X1Acr;{PuntInt(X1Acr,X3,S2,Lung);}
       { X1Acr;}
        Vettore^.Y1:=Y1Acr;{PuntInt(Y1Acr,Y3,S2,Lung);}
        {Y1Acr;}
        Vettore^.X2:=X3;
        Vettore^.Y2:=Y3;
        RaddrizzaDis(0);

        Vettore^.X1:={PuntInt(X2Acr,X3,S2,Lung);}X2Acr;
        Vettore^.Y1:={PuntInt(Y2Acr,Y4,S2,Lung);}Y2Acr;
        Vettore^.X2:=X4;
        Vettore^.Y2:=Y4;
        RaddrizzaDis(0);
        X3:=Vettore^.X1;
        Y3:=Vettore^.Y2;
        X4:=Vettore^.X1;
        Y4:=Vettore^.Y2;
      end;

     if TR > 0 then
      begin
         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=X3;
         Vettore^.Y2:=Y3;
         RaddrizzaDis(0);

         Vettore^.X1:=X2Acr;
         Vettore^.Y1:=Y2Acr;
         Vettore^.X2:=X4;
         Vettore^.Y2:=Y4;
         RaddrizzaDis(0);

         Vettore^.X1:=X3;
         Vettore^.Y1:=Y3;
         Vettore^.X2:=X4;
         Vettore^.Y2:=Y4;
         RaddrizzaDis(0);


         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=X2Acr;
         Vettore^.Y2:=Y2Acr;
         RaddrizzaDis(0);
      end;

end;

{$endIF}
*)
(*
Procedure Dimensionato;

Type RecPU=record xa,ya,xb,yb:real end;
     Ar_pu=Array[0..3]of recpu;

Var X1A,X2A,y1A,y2A,Direz,DirezZ:real;

    PezzoMain,PezzoBr1,PezzoBr2:integer; {- CR Variabili di comodo --}
    crout:Boolean; {-- Attivazione intefaccia --}
    Xins_A1,Yins_A1,Zins_A1:real;    {-- Punto di inserimento ultimo pezzo     --}
    GruppoCor:integer;

   TempPU:RecPu;
   TempZU:Real;

{- prima erano dop distronco --}


var

    Dir,DirZ,L,H,Fi   :array[0..3]of real;
    orient            :integer;
    angrot            :real;
    main,br1,br2      :integer;
    Temp              :real;
    PU1,TPU           :ar_pu;
    TZU               :Array[0..3] of real;
    Intx,inty         :REAL;
    res               :integer;
    PrimaVolta        :Boolean;
    Pezzican,Pezzidis :Integer;
    ProsPezzo         :integer;
    Incrementa        :Boolean;
    UltPezzoDis       :integer;

    Vert1,CanVert     :Boolean;
    Deviaz            :Boolean;
    xrel,yrel,DirLn,DZ:real;
    Trat1             :integer;
    Rprec,Aprec,Bprec :real;

    Xins_A,Yins_A,Zins_A:real;    {-- Punto di inserimento ultimo pezzo     --}

Var inverti,boc,Boc_can {- Bocchetta su canale -}:boolean;
    pez    :integer;
    x1boc,y1boc,x2boc,y2boc:real;
    RapPort,RapPort1:real;
    riduz:boolean;
    InvCan:Boolean;
    Inv_U:RecVert;
    Main_VD:Boolean;
    L_sp,H_sp,Fi_sp:real;

             {-- Variabili CR --}


    NPDIS:integer;                {-- Ultimo pezzo disegnato                --}
    ind_Ult,ind_ult1:integer;     {-- Indice di elpezzi[] dell'ultimo pezzo --}
    LR_Prec:real;                 {-- Lunghezza ingresso ultimo pezzo       --}
    Indcroce:integer;             {-- Indice della diramazione              --}

    L_Eff1,L_Eff2 :real;          {-- Lunghezze dei pezzi ad una uscita     --}

*)
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  DisTronco     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}


Procedure DisTronco(tr1,padre,diram:integer;X1A,Y1A,X2A,Y2A,Zout,UltAng:real;Vert:Boolean;spxPrec,spyprec:real;
          Var L_R:real;Xins_P,Yins_P,Zins_P:real); { --CR --}


Var
   PU     :ar_Pu;
   Z_U    :Array[0..3]of real;
   VRT    :RecVert;
   spx,spy:real;
   Lung_ret:array[0..3] of real; {-- Lunghezza delle diramazioni           --}


Procedure Spezza_canMc4(tr1,pez:integer;X1,X2,X3,X4,Y1,Y2,Y3,Y4,ZA,ZB,AngDirez:real);

{ X 1 2 ,..,.. = Punto di inserimento del pezzo a monte del canale
  X 3 4 ,..,.. = Punto di inserimento del pezzo a valle del canale }

var Lung,num,TR,S1,S2,resto,resto1:real;
    n,x,j:integer;
    {Lung_Tr,Tratto_Mim:real;}
    strx:string[30];
    bocca:boolean;
    X1Acr,Y1Acr,X2Acr,Y2Acr,X1S,Y1S,X2S,Y2S:real;
    ttr1,ppez:integer;

function PuntInt(A1,A2,L0,L1:real):real;
 begin
   PuntInt:=(L0*(A2-A1)/L1)+A1;
 end;

begin {quote in mm}
 { Lung_Tr:=1500;
  Tratto_Mim:=1000;}
  TR:=0;  S1:=0;  S2:=0;
  Lung:=sqrt(sqr(X3-X1)+sqr(Y3-Y1)+sqr(ZB-ZA)){*Conf^.altNum/40};
  if VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^.TabDescr[1].Descr = '' then {se la tabella e'vuota la carico}
  BEGIN
   Bocca:=(dati^[tr1]^.pros[1]=0) and {--- Bocchette ----}
          (Dati^[tr1]^.Pezzi[Pez+2]=0);
   x:=0;
   num:=int(Lung/Pcan^.Lung_Tr);
  { str(Lung_Tr:5:0,Strx);}
   if Dati^[tr1]^.Pezzi[Pez] = 0 then exit;

   if num > 0 then
   with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
   begin
      x:=UltDesc(Tr1,Pez);
      TabDescr[x].Descr:=S_Molulo{ da '+strx};
      str(Num:5:0,TabDescr[x].valor);
      TabDescr[x].Attrib:='';
   end;

   Resto:=Lung-(Num*Pcan^.Lung_Tr);

   if Resto > 0 then
    begin
       if (Resto > (2*Pcan^.Tratto_Mim)) then {tratto rettilineo}
        begin
           with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
            begin
               x:=UltDesc(Tr1,Pez);
               TabDescr[x].Descr:=S_Resto;
               str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
               TabDescr[x].Attrib:='';
               TR:=Resto;
            end;
        end
       else
        begin
           if (Resto > Pcan^.Tratto_Mim) then {doppio sormonte}
            begin
               if Bocca or (Padre=0) then
                begin
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez);
                      TabDescr[x].Descr:=S_Resto;
                      str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      TR:=Resto;
                    end;
                end
               else
                begin
                   Resto1:=(Resto*(Conf^.altNum/40))/2;
                   if Pez=1 then  {sono sul primo tratto}
                    begin
                       ppez:=UltPez(Padre)+1;
                       if Dati^[Padre]^.Pezzi[PPez] <> 0 then
                        with VPezzi^[Dati^[Padre]^.Pezzi[PPez]]^ do
                         begin
                            x:=UltDesc(Padre,PPez);
                            case diram of
                             1:TabDescr[x].Descr:=S_Main;
                             2:TabDescr[x].Descr:=S_Br1;
                             3:TabDescr[x].Descr:=S_Br2;
                            end;
                            str(Resto1:5:0,TabDescr[x].valor);
                            TabDescr[x].Attrib:='';
                            S1:=Resto/2;
                         end;
                    end
                   else
                   begin
                   if Dati^[tr1]^.Pezzi[Pez-1]<>0 then
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez-1]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez-1);
                      TabDescr[x].Descr:=S_RestoU;
                      str(Resto1:5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      S1:=Resto/2;
                    end;
                   end;
                   if Dati^[tr1]^.Pezzi[Pez+1]<>0 then
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez+1]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez+1);
                      TabDescr[x].Descr:=S_RestoI;
                      str(Resto1:5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      S2:=Resto/2;
                    end;
                end;
            end
           else  {unico sormonte}
            begin
               if Bocca and (Padre=0) then
                begin
                   with VPezzi^[Dati^[tr1]^.Pezzi[Pez]]^ do
                    begin
                      x:=UltDesc(Tr1,Pez);
                      TabDescr[x].Descr:=S_Resto;
                      str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                      TabDescr[x].Attrib:='';
                      TR:=Resto;
                    end;
                end
               else
               begin
               if Bocca then
                begin
                   S1:=Resto;
                   if Pez <> 1 then
                    begin
                       j:=Pez-1;
                       Ttr1:=tr1;
                       Strx:=S_RestoU;
                      { S1:=Resto;}
                    end
                   else
                    begin
                       j:=UltPez(Padre)+1;
                       ttr1:=padre;
                       case diram of
                        1:Strx:=S_Main;
                        2:Strx:=S_Br1;
                        3:Strx:=S_Br2;
                       end;
                    end;
                   if Dati^[ttr1]^.Pezzi[j]<>0 then
                   with VPezzi^[Dati^[ttr1]^.Pezzi[j]]^ do
                    begin
                       x:=UltDesc(tTr1,j);
                       TabDescr[x].Descr:=Strx;
                       str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                       TabDescr[x].Attrib:='';
                    end;
                end
               else
                begin
                   j:=Pez+1;
                   if Dati^[tr1]^.Pezzi[j]<>0 then
                   with VPezzi^[Dati^[tr1]^.Pezzi[j]]^ do
                    begin
                       x:=UltDesc(Tr1,j);
                       TabDescr[x].Descr:=S_RestoI;
                       str(Resto*(Conf^.altNum/40):5:0,TabDescr[x].valor);
                       TabDescr[x].Attrib:='';
                       S2:=Resto;
                    end;
                end;
               end;
            end;
        end;
    end;
  END
 else
  begin  {se la tabella e'carica prendo solo i valori}
     Num:=NumPezRet(tr1,Pez);
     Tr:=NumTratRet(tr1,Pez);
     if Dati^[tr1]^.Pezzi[Pez-1] <> 0 then S1:=NumS1(tr1,Pez-1);
     if Dati^[tr1]^.Pezzi[Pez+1] <> 0 then S2:=NumS2(tr1,Pez+1);
     {devo ancora compilare S1,S2 se arrivano da un incrocio}
  end;

     GruppoCor:=gruppocor+1;
     Vettore^.Gruppo:=Gruppocor;
     Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez];
     Vettore^.entita:='L';
     Vettore^.TLinea:=1;
     Vettore^.Colore:=Costant^.colcan;
     Vettore^.R:=0;

     X1Acr:=X1;
     Y1Acr:=Y1;
     X2Acr:=X2;
     Y2Acr:=Y2;

     if S1 > 0 then
      begin
        Vettore^.X1:=X1Acr;
        Vettore^.Y1:=Y1Acr;
        Vettore^.X2:=PuntInt(X1Acr,X3,S1,Lung);
        Vettore^.Y2:=PuntInt(Y1Acr,Y3,S1,Lung);
        RaddrizzaDis(0);

        X1Acr:=Vettore^.X2;
        Y1Acr:=Vettore^.Y2;

        Vettore^.X1:=X2Acr;
        Vettore^.Y1:=Y2Acr;
        Vettore^.X2:=PuntInt(X2Acr,X4,S1,Lung);
        Vettore^.Y2:=PuntInt(Y2Acr,Y4,S1,Lung);
        RaddrizzaDis(0);

        X2Acr:=Vettore^.X2;
        Y2Acr:=Vettore^.Y2;
      end;

      x:=trunc(Num);
      for j:=1 to x do
      begin
         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=PuntInt(X1Acr,X3,Pcan^.Lung_Tr,Lung);
         Vettore^.Y2:=PuntInt(Y1Acr,Y3,Pcan^.Lung_Tr,Lung);
         RaddrizzaDis(0);

         X1S:=Vettore^.X1;
         Y1S:=Vettore^.Y1;
         X1Acr:=Vettore^.X2;
         Y1Acr:=Vettore^.Y2;

         Vettore^.X1:=X2Acr;
         Vettore^.Y1:=Y2Acr;
         Vettore^.X2:=PuntInt(X2Acr,X4,Pcan^.Lung_Tr,Lung);
         Vettore^.Y2:=PuntInt(Y2Acr,Y4,Pcan^.Lung_Tr,Lung);
         Vettore^.R:=0;
         RaddrizzaDis(0);

         X2S:=Vettore^.X1;
         Y2S:=Vettore^.Y1;
         X2Acr:=Vettore^.X2;
         Y2Acr:=Vettore^.Y2;

         Lung:=Lung-Pcan^.Lung_Tr;

         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=X2Acr;
         Vettore^.Y2:=Y2Acr;
         Vettore^.R:=0;
         RaddrizzaDis(0);

         Vettore^.X1:=X1S;
         Vettore^.Y1:=Y1S;
         Vettore^.X2:=X2S;
         Vettore^.Y2:=Y2S;
         Vettore^.R:=0;
         RaddrizzaDis(0);
      end;


      if S2 > 0 then
      begin
        Vettore^.X1:=X1Acr;{PuntInt(X1Acr,X3,S2,Lung);}
       { X1Acr;}
        Vettore^.Y1:=Y1Acr;{PuntInt(Y1Acr,Y3,S2,Lung);}
        {Y1Acr;}
        Vettore^.X2:=X3;
        Vettore^.Y2:=Y3;
        RaddrizzaDis(0);

        Vettore^.X1:={PuntInt(X2Acr,X3,S2,Lung);}X2Acr;
        Vettore^.Y1:={PuntInt(Y2Acr,Y4,S2,Lung);}Y2Acr;
        Vettore^.X2:=X4;
        Vettore^.Y2:=Y4;
        RaddrizzaDis(0);
        X3:=Vettore^.X1;
        Y3:=Vettore^.Y2;
        X4:=Vettore^.X1;
        Y4:=Vettore^.Y2;
      end;

     if TR > 0 then
      begin
         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=X3;
         Vettore^.Y2:=Y3;
         RaddrizzaDis(0);

         Vettore^.X1:=X2Acr;
         Vettore^.Y1:=Y2Acr;
         Vettore^.X2:=X4;
         Vettore^.Y2:=Y4;
         RaddrizzaDis(0);

         Vettore^.X1:=X3;
         Vettore^.Y1:=Y3;
         Vettore^.X2:=X4;
         Vettore^.Y2:=Y4;
         RaddrizzaDis(0);


         Vettore^.X1:=X1Acr;
         Vettore^.Y1:=Y1Acr;
         Vettore^.X2:=X2Acr;
         Vettore^.Y2:=Y2Acr;
         RaddrizzaDis(0);
      end;

end;

{$endIF}



{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Componi         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Componi(orie:integer);

var i,j:integer;
    MidY:real;
    SpoX:real;

begin
Componi3d(orie,PU1[0].Xa,PU[1].Xa);
i:=1;
while DisPezzo1^[i].Entita[1]<>' ' do
  begin
  with DisPezzo1^[i] do
    begin
    Y1:=Y1-PU1[0].Ya+PU[1].Ya;
    if entita[1]='L' THEN Y2:=Y2-PU1[0].Ya+PU[1].Ya;
    end;
  I:=i+1;
  end;
j:=1;
while DisPezzo^[j].Entita[1]<>' ' do
  begin
  DisPezzo1^[i+j-1]:=DisPezzo^[j];
  with DisPezzo1^[i+j-1] do
    begin
    X1:=X1+PU1[0].Xa-PU[1].Xa;
    if entita[1]='L' THEN  X2:=X2+PU1[0].Xa-PU[1].Xa;
    end;
  j:=j+1;
  end;

if Not(orie IN[5,6]) then
With DisPezzo1^[i+j-1] do
  begin
  Entita:='L';
  Tlinea:=1;
  X1:=PU1[0].Xa;Y1:=PU1[0].Ya-PU1[0].Ya+PU[1].Ya;;
  X2:=PU1[0].Xb;Y2:=PU1[0].Yb-PU1[0].Ya+PU[1].Ya;;
  end;

PU1[0].Xa:=PU1[0].Xa-(PU[1].Xa-PU[0].Xa);
PU1[0].Xb:=PU1[0].Xb-(PU[1].Xa-PU[0].Xa);
PU1[1].Yb:=PU1[1].Yb-PU1[0].Ya+PU[1].Ya;
PU1[1].Ya:=PU1[1].Ya-PU1[0].Ya+PU[1].Ya;
PU1[0].yb:=PU[0].yb;
PU1[0].ya:=PU[0].ya;

if orie IN[5,6] then
  begin
  MidY:=(PU1[0].Ya+PU1[0].Yb)/2;
  i:=1;
  while DisPezzo1^[i].Entita[1]<>' ' do
    begin
    with DisPezzo1^[i] do
      begin
      Y1:=Y1-MidY;
      X1:=X1-PU1[0].Xa;
      if entita[1]='L' THEN
        begin
        Y2:=Y2-MidY;
        X2:=X2-PU1[0].Xa;
        end;
      end;
    I:=i+1;
    end;
  Spox:=PU1[0].Xa;
  For i:=0 To 1 do
    begin
    PU1[i].Xa:=PU1[i].Xa-Spox;
    PU1[i].Xb:=PU1[i].Xb-Spox;
    PU1[i].yb:=PU1[i].yb-MidY;
    PU1[i].ya:=PU1[i].ya-MidY;
    end;
  end


end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Inser           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Inser(DX,DY,DZ,Rot,rotz:real);


var i:integer;

begin
for i:=1 to 30 do
with DisPezzo1^[i] do
if entita[1]<>' ' then
  begin
  ModiCord(X1,Y1,Dx,Dy,Rot,true);
  case entita[1] of
    'L'    :ModiCord(X2,Y2,Dx,Dy,Rot,true);
    'A','C','P':Begin
                R:=R/(Conf^.Altnum/40);
                R1:=R1/(Conf^.Altnum/40);
                X2:=x2-rot;
                Y2:=y2-rot;
                end;
    end;
  end;
For i:=0 to 3 do
  begin
  Z_u[i]:=Z_u[i]+Dz;
  Modicord(Pu[i].Xa,Pu[i].Ya,Dx,Dy,Rot,true);
  Modicord(Pu[i].Xb,Pu[i].Yb,Dx,Dy,Rot,true);
  end;

DisegnaNumPezzo(Dx,Dy,0);    { CR }
Inser3d(DX,DY,DZ,Rot,rotz);
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  LoadDim        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure LoadDim(NDim,NPezzo:integer);

begin
With VPezzi^[Dati^[tr1]^.Pezzi[NPezzo]]^ Do
  begin
  L[NDim] :=A;
  H[NDim] :=B;
  FI[NDim]:=R;
  end
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  SerTer          *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function NoDis(indPezzo:integer):Boolean;

begin
NoDis:=false;
if indpezzo<>0 then
  begin
  if Dati^[tr1]^.Pezzi[IndPezzo]<>0 then
  with VPezzi^[Dati^[tr1]^.Pezzi[IndPezzo]]^ do
  if (Codice='310R')or(Codice='310C')or(Codice='310R ')or(Codice='310C ')
   or(Codice='310F')or(Codice='310F ') then NoDis:=true
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CopiaPezzo      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure CopiaPezzo;

var i:integer;

begin

for i:=1 to 30 do
  begin
  DisPezzo1^[i]:=DisPezzo^[i];
  if DisPezzo^[i].Entita[1]=' ' then DisPezzo1^[i].Entita:=' ';
  end;

for i:=31 to 50 do
with DisPezzo1^[i] do
  begin
  entita:=' ';  TLinea:=0;
  X1:=0;            Y1:=0;
  X2:=0;            Y2:=0;
  R:=0;
  end;
PU1:=PU;

Copiapezzo3D;
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  SetOri        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure SetOri(var Cod:st5;Var Ori:integer;line:integer);

var Br:real;
    Cod2:string;
    Trov,Trov2:Boolean;

begin
Br:=Bordo(line,1,1);
trov:=false;
Cod2:=Cod;
if cod='271R' then
  begin
  Cod2:='281R';
  trov:=true;
  end;
if cod='273R' then
  begin
  Cod2:='283R';
  trov:=true;
  end;
if cod='021R' then
  begin
  Cod2:='031R';
  trov:=true;
  end;
if cod='023R' then
  begin
  Cod2:='033R';
  trov:=true;
  end;
if cod='021C' then
  begin
  Cod2:='031C';
  trov:=true;
  end;
if cod='023C' then
  begin
  Cod2:='033C';
  trov:=true;
  end;
if cod='271C' then
  begin
  Cod2:='281C';
  trov:=true;
  end;
if cod='273C' then
  begin
  Cod2:='283C';
  trov:=true;
  end;
if cod='441R' then
  begin
  Cod2:='431R';
  trov:=true;
  end;
if cod='443R' then
  begin
  Cod2:='433R';
  trov:=true;
  end;

Trov2:=False;
if (cod='281R')or(cod='283R')or(cod='031C')or
   (cod='031R')or(cod='033R')or
   (cod='033C')or(cod='261R')or(cod='263R')
   or(cod='281C')or(cod='283C')
   or(cod='431R')or(cod='433R')   then trov2:=true;

if (trov)or(Trov2) then
  begin
  if br<>0 then
    begin
    if br>0 then ori:=1 else ori:=3;
    Cod:=Cod2;
    end
  else ori:=2;
  end;

end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Indietro         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Indietro(PezzoIn,line,orie:integer;Var L_Sp,H_sp,Fi_Sp:real;Color:integer);


begin
CopiaPezzo;
if (Pezzoin>1)and(not (nodis(PezzoIn-1))) then
  begin
    repeat
    LoadDim(0,Pezzoin-1);
    LoadDim(1,Pezzoin);
    with Vpezzi^[Dati^[tr1]^.pezzi[PezzoIn-1]]^ do
    begin
    codice:=upstring(codice);
{    NSecPezzi:=NSecPezzi+1;
    TabDescr[1].Descr:='Numerazione pezzo ';
    str(NSecPezzi:5,TabDescr[1].valor);}
    if not(orie IN [5,6]) then SetOri(codice,orie,line);
    disegnapezzo(upstring(codice),L[0],H[0],L[1],H[1],0,0,0,0,
                  Fi[0],Fi[1],0,0,
                  Orie,Ang,Rag,lung*1000,0,0,Varie,Color,
                  PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                  PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                  PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                  PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                  Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

    L_Sp:=L[0];H_Sp:=H[0];Fi_Sp:=Fi[0];

    end;

  ComPoni(orie);
  PezzoIn:=PezzoIn-1;
  until (Nodis(PezzoIn-1))or(PezzoIn=0);
  PU:=PU1;
  end;

end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Main DISTRONCO      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}


var i,j,k:integer;

Function Tipo_br(ramo:integer):integer;
begin
Tipo_br:=1;
if ramo=br1 then Tipo_br:=2;
if ramo=br2 then Tipo_br:=3;
end;

begin

(*gotoxy(10,12);
write('nodo:',tr1);{*TR*}
clreol;*)
{percentu;}

for i:=1 to 3 do  VRT[i] :=false;

Main_VD:=false;
InvCan:=false;
UltPezzoDis:=0;
i:=Dati^[tr1]^.Ti;
PrimaVolta:=true;
Vert1:=false;
boc:=false;
Rprec:=0;
APrec:=0;
BPrec:=0;
Spx:=SpxPrec;
br1:=0;

  Repeat

  {while dis^[i]^.Npezzo=0 do i:=dis^[i]^.NLinea;}

  Boc_can:=False;
  CalcDirez(i,Dirln,DZ);
  if  UG(abs(abs(DZ)-Pi/2),0,1) then
  spy:=spyprec
  else
    begin
    inters(intx,inty,res,X1a,X2a,dis^[i]^.X1,dis^[i]^.X2,Y1a,Y2a,Dis^[i]^.Y1,Dis^[i]^.Y2);

    if res=0 then write(chr(7));

    yrel:=(Y2a+Y1a)/2-inty;
    xrel:=(X2a+X1a)/2-intx;

    if not vert then CalcDirez(i,Dirln,DZ)
    else DirLn:=UltAng;

    ModiCord(xrel,yrel,0,0,-(DirLn-Pi/2),False);

    spy:=Yrel;

    spy:=spy*Conf^.Altnum/40;

    end;


  if Ug(abs(Dz),Pi/2,1) then Vert1:=True else vert1:=false;


                {--  individua i pezzi inseriti in aut. dopo i nodi --}

  if (primavolta) then

    begin

    PezziCan:=0;
    Prospezzo:=Dis^[i]^.Npezzo;

    if Dis^[i]^.Npezzo=0 then
      begin
      ProsPezzo:=i;
      if Dis^[i]^.Nlinea<>0 then
        Begin
        ProsPezzo:=Dis^[i]^.Nlinea;
        while (Dis^[Prospezzo]^.Nlinea<>0)and(Dis^[Prospezzo]^.NPezzo=0)do
        ProsPezzo:=Dis^[Prospezzo]^.Nlinea;
        end;
      ProsPezzo:=Dis^[Prospezzo]^.NPezzo;
      end;

    Pezzican:=0;
    while (ProsPezzo>(Ultpezzodis+Pezzican+1))and
           (not nodis(Ultpezzodis+Pezzican+1)) do pezzican:=Pezzican+1;

    if pezzican<0 then Pezzican:=0;

    PrimaVolta:=False;
    PezziDis:=1;

    end;

 if  PezziCan=0  then
   begin
   While (dis^[i]^.NPezzo=0)and(Dis^[i]^.Nlinea<>0) do
   i:=Dis^[i]^.Nlinea;
   PrimaVolta:=true;
   end;



 {-- Disegna i pezzi  inseriti in automatico da canali ( Dav. un pezzo esist--}

  if Pezzican>0 then

    begin

    Deviaz:=False;
    if not Vert1 then
      begin
      inters(intx,inty,res,X1a,X2a,dis^[i]^.X1,dis^[i]^.X2,Y1a,Y2a,Dis^[i]^.Y1,Dis^[i]^.Y2);
      if res=0 then write(chr(7));
      spx:=-sqrt(sqr(Dis^[i]^.x2-intx)+sqr(Dis^[i]^.y2-inty));
      spx:=spx*Conf^.Altnum/40;
      end;
    pez:=UltPezzoDis+PezziDis;
    LoadDim(0,UltPezzoDis+PezziDis);
    LoadDim(1,UltPezzoDis+PezziDis+1);

    CalcDirez1(i,0,Direz,DirezZ,UltAng,False,CanVert,inverti);
        if not(UG(abs(direzZ),Pi/2,1)) then orient:=1
        else
          begin
          if DirezZ>0 then orient:=6 else orient:=5;
          Vert:=true;
          end;



    with Vpezzi^[Dati^[tr1]^.pezzi[UltPezzodis+Pezzidis]]^ do
      begin
      Codice:=upstring(codice);
{      NSecPezzi:=NSecPezzi+1;
      TabDescr[1].Descr:='Numerazione pezzo ';
      str(NSecPezzi:5,TabDescr[1].valor);}
      if not vert then SetOri(codice,orient,i);

      disegnapezzo(codice,L[0],H[0],L[1],H[1],0,0,0,0,
                     Fi[0],Fi[1],0,0,
                     Orient,Ang,Rag,lung*1000,0,0,Varie,Dis^[i]^.Color,
                     PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                     PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                     PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                     PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                     Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

      end;

    CopiaPezzo;

    spx:=spx-Pu[0].xa;

    if PezziDis=Pezzican then Pezzican:=0
    else PezziDis:=PezziDis+1;
    incrementa:=false;

    end

  else

    begin
    incrementa:=true;

    if Dis^[i]^.Nlinea<>0 then {-- Curva etc.--}

      begin

      Deviaz:=true;
      Trat1:=Dis^[i]^.Nlinea;
      pez:=dis^[i]^.Npezzo;
      CalcAng(i,Dis^[i]^.Nlinea,Dir[1],DirZ[1],Orient,Vert,UltAng);

      if (ug(Dir[1],0,1))and(ug(DirZ[1],0,1)) then {-- Riduzioni --}
        begin
        Riduz:=true;
        CalcDirez1(i,0,Direz,DirezZ,UltAng,False,CanVert,inverti);
        if not(UG(abs(direzZ),PI/2,1)) then orient:=1
        else
          begin
          if DirezZ>0 then orient:=6 else orient:=5;
          Vert:=true;
          end;
        end
      else riduz:=false;

      LoadDim(0,dis^[i]^.Npezzo);
      LoadDim(1,dis^[i]^.Npezzo+1);
      UltPezzoDis:=dis^[i]^.Npezzo;

      {writeln(lst,' Curve ',orient);}

      with Vpezzi^[Dati^[tr1]^.pezzi[dis^[i]^.Npezzo]]^ do
        begin
        codice:=upstring(codice);
       { NSecPezzi:=NSecPezzi+1;
        TabDescr[1].Descr:='Numerazione pezzo ';
        str(NSecPezzi:5,TabDescr[1].valor);}

        if not vert then SetOri(codice,orient,i);
        disegnapezzo(codice,L[0],H[0],L[1],H[1],0,0,0,0,
                       Fi[0],FI[1],0,0,
                       Orient,Ang,Rag,lung*1000,0,0,Varie,Dis^[i]^.Color,
                       PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                       PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                       PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                       PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                       Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

        end;

      L_Sp:=L[0];H_Sp:=H[0];Fi_Sp:=Fi[0];

      Indietro(dis^[i]^.Npezzo,i,orient,L_sp,H_Sp,Fi_Sp,Dis^[i]^.Color);


      Spx:=CalcSpx(dis^[i]^.nlinea,Dir[1],DirZ[1],L_sp,H_Sp,Fi_Sp,Spy,Riduz);

      {

      IF DirZ[1]<>0 then sezione:=true;

      spx:=Bordo(Dis^[i].Nlinea,L[0],Fi[0]);

      sezione:=false;

      IF DirZ[1]<>0 then
        begin
        if not riduz then
          begin
          if abs(abs(dirZ[1])-Pi/2)>0.1 then
          spx:=spx/sin(dirZ[1])-spy/(sin(dirZ[1])/cos(dirZ[1]))
          else spx:=spx/sin(dirZ[1]);
          end;
        end
      else
        begin
        if not riduz then
          begin
          if abs(abs(dir[1])-Pi/2)>0.1 then
          spx:=spx/sin(dir[1])-spy/(sin(dir[1])/cos(dir[1]))
          else spx:=spx/sin(dir[1]);
          end;
        end;

      }

      end

    else

      begin
      if dati^[tr1]^.pros[1]=0 then  {--- Bocchette ----}
        begin

        Deviaz:=False;
        CalcDirez1(i,0,Direz,DirezZ,UltAng,False,CanVert,Inverti);
        if not(UG(abs(direzZ),PI/2,1)) then orient:=1
        else
          begin
          if DirezZ>0 then orient:=6 else orient:=5;
          end;

        pez:=dis^[i]^.Npezzo;
        LoadDim(0,Dis^[i]^.NPezzo);

        with Vpezzi^[Dati^[tr1]^.pezzi[dis^[i]^.Npezzo]]^ do
          begin
       {   NSecPezzi:=NSecPezzi+1;
          TabDescr[1].Descr:='Numerazione pezzo ';
          str(NSecPezzi:5,TabDescr[1].valor);}
          disegnapezzo(UpString(codice),L[0],H[0],0,0,0,0,0,0,
                         FI[0],0,0,0,
                         orient,0,0,lung*1000,0,0,Varie,Dis^[i]^.Color,
                         PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                         PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                         PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                         PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                         Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

          end;
        x1boc:=PU[0].xa;
        y1Boc:=PU[0].ya;
        x2boc:=PU[0].xb;
        y2boc:=PU[0].yb;
        Boc:=true;
        Indietro(dis^[i]^.Npezzo,i,orient,L_SP,H_Sp,Fi_Sp,Dis^[i]^.Color);
        {
        inters_A(intx,inty,res,X1a,X2a,dis^[i].X1,dis^[i].X2,Y1a,Y2a,Dis^[i].Y1,Dis^[i].Y2,10);
        if res=0 then Boc_Can:=True;
        }
        spx:=0;
        end
      else
        begin
        if dati^[tr1]^.pros[3]=0 then  {--- TEE ----}
          begin


          SETBRANCH(i,2,Main,Br1,Br2,Orient,Vrt,UltAng,InvCan,Inv_U,Main_VD);
          Deviaz:=true;
          Trat1:=Dati^[Dati^[tr1]^.pros[br1]]^.Ti;


          {-- CR Caricamento lunghezza minima degli stacchi --}

          if CROut then
            begin
            indcroce:=Dis^[i]^.NPezzo;
            SetPezzi(PezzoMain,PezzoBr1,PezzoBr2,tr1,indcroce,Main,Br1,Br2);
            Carica_LMin(Lung_ret[0],Lung_ret[Main],Lung_ret[br1],Lung_ret[br2],
                       Dati^[tr1]^.Pezzi[indcroce],PezzoMain,PezzoBr1,PezzoBr2);
            end;



          LoadDim(0,dis^[i]^.Npezzo);
          L[1] :=Vpezzi^[Dati^[Dati^[tr1]^.pros[1]]^.pezzi[0]]^.A;
          L[2] :=Vpezzi^[Dati^[Dati^[tr1]^.pros[2]]^.pezzi[0]]^.A;
          FI[1]:=Vpezzi^[Dati^[Dati^[tr1]^.pros[1]]^.pezzi[0]]^.R;
          FI[2]:=Vpezzi^[Dati^[Dati^[tr1]^.pros[2]]^.pezzi[0]]^.R;
          H[1] :=Vpezzi^[Dati^[Dati^[tr1]^.pros[1]]^.pezzi[0]]^.B;
          H[2] :=Vpezzi^[Dati^[Dati^[tr1]^.pros[2]]^.pezzi[0]]^.B;

          {$IFDEF NEWcR}
          RapPort:=0.2 ;
          {$Else}

          RapPort:=Vpezzi^[Dati^[Dati^[tr1]^.Pros[Main]]^.Pezzi[1]]^.Port/
                   (Vpezzi^[Dati^[Dati^[tr1]^.Pros[Main]]^.Pezzi[1]]^.Port+
                    Vpezzi^[Dati^[Dati^[tr1]^.pros[Br1 ]]^.Pezzi[1]]^.Port);

          {$ENDIF}

          with Vpezzi^[Dati^[tr1]^.pezzi[dis^[i]^.Npezzo]]^ do
            begin
           { NSecPezzi:=NSecPezzi+1;
            TabDescr[1].Descr:='Numerazione pezzo ';
            str(NSecPezzi:5,TabDescr[1].valor);}
            disegnapezzo(UpString(codice),L[0],H[0],L[Main],H[Main],L[Br1],H[Br1],0,0,
                           FI[0],FI[Main],FI[Br1],0,
                           orient,Ang,Rag,lung*1000,RapPort,0,Varie,Dis^[i]^.Color,
                           PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                           PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                           PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                           PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                           Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

            end;

          L_Sp:=L[Br1];H_Sp:=H[Br1];Fi_Sp:=Fi[Br1];

          Indietro(dis^[i]^.Npezzo,i,orient,L_SP,H_Sp,Fi_Sp,Dis^[i]^.Color);
          pez:=dis^[i]^.Npezzo;

          CalcAng(i,Dati^[Dati^[tr1]^.pros[br1]]^.Ti,Dir[br1],DirZ[br1],Orient,Vert,UltAng);

            if main=2 then
              begin
              TempPU:=PU[1];
              PU[1] :=PU[2];
              PU[2] :=TempPU;

              TempZU:=Z_U[1];
              Z_U[1] :=Z_U[2];
              Z_U[2] :=TempZU;
              end;


          Spx:=CalcSpx(Dati^[Dati^[tr1]^.pros[br1]]^.Ti,Dir[br1],DirZ[br1],L_SP,H_Sp,Fi_Sp,Spy,false);


          end

        else

          begin     {---- CROCE  ---}


          SETBRANCH(i,3,Main,Br1,Br2,Orient,Vrt,UltAng,InvCan,Inv_U,Main_VD);
          Deviaz:=true;
          Trat1:=Dati^[Dati^[tr1]^.pros[br1]]^.Ti;

          pez:=dis^[i]^.Npezzo;

          {-- CR Caricamento lunghezza minima degli stacchi --}

          if CROut then
            begin
            indcroce:=Dis^[i]^.NPezzo;
            SetPezzi(PezzoMain,PezzoBr1,PezzoBr2,tr1,indcroce,Main,Br1,Br2);
            Carica_LMin(Lung_ret[0],Lung_ret[Main],Lung_ret[br1],Lung_ret[br2],
                       Dati^[tr1]^.Pezzi[indcroce],PezzoMain,PezzoBr1,PezzoBr2);
            end;



          LoadDim(0,dis^[i]^.Npezzo);

          FOR K:=1 TO 3 DO
            begin
            L[k] :=Vpezzi^[Dati^[Dati^[tr1]^.pros[k]]^.pezzi[0]]^.A;
            H[k] :=Vpezzi^[Dati^[Dati^[tr1]^.pros[k]]^.pezzi[0]]^.B;
            FI[k]:=Vpezzi^[Dati^[Dati^[tr1]^.pros[k]]^.pezzi[0]]^.R;
            end;

         {$IFDEF NEWcR}
          RapPort:=0.2 ;
          RapPort1:=0.2 ;
          {$Else}

          RapPort:=1- Vpezzi^[Dati^[Dati^[tr1]^.Pros[br1]]^.Pezzi[1]]^.Port/
                     (Vpezzi^[Dati^[Dati^[tr1]^.Pros[Main]]^.Pezzi[1]]^.Port+
                      Vpezzi^[Dati^[Dati^[tr1]^.Pros[br1]]^.Pezzi[1]]^.Port+
                      Vpezzi^[Dati^[Dati^[tr1]^.pros[Br2 ]]^.Pezzi[1]]^.Port);

          RapPort1:=1-Vpezzi^[Dati^[Dati^[tr1]^.Pros[br2]]^.Pezzi[1]]^.Port/
                     (Vpezzi^[Dati^[Dati^[tr1]^.Pros[Main]]^.Pezzi[1]]^.Port+
                      Vpezzi^[Dati^[Dati^[tr1]^.Pros[br1]]^.Pezzi[1]]^.Port+
                      Vpezzi^[Dati^[Dati^[tr1]^.pros[Br2 ]]^.Pezzi[1]]^.Port);

          {$Endif}

          with Vpezzi^[Dati^[tr1]^.pezzi[dis^[i]^.Npezzo]]^ do
            begin
           { NSecPezzi:=NSecPezzi+1;
            TabDescr[1].Descr:='Numerazione pezzo ';
            str(NSecPezzi:5,TabDescr[1].valor);}
            disegnapezzo(UpString(codice),
                         L[0],H[0],L[Main],H[Main],L[Br1],H[Br1],L[Br2],L[Br2],
                         FI[0],FI[Main],Fi[Br1],Fi[Br2],
                         orient,Ang,Rag,lung*1000,RapPort,RapPort1,Varie,Dis^[i]^.Color,
                         PU[0].xa,PU[0].ya,PU[0].xb,PU[0].yb,
                         PU[1].xa,PU[1].ya,PU[1].xb,PU[1].yb,
                         PU[2].xa,PU[2].ya,PU[2].xb,PU[2].yb,
                         PU[3].xa,PU[3].ya,PU[3].xb,PU[3].yb,
                         Z_U[0],Z_U[1],Z_U[2],Z_U[3]);

            end;
          L_Sp:=L[Br1];H_Sp:=H[Br1];Fi_Sp:=Fi[Br1];

          Indietro(dis^[i]^.Npezzo,i,orient,L_SP,H_Sp,Fi_Sp,Dis^[i]^.Color);

          CalcAng(i,Dati^[Dati^[tr1]^.pros[br1]]^.Ti,Dir[br1],DirZ[br1],Orient,Vert,UltAng);

          TPU[Main]:=PU[1];
          TPU[Br1] :=PU[2];
          TPU[BR2] :=PU[3];

          for k:=1 to 3 do PU[K]:=TPU[K];

          TZU[Main]:=Z_U[1];
          TZU[Br1] :=Z_U[2];
          TZU[BR2] :=Z_U[3];

          for k:=1 to 3 do Z_U[K]:=TZU[K];

          Spx:=CalcSpx(Dati^[Dati^[tr1]^.pros[br1]]^.Ti,Dir[br1],DirZ[br1],L_SP,H_Sp,Fi_Sp,Spy,false);

          end {Croce}

        end {TEE}

      end {Bocchetta}

    end; {Curve etc.}


  CalcDirez1(i,Trat1,Direz,DirezZ,UltAng,Deviaz,CanVert,Inverti);

  Direz:=direz-pi/2;


  if direz<0 then direz:=2*pi+direz;


  CalcDirez(i,Dirln,DZ);


  if UG(abs(abs(DZ)-Pi/2),0,1) then
    begin
    spx:=spxPrec;
    spy:=spyPrec;
    end
  else
  ModiCord(spx,spy,0,0,Direz,true);

  if ug(abs(Dz),PI/2,1) then Spy:=SpyPrec;

  spxPrec:=spx;
  spyPrec:=spy;


  if UG(abs(abs(DZ)-Pi/2),0,1)or(Boc_Can) then {- rende inutili Spxprec etc...-}
    begin
    inser((X1A+X2A)/2,(Y1A+Y2A)/2,Dis^[i]^.Z2,Direz,direzZ);


    {-- CR Punto di inserimento--}

    if CROut then
      begin
      Xins_A:=(X1A+X2A)/2;
      Yins_A:=(Y1A+Y2A)/2;
      Zins_A:=Dis^[i]^.Z2;
      end;

    end
  else

    begin
    inser(spx+Dis^[i]^.x2,spy+dis^[i]^.y2,Dis^[i]^.Z2,Direz,direzZ);

    {-- CR Punto di inserimento--}

    if CROut then
      begin
      Xins_A:=spx+Dis^[i]^.X2;
      Yins_A:=spy+Dis^[i]^.Y2;
      Zins_A:=Dis^[i]^.Z2;
      end;

    end;


  Vettore^.Z1:=Dis^[i]^.Z1;
  Vettore^.Z2:=Dis^[i]^.Z2;
  GruppoCor:=gruppocor+1;
  Vettore^.Gruppo:=Gruppocor;
  Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez];

   scrivi3d;

  j:=1;       {-- Disegno del pezzo --}
    repeat
    Vettore^.entita:=DisPezzo1^[j].entita;
    Vettore^.TLinea:=DisPezzo1^[j].TLinea;
    Vettore^.Colore:=Costant^.colcan;
    Vettore^.X1:=DisPezzo1^[j].X1;
    Vettore^.Y1:=DisPezzo1^[j].Y1;
    Vettore^.X2:=DisPezzo1^[j].X2;
    Vettore^.Y2:=DisPezzo1^[j].Y2;
    Vettore^.R:=DisPezzo1^[j].R;
    Vettore^.R2:=DisPezzo1^[j].R1;
    RaddrizzaDis(0);
    {Write(FDim,Vettore^);}
    j:=j+1;
    until DisPezzo1^[j].entita[1]=' ';



             {-- Disegno del tratto rettilineo --}

  {-- Interfacciamento CR per canali rettilinei --}

  if CROut then
    begin
    Disegnacan1(tr1,pez-1,(x1A+X2a)/2,(Y1A+Y2a)/2,Zout,(Pu[0].xA+Pu[0].Xb)/2,(Pu[0].YA+Pu[0].YB)/2,Z_U[0],Ultang);


   { Spezza_can(tr1,pez,Xins_p,Yins_p,Zins_p,Xins_A,Yins_A,Zins_A,
               (x1A+X2a)/2,(Y1A+Y2a)/2,ZOut,
               (Pu[0].xA+Pu[0].Xb)/2,(Pu[0].YA+Pu[0].YB)/2,Z_U[0],
               L_Eff1,L_Eff2);}
    if ind_Ult=0 then L_R:=L_eff1
    else
      begin
      ScaricaPezzoTR(L_eff1,L_eff2,Ind_Ult,Ind_ult1);
      end;
    end;

  {-- CR SWAP delle coordinate di inserimento del pezzo --}

  if CROut then
    begin
    Xins_P:=XIns_A;
    Yins_P:=YIns_A;
    Zins_P:=ZIns_A;
    end;


  if  Not(CanVert) then

  begin
  if (abs(x1A-PU[0].XA)>5)or(abs(Y1a-PU[0].YA)>5)or(Boc_Can) then
    begin
    GruppoCor:=gruppocor+1;
    Vettore^.Gruppo:=Gruppocor;
    Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez-1];
    Quote(tr1,pez,(x1A+x2A)/2,(y1A+y2a)/2,(Pu[0].XA+Pu[0].XB)/2,(Pu[0].YA+Pu[0].YB)/2,Direz,RPrec,APrec,BPrec);
    end;

  if boc then
    begin
    GruppoCor:=gruppocor+1;
    Vettore^.Gruppo:=Gruppocor;
    Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez];
    Modicord(x1boc,y1boc,spx+Dis^[i]^.x2,spy+dis^[i]^.y2,Direz,true);
    Modicord(x2boc,y2boc,spx+Dis^[i]^.x2,spy+dis^[i]^.y2,Direz,true);
    QuotaBoc(tr1,pez,x1boc,y1boc,X2boc,Y2boc,Direz);
    end;

{  if (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310F') or
     (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310F ')then
   begin
      D_310F(X1A,X2A,PU[0].XA,PU[0].XB,Y1A,Y2A,PU[0].YA,PU[0].YB);
   end
  else}
   begin
     {$IFDEF NEWcR}
     { if (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310F') or
         (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310F ') or
         (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310C') or
         (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310C ') or
         (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310R') or
         (Vpezzi^[Dati^[Dis^[i]^.Tronco]^.Pezzi[Dis^[i]^.NPezzo-1]]^.Codice = '310R ') then}
         Spezza_canMc4(tr1,pez-1,X1A,X2A,PU[0].XA,PU[0].XB,Y1A,Y2A,PU[0].YA,PU[0].YB,Dis^[i]^.Z1,Dis^[i]^.Z2,dirln);
      {$else}
      GruppoCor:=gruppocor+1;
      Vettore^.Gruppo:=Gruppocor;
      Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez-1];
      Vettore^.entita:='F';
      Vettore^.TLinea:=1;
      Vettore^.Colore:=Costant^.colcan;
      Vettore^.X1:=X1A;
      Vettore^.Y1:=Y1A;
      Vettore^.X2:=PU[0].XA;
      Vettore^.Y2:=PU[0].YA;
      Vettore^.R:=0;
      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      Vettore^.entita:='*';
      Vettore^.TLinea:=1;
      Vettore^.Colore:=Costant^.colcan;
      Vettore^.X2:=PU[0].XB;
      Vettore^.Y2:=PU[0].YB;
      Vettore^.X1:=PU[0].XA;
      Vettore^.Y1:=PU[0].YA;
      Vettore^.R:=0;
      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      Vettore^.entita:='*';
      Vettore^.TLinea:=1;
      Vettore^.Colore:=Costant^.colcan;
      Vettore^.X2:=X2A;
      Vettore^.Y2:=Y2A;
      Vettore^.X1:=PU[0].XB;
      Vettore^.Y1:=PU[0].YB;
      Vettore^.R:=0;
      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      Vettore^.entita:='*';
      Vettore^.TLinea:=1;
      Vettore^.Colore:=Costant^.colcan;
      Vettore^.X1:=X2A;
      Vettore^.Y1:=Y2A;
      Vettore^.X2:=X1A;
      Vettore^.Y2:=Y1A;
      Vettore^.R:=0;

      RaddrizzaDis(0);
      {$endIF }
      {Write(FDim,Vettore^);}
   end;
  end
  else
  begin
  Rprec:=0;
  APrec:=0;
  BPrec:=0;
  end;

  X1A :=PU[1].XA;
  Y1A :=PU[1].YA;
  Y2A :=PU[1].YB;
  X2A :=PU[1].XB;
  Zout:=Z_U[1];

  if incrementa then i:=Dis^[i]^.Nlinea;

  until i=0;



if Dati^[tr1]^.PROS[1]<>0 then

  begin
  i:=0;

    {---- disegna i figli (ricorsivo)---- }

    repeat
     i:=i+1;
     if dati^[tr1]^.pros[i]<>0 then DisTronco(dati^[tr1]^.pros[i],tr1,Tipo_br(i),
                                             PU[i].Xa,PU[i].ya,
                                             PU[i].Xb,PU[i].yb,Z_u[i],UltAng,VRT[i],
                                             spx,spy,
                                             Lung_ret[i],Xins_A,Yins_A,Zins_A);

    until (i=6)or(dati^[tr1]^.pros[i]=0);


  {- CR: Sono terminati i figli: posso chiudere il nodo terminale del tronco -}

  If CROut Then
    begin

    Pezzomain:=0;
    if Main<>0 then PezzoMain:=Dati^[tr1]^.pros[main];
    if Pezzomain<>0 then Pezzomain:=Dati^[pezzomain]^.Pezzi[0];

    PezzoBr1:=0;
    if Br1<>0 then PezzoBr1:=Dati^[tr1]^.pros[Br1];
    if PezzoBr1<>0 then PezzoBr1:=Dati^[pezzoBr1]^.Pezzi[0];

    PezzoBr2:=0;
    if Br2<>0 then PezzoBr2:=Dati^[tr1]^.pros[Br2];
    if PezzoBr2<>0 then PezzoBr2:=Dati^[pezzoBr2]^.Pezzi[0];

    Scarica_Nodo(Lung_ret[0],Lung_ret[Main],Lung_ret[br1],Lung_ret[br2],
                 Dati^[tr1]^.Pezzi[indcroce],PezzoMain,PezzoBr1,PezzoBr2);
    end;

  {-- Fine CR --}

  end;


end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*      MAIN     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
Var LR_0:real;  { Valore Don't-Care }

begin
   GruppoCor:=0;
   CROut:=true;

   LR_0:=0;
   if Not sezione Then
     begin
     Assign(FDim,Driveprog+NomeProg+'.DIM');
     Rewrite(Fdim);
     End
   else
     begin
     Assign(FDim,Driveprog+NomeProg+'.SZZ');
     Rewrite(Fdim);
     End;

   InitCr;
   with VPezzi^[Dati^[RisultCalc^.Origine]^.Pezzi[1]]^ Do
   CalcCordIniz(A,B,R,X1A,Y1A,X2A,Y2A,Direz,DirezZ);

   {-- CR Calcolo punto iniziale --}

   Xins_A1:=(X1A+X2A)/2;
   Yins_A1:=(Y1A+Y2A)/2;
   Zins_A1:=Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.Z1;



   DisTronco(RisultCalc^.Origine,0,1,X1A,Y1A,X2A,Y2A,Zins_A1,NotVert,False,0,0,
             Lr_0,Xins_A1,Yins_A1,Zins_A1);

   Close(Fdim);
   CloseCr;

end;


(*
{ conta i tronchi in modo da sapere la % di lavoro da fare e fatta }
procedure Contatronchi(tr1,i:integer;var conta : integer);
begin
    repeat
     conta := conta+1;
     i:=i+1;
     if dati^[tr1]^.pros[i]<>0 then Contatronchi(dati^[tr1]^.pros[i],i,conta);
    until (i=6)or(dati^[tr1]^.pros[i]=0);
end;
*)

Procedure NumeraTronco(tr1:integer);

var i,x:integer;

begin
   x:=1;
   while Dati^[tr1]^.pezzi[x] <> 0 do
    begin
       with VPezzi^[Dati^[tr1]^.Pezzi[x]]^ do
       if Codice > '' then
        begin
           if RetDis(tr1,x) then
            begin
               NSecPezzi:=NSecPezzi+NumPezRet(tr1,x);
               if NumTratRet(tr1,x) > 0 then NSecPezzi:=NSecPezzi+1;
            end
           else NSecPezzi:=NSecPezzi+1;
           TabDescr[1].Descr:='Numerazione pezzo ';
           str(NSecPezzi:5,TabDescr[1].valor);
           TabDescr[1].Attrib:='';
        end;
       x:=x+1;
    end;

 if Dati^[tr1]^.PROS[1]<>0 then
  begin
  i:=0;
    {---- disegna i figli (ricorsivo)---- }
    repeat
     i:=i+1;
     if dati^[tr1]^.pros[i]<>0 then NumeraTronco(dati^[tr1]^.pros[i]);
    until (i=6)or(dati^[tr1]^.pros[i]=0);
  end;
end;

procedure main_dim;
Var Fc:Text;
    ValoreS,i:integer;
 Begin
FileTraduz:='DUCT';
(*
new(conf);
new(risultcalc);
textColor(14); {ex 7}
textbackground(1);
window(1,3,80,25);
clrscr;
gotoXy(1,3);
write(w_m(152){'Caricamento in corso...'});{*TR*}*)

{initcca;}
LoadNome;
init3d;

{
new(dis);
new(dati);
new(Vpezzi);}
{new(VaiColDim);}

new(Vettore);
{
new(Costant);
}
new(DisPezzo);
new(DisPezzo1);
{
TranSfer_Costanti(Drivearc+'Costanti.Ark','L');
for i:=1 to lungpezzi do Vpezzi^[i]:=nil;
for i:=0 to lungdis   do Dis^[i]:=nil;
new(dis^[0]);
for i:=1 to lungdati  do Dati^[i]:=nil;
}
grafica:=false;

{LoadDis(Driveprog+NomeProg);}
Sezione:=False;  {cippo}
Sez_Dim:=False;
conta:=ulttronco;

{NSecPezzi:=0;
NumeraTronco(RisultCalc^.Origine);}

Dimensionato;

NSecPezzi:=0;
NumeraTronco(RisultCalc^.Origine);

Pltizza(1,1,1,Driveprog+NomeProg);
{textcolor(7);


    for i:=1 to lungpezzi do if Vpezzi^[i]<>nil Then Dispose(Vpezzi^[i]);
    for i:=0 to lungdis   do if Dis^[i]<>nil Then Dispose(Dis^[i]);
    for i:=1 to lungdati  do if Dati^[i]<>nil Then Dispose(Dati^[i]);
    dispose(dis);
    dispose(dati);
    dispose(VPezzi);}

{Dispose(vaicoldim);}
Dispose(Vettore);
Dispose(DisPezzo);
Dispose(DisPezzo1);
grafica:=true;
close3d;
end;
end.






  X1Acr:=X1;
  Y1Acr:=Y1;
  X2Acr:=X2;
  Y2Acr:=Y2;

  Lung_Tr:=Lung_Tr/(Conf^.altNum/40);
  Lung:=Lung/(Conf^.altNum/40);

  x:=trunc(Num);
  for j:=1 to x do
   begin
      GruppoCor:=gruppocor+1;
      Vettore^.Gruppo:=Gruppocor;
      Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez];
      Vettore^.entita:='L';
      Vettore^.TLinea:=1;
      Vettore^.Colore:=Costant^.colcan;
      Vettore^.X1:=X1Acr;
      Vettore^.Y1:=Y1Acr;
      Vettore^.X2:=PuntInt(X1Acr,X3,Lung_Tr,Lung);
      Vettore^.Y2:=PuntInt(Y1Acr,Y3,Lung_Tr,Lung);
      Vettore^.R:=0;
      RaddrizzaDis(0);

      X1S:=Vettore^.X1;
      Y1S:=Vettore^.Y1;
      X1Acr:=Vettore^.X2;
      Y1Acr:=Vettore^.Y2;

      Vettore^.X1:=X2Acr;
      Vettore^.Y1:=Y2Acr;
      Vettore^.X2:=PuntInt(X2Acr,X4,Lung_Tr,Lung);
      Vettore^.Y2:=PuntInt(Y2Acr,Y4,Lung_Tr,Lung);
      Vettore^.R:=0;
      RaddrizzaDis(0);

      X2S:=Vettore^.X1;
      Y2S:=Vettore^.Y1;
      X2Acr:=Vettore^.X2;
      Y2Acr:=Vettore^.Y2;

      Lung:=Lung-Lung_Tr;

      Vettore^.X1:=X1Acr;
      Vettore^.Y1:=Y1Acr;
      Vettore^.X2:=X2Acr;
      Vettore^.Y2:=Y2Acr;
      Vettore^.R:=0;
      RaddrizzaDis(0);

      Vettore^.X1:=X1S;
      Vettore^.Y1:=Y1S;
      Vettore^.X2:=X2S;
      Vettore^.Y2:=Y2S;
      Vettore^.R:=0;
      RaddrizzaDis(0);
   end;

***************************
      X1Acr:=X1;
      Y1Acr:=Y1;
      X2Acr:=X2;
      Y2Acr:=Y2;

    {  angolo:=AngDirez-pi/2;

      if angolo > 2*pi then angolo:=angolo-2*pi;
      if angolo < 0 then angolo:=angolo+2*pi;

      if angdirez > 3.14 then angdirez:=angdirez-pi;
      if angolo < 0 then angolo:=angolo+pi;}

      Lung_Tr:=Lung_Tr/(Conf^.altNum/40);
      Lung:=Lung/(Conf^.altNum/40);
      x:=trunc(Num);
      for j:=1 to x do
      begin
      GruppoCor:=gruppocor+1;
      Vettore^.Gruppo:=Gruppocor;
      Vettore^.CodPezzo:=Dati^[tr1]^.Pezzi[Pez];
      Vettore^.entita:='L';
      Vettore^.TLinea:=1;
      Vettore^.Colore:=Costant^.colcan;
      Vettore^.X1:=X1Acr;
      Vettore^.Y1:=Y1Acr;
      Vettore^.X2:=PuntInt(X1Acr,X3,Lung_Tr,Lung);
      Vettore^.Y2:=PuntInt(Y1Acr,Y3,Lung_Tr,Lung);
      Vettore^.R:=0;
      RaddrizzaDis(0);

      X1S:=Vettore^.X1;
      Y1S:=Vettore^.Y1;
      X1Acr:=Vettore^.X2;
      Y1Acr:=Vettore^.Y2;

      Vettore^.X1:=X2Acr;
      Vettore^.Y1:=Y2Acr;
      Vettore^.X2:=PuntInt(X2Acr,X4,Lung_Tr,Lung);
      Vettore^.Y2:=PuntInt(Y2Acr,Y4,Lung_Tr,Lung);
      Vettore^.R:=0;
      RaddrizzaDis(0);

      X2S:=Vettore^.X1;
      Y2S:=Vettore^.Y1;
      X2Acr:=Vettore^.X2;
      Y2Acr:=Vettore^.Y2;

      Lung:=Lung-Lung_Tr;

      Vettore^.X1:=X1Acr;
      Vettore^.Y1:=Y1Acr;
      Vettore^.X2:=X2Acr;
      Vettore^.Y2:=Y2Acr;
      Vettore^.R:=0;
      RaddrizzaDis(0);

      Vettore^.X1:=X1S;
      Vettore^.Y1:=Y1S;
      Vettore^.X2:=X2S;
      Vettore^.Y2:=Y2S;
      Vettore^.R:=0;
      RaddrizzaDis(0);
     end;



type

     DatiCan=object
             function ndg:real;
             function nag:real;
             function TiAmbx:real;
             function RendReg(mese:integer):real;
            end;
var
    PdatiCan : ^datiCan;


implementation

function dati10.ndg:real;
begin
   ndg:=zone10^[zonacalc].NOreGiorno;
end;
function dati10.nag:real;
begin
   nag:=zone10^[zonacalc].NOreNotte;
end;
function dati10.TiAmbx:real;
begin
   TiAmbx:=zone10^[zonacalc].TAria;
end;