unit Leggidxf;

interface
uses dxf_In_Out,sysutils,OutDXFBM,libreriagenerale,definiz,windows,gestdim;

Procedure LineaDxf(xl1,yl1,xl2,yl2:real;layer,colore,tlinea:string);
Procedure ArcoDxf(xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
Procedure ScriviQuote(Nomedxf:string);

Var AttivaoutBm:boolean;
implementation
Var FiDXF, FoDXF:Textfile;
    buf,buf1:string;
    i:integer;
{-----------------------------------------------------------------------------
  Procedure: Piano_Ogg
  Author:    Emanuela
  Date:      18-lug-2005
  Arguments: piano:string
  Result:    String

  serve per farmi restituire il piano
-----------------------------------------------------------------------------}
Function Piano_Ogg(piano:string):String;
var ss:string;
     pp:integer;
begin
result:='';
pp:=pos('_',piano);
if pp<>0 then
   result:=copy(piano,1,pp - 1);
end;

Function Pianovalido(piano:string):boolean;
var ss:string;
     pp:integer;
begin
result:=true;
pp:=pos('_',piano);
if pp<>0 then
result:=copy(piano,pp,length(piano)-pp+1)<>'_RITCOLLE';
end;

 procedure OutLineaBM(xl1,yl1,xl2,yl2:real; Piano, Layer, colore: String);
  Var
    Xi, Yi, Xf, Yf: String;
  begin
    if Pos('RITCOLLE', Layer) <> 0 then exit;
    Xi := Format('%1.4f', [xl1]);
    Yi := Format('%1.4f', [yl1]);
    Xf := Format('%1.4f', [xl2]);
    Yf := Format('%1.4f', [yl2]);
    writeln(Fgenerato,'T:' + Piano + ':' + Xi +':'+ Yi +':'+ Xf +':'+ Yf +':'+Colore+':'+Layer+':');
  end;

  procedure OutArcoBM(xl1,yl1,raggio,angin,angfin:real; Piano, Colore, Layer: String);
  Var
    Xi, Yi, rg, ani, anf: String;
  begin
    Xi := Format('%1.4f', [xl1]);
    Yi := Format('%1.4f', [yl1]);
    rg := Format('%1.4f', [raggio]);
    ani := Format('%1.4f', [angin]);
    anf := Format('%1.4f', [angfin]);
    writeln(Fgenerato,'A:' + Piano + ':' + Xi +':'+ Yi +':'+ rg +':'+ ani +':'+anf+':'+colore+':'+Layer+':');
  end;

Procedure ArcoDxf(xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
Var lx1,ly1,sraggio,sangin,sangfin:string;
    temp:real;
function angacad(angolo:real):real;
begin
result:=angolo*180/pi;
end;
begin
Add_ArcoDxf(xl1,yl1,0,raggio,angin,angfin,layer,colore,tlinea);
if tlinea='' then tlinea:='CONTINUOUS';
if tlinea='TR' then tlinea:='ACAD_ISO02W100';
if not pianovalido(layer) then exit;
lx1:=float_to_str(xl1,16);
ly1:=float_to_str(yl1,16);
angin:=angacad(angin);
angfin:=angacad(angfin);
if attivaoutbm then
   OutArcoBM(xl1,yl1,raggio,angin,angfin, piano_Ogg(layer), colore, Layer);
end;

Procedure QuotaDXF(Xins,Yins:real;Numtr,tipo:integer;Piano:string);
Var NomeMod:string;
    Quotebl:boolean;
    const spz=0.1;
          htxt=0.2;
begin
QuoteBl:=true;
case tipo of
1:nomemod:='Quota';
2:nomemod:='Etichetta';
end;
add_bloccodxf(Xins,Yins,0,0,nomemod,Piano);
Case Tipo of
1:Begin
  with Dati^[Numtr]^ do
  Add_AttribDxf(x+spz,y+spz,0,'DIAM',dati^[Numtr].Coddiam);
  // Emanuela inserimento delle quote dei tubi
  if attivaoutbm then
  OutQuotaBM(xins,yins,0,Piano,dati^[Numtr].Coddiam);
  //Add_AttribDxf(x+spz,y+spz,0,'CODTR',inttostr(dati^[Numtr].Num));
  end;
2:with Gterm^[Numtr]^ do
  begin
   Add_AttribDxf(xetic+spz,yetic+2*spz+htxt,0,'POTENZA',float_to_str(Pot,0));
   Add_AttribDxf(xetic+spz,yetic+spz,0,'MODELLO',MODELLO);
  end;
end;
end;

Procedure LineaDxf(xl1,yl1,xl2,yl2:real;layer,colore,tlinea:string);
Var lx1,ly1,lx2,ly2:string;
begin
Add_LineaDxf(xl1,yl1,0,xl2,yl2,0,layer,colore,tlinea);
if attivaoutbm then
   OutLineaBM(xl1,yl1,xl2,yl2, piano_Ogg(layer), Layer, colore);
end;
const apr=0.01;
{$I Inters}
Procedure CancellaQuote(Nomedxf:string);
Var buf1,buf2,pianoblo,nomeblo,nomeatr,rifatr,gestore,tipoent:string;
    ft:textfile;
    i,res:integer;
    nonleggere,trovatopi,posblo,trovatonomeblo,linkblo:Boolean;
    posx,posy,posx2,posy2,xint,yint:real;
begin
exit;
if not fileexists(nomedxf) then exit;
assign(fiDXF,Nomedxf);
reset(fiDXF);
try
  assign(foDXf, IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp.dxf');
  rewrite(foDXF);
  try
    for i:=1 to ulttronco do
      with dati^[i]^ do
      begin
        x:=0;
        y:=0;
        xbase:=0;
        ybase:=0;
      end;
    readln(fiDXF,buf);
    while (not (eof(fiDXF)))and(buf<>'ENTITIES') do
    begin
      writeln(foDXF,buf);
      readln(fiDXF,buf);
    end;
    writeln(foDXF,buf);
    nonleggere:=false;
    while not (eof(fiDXF)) do
    begin
      if nonleggere then nonleggere:=false
      else
      begin
        readln(fiDXF,buf);
        readln(fiDXF,buf1);
      end;
      if buf1='INSERT' then
      begin
        posblo:=true;
        trovatonomeblo:=false;
        trovatopi:=false;
        rewrite(ft);
        writeln(ft,buf);
        writeln(ft,buf1);

        while buf1<>'SEQEND' do
        begin
          readln(fiDXF,buf);
          readln(fiDXF,buf1);
          // rileva la posizione di etichette e quote
          if buf=' 10' then
            begin
            if posblo then posx:=str_tofloat(buf1);
            end
          else
            if buf=' 20' then
            begin
            if posblo then
              begin
              posy:=str_tofloat(buf1);
              posblo:=false;
              end;
            end
          else
            if buf='  2' then
            begin
            if not trovatonomeblo then
              begin
              trovatonomeblo:=true;
              nomeblo:=buf1;
              end
            else
            if (nomeblo='ETICHETTA') and (buf1='RIF') then
              begin
              for i:=1 to NGTerm do
              if Gterm^[i]^.Cod=Rifatr then
                begin
                Gterm^[i]^.xetic:=posx;
                Gterm^[i]^.yetic:=posy;
                end;
              end;
            end
          else
          if buf='  1' then
            begin
            rifatr:=buf1;
            end
          else
          if buf='  8' then
            begin
            if not trovatopi then
              begin
              pianoblo:=buf1;
              trovatopi:=true;
              end;
            end;
          writeln(ft,buf);
          writeln(ft,buf1);
          end;
        buf:='';
        while buf<>'  0' do
          begin
          readln(fiDXF,buf);
          readln(fiDXF,buf1);
          if buf<>'  0' then
            begin
            writeln(ft,buf);
            writeln(ft,buf1);
            end
          else nonleggere:=true;
          end;
        if  (length(pianoblo)<8)or(copy(pianoblo,length(pianoblo)-5,6)<>'_QUOTE') then  // copia blocco
        begin
          assign(ft, IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp1.dxf');
          reset(ft);
          try
            while not eof(ft) do
            begin
              readln(ft,buf2);
              writeln(foDXF,buf2);
            end;
            closeFile(ft);
          except
            closeFile(ft);
          end;
        end
      else
      if (buf1='LINE')or(buf1='ARC') then
        begin
        tipoent:=buf1;
        readln(fiDXF,Gestore);
        readln(fiDXF,Gestore);
        readln(fiDXF,Pianoblo);
        readln(fiDXF,Pianoblo);
        if  (length(pianoblo)<8)or((copy(pianoblo,length(pianoblo)-5,6)<>'_QUOTE')and(copy(pianoblo,length(pianoblo)-7,8)<>'_RITORNO')) then  // copia linea
           begin
           writeln(foDXf,buf);
           writeln(foDXf,buf1);
           writeln(foDXF,'  5');
           writeln(foDXF,gestore);
           writeln(foDXF,'  8');
           writeln(foDXF,pianoblo);
           end
        else
          begin
          nonleggere:=true;
          readln(fiDXF,Buf);
          readln(fiDXF,buf1);
            while buf<>'  0' do
              begin
              if tipoent<>'ARC' then
              if buf=' 10' then POsx:=str_tofloat(buf1)
              else if buf=' 20' then POsy:=str_tofloat(buf1)
              else if buf=' 11' then POsx2:=str_tofloat(buf1)
              else if buf=' 21' then
                begin
                POsy2:=str_tofloat(buf1);
                for i:=1 to ultriga do
                with dis^[i]^ do
                if visitato then
                if (tronco>0) and(tronco<=ulttronco) then
                  begin
                  inters(xint,yint,res,x1,x2,posx,posx2,y1,y2,posy,posy2);
                  if res<>0 then
                  with dati^[tronco]^ do
                    begin
                    if vicino(xint,yint,0,POsx,POsy,0) then
                      begin
                      xbase:=POsx;
                      Ybase:=POsy;
                      x:=POsx2;
                      y:=POsy2;
                      end;
                    if vicino(xint,yint,0,POsx2,POsy2,0) then
                      begin
                      xbase:=POsx2;
                      Ybase:=POsy2;
                      x:=POsx;
                      y:=POsy;
                      end;
                    end
                  end;
                end;
              readln(fiDXF,Buf);
              readln(fiDXf,buf1);
              end;
          end
        end
      else
        begin
        writeln(FoDXF,buf);
        writeln(FoDXF,buf1);
        end;
      end;
    end;
    close(FoDXF);
  except
   close(FoDXF);
  end;
  close(FoDXF);
except
  close(fiDXF);
end;
copyfile(pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp.dxf'),pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'copiadisegno.dxf'),false)
end;



Procedure ScriviQuote(Nomedxf:string);
Var trov:boolean;
    j,jmax:integer;
    lmax,lcor:real;
begin
//scriviquotebm;

cancellaquote(Nomedxf);
//aggiornaAttributi(Nomedxf,4);
//exit;

if fileexists(nomedxf) then
begin
  assign(fiDXF,Nomedxf);
  reset(fiDXF);
  assign(FoDXF, IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp.dxf');
  rewrite(FoDXF);
  readln(fiDXF,buf);
  while (not (eof(fiDXF)))and(buf<>'ENTITIES') do
  begin
    writeln(FoDXF,buf);
    readln(fiDXF,buf);
  end;
  writeln(FoDXF,buf);
end;
    //readln(fi,buf);
    //writeln(fo,buf);

    for i:=1 to Ulttronco do
    if dati^[i]^.Coddiam<>'' then
      begin
      if (Dati^[i]^.x=0)and(Dati^[i]^.y=0)then
        begin
        trov:=false;
        j:=Dati^[i]^.ti;
        jmax:=j;
        lmax:=0;
        while j<>0 do
          begin
          if not dis^[j]^.CL then
            begin
            trov:=true;
            with dis^[j]^ do
              begin
              lcor:=sqrt(sqr(x2-x1)+sqr(y2-y1));
              if (lcor>lmax)or(Lcor>1) then
                begin
                lmax:=lcor;
                jmax:=j;
                end;
              end;
            end;
          j:=dis^[j]^.nlinea;
          end;
        if trov then
        with dis^[jmax]^ do
          begin
          Dati^[i]^.x:=(x1+x2)/2+0.2;
          Dati^[i]^.y:=(y1+y2)/2+0.2;
          Dati^[i]^.xbase:=(x1+x2)/2;
          Dati^[i]^.ybase:=(y1+y2)/2;
          end;
        end;
      //testodxf((x1+x2)/2,(y1+y2)/2,dati^[tronco].Coddiam,'P1_QUOTE');
      if (Dati^[i]^.x<>0)and(Dati^[i]^.y<>0)then
        begin
        QuotaDxf(Dati^[i]^.x,Dati^[i]^.y,i,1,dis^[Dati^[i]^.ti]^.PianoCAD+'_QUOTE');
        lineadxf(Dati^[i]^.xbase,Dati^[i]^.Ybase,Dati^[i]^.x,Dati^[i]^.y,dis^[Dati^[i]^.ti]^.PianoCad+'_QUOTE','7','CONTINUOUS');
        end;
      end;
    for i:=1 to NGterm do
    with Gterm^[i]^ do
      begin
      QuotaDxf(xetic,Yetic,i,2,piano);
      end;
    //for i:=1 to Ultriga do
    //with dis^[i]^ do
    //if (tronco<>0)and(Nlinea=0)then
    //  begin
    //  testodxf((x1+x2)/2,(y1+y2)/2,inttostr(dati^[tronco].Num),'P1_NUMERI');
    //  end;
if fileexists(nomedxf) then
begin
    while not eof(fiDXF) do
     begin
      readln(fiDXF,buf);
      //if buf='TEXT' then
      //  repeat
      //  readln(fi,buf);
      //  until buf='  0'
      //else
      writeln(FoDXF,buf);
      end;
      close(FoDXF);
      close(fiDXF);
end;
copyfile(pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'temp.dxf'),pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'copiadisegno.dxf'),false)
end;

end.
