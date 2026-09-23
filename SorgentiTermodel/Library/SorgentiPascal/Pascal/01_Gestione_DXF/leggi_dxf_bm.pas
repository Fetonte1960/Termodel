unit leggi_dxf_bm;

interface
uses Uvariabililettura,varcarichi,dxf_in_out,libreriagenerale,sysutils,windows,duplicapiani,dbtables;
Procedure Leggidxf_bm;
implementation
uses cpi_win_clima_Cadlt;
Procedure Leggidxf_bm;

type Datilink=record
              tipo:char;
              cod,descr,piano:string[50];
              x,y,z,ang:real;
              end;
const maxsot=50;
      fattorediscala=100;
{$I M_Daticad}
Var Buf:CadRec;
    FHT:File of CadRec;
    BufT:RecGTerm;
    FHTT:File of RecGTerm;
    BufO:DatiLink;
    FHTO:File of DatiLink;
    BufF:front;
    FHTF:File of front;
    FHTB:File of Uvariabililettura.BLOCCHI;
    BufB:Uvariabililettura.BLOCCHI;
    Nomefile,perc,lay,nomerete: String;
    sr:Tsearchrec;
    trovato:integer;

function coloretubo(codtubo:string):string;
Var ttt:TTable;
begin
result:='1';
codtubo:=uppercase(codtubo);
ttt:=tTable.create(nil);
with ttt do
  begin
  databasename:=Percorso_progetti;
  tablename:='Tipirete';
  open;
  first;
  while (not eof) and ( uppercase( fieldbyname('Codice').value ) <>codtubo) do  next;
  if uppercase(fieldbyname('Codice').value)=codtubo then
  result:=inttostr(indcolore(fieldbyname('Colore').value));
  free;
  end;
end;
begin
nentita:=0;
copyfile(pchar(percorsodrive+'\prototipo.dxf'),pchar(percorsodrive+'\intestazionedxf.txt'),false);

if fileexists(percorsodrive+'\intdxf.rtt') then
  begin
  assign(fht,percorsodrive+'\intdxf.rtt');
  reset(Fht);
  while not eof(FHT) do
    begin
    read(FHT,Buf);
    with buf do
      begin
      if rimando<>'' then
        begin
        Add_BloccoDxf(x1,y1,z1,0,'RIMRETED',IndcodPiano(piano)+'_TUBISIMB');
        Add_AttribDxf(x1-1,y1,z1,'CODICE',rimando);
        Add_BloccoDxf(x2,y2,z2,0,'RIPRETED',IndcodPiano(piano)+'_TUBISIMB');
        Add_AttribDxf(x2-1,y2,z2,'CODICE',rimando);
        end
      else
        begin
        lay:=IndcodPiano(pianocad);
        if CL then lay:=lay+'_COLLE'
        else lay:=lay+'_TUBI';
        if lay='' then lay:='Non_definito';
        Add_LineaDxf(x1,y1,z1,x2,y2,z2,lay,coloretubo(tipo),'Continuous');
        end;
      end;
    end;
  close(fht);


  assign(fhtO,percorsodrive+'\intdxf.lkk');
  reset(FhtO);
  while not eof(FHTO) do
    begin
    read(FHTO,BufO);
    with bufO do
    case tipo of
    'I':begin
        Add_BloccoDxf(x,y,z,0,'IRETED',IndcodPiano(piano)+'_TUBISIMB');
        Add_AttribDxf(x-1,y+0.3,z,'CODICE',Cod);
        Add_AttribDxf(x-1,y+0.6,z,'Tiporete',Descr);
        end;
    end
    end;
  close(fhtO);
  end;


perc:=percorsodrive+'\*.fxf';
Trovato := FindFirst(perc,faarchive,sr);
  while Trovato = 0 do
  begin
  perc := percorsodrive + '\' + sr.Name;
  assign(FhtF,perc);
  reset(fhtf);
  perc:=extractfilename(perc);
  perc:=copy(perc,1,length(perc)-4);
  while not eof(fhtf) do
    begin
    read(fhtf,buff);
    with buff do
      begin
      Add_LineaDxf(x0/FattoreDiscala,y0/FattoreDiscala,z0/FattoreDiscala,x1/FattoreDiscala,y1/FattoreDiscala,z1/FattoreDiscala,IndcodPiano(perc),{coloretubo(tipo)}'1','Continuous');
      end;
    end;
  close(fhtf);
  Trovato := FindNext(sr);
 end;

perc:=percorsodrive+'\*.Bxf';
Trovato := FindFirst(perc,faarchive,sr);
  while Trovato = 0 do
  begin
  perc := percorsodrive + '\' + sr.Name;
  assign(FhtB,perc);
  reset(fhtB);
  perc:=extractfilename(perc);
  perc:=copy(perc,1,length(perc)-4);
  while not eof(fhtB) do
    begin
    read(fhtB,bufB);
    with bufB do
    if nome='AMB' then
      begin
      x:=x/fattorediscala;
      y:=y/fattorediscala;
      Add_BloccoDxf(x,y,0,0,'LOC_',IndcodPiano(perc));
      {
      Attrib1[1]:=CodiceEnt;
      Attrib1[2]:=Leggiidentif1(Bufdis); //Descrizione
      Attrib1[3]:=Leggiidentif1(Bufdis); //altezza
      Attrib1[4]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //zona-impianto
      Attrib1[5]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //Pavimento
      Attrib1[6]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //Soffitto
      }
      Add_AttribDxf(x-1,y-0.3,0,'COD',Attrib1[1]);
      Add_AttribDxf(x-1,y-0.6,0,'DESCR.',Attrib1[2]);
      azzeraidentif;
      Add_AttribDxf(x-1,y-0.9,0,'ZONA',leggiidentif1(Attrib1[4]));
      Add_AttribDxf(x-1,y-1.2,0,'IMPIANTO',leggiidentif1(Attrib1[4]));
      azzeraidentif;
      Add_AttribDxf(x-1,y-1.8,0,'TPAV',leggiidentif1(Attrib1[5]));
      Add_AttribDxf(x-1,y-2.0,0,'CPAV',leggiidentif1(Attrib1[5]));
      azzeraidentif;
      Add_AttribDxf(x-1,y-2.2,0,'TSOF',leggiidentif1(Attrib1[6]));
      Add_AttribDxf(x-1,y-2.4,0,'CSOF',leggiidentif1(Attrib1[6]));
      end;
    end;
  close(fhtB);
  Trovato := FindNext(sr);
 end;


{
nome:=percorsodrive+'\
assign(fhtt,Nome);
reset(Fhtt);
while not eof(FHTt) do
  begin
  read(FHTt,Buft);
  with buft do
    begin
    end;
  end;
  close(fhtt);
 }
output_dxf(percorsodrive+'\disegno.dxf');
end;


end.
