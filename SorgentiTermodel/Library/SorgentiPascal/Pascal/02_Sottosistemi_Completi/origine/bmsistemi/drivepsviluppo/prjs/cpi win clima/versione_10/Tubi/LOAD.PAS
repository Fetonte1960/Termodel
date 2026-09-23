unit load;

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
   iotubi,
   UUtigen,
   LibreriaGenerale;


function LungTXT(Nomeprn:string):integer;

procedure WriteTemp(Nome:st80);

Procedure StampaTestata(var rig : integer;page : integer);

procedure AltraPagina(var Pag,Riga : integer);

procedure InitRis;

Procedure LoadDis(nomedis:string);

procedure existsottorete(nome:string;var esiste:boolean);

Procedure SaveDis(Nome:string);

Procedure TrovaSottoreti;

Procedure CercaSfavorito;

procedure SettaLaStampante(var ok : boolean);

{ ************************************************************************ }
implementation

{***************************  LungTXT *************************************}

 function LungTXT(Nomeprn:string):integer;
 var f     : text;
     j     : integer;
     R     : st80;
begin
  lungtxt:=0;
  exit;
  ltx := ltx+1;
{  writeln(ltx,'   ',nomeprn);
  repeat until keypressed;
  settadriveprn(nomeprn); }
  assign(f,Nomeprn);
  reset(f);
  j:=0;
  while not eof(f) do
  begin
    j:=j+1;
    readln(f,R);
  end;
  close(f);
  LungTXT:=j;
end;

{***************************  WRITETEMP  *******************************}

procedure WriteTemp(Nome:st80);
  var f:text;
      Riga:st126;
  begin
     assign(f,Nome);
     reset(f);
     while not eof(f) do
      begin
         readln(f,Riga);
         writeln(ft,Riga);
      end;
     close(f);
  end;

{***************************  STAMPATESTATA *********************************}

Procedure StampaTestata(var rig : integer;page : integer);
 begin
   NomProgetto.data := Generalita_D^.data; {data di revisione del progetto}
   NomProgetto.progetto := numeroprog1;
   NomProgetto.pagina   := page;

{***  StampaMask(SEG(NomProgetto),OFS(NomProgetto),'Prog.prn',true);}

  rig := rig + LungTXT('Prog.prn');
 end;

{***************************  ALTRAPAGINA **********************************}

 procedure AltraPagina(var Pag,Riga : integer);
 var i : integer;
 begin
    Riga := riga+1;

    for i:=Riga to MaxRighe do writeln(glst);

    SaltoPag;

    riga := 0;

    StampaTestata(riga,pag);

    Pag:=Pag+1;
 end;


{ ************************** INITRIS ************************************** }

procedure InitRis;

begin
  with RisulTCalc^ do
  begin
    Origine:=0;
    Portata:=0;
    Perdita:=0;
    Sbil   :=0;
    Sfavor :=0;
  end;
end;


{************************** LOADDIS*****************************************}

Procedure LoadDis(nomedis:string);

var i     :integer;
    estens:string;

begin

{if wr then
Writeln(lst,' Loaddis:',Nomedis,'  ',Manrip);}


if ManRip then estens := '.dtr' else estens := '.dta';
UltTronco:=1;
if exist(nomedis+estens) then
begin
  i:=1;
  assign(fr,nomedis+estens);reset(fr);
  while not(eof(fr)) and (i<=lungDati) do
  begin
    if dati^[i] =nil then new(dati^[i]);
    read(fr,dati^[i]^);
    i:=i+1;
  end;
  UltTronco:=i-1;
  close(fr);
end
else
begin
  Ulttronco:=1;
  new(dati^[UltTronco]);
  dati^[UltTronco]^.Ti:=0;
end;
Ntronchi:=ultTronco;

if ManRip then estens := '.ter' else estens := '.tea';
UltGTerm:=1;
if exist(nomedis+estens) then
  begin
  i:=1;
  assign(fGT,nomedis+estens);reset(fgt);
  while not(eof(fgt)) and (i<=MaxGTErm) do
    begin
      IF GTerm^[i] =NIL then new(GTerm^[i]);
      read(fgt,GTerm^[i]^);
      i:=i+1;
    end;
    UltGTerm:=i-1;
    close(fgt);
  end
  else
    begin
    UltGTerm:=1;
    new(GTerm^[UltGTerm]);
    GTerm^[UltGTerm]^.Cod:='';
    end;

NGTerm:=ultGTerm;

if ManRip then estens := '.ris' else estens := '.ria';

if exist(nomedis+estens) then
begin
  assign(frisult,nomedis+estens);
  reset(frisult);
  read(frisult,RisulTCalc^);
  close(FRisult);
end
else initris;
end;



{************************** SAVEDIS*****************************************}

Procedure SaveDis(Nome:string);
var i:integer;
    estens:string;

begin

