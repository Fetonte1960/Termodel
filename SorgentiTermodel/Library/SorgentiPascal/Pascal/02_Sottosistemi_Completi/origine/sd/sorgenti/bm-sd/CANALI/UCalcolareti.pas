unit UCalcolareti;

interface
Procedure CalcolaReti(percorso,Nomerete:Pchar);
Procedure InitGrafo;

implementation
uses udbt,dbtables,sysutils,definizcan,definiz,calcolocanali,InitPunt_Tubi,libreriagenerale,db,uleggiscrividati,gestudb;
Procedure InitGrafo;
Var i:integer;
begin
Iniz_PuntTubi;
new(dis);
for i:=1 to lungdis do dis^[i]:=nil;
new(dati);
for i:=1 to lungdati do dati^[i]:=nil;
new(risultcalc);
end;

Procedure Caricagrafo(percorso,Nomerete:String);
Var Buf:cadrec;
    FU3d:file of cadrec;
    Buf1:calcrec;
    FD3d:file of calcrec;
    Buf2:DatiInt;
    FO3d:file of DatiInt;
    i:integer;
begin
  assign(FO3d,Percorso+'\'+Nomerete+'.o3D');
  Reset(Fo3d);
  read(fo3d,buf2);
  risultcalc^:=buf2;
  close(Fo3d);

  assign(FU3d,Percorso+'\'+Nomerete+'.U3D');
  Reset(FU3d);
  ultriga:=0;
  while not eof(fu3d) do
    begin
    inc(ultriga);
    if dis^[ultriga]=Nil then new(dis^[ultriga]);
    read(fu3d,dis^[Ultriga]^);
    end;
  close(Fu3d);

  assign(FD3d,Percorso+'\'+Nomerete+'.D3D');
  Reset(FD3d);
  Ulttronco:=0;
  while not eof(fd3d) do
    begin
    inc(Ulttronco);
    if dati^[Ulttronco]=Nil then new(dati^[Ulttronco]);
    read(fd3d,dati^[Ulttronco]^);
    end;
  close(Fd3d);
end;
Procedure CalcolaReti1(percorso,Nomerete:string);
//{$I Datain}
begin
//Caricagrafo(percorso,nomerete);
//percorsodrive:=percorso;
//initUdbT(percorso_progetti,percorso_archivi);
Leggi_mem_Update;
//DisposeUdb;
Calcolo_Canali(percorso,nomerete);
end;

Procedure Calcolareti(percorso,nomerete:Pchar);
Var Perc:string;
    trovato:integer;
    sr:tSearchrec;
begin
Calcolareti1(strpas(percorso),strpas(nomerete));
{
if strpas(nomerete)<>'' then  Calcolareti1(strpas(percorso),strpas(nomerete))
else
  begin
  perc:=strpas(percorso)+'\*.U3D';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             Calcolareti1(strpas(percorso),copy(sr.Name,1,length(sr.name)-4));
             Trovato := FindNext(sr);
        end;
  end;
}  
end;
end.
