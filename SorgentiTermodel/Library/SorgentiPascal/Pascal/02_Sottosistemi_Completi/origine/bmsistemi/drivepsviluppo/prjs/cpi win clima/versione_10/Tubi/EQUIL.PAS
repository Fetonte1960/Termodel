unit equil;

interface

uses
   {crt,
   dos,
   printer,
   print,
   defuti,
   utilitie,}
   {tubivar}definiz,varcarichi,
   {wm,}
   iotubi,UUtigen, LibreriaGenerale;



procedure equilibratura1;

{ ************************************************************************ }
implementation


{***************************  ISot  ******************************}

Function Isot:integer;

Begin
  if wr then
  Writeln(lst,'Indsot :',Manrip);   {  Indsot : }

  if Manrip then Isot:=1 else Isot:=2;

End;



{***************************  Elev          *******************************}

Function Elev(a,b:real):real;

begin
elev:=exp(b*ln(a));
end;


{***************************  F0              *******************************}

Function F0(form:integer;D0,E1,V0,Ni,dens,Q0:real):real ;

var
    re,C0,C1,C2,F1:real;

{
form2:  F0=5.3740442/(8*dens#)*PI^2*D0^.1345*(ABS(VO)*PI*D0^2/4)^(-.148):F(j)=F0:RETURN
form3:  F0=9806.65*(.00328+.00084/D0)/(8*DENS#)*PI^2                    :F(j)=F0:RETURN
form4:  F0=9.6497436/(8*DENS#)*PI^2*D0^.22*(ABS(VO)*PI*D0^2/4)^(-.22)   :F(j)=F0:RETURN
form5:  F0=17.279317/(8*DENS#)*PI^2*D0^.28*(ABS(VO)*PI*D0^2/4)^(-.18)   :F(j)=F0:RETURN
form6:  F0=11.238421/(8*DENS#)*PI^2*D0^.19*(ABS(VO)*PI*D0^2/4)^(-.19)   :F(j)=F0:RETURN
form7:  F0=2*D0/VO^2/DENS#*87.1*1E+04*(1+91.44/(D0*1E+03)+.0018*(D0*1E+03))*(Q0*3600)^2/(D0*1E+03)^5*DENS#/1.25:F(j)=F0:RETURN
}

begin

  case form of

  1:begin              {-- Darcy e coeff. Colebruc --}
    re:=abs(V0*D0/NI);
    if re >2000 then
      begin
      F1:=0.0001;
        repeat
        C0:=E1/(D0*3.7)+2.51/(SQRT(F1)*RE);
        C1:=-2*ln(C0)/2.302585-1/SQRT(F1);
        C2:=C1/((1/2.302585*2.51/RE/C0+0.5)/elev(F1,1.5));
        if abs(C2)>0.0001 then F1:=F1-C2
        until abs(C2)<=0.0001;
      F0:=F1
      end
    else F0:=64/re
    end;

  2:F0:=5.3740442/(8*dens)*sqr(PI)*elev(D0,0.1345)*
             elev((ABS(V0)*PI*sqr(D0)/4),(-0.148));

  3:F0:=9806.65*(0.00328+0.00084/D0)/(8*DENS)*sqr(PI);

  4:F0:=9.6497436/(8*DENS)*sqr(PI)*elev(D0,0.22)*
              elev(ABS(V0)*PI*sqr(D0)/4,(-0.22));

  5:F0:=17.279317/(8*DENS)*sqr(PI)*elev(D0,0.28)*
            elev((ABS(V0)*PI*sqr(D0)/4),(-0.18));

  6:F0:=11.238421/(8*DENS)*sqr(PI)*elev(D0,0.19)*
           elev((ABS(V0)*PI*sqr(D0)/4),(-0.19));

  7:F0:=2*D0/sqr(V0)/DENS*87.1*1E+04*(1+91.44/(D0*1E+03)+0.0018*(D0*1E+03))*
                                sqr(Q0*3600)/elev((D0*1E+03),5)*DENS/1.25;

  end;
end;


{$I Perdconc.pas}












{************************* EQUILIBRATURA1     *******************************}

Procedure Equilibratura1;

var tr     :integer;
    TotPerd:real;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Equilibra1       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

procedure Equilibra1(TR:integer;deltap:real);

var i,j,k:integer;
    Diametro,Portata,Velocita,Perdita:real;  {-- Espresse in SI --}
    MaxPerd  :real;
    Trovato  :boolean;
    TipoPerd :integer;
    PerdTerm :real;


begin

with dati^[tr]^ do
if swdiam<>'*' then
  begin
  i:=0;
    repeat
    i:=i+1;
    until (Upstring(tipo)=Upstring(Tubaz_D^[i].Cod))or(i=Maxtubaz);

    if (i=maxtubaz)and(Upstring(tipo)<>Upstring(Tubaz_D^[i].Cod)) then
    writeln('Tipo tubazione '+Tipo+' non trovata');

                   {-- Calcolo Diametro --}
    begin
    j:=0;
    Trovato:=false;
    Perdita:=0;
    MaxPerd:=Generalita_D^.DPE;

      repeat
      if  Tubaz_D^[i].sez[j+1].Dint >0 then
      begin
        j:=J+1;
        Diametro:=Tubaz_D^[i].sez[j].Dint/1000;
        Portata :=Dati^[tr]^.porteff/1000;

        {writeln(lst,'j ',j,' ',diametro:7:6,' ',(PI*sqr(diametro)):7:6);}

        Velocita:=4*Portata/(PI*sqr(diametro));

        if velocita <= Generalita_D^.Maxvele then
        begin
          Perdita:=F0(Tubaz_D^[i].sez[j].Form  ,
                    Diametro                 ,
                    Tubaz_D^[i].Rug/1000     ,
                    Velocita                 ,
                    FluM_D^.Visc/FluM_D^.Dens,
                    FluM_D^.Dens             ,
                    Portata                   )*
                    sqr(Velocita)*FluM_D^.dens/(2*Diametro);

           if (perdita<=MaxPerd) then trovato:=true;

           if (Trovato) then
           begin
             pl:=0;
             for k:=1 to 5 do
             if (Pconc[k].cod<>'')and(Pconc[k].N<>0) then
             Pl:=pl+PerdConc(Pconc[k].cod,velocita,perdita,diam,tipoperd)*
                                                          (Pconc[k].N);
             pl:=pl/1E3;
             Pd:=Perdita*Lungh/1E3+FluM_D^.dens*DH*9.81/1E3;


            PerdTerm:=0;
            if (term<>0) then
            begin
              if (not reteprinc)or(GTerm^[term]^.NumTer=0)  then

              begin
                if (GTerm^[term]^.Taratura<>'') then
                GTerm^[term]^.Perd:=
                PerdConc(GTerm^[term]^.Taratura,velocita,perdita,diam,tipoperd)/(Divrit*1E3);
                PerdTerm:=GTerm^[term]^.Perd;
              end;
            end;
            if pd+pl+PerdTerm>Deltap then Trovato:=false;
          end;
        end;
      end
      else trovato:=true;
      Until (j=MaxSez)or(Trovato);
    CodDiam:=Tubaz_D^[i].sez[j].DNom;

    end;

  pp:=0;
  diam:=Tubaz_D^[i].sez[j].Dint;
  end

end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  IterEquil1       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function IterEquil1(tr1:integer;PRamo:real):real;

var

PerdFavorito :real;
PerdSfavorito:real;
VecchiaPSfav  :real;
Favorito     :integer;
Sfavorito    :integer;
pres,DeltaP  :real;
i            :integer;
PerdTerm :real;

begin


PerdFavorito :=100000;
PerdSfavorito:=0;
Favorito     :=0;
Sfavorito    :=0;
DeltaP:=PRamo;

if dati^[tr1]^.term=0 then
  begin
  PerdTerm:=0;
  i:=0;
  repeat               {-- Trova il piu` favorito --}
    i:=i+1;
    if dati^[tr1]^.pros[i]<>0 then
    begin
      if PerdFavorito>dati^[dati^[tr1]^.pros[i]]^.pr then
      begin
        PerdFavorito:=dati^[dati^[tr1]^.pros[i]]^.pr;
        Favorito:=i;
      end;
      if PerdSFavorito<dati^[dati^[tr1]^.pros[i]]^.pr then
      begin
        PerdSFavorito:=dati^[dati^[tr1]^.pros[i]]^.pr;
        SFavorito:=i;
      end;
    end;

  until (i=6)or(dati^[tr1]^.pros[i]=0);


  DeltaP:=PRamo-Dati^[tr1]^.pr;
  VecchiaPSfav:=PerdSfavorito;

  perdsfavorito:=IterEquil1(dati^[tr1]^.pros[sfavorito],DeltaP+PerdSFavorito);

  i:=0;
  repeat
    i:=i+1;
    if (dati^[tr1]^.pros[i]<>0)and(i<>sfavorito) then
    pres:=IterEquil1(dati^[tr1]^.pros[i],DeltaP+VecchiaPSFav);
    if pres>perdsfavorito then perdsfavorito:=pres;
  until (i=6)or(dati^[tr1]^.pros[i]=0);

  end

else

  begin
  PerdTerm:=0;
  if (reteprinc)and(GTerm^[dati^[tr1]^.term]^.NumTer<>0) then
  PerdSfavorito:=DatiSot^[GTerm^[dati^[tr1]^.term]^.NumTer,isot].Perdita
  else
    begin
    PerdSfavorito:=GTerm^[Dati^[tr1]^.term]^.Perd;
    PerdTerm:=GTerm^[dati^[tr1]^.term]^.Perd;
    end;
  end;

DeltaP:=PRamo-PerdSfavorito+PerdTerm;

if ((DeltaP-Dati^[tr1]^.pl-Dati^[tr1]^.pd-perdterm)>0.1)and(Dati^[tr1]^.porteff>0)
then Equilibra1(tr1,DeltaP);

Dati^[tr1]^.pr:=PerdSfavorito+Dati^[tr1]^.pl+Dati^[tr1]^.pd;

IterEquil1:=Dati^[tr1]^.pr;

end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*       Main      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

begin

if reteprinc then
  begin
  PerditaTotale:=RisultCalc^.perdita;
  RisultCalc^.perdita:=IterEquil1(RisultCalc^.Origine,RisultCalc^.Perdita);
  end
else
RisultCalc^.perdita:=IterEquil1(RisultCalc^.Origine,PerditaTotale-RisultCalc^.Sbil);
end;

end.