{  if wr then
  Writeln(lst,' Savedis:',Nome,'  ',Manrip);}

  if ManRip then estens:= '.dtr' else estens:= '.dta';
  assign(fr,nome+estens);rewrite(fr);
  for i:=1 to ulttronco do write(fr,dati^[i]^);
  close(fr);

  if ManRip then estens:= '.ter' else estens:= '.tea';
  assign(fgt,nome+estens);rewrite(fgt);
  for i:=1 to ultgterm do write(fgt,GTerm^[i]^);
  close(fgt);

  if ManRip then estens:= '.ris' else estens:= '.ria';
  assign(fRisult,nome+estens);
  rewrite(fRisult);
  write(fRisult,RisulTCalc^);
  close(fRisult);

end;

{***************************  ExistSottorete  ******************************}

procedure existsottorete(nome:string;var esiste:boolean);

var i:integer;
begin
  for i:=1 to maxsot do elsot[i]:='';
  if exist(driveprog+nome+'.sot') then
  begin
    assign(fa,driveprog+nome+'.sot');
    reset(fa);
    read(fa,vprog^);
    close(fa);
    i:=1;
    repeat
     if vprog^[i].nome<>''then
     begin
     elsot[i]:=vprog^[i].nome;
     i:=i+1;
     end
    until (vprog^[i].nome='')or (i>maxsot);
     i:=i-1;
    nsot:=i;
    if nsot>0 then esiste:=true;
  end
    else
    begin
    nsot:=0;
    esiste:=false;
    end;

end;
{************************** SAVEDIS*****************************************}

(* Procedure SaveDis(Nome:string);
   var i:integer;

begin

{ assign(fi,Nome+'.ret');rewrite(fi);
 for i:=1 to ultriga do write(fi,dis^[i]);
 close(fi);}

 assign(fr,nome+'.dtr');rewrite(fr);
 for i:=1 to ulttronco do write(fr,dati^[i]);
 close(fr);

 assign(fgt,nome+'.ter');rewrite(fgt);
 for i:=1 to ultgterm do write(fgt,GTerm^[i]);
 close(fgt);

{ assign(fconf,Nome+'.con');
 rewrite(fconf);
 write(fconf,conf);
 close(fconf);}

end;

*)

{ ************************* TROVASOTTORETI ******************************** }

Procedure TrovaSottoreti;
var k : integer;
begin
  CisonoSottoreti := false;
  ExistSottorete(numeroprog1,CiSonoSottoreti);
end;



{ ************************* CercaSfavorito ****************************** }

Procedure CercaSfavorito;
{.. Procedura che setta la variabile globale SottoreteSfavorita
    indicante la rete col percorso + sfavorito di tutti         ..}

begin
  Sfavorito := 0;
  SfavoritoSot := 0;
  IndiceSfavorito := 0;
  SottoreteSfavorita :='';

  if (not manrip) and (rit=2) then exit;
  {rit=1=solo mandata; rit=2= mandata e ritorno=non calcolare lo sfavorito}

  SottoreteSfavorita := '';
  if GTerm^[Dati^[RisulTCalc^.Sfavor]^.Term]^.NumTer=0 then
    begin
       Sfavorito := Dati^[RisulTCalc^.Sfavor]^.Num;
       SfavoritoSot := 0;
       IndiceSfavorito := 0;
    end
  else
    begin
       Sfavorito := 0;
       SottoreteSfavorita  := elsot[GTerm^[Dati^[RisulTCalc^.Sfavor]^.Term]^.NumTer];
       indicesfavorito := GTerm^[Dati^[RisulTCalc^.Sfavor]^.Term]^.NumTer;
    end;
end;



{ ************************* SettaLaStampante ****************************** }

procedure SettaLaStampante(var ok : boolean);
{.. settaggio stampante per i vari formati carta ..}
var   f1 : file of recstamp;
      err: boolean;
      riga:string[126];
      lpt1,lpt2,lpt3,com1,com2:text;


begin
(*
 ok := true;

 riga:=chr(24)+chr(27)+chr(67)+chr(vstamp.lungmod);
  if vstamp.portap>0 then
  begin
    case vstamp.portap of
      1:begin
          assign(lpt1,'lpt1');
          rewrite(lpt1);
        end;
      2:begin
          assign(lpt2,'lpt2');
          rewrite(lpt2);
        end;
      3:begin
          assign(lpt3,'lpt3');
          rewrite(lpt3);
        end;
    end;
  end;
  if keypressed then ch:=readkey;
  repeat
  err:=false;
  {$I-}
  if vstamp.portap>0 then
  begin
   case vstamp.portap of
     1:writeln(lpt1,riga);
     2:writeln(lpt2,riga);
     3:writeln(lpt3,riga);
   end;
  end;
  {$I+}

  if ioresult<>0 then
         begin
           err:=true;
           clrscr;

           if Conferma('stampeT.msg','',1) then
            begin {fine stampa}
              ok := false;
              exit;
            end
        end;

    until err<> true;

  if vstamp.portap>0 then
        begin
          case vstamp.portap of
            1:close(lpt1);
            2:close(lpt2);
            3:close(lpt3);
          end;
        end;
*)
end;


end.