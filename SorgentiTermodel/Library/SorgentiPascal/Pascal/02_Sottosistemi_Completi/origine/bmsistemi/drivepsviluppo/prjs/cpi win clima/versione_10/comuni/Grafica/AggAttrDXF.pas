unit AggAttrDXF;

interface
uses libreriagenerale,sysutils,windows,dbtables,
{$Ifdef Tubi}
Definiz
{$else}
Varcarichi
{$endif};
Procedure Aggiornaattributi(Nomedxf:string;Modo:integer);
{$Ifdef Tubi}
{$else}

Procedure InitArpot(modo:integer);
Procedure CloseArpot;
Function Codice_amb(entdxf:string):integer;
{$endif}

implementation
{$Ifdef Tubi}
{$else}

type TintPOt=record
                NumAmb: Integer;
                NomeLoc, Piano, CodGen: String[30];
                Pot, Port, DispInf, Vol, Sup: Double;
             end;
Var BufIntPOt:TintPOt;
    FIP:file of TIntPOt;

type TintPOtE=record
             NumAmb:integer;
             POtE:real;
             end;
Var BufIntPOtE:TintPOtE;
    FIPE:file of TIntPOtE;


type TRECPOt=record
             CodDXF:string[10];
             NumAmb:integer;
             POtInv:real;
             POtest:real;
             end;
arPOt=array [1..MaxAmbienti]of Trecpot;
Var BufPOt:TintPOt;
    POt_D:^arpot;
    NpotAmb:integer;

Function NumLibero:integer;
var i,j:integer;
    trovato:boolean;
begin
i:=1;
trovato:=false;
  repeat
  j:=1;
  while (j<Npotamb)and(pot_D^[j].NumAmb<>i)do inc(j);
  if pot_D^[j].NumAmb<>i then trovato:=true
  else inc(i);
  until trovato;
result:=i;
end;

Function ripetuto(pos,num:integer):boolean;
Var j:integer;
begin
result:=false;
j:=1;
while (j<Npotamb)and((pos=j)or(pot_D^[j].NumAmb<>num))do inc(j);
if (pot_D^[j].NumAmb=num)and(pos<>j) then result:=true
end;

Procedure completanumeri;
Var i:integer;
begin
for i:=1 to Npotamb do
  begin
  if (POt_D^[i].NumAmb=0)or(ripetuto(i,POt_D^[i].NumAmb)) then POt_D^[i].NumAmb:=Numlibero
  end;
end;

Procedure InitArpot(modo:integer);
Var i:integer;
    tt:ttable;
begin
new(pot_d);
tt:=ttable.Create(nil);
tt.DatabaseName:=percorso_progetti;
tt.TableName:='Locali.db';
tt.open;
tt.First;
NPOtAmb:=0;
while not(tt.eof) do
  begin
  {
  Inc(NpotAmb);
  with POt_d^[NPOtamb] do
    begin
    Numamb:=tt.fieldbyname('Codice').AsInteger;
    CodDxf:='';
    POtInv:=0;
    POtest:=0;
    end;
  }
  tt.first;
  tt.Delete;
  end;
tt.Free;
Aggiornaattributi(IncludeTrailingPathDelimiter(percorsoDrive) + 'disegno.dxf',1);
completanumeri; // inserisce i numeri mancanti
if modo=1 then
  begin
  cancellafile(IncludeTrailingPathDelimiter(percorsodrive) + 'POTInv.int');
  cancellafile(IncludeTrailingPathDelimiter(percorsodrive) + 'POTEst.int');
  end
else
begin
  if fileexists(IncludeTrailingPathDelimiter(percorsodrive) + 'POTInv.int') then
  begin
    assign(FIP,IncludeTrailingPathDelimiter(percorsodrive) + 'POTInv.int');
    try
      reset(FIP);
      while not eof(FIP) do
      begin
        read(Fip,BufIntPOt);
        i:=1;
        while (i<NPOtamb)and(BufIntPOt.NumAmb<>POt_D^[i].NumAmb) do inc(i);
        if (i<=NPOtamb)and(BufIntPOt.NumAmb=POt_D^[i].NumAmb )then
        POt_D^[i].POtInv:=BufIntPOt.POt;
      end;
      close(FIP);
    except
      close(FIP);
    end;
  end;
  if fileexists(IncludeTrailingPathDelimiter(percorsodrive) + 'POTEST.int') then
  begin
    assign(FIPE,IncludeTrailingPathDelimiter(percorsodrive) + 'POTEST.int');
    try
      reset(FIPE);
      while not eof(FIPE) do
      begin
       read(FipE,BufIntPOtE);
       i:=1;
       while (i<NPOtamb)and(BufIntPOtE.NumAmb<>POt_D^[i].NumAmb) do inc(i);
       if (i<=NPOtamb)and(BufIntPOtE.NumAmb=POt_D^[i].NumAmb )then
       POt_D^[i].POtEst:=BufIntPOtE.POtE;
      end;
      close(FIPE);
    except
      close(FIPE);
    end;
  end;
