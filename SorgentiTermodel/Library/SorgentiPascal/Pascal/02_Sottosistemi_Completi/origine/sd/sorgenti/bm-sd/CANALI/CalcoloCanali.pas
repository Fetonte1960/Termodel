Unit calcoloCanali;
interface
uses sysutils,unitcan,U_cvcan,u_cvcan1,Copialibreriagenerale,definizcan,definiz,dimens,disperrori,includitabelle;
Procedure Calcolo_Canali(percorso,nomerete:string);
Procedure Init_PuntatoriCan;
implementation
Procedure Init_PuntatoriCan;
var I:integer;
begin
new(tabcalc);
for i:=0 to maxtabcalc do
tabcalc^[i]:=nil;
new(tabcalc^[0]);
tabcalc^[0]^.riga:=0;
New(dpr1);
New(dpr2);
new(Vpezzi);
for i:=1 to lungpezzi do  vPezzi^[i]:=nil;
new(conf);
new(riduz);
new(P_cvcan1);
end;

Procedure MontaggioTerminali;
Var i,ultriga1:integer;
    dz:real;
begin
ultriga1:=ultriga;
For i:=1 to ultriga1 do
with dis^[i]^ do
if Nlinea=0 then
if dati^[tronco].pros[1]=0 then
if (dati^[tronco].term>0)and(dati^[tronco].term<=NGterm) then
if Gterm^[dati^[tronco].term]^.Montaggio<>'' then
  begin
  dz:=str_tofloat(Gterm^[dati^[tronco].term]^.Montaggio);
  if dz<>0 then
    begin
    inc(Ultriga);
    if dis^[ultriga]=nil then new( dis^[ultriga]);
    Nlinea:=Ultriga;
    dis^[ultriga]^:=dis^[i]^;
    dis^[ultriga]^.x1:=x2;
    dis^[ultriga]^.y1:=y2;
    dis^[ultriga]^.z1:=z2;
    dis^[ultriga]^.x2:=x2;
    dis^[ultriga]^.y2:=y2;
    dis^[ultriga]^.z2:=z2+dz;
    dis^[ultriga]^.Nlinea:=0;
    dis^[ultriga]^.Rid:='';
    end;
  end;
end;

Procedure Dislivelli;

Procedure iter(tr:integer;dz:real);
Var i,j,Nlineatemp:integer;
    dz1:real;
begin
i:=dati^[tr].Ti;
while i<>0 do
with dis^[i]^ do
  begin
  z1:=z1+dz;
  z2:=z2+dz;
  dz1:=str_tofloat(rid);
  rid:='';
  if dz1<>0 then
    begin
    Nlineatemp:=Nlinea;
    inc(Ultriga);
    if dis^[ultriga]=nil then new( dis^[ultriga]);
    Nlinea:=Ultriga;
    dis^[ultriga]^:=dis^[i]^;
    dis^[ultriga]^.x1:=x2;
    dis^[ultriga]^.y1:=y2;
    dis^[ultriga]^.z1:=z2;
    dis^[ultriga]^.x2:=x2;
    dis^[ultriga]^.y2:=y2;
    dis^[ultriga]^.z2:=z2+dz1;
    dis^[ultriga]^.Nlinea:=NLineaTemp;
    dis^[ultriga]^.Rid:='';
    rid:='';
    i:=ultriga;
    dz:=dz+dz1;
    end;
  i:=dis^[i]^.nlinea;
  end;
for j:=1 to  dati^[tr].NPros do iter(dati^[tr].pros[j],dz);
end;
begin
iter(risultcalc^.Origine,0);
end;



Procedure ScriviUnif3D(nomepr:string);

Var Buf:cadrec;
    FU3d:file of cadrec;
    i:integer;
begin
assign(FU3d,PercorsoDrive+'\'+Nomepr+'.U3D');
Rewrite(FU3d);
For i:=1 to  ultriga do
write(fu3d,dis^[i]^);
close(Fu3d);
end;

Procedure ScriviPezzi3D(nomepr:string);

Var Buf:recpezzi;
    FU3d:file of recpezzi;
    i:integer;
begin
assign(FU3d,PercorsoDrive+'\'+Nomepr+'.P3D');
Rewrite(FU3d);
For i:=1 to  ultpezzo do
write(fu3d,Vpezzi^[i]^);
close(Fu3d);
end;

{ TODO -oDiego -cNavigazione : Calcolo_Canali }
Procedure Calcolo_Canali(percorso,nomerete:string);
Var indiceerrore,i,indiceP:integer;
    dd:string;
begin
cwrite_e('');
percorsodrive:=percorso;
//dd:=copy(percorsodrive,1,length(percorsodrive)-length('\cadesterno')-1);
//percorso_RisorseGen:=percorsodrive;
//drivearc:=dd+'\canali\';
//chdir(dd+'\canali');
chdir(percorsodrive);
drivearc:=percorsodrive;
Montaggioterminali;
Dislivelli;
//ScriviUnif3D(nomerete);

//inderr:=0;
definizcan.nomeprog:=nomerete;
cvcan(indiceerrore);

  if indiceerrore=1 then
  begin
  calc_can;
  cvcan1(nomerete);
  main_dim(percorsodrive,nomerete);
  end;
//donewincrt;
for i:=1 to UltPezzo do
with Vpezzi^[i]^ do
  begin
  IndiceP:=find_Archivio(Codice);
  if indiceP<>0 then CODP:=archivio^[indiceP].Codice;
  end;
ScriviPezzi3D(nomerete);
//Includi(dd+'\canali');
end;

end.