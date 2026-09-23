unit esplodigrafo;

interface
uses Definiz,varcarichi, LibreriaGenerale,sysutils;
procedure Esplodireti;
implementation
function pianiuguali(Piano:string;var dz:real):integer;
Var i:integer;
begin
piano:=Uppercase(Piano);
i:=1;
while (i<Npiani)and(piano<>uppercase(piani_d^[i].Cod))do inc(i);
result:=piani_d^[i].Piani_Uguali;
dz:=piani_d^[i].AltL;
end;

procedure Esplodireti;
Var i,j:integer;
    ultriga1,ngterm1,pu:integer;
    dz:real;
begin
ultriga1:=ultriga;
for i:=1 to ultriga do
with dis^[i]^ do
  begin
  pu:=Pianiuguali(Pianocad,dz);
    if pu>1 then
    for j:=1 to pu-1 do
      begin
      inc(ultriga1);
      if dis^[ultriga1]=nil then new(dis^[ultriga1]);
      dis^[ultriga1]^:=dis^[i]^;
      dis^[ultriga1]^.PianoCAD:=dis^[ultriga1]^.PianoCAD+'_'+inttostr(j+1);
      
      if dis^[ultriga1]^.Rimando<>'' then
        begin
        dis^[ultriga1]^.Rimando:='';
        inc(ultriga1);
        if dis^[ultriga1]=nil then new(dis^[ultriga1]);
        dis^[ultriga1]^:=dis^[ultriga1-1]^;
        dis^[ultriga1]^.x2:=dis^[ultriga1]^.x1;
        dis^[ultriga1]^.y2:=dis^[ultriga1]^.Y1;
        dis^[ultriga1]^.z2:=dis^[ultriga1]^.z1+dz;
        end

      end;
  end;
ultriga:=ultriga1;

Ngterm1:=Ngterm;
for i:=1 to Ngterm do
with Gterm^[i]^ do
  begin
  pu:=Pianiuguali(Piano,dz);
    if pu>1 then
    for j:=1 to pu-1 do
      begin
      inc(ngterm1);
      if gterm^[ngterm1]=nil then new(gterm^[Ngterm1]);
      gterm^[ngterm1]^:=gterm^[i]^;
      dis^[ngterm1]^.Piano:=gterm^[ngterm1]^.Piano+'_'+inttostr(j+1);
      end;
  end;
Ngterm:=Ngterm1;

end;
end.
