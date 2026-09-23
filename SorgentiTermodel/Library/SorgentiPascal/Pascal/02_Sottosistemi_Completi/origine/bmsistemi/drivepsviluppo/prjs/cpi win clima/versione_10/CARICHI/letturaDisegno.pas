unit Letturadisegno;

interface
uses UvariabiliLettura,VariabiliGenerali,proceduregrafiche,
     Libreriagenerale,varcarichi,sysutils,interfdxf;

procedure CaricaInput(nomepiano : string;var interrompi :boolean);

var     NBlocchi,UltBlocco,{UltFt,}ultblocco1,indpcor: integer;
        MinimoX,minimoy:real;

implementation
uses ulettura;
 { ......................... CaricaInputSD ............................. }

FUNCTION UnicoAmbiente:BOOLEAN;
var j,i:integer;
begin
  j:=0;
  for i:=1 to nblocchi do
  if (bll^[i].nome='AMB')  or (copy(bll^[i].nome,1,3)='NCA') then inc(j);
  result:=j=1;
end;


Procedure Azzerafrontiere;
 var i:integer;
 begin
 for i:= 1 to MaxFrontiere1 do
 with Ft^[i] do
   begin
   x0:=0;
   Y0:=0;
   Z0:=0;
   X1:=0;
   Y1:=0;
   z1:=0;
   error:=false;
   end;
 end;

procedure CaricaInput(nomepiano : string;var interrompi :boolean);

var fbl : file of blocchi;
    fft : file of front;
    m,i,j : integer;

    vic :integer;


var fdeb:text;
    //O: POggetto;
    FattoreDiscala:real;
    err:Integer;
    Tipo:char;
    Colore:string;
    CodiceEnt:string;
    x1,y1,x2,y2:real;
    entita,tpp:string;
    finePiano:boolean;

{Coordinate minori di 0 }
Procedure CMinx(vv:real);
begin
if vv<Minimox then minimox:=vv;
end;
Procedure CMinY(vv:real);
begin
if vv<Minimoy then minimoy:=vv;
end;