end;
Aggiornaattributi(IncludeTrailingPathDelimiter(percorsoDrive) + 'disegno.dxf',2);
end;

Procedure CloseArpot;
begin
 dispose(pot_d);
end;

Function Codice_amb(entdxf:string):integer;
var i:integer;
begin
result:=0;
i:=1;
while (i<NPOtamb)and(entdxf<>POt_D^[i].CodDXF) do inc(i);
if entdxf=POt_D^[i].CodDXF then result:=POt_D^[i].NumAmb;
end;
Function indice_amb(entdxf:string):integer;
var i:integer;
begin
result:=0;
i:=1;
while (i<NPOtamb)and(entdxf<>POt_D^[i].CodDXF) do inc(i);
if entdxf=POt_D^[i].CodDXF then result:=i;
end;

{$endif}




Procedure Aggiorna_attributi(Nomedxf:string;Modo:integer);
Var buf,buf1,buf2,buf3,pianoblo,nomeblo,nomeatr,rifatr,entdxf:string;
    fi,fo,ft:textfile;
    i,namb,err:integer;
    nonleggere,trovatopi,posblo,trovatonomeblo,trovatoentdxf,linkblo:Boolean;
    posx,posy:real;
begin
if not fileexists(nomedxf) then exit;
assign(fi,Nomedxf);
try
  reset(fi);
  assign(fo, IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp.dxf');
  try
    rewrite(fo);
    readln(fi,buf);
    while (not (eof(fi)))and(buf<>'ENTITIES') do
    begin
    writeln(fo,buf);
    readln(fi,buf);
    end;
    writeln(fo,buf);
    nonleggere:=false;
    while not (eof(fi)) do
    begin
    readln(fi,buf);
    readln(fi,buf1);

    if buf1='INSERT' then
    begin
    writeln(fo,buf);
    writeln(fo,buf1);
    buf:='';
    trovatonomeblo:=false;
    trovatoentdxf:=false;
    while (buf<>'  0')or(buf1='ATTRIB') do
      begin
      readln(fi,buf);
      readln(fi,buf1);
      if buf='  2' then
        begin
        if not trovatonomeblo then
          begin
          trovatonomeblo:=true;
          nomeblo:=buf1;
          end
        end
      else
      if buf='  5' then
        begin
        if not trovatoentdxf then
          begin
          entdxf:=buf1;
          trovatoentdxf:=true;
          end;
        end
      else
      if buf='  1' then
        begin
        rifatr:=buf1;
        rewrite(ft);
        buf2:='';
        while buf2<>'  2' do
           begin
           readln(fi,Buf2);
           if buf2<>'  2' then writeln(ft,buf2);
           end;
        readln(fi,Buf2);
        {$Ifdef Tubi}
        if (copy(uppercase(nomeblo),1,4)='RAD_')  then
          begin
          if Uppercase (buf2)='COD' then
          buf1:='Codice';
          end;
        {$else}
        if (copy(uppercase(nomeblo),1,4)='LOC_')  then
          begin
          if Uppercase (buf2)='PINV' then
            begin
            if indice_amb(entdxf)<>0 then
            buf1:=float_to_str(POt_D^[indice_amb(entdxf)].POtInv,0);
            end
          else
          if Uppercase (buf2)='PEST' then
            begin
            if indice_amb(entdxf)<>0 then
            buf1:=float_to_str(POt_D^[indice_amb(entdxf)].POtEST,0);
            end
          else
          if Uppercase (buf2)='COD' then
            begin
            Val(buf1,namb,err);
            if modo=1 then
              begin
              if err=0 then  // numerazione valida
                 begin
                 i:=1;
                 while (i<NPOtamb)and( (POt_D^[i].CodDXF<>'')or(POt_D^[i].NumAmb<>namb)) do inc(i);
                 if (i<=NPOtamb)and( (POt_D^[i].CodDXF='')and(POt_D^[i].NumAmb=Namb))
                 then POt_D^[i].CodDXF:=entdxf
                 else
                   begin
                   inc(NPOtamb);
                   POt_D^[NPOtamb].CodDXF:=entdxf;
                   POt_D^[NPOtamb].NumAmb:=namb;
                   POt_D^[NPOtamb].POtInv:=0;
                   POt_D^[NPOtamb].POtest:=0;
                  end;
                 end
              else
                 begin
                 inc(NPOtamb);
                 POt_D^[NPOtamb].CodDXF:=entdxf;
                 POt_D^[NPOtamb].NumAmb:=0;
                 POt_D^[NPOtamb].POtInv:=0;
                 POt_D^[NPOtamb].POtest:=0;
                end;
              end
            else buf1:=inttostr(Codice_amb(entdxf));
            end;
          end;
        {$endif}

        writeln(fo,buf);
        writeln(fo,buf1);
        assign(ft, IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp1.dxf');
        try
          reset(ft);
          while not(eof(ft)) do
          begin
           readln(ft,Buf3);
           writeln(fo,buf3);
          end;
          close(ft);
        except
          close(ft);
        end;
        buf:='  2';
        buf1:=buf2;
        end;
      writeln(fo,buf);
      writeln(fo,buf1);
     end;
    end
    else
    begin
    writeln(fo,buf);
    writeln(fo,buf1);
    end;
    end;
    close(fo);
   except
    close(fo);
   end;
   close(fi);
  except
   close(fi);
  end;
copyfile(pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp.dxf'),pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegno.dxf'),false)
end;

Procedure Aggiornaattributi(Nomedxf:string;Modo:integer);
Var i,j,k,namb,err:integer;
    nonleggere,trovatopi,posblo,trovatonomeblo,trovatoentdxf,linkblo:Boolean;
    posx,posy:real;
begin
for j:=1 to NEntita do
with entita_D^[j]^ do
if cod='B' then
    begin
    for k:=1 to Nattrib   do
    with entita_D^[j]^.Attrib[k] do
      begin
     {$Ifdef Tubi}
     if (copy(uppercase(nomebl),1,4)='RAD_')  then
       begin
       if Uppercase (Coda)='COD' then
       Valore:='Codice';
       end;
    {$else}
    if (copy(uppercase(nomebl),1,4)='LOC_')  then
      begin
      if Uppercase (CodA)='PINV' then
        begin
        if indice_amb(Codent)<>0 then
        Valore:=float_to_str(POt_D^[indice_amb(Codent)].POtInv,0);
        end
      else
      if Uppercase (CodA)='PEST' then
            begin
            if indice_amb(CodEnt)<>0 then
            Valore:=float_to_str(POt_D^[indice_amb(Codent)].POtEST,0);
            end
          else
          if Uppercase (Coda)='COD' then
            begin
            Val(Valore,namb,err);
            if modo=1 then
              begin
              if err=0 then  // numerazione valida
                 begin
                 i:=1;
                 while (i<NPOtamb)and( (POt_D^[i].CodDXF<>'')or(POt_D^[i].NumAmb<>namb)) do inc(i);
                 if (i<=NPOtamb)and( (POt_D^[i].CodDXF='')and(POt_D^[i].NumAmb=Namb))
                 then POt_D^[i].CodDXF:=Codent
                 else
                   begin
                   inc(NPOtamb);
                   POt_D^[NPOtamb].CodDXF:=Codent;
                   POt_D^[NPOtamb].NumAmb:=namb;
                   POt_D^[NPOtamb].POtInv:=0;
                   POt_D^[NPOtamb].POtest:=0;
                  end;
                 end
              else
                 begin
                 inc(NPOtamb);
                 POt_D^[NPOtamb].CodDXF:=Codent;
                 POt_D^[NPOtamb].NumAmb:=0;
                 POt_D^[NPOtamb].POtInv:=0;
                 POt_D^[NPOtamb].POtest:=0;
                end;
              end
            else Valore:=inttostr(Codice_amb(Codent));
            end;
          end;
        {$endif}
      end
    end
end;

end.
