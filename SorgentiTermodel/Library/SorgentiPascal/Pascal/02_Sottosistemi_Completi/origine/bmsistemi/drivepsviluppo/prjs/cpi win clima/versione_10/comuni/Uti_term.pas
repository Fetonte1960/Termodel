unit Uti_term;

interface
uses libreriagenerale;
Function Pot_sensAria(t1,t2,Portmch,POrtls:real):real;
Function Ricambio_ariamch(persmch,persls,volmch,portmch,portls:real):real;
Function PortH2oLs(POt,Dt:real):real;
function Pressat(T:real):Smallint;
Function PVapore(T,Ur:real):real;

implementation


function Pressat(T:real):Smallint;
  var
     i,j:Smallint;
type    recpres=array[1..600] of Smallint;

const Press:recpres=({$I pression.pas});

  begin
    if T < -29.9 then Pressat:=39
    else
     begin
        if T > 29.9 then Pressat:=4218
        else
         begin
            T:=T+29.9;T:=T*10+1;
            if T > 300 then T:=T+1;
            i:=round(T);
            Pressat:=Press[i];
         end;
     end;
  end;

Function PVapore(T,Ur:real):real;
begin
result:=Pressat(t)*UR/100
end;

// Utilizzo calssico
//POtenza=Pot_sensAria(T1,T2,Ricambio_ariamch(Npersone*RicambioPersonamch,Npersone*RicambioPersona,ventilazione*slorda*Alt,0,0),0));
Function Pot_sensAria(t1,t2,Portmch,POrtls:real):real;
const CaptAriamch=0.3315;
begin
if portmch=0 then portmch:=portls*3.6;
result:=RoundR(0,Portmch*CaptAriamch*(t2-t1));
end;

Function Ricambio_ariamch(persmch,persls,volmch,portmch,portls:real):real;
begin
if persmch=0 then persmch:=persls*3.6;
if portmch=0 then portmch:=portls*3.6;
result:=persmch;
if volmch>result then result:=volmch;
if portmch>result then result:=portmch;
end;
Function PortH2oLs(POt,Dt:real):real;
begin
 if dt<>0 then
 result := roundR(3,pot * 2.427184E-4/Dt)
 else result:=0;
end;
end.