BEGIN
     // Modifica by Piero
     if NomePiano <> '' then
        pianocor:=Flettura.ComboBox1.Text;

 // val(FormTesto.edit1.text,FattoreDiScala,err);
  //fattorediscala:=fattorediscala/100;
  fattorediscala:=100;
  InitFrontiere1;
  InitBlocchi;
  Azzerafrontiere;
  UltBlocco:=0;
  ultft:=0;
  FinePiano:=false;
  MinimoX:=10E6;
  MinimoY:=10E6;
  //InitVariabili;
  Driveplt := IncludeTrailingPathDelimiter(percorsodrive);
  while (not eof(fdis))and(not finepiano) do
    begin
    readln(fdis,Bufdis);
    azzeraIdentif;
    entita:=Leggiidentif1(Bufdis);
    Tipo:='-';
    If upstring(entita)='PIANO' then
      begin
      if Nomepiano='' then
        begin
        pianocor:=Flettura.ComboBox1.Text;
        TPP:=Uppercase(Leggiidentif1(Bufdis));
        //if length(tpp)>10 then tpp:=copy(tpp,1,10);
        Flettura.ComboBox1.Text:=tpp;
        Flettura.ComboBox1.Items.Add(Flettura.ComboBox1.Text);
        i:=1;
        while (i<Npiani)and(Uppercase(Flettura.ComboBox1.Text)<>uppercase(Piani_d^[i].Cod)) do inc(i);
        if (NPiani=0)or(Uppercase(Flettura.ComboBox1.Text)<>uppercase(Piani_d^[i].Cod)) then
          begin
          Inc(NPiani);
          Piani_d^[Npiani].NPPiano:=0;
          Piani_d^[Npiani].Cod:=Flettura.ComboBox1.Text;
          indpcor:=Npiani;
          end
         else indpcor:=i;
        Piani_d^[Indpcor].NPPiano:=0;
        end;
      if ultft<>0 then finepiano:=true
      else
         pianocor:=Flettura.ComboBox1.Text;
      end
    else
      begin
      If upstring(entita)='NORD' then
        begin
        direzNord:=360-str_tofloat(Leggiidentif1(Bufdis))+90;
        end
      else
        begin
        tipo:=entita[1];
        CodiceEnt:=Leggiidentif1(Bufdis);
        end;
      end;

   //with Buffig do
      case Tipo of
      'M':begin
          Colore:=Leggiidentif1(Bufdis);
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          x2:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y2:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminx(x2);cminy(y1);cminy(y2);
          controllodoppielinee(ultft);
          inc(ultFt);
          Ft^[ultft].colore:=colore;
          Ft^[ultft].x0:=x1;
          Ft^[ultft].y0:=y1;
          Ft^[ultft].z0:=0;
          Ft^[ultft].x1:=x2;
          Ft^[ultft].y1:=y2;
          Ft^[ultft].z1:=0;
          Ft^[ultft].error:=false;
          Ft^[ultft].TLinea:=Restoidentif(Bufdis);//Leggiidentif1(Bufdis); modifica doppia parete
          //PareteSemp(x1,y1,x2,y2,0.001,0.1);
          if Nomepiano='' then
            begin
            inc(Piani_d^[indpcor].NPPiano);
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Tipo:='Parete';
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Cod:=colore;
            azzeraidentif;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Alt:=str_tofloat(leggiidentif1(Ft^[ultft].TLinea));
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Alt2:=str_tofloat(leggiidentif1(Ft^[ultft].TLinea));
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Confine:=leggiidentif1(Ft^[ultft].TLinea);
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].X1:=x1/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Y1:=Y1/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].X2:=X2/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Y2:=Y2/fattorediscala;
            Piani_d^[indpcor].ParL[Piani_d^[indpcor].NPPiano].Item:=Piani_d^[indpcor].NPPiano;
            end;
          end;
      'L':begin
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminy(y1);
          inc(ultblocco);
           with blL^[Ultblocco] do
             begin
             Nome:='AMB';
             Attrib1[1]:=CodiceEnt;
             Attrib1[2]:=Leggiidentif1(Bufdis); //Descrizione
             Attrib1[3]:=Leggiidentif1(Bufdis); //altezza
             Attrib1[4]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //zona-impianto
             Attrib1[5]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //Pavimento
             Attrib1[6]:=Leggiidentif1(Bufdis)+':'+Leggiidentif1(Bufdis)+':'; //Soffitto
             X:=X1;
             y:=Y1;
             end;
          end;
      'F':begin
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminy(y1);
          inc(ultblocco);
           with blL^[Ultblocco] do
             begin
             Nome:='FIN';
             //Attrib1[1]:=inttostr(CodiceEnt);
             Attrib1[1]:=Leggiidentif1(Bufdis);
             Attrib1[3]:= Leggiidentif1(Bufdis);
             Attrib1[4]:= Leggiidentif1(Bufdis);
             Attrib1[2]:=Float_to_str(str_tofloat(Attrib1[3])*str_tofloat(Attrib1[4]),3);

             //Attrib1[1]:=Leggiidentif1(Bufdis);
             //Attrib1[2]:=Leggiidentif1(Bufdis);
             X:=X1;
             y:=Y1;
             end;
          end;
      'P':begin
          x1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          y1:=str_tofloat(Leggiidentif1(Bufdis))*FattoreDiscala;
          cminx(x1);cminy(y1);
          inc(ultblocco);
           with blL^[Ultblocco] do
             begin
             Nome:='PON';
             //Attrib1[1]:=inttostr(CodiceEnt);
             Attrib1[1]:=Leggiidentif1(Bufdis);
             Attrib1[2]:=Leggiidentif1(Bufdis);
             X:=X1;
             y:=Y1;
             end;
          end;
      end;
    end;

  ScriviInterfDXF;  
  controllodoppielinee(ultft);
  If (minimox<=0)or(minimoy<=0) then
    begin
    if minimox>0 then minimox:=0;
    if minimoy>0 then minimoy:=0;
    for i:= 1 to ultblocco do
      begin
      blL^[i].x:=blL^[i].x-Minimox+0.1;
      blL^[i].y:=blL^[i].y-Minimoy+0.1;
      end;
    for i:= 1 to ultft do
      begin
      Ft^[i].x1:=Ft^[i].x1-Minimox+0.1;
      Ft^[i].x0:=Ft^[i].x0-Minimox+0.1;
      Ft^[i].y1:=Ft^[i].y1-Minimoy+0.1;
      Ft^[i].y0:=Ft^[i].y0-Minimoy+0.1;
      end;
    end
  else
    begin
    minimox:=0;
    minimoy:=0;
    end;

  fts^:=ft^;
  i:=Ultblocco+1;
  m:=Ultblocco+1;
  NBLOCCHI := ULTBLOCCO;
  Ultblocco1:=UltBlocco;
  unicoamb:=unicoambiente;
  //unicoamb:=false;
  unicoamb1:=false;

  //AssignFile(ffig,drivprg+'\Prova2.d02');
  //Rewrite(ffig);

end;
end.
