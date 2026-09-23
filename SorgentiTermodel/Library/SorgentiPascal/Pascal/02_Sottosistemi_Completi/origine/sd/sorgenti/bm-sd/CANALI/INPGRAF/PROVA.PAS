program prova;
const lungdis=300;
type cadrec=record
            entita:string[1];
            x1    :real;
            y1    :real;
            z1    :real;
            x2    :real;
            y2    :real;
            z2    :real;
            NPezzo:integer;
            Rid   :String[5];
            color :integer;
            tlinea:integer;
            tronco:integer; {-- Nø tronco contenente i dati  --}
            nlinea:integer; {-- prossima linea del tronco    --}
                            {-- Oppure N terminale se entita --}
                            {-- e` un terminale              --}
            flag  :boolean; {-- Serve per marcare il tratto  --}
            end;


elenco=array[0..lungdis] of cadrec;

var dis    :^elenco;
      fi   :file of cadrec;
      i    :integer;
begin
assign(fi,'p01.ret');
reset(fi);
i:=1;
new(dis);
while not(eof(fi)) do
begin
  read(fi,dis^[i]);
  writeln(dis^[i].nlinea);
end;
dispose(dis);
end.