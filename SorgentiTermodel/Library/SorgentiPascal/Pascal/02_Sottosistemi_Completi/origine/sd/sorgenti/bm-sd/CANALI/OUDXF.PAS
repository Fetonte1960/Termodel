Procedure outdxf(nomefile:string);
const
    Piano='  8';
    Nomi ='  2';
    Testo='  1';
    TLin ='  6';
    Pxi  ='  10';
    Pyi  ='  20';
    pzi  ='  30';
    AltT ='  40';
    pxf  ='  11';
    pyf  ='  21';
    Color='  62';
    Fine ='  0';
    FX=1.0;
    FY=1.0;

var f:text;
    i:integer;
    f1:text;
    j:integer;
    s1,s2,s3,s4:string;

Procedure Disetic1(simb,tipo,nrec:integer;x,y,ing:real);
var i:integer;
    xins,yins:real;
begin
  writeln(f1,'  41');
  s4:='';
  str(ing:5:4,s4);
  writeln(f1,s4);
  writeln(f1,'  42');
  writeln(f1,s4);
  writeln(f1,'  43');
  writeln(f1,s4);
  writeln(f1,fine);
  s4:='';
  i:=elsimb[simb].iniz;
  for i:=elsimb[simb].iniz+1 to elsimb[simb].fin do
  with tabella[i] do
  case codice[1] of
    'ù':begin

          if nrec=0 then st1:=''
          else
            begin
              case UPCASE(codice[2]) of
              'N':case tipo of                    {--- Numero tronco ---}
                  1:str(nrec,st1)
                  end;
              'D':case tipo of                    {--- Diamentro     ---}
                  1:str(dati^[nrec].diam:3:2,st1)
                  end;
              'P':case tipo of                    {--- Portata       ---}
                  1:str(dati^[nrec].port:4:3,st1)
                  end;
              'C':begin
                    writeln(f1,'ATTRIB');
                    writeln(f1,piano);
                    writeln(f1,'0');
                    st1:=GTerm^[nrec].cod;
                  END;
             'S':BEGIN
                   if GTerm^[nrec].Taratura='' then
                   str(GTerm^[nrec].sbil:4:3,st1)
                   else st1:=GTerm^[nrec].Taratura;
                   writeln(f1,'ATTRIB');
                   writeln(f1,piano);
                   writeln(f1,'0');
                 end;
              end
            end;
          real1:=(x+(punti[1].x)*ing)*FX;
          real2:=(y+(punti[1].y)*ing)*FY;
          writeln(f1,pxi);
          str(real1:6:5,s4);
          writeln(f1,s4);
          s4:='';
          writeln(f1,pyi);
          str(real2:6:5,s4);
          writeln(f1,s4);
          s4:='';
          writeln(f1,altt);
          real1:=0.8*ing;
          str(real1:6:5,s4);
          writeln(f1,s4);
          s4:='';
          writeln(f1,'  1');
          writeln(f1,st1);
          writeln(f1,nomi);
          case upcase(codice[2]) of
          'C':writeln(f1,'COD');
          'S':writeln(f1,'SBIL');
          end;
          writeln(f1,'  70');
          writeln(f1,'     0');
          writeln(f1,fine);
        end;
   else if (codice<>'END')and(codice<>'DX')and(codice<>'D')
         then
         begin
          real1:=xg(x+(punti[1].x)*ing);
          real2:=yg(y+(punti[1].y)*ing);
         end;
  end;
end;

begin
  s1:='';s2:='';s3:='';s4:='';
  assign(f,'dxf1.dxf');
  reset(f);
  assign(f1,nomefile);
  rewrite(f1);
  while not eof(f) do
  begin
    readln(f,s1);
    if (s1<>'ENTITIES')  then writeln(f1,s1)
    else
    begin
        readln(f,s2);
        readln(f,s3);
        writeln(f1,s1);
        writeln(f1,fine);
        for i:=1 to Ultriga do
        if dis^[i].entita<>'' then
        begin
         case dis^[i].entita[1] of
             'L':begin
                   writeln(f1,'LINE');
                   writeln(f1,piano);
                   writeln(f1,'0');
                   writeln(f1,pxi);
                   real1:=xg(dis^[i].x1)*FX;
                   str(real1:5:4,S4);
                   writeln(f1,s4);
                   s4:='';
                   writeln(f1,pyi);
                   real2:=yg(dis^[i].y1)*FY;
                   str(real2:5:4,S4);
                   writeln(f1,s4);
                   s4:='';
                   writeln(f1,pxf);
                   real1:=xg(dis^[i].x2);
                   str(real1:5:4,S4);
                   writeln(f1,s4);
                   s4:='';
                   writeln(f1,pyf);
                   real2:=yg(dis^[i].y2);
                   str(real2:5:4,S4);
                   writeln(f1,s4);
                   writeln(f1,fine);
                 end;
              'T':begin
                   writeln(f1,'INSERT');
                   writeln(f1,piano);
                   writeln(f1,'0');
                   writeln(f1,'  66');
                   writeln(f1,'     1');
                   writeln(f1,nomi);
                   str(round(dis^[i].x2),s4);
                   s4:='BLOCCO'+s4;
                   writeln(f1,S4);
                   s4:='';
                   writeln(f1,pxi);
                   real1:=xg(dis^[i].x1)*FX;
                   str(real1:5:4,S4);
                   writeln(f1,s4);
                   s4:='';
                   real2:=yg(dis^[i].y1)*FY;
                   writeln(f1,pyi);
                   str(real2:5:4,S4);
                   writeln(f1,s4);
                   s4:='';
                   disetic1(round(dis^[i].x2),2,dati^[Dis^[i].tronco].term,real1,real2,dis^[i].y2);
                   writeln(f1,'SEQEND');
                   writeln(f1,piano);
                   writeln(f1,'0');
                   writeln(f1,fine);
                 end;
         end
        end;
        for i:=1 to ulttronco do
        if (dati^[i].ti<>0)and(dati^[i].x<>0)and(dati^[i].y<>0) then
        begin
          real1:=xg(dati^[i].x)*FX;
          real2:=yg(dati^[i].y)*FY;
          st1:='';
          if upcase(conf.numdia[1])='N'then str(dati^[i].num,st1)
          else
          if dati^[i].CodDiam<>''then st1:=dati^[i].Coddiam;
          writeln(f1,'TEXT');
          WRITELN(F1,piano);
          writeln(f1,'0');
          writeln(f1,pxi);
          s4:='';
          str(real1:5:4,s4);
          writeln(f1,s4);
          s4:='';
          writeln(f1,pyi);
          str(real2:5:4,s4);
          writeln(f1,s4);
          s4:='';
          writeln(f1,AltT);
          str(conf.altnum:3:2,s4);
          writeln(f1,s4);
          writeln(f1,'  1');
          writeln(f1,st1);
          writeln(f1,fine);
        end;
        writeln(f1,s3);
        s2:='';
        s3:='';
    end;
  end;
  close(f);
  close(f1);
end;

