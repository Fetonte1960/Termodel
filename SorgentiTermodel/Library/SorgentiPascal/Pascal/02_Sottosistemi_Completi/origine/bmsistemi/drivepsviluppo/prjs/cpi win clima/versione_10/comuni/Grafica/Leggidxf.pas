unit Leggidxf;

interface
Uses Libreriagenerale,sysutils,windows,dialogs,classes,math,dbtables

{$Ifdef Tubi}
,Uleggitxt
,definiz
,impterm
,OutDxfBM
//,ritornoDXF
, ritorno
,UGrafoDXF,interfdxf
{$Endif}
,aggattrdxf,dxf_in_out
;
{
Const NameFin='D:\DISTRIBUZIONE_10\VERSIONE_10\CPI WIN CLIMA\disegno.dxf';
      NameFout='D:\DISTRIBUZIONE_10\VERSIONE_10\CPI WIN CLIMA\File_TERMICO_10\Database\disegno.txt';
}

procedure Read_Dxf(Namefin,Namefout:string;Tubi:boolean);
{$Ifdef Tubi}
Procedure ScriviQuote(Nomedxf:string);
Procedure InitcolCad;
Procedure LineaDxf(xl1,yl1,xl2,yl2:real;layer,colore,tlinea:string);
Procedure ArcoDxf(xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
Procedure puliscicollettore;
procedure ApriFo(NomeFile: String);
procedure ChiudiFo;
Function  Piano_Ogg(piano:string):String;
Function CodIndPiano(Ind:string):string;
Procedure Out_simb_bm_dxf;

{$Endif}

Var AttivaoutBm:boolean;

Implementation


Var FiDXF, FoDXF:Textfile;
    buf,buf1:string;
    i:integer;


const rsp=0.1;

{$Ifdef Tubi}
const apr=0.01;
{$I Inters}

Procedure Out_term_dxf;
Var i:integer;
begin
For i:=1 to NGterm do
with Gterm^[i]^ do
  begin
  Add_BloccoDxf(xterm,yterm,zterm,angolo,Nomeblocco,Piano+'_TUBI');
  end;
end;
Procedure Out_simb_bm_dxf;
begin
Out_term_dxf;
end;

procedure ApriFo(NomeFile: String);
begin
  AssignFile(FoDXF, NomeFile);
  Rewrite(FoDXF);
  try
    //
  except
   CloseFile(FoDXF);
  end;
end;

procedure ChiudiFo;
begin
  CloseFile(FoDXF);
end;

Procedure spezzalinee;
var i,j,res:integer;
    XInt,Yint:real;
begin

i:=0;
while i<Ultriga-1 do
  begin
  inc(i);
  j:=i;
  while j<Ultriga do
    begin
    inc(j);
    inters(xint,yint,res,dis^[i]^.x1,dis^[i]^.x2,dis^[j]^.x1,dis^[j]^.X2,dis^[i]^.Y1,dis^[i]^.Y2,dis^[j]^.Y1,dis^[j]^.Y2);

    if (res=1) then
      begin
      if vicino(xint,yint,0,dis^[i]^.x1,dis^[i]^.Y1,0) or
         vicino(xint,yint,0,dis^[i]^.x2,dis^[i]^.Y2,0)  then
        begin
        if not(vicino(xint,yint,0,dis^[j]^.x1,dis^[j]^.Y1,0) or
           vicino(xint,yint,0,dis^[j]^.x2,dis^[j]^.Y2,0) ) then
           begin
           inc(ultriga);
           if dis^[ultriga]=nil then new(dis^[ultriga]);
           dis^[ultriga]^:=dis^[j]^;
           dis^[ultriga]^.x1:=xint;
           dis^[ultriga]^.y1:=yint;
           dis^[j]^.x2:=xint;
           dis^[j]^.y2:=yint;
           end;
        end
      else
      if vicino(xint,yint,0,dis^[j]^.x1,dis^[j]^.Y1,0) or
         vicino(xint,yint,0,dis^[j]^.x2,dis^[j]^.Y2,0)  then
        begin
        if not(vicino(xint,yint,0,dis^[i]^.x1,dis^[i]^.Y1,0) or
           vicino(xint,yint,0,dis^[i]^.x2,dis^[i]^.Y2,0) ) then
           begin
           if UltRiga < LungDis then
              inc(ultriga);
           if dis^[ultriga]=nil then new(dis^[ultriga]);
           dis^[ultriga]^:=dis^[i]^;
           dis^[ultriga]^.x1:=xint;
           dis^[ultriga]^.y1:=yint;
           dis^[i]^.x2:=xint;
           dis^[i]^.y2:=yint;
           end;
        end
      end;
    end;
  end;

Puliscicollettore;
end;



Procedure SpezzaTerminali;
var i,j,res:integer;
    xint,Yint,Dx,Dy,Dz:real;
begin
for i:=1 to NGterm do
with Gterm^[i]^ do
For j:=1 to ultriga do
    begin
    inters(xint,yint,res,Xterm-apr,Xterm+apr,dis^[j]^.x1,dis^[j]^.X2,Yterm-apr,Yterm+apr,dis^[j]^.Y1,dis^[j]^.Y2);
    if res<>1 then
    inters(xint,yint,res,Xterm+apr,Xterm-apr,dis^[j]^.x1,dis^[j]^.X2,Yterm+apr,Yterm-apr,dis^[j]^.Y1,dis^[j]^.Y2);
    if (res=1) then
      begin
        if not(vicino(xint,yint,0,dis^[j]^.x1,dis^[j]^.Y1,0) or
           vicino(xint,yint,0,dis^[j]^.x2,dis^[j]^.Y2,0) ) then
           begin
           if UltRiga < LungDis then
              inc(ultriga);
           if dis^[ultriga]=nil then new(dis^[ultriga]);
           dis^[ultriga]^:=dis^[j]^;
           dis^[ultriga]^.x1:=xint;
           dis^[ultriga]^.y1:=yint;
           dis^[j]^.x2:=xint;
           dis^[j]^.y2:=yint;
           Dx:=0;Dy:=0;
           dz:=str_tofloat(Gterm^[i]^.Montaggio);
           if dz=0 then Dz:=-0.1;
           if UltRiga < LungDis then
              inc(ultriga);
           if dis^[ultriga]=nil then new(dis^[ultriga]);
           dis^[ultriga]^:=dis^[j]^;
           dis^[ultriga]^.x1:=xint;
           dis^[ultriga]^.y1:=yint;
           dis^[ultriga]^.x2:=xint+dx;
           dis^[ultriga]^.y2:=yint+dy;
           dis^[ultriga]^.z2:=dis^[ultriga]^.z1+dz;
           end;
      end;
    end;
 //Montaggioterminali;
end;

Procedure puliscicollettore;

Function lineacollegata(j:integer):boolean;
Var i:integer;
begin
result:=false;
i:=1;
while (i<ultriga)and((i=j)or(not dis^[i]^.VL )or(not(
  vicino(dis^[j]^.x1,dis^[j]^.Y1,0,dis^[i]^.x1,dis^[i]^.Y1,0) or
  vicino(dis^[j]^.x1,dis^[j]^.Y1,0,dis^[i]^.x2,dis^[i]^.Y2,0) ))) do inc(i);

if  ((i<>j)and(dis^[i]^.VL )and(
  vicino(dis^[j]^.x1,dis^[j]^.Y1,0,dis^[i]^.x1,dis^[i]^.Y1,0) or
  vicino(dis^[j]^.x1,dis^[j]^.Y1,0,dis^[i]^.x2,dis^[i]^.Y2,0) )) then
  begin
  i:=1;
  while (i<ultriga)and((i=j)or(not dis^[i]^.VL )or(not(
    vicino(dis^[j]^.x2,dis^[j]^.Y2,0,dis^[i]^.x2,dis^[i]^.Y2,0) or
    vicino(dis^[j]^.x2,dis^[j]^.Y2,0,dis^[i]^.x1,dis^[i]^.Y1,0) ))) do inc(i);

  if  ((i<>j)and(dis^[i]^.VL )and(
    vicino(dis^[j]^.x2,dis^[j]^.Y2,0,dis^[i]^.x2,dis^[i]^.Y2,0) or
    vicino(dis^[j]^.x2,dis^[j]^.Y2,0,dis^[i]^.x1,dis^[i]^.Y1,0) )) then
    begin
    result:=true;
    end
end
end;
var k:integer;
    eliminata:boolean;
begin
  repeat
  eliminata:=false;
  for k:=1 to ultriga do
  if (dis^[k]^.cl)and(dis^[k]^.VL)and(not lineacollegata(k)) then
    begin
    eliminata:=true;
    dis^[k]^.VL:=false;
    dis^[k]^.Visitato:=true;
    end;
  until not eliminata;
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

Procedure LineaDxf(xl1,yl1,xl2,yl2:real;layer,colore,tlinea:string);
Var lx1,ly1,lx2,ly2:string;
begin
Add_LineaDxf(xl1,yl1,0,xl2,yl2,0,layer,colore,tlinea);
if attivaoutbm then
   OutLineaBM(xl1,yl1,xl2,yl2, piano_Ogg(layer), Layer, colore);
{if tlinea='' then tlinea:='CONTINUOUS';
if tlinea='TR' then tlinea:='ACAD_ISO02W100';
if not pianovalido(layer) then exit;
lx1:=float_to_str(xl1,16);
ly1:=float_to_str(yl1,16);
lx2:=float_to_str(xl2,16);
ly2:=float_to_str(yl2,16);
Writeln(FoDXF,'  0');
Writeln(FoDXF,'LINE');
Writeln(FoDXF,'  5');
Writeln(FoDXF,'160C3');
Writeln(FoDXF,'  8');
Writeln(FoDXF,Layer);
Writeln(FoDXF,'  6');
Writeln(FoDXF,tlinea);
Writeln(FoDXF,' 62');
Writeln(FoDXF,'     ' + colore);
Writeln(FoDXF,' 10');
Writeln(FoDXF,lx1);
Writeln(FoDXF,' 20');
Writeln(FoDXF,ly1);
Writeln(FoDXF,' 30');
Writeln(FoDXF,'0.0');
Writeln(FoDXF,' 11');
Writeln(FoDXF,lx2);
Writeln(FoDXF,' 21');
Writeln(FoDXF,ly2);
Writeln(FoDXF,' 31');
Writeln(FoDXF,'0.0');   }

end;

Procedure ArcoDxf(xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
Var lx1,ly1,sraggio,sangin,sangfin:string;
    temp:real;
function angacad(angolo:real):real;
begin
{
angolo:=-angolo;//antiorario
angolo:=angolo+PI/2; //origine orizzontale
if angolo < 0 then angolo:=angolo+2*pi;
if angolo > 2*PI then angolo:=angolo-2*pi; }
result:=angolo*180/pi;
end;
begin
Add_ArcoDxf(xl1,yl1,0,raggio,angin,angfin,layer,colore,tlinea);
//OutArcoBM(xl1,yl1,raggio,angin,angfin, piano_Ogg(layer));
if tlinea='' then tlinea:='CONTINUOUS';
if tlinea='TR' then tlinea:='ACAD_ISO02W100';
if not pianovalido(layer) then exit;
lx1:=float_to_str(xl1,16);
ly1:=float_to_str(yl1,16);
angin:=angacad(angin);
angfin:=angacad(angfin);
{
if (angfin>angin)and(angfin-angin>180)then  //solo angoli acuti
  begin
  temp:=angin;
  angin:=angfin;
  angfin:=temp;
  end
else
if (angin>angfin)and(angin-angfin<180)then  //solo angoli acuti
  begin
  temp:=angin;
  angin:=angfin;
  angfin:=temp;
  end;
}
if attivaoutbm then
   OutArcoBM(xl1,yl1,raggio,angin,angfin, piano_Ogg(layer), colore, Layer);
{sraggio:=float_to_str(raggio,16);
sangin:=float_to_str(angin,16);
sangfin:=float_to_str(angfin,16);
Writeln(FoDXF,'  0');
Writeln(FoDXF,'ARC');
Writeln(FoDXF,'  5');
Writeln(FoDXF,'7E');
Writeln(FoDXF,'  8');
Writeln(FoDXF,Layer);
Writeln(FoDXF,'  6');
Writeln(FoDXF,tlinea);
Writeln(FoDXF,' 62');
Writeln(FoDXF,'     '+colore);
Writeln(FoDXF,' 10');
Writeln(FoDXF,lx1);
Writeln(FoDXF,' 20');
Writeln(FoDXF,ly1);
Writeln(FoDXF,' 30');
Writeln(FoDXF,'0.0');
Writeln(FoDXF,' 40');
Writeln(FoDXF,sraggio);
Writeln(FoDXF,' 50');
Writeln(FoDXF,sangin);
Writeln(FoDXF,' 51');
Writeln(FoDXF,sangfin); }
end;

Procedure Testodxf(xt,yt:real;testo,layer:string);
Var tx,ty:string;
begin
str(xt+rsp:6:5,tx);
str(yt+rsp:6:5,ty);
{Writeln(FoDXF,'TEXT');
Writeln(FoDXF,'  8');
Writeln(FoDXF,Layer);
Writeln(FoDXF,'  40');
Writeln(FoDXF,'0.2');
Writeln(FoDXF,'  5');
Writeln(FoDXF,'1516C');
Writeln(FoDXF,'  62');
Writeln(FoDXF,'1');
Writeln(FoDXF,'  72');
Writeln(FoDXF,'0');
Writeln(FoDXF,'  71');
Writeln(FoDXF,'0');
Writeln(FoDXF,' 10');
Writeln(FoDXF,tx);
Writeln(FoDXF,' 20');
Writeln(FoDXF,ty);
Writeln(FoDXF,' 30');
Writeln(FoDXF,'0.000000');
Writeln(FoDXF,'  1');
Writeln(FoDXF,Testo);
Writeln(FoDXF,'  0');   }
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

Procedure QuotaD_XF(Xins,Yins:real;Numtr,tipo:integer;Piano:string);
Var Fmod:textfile;
    bufmod,nomemod:String;
    tipop,err:integer;
    QuoteBl:boolean;
    xrel,yrel:real;
begin
QuoteBl:=true;
case tipo of
1:nomemod:='Quota';
2:nomemod:='Etichetta';
end;
assign(fmod, IncludeTrailingPathDelimiter(PercorsoDrive) + nomemod + '.dxf');
reset(fmod);
try
  readln(fmod,bufmod);
  while (not (eof(fmod)))and(bufmod<>'ENTITIES') do
    begin
    readln(fmod,bufmod);
    end;
  while (not (eof(fmod)))and(bufmod<>'ENDSEC') do
    begin
    // identificativo parametro
    readln(fmod,bufmod);
    val(bufmod,tipop,err);
    if tipop<>0 then writeln(foDXF,bufmod);
    readln(fmod,bufmod);
    if err=0 then
      begin
        case tipop of
        10:if quotebl then
             begin
             xrel:=str_tofloat(bufmod);
             writeln(foDXF,float_to_str(xins,16));
             end
           else  writeln(foDXF,float_to_str(xins-xrel+str_tofloat(bufmod),16));
        20:if quotebl then
             begin
             yrel:=Str_tofloat(bufmod);
             writeln(foDXF,float_to_str(yins,16));
             quotebl:=false;
             end
           else  writeln(foDXF,float_to_str(yins-yrel+str_tofloat(bufmod),16));
          1:begin
            //writeln(fo,bufmod); // 1
            //readln(fmod,bufmod);  // parametro vuoto
            readln(fmod,bufmod);  //  2
            readln(fmod,bufmod);  //  Nome parametro
            If bufmod='DIAM' then  writeln(foDXf,dati^[Numtr].Coddiam)
            else If bufmod='CODTR' then  writeln(foDXF,dati^[Numtr].Num)
            else If bufmod='POTENZA' then  writeln(foDXF,float_to_str(Gterm^[Numtr].Pot,0)+' W')
            else If bufmod='RIF' then  writeln(foDXF,Gterm^[Numtr].Cod)
            else If bufmod='LINK' then  writeln(foDXF,Gterm^[Numtr].CodEntDxf)
            else If bufmod='MODELLO' then  writeln(foDXF,{Gterm^[Numtr].modello}'Modello')
            else writeln(foDXF,'');
            writeln(foDXF,'  2');
            writeln(foDXF,bufmod); // nome parametro
            end;
          8:begin
            //writeln(fo,bufmod); // 8 layer
            //readln(fmod,bufmod);  // parametro vuoto
            writeln(foDXF,Piano+'_QUOTE');
            end;
          0:begin       //non stampare endsec
            if bufmod<>'ENDSEC' then
              begin
              writeln(foDXF,'  0');
              writeln(foDXF,bufmod); //
              end;
            end;
        else
        if bufmod<>'ENDSEC' then writeln(foDXF,bufmod);
        end;
      end
    else
    if bufmod<>'ENDSEC' then writeln(foDXF,bufmod);
    end;
  close(Fmod);
except
  close(Fmod);
end;
end;

{$Ifdef Tubi}


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
aggiornaAttributi(Nomedxf,4);
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

Type TCol_Cad=record  codice:string;colore:integer end;
Const maxcolcad=50;


Var Col_cad:array[1..maxcolcad] of TCol_Cad;
    NcolCad:integer;

Procedure InitcolCad;
Var clpar:string;
    I:integer;
    tt:Ttable;
begin
tt:=TTable.create(nil);
tt.DatabaseName:=percorso_progetti;
tt.TableName:='tipirete.db';
tt.Open;
tt.First;
NcolCad:=0;
while not tt.Eof do
    begin
    inc(NcolCad);
    col_cad[NcolCad].codice:=tt.fields[1].asstring;
    if tt.fields[14].asString <> '' then
       clpar:=formst(tt.fields[14].Value)
    else clpar := 'ROSSO';
    col_cad[NcolCad].colore:=0;
    if clpar='ROSSO'then col_cad[NcolCad].colore:=1;
    if clpar='GIALLO'then col_cad[NcolCad].colore:=2;
    if clpar='VERDE'then col_cad[NcolCad].colore:=3;
    if clpar='CIANO'then col_cad[NcolCad].colore:=4;
    if clpar='BLU'then col_cad[NcolCad].colore:=5;
    if clpar='MAGENTA'then col_cad[NcolCad].colore:=6;
    tt.Next;
    end;
tt.free;
end;

Function CCad(cc:string):String;
Var err,i:integer;
    cpar:integer;
begin
cc:=formst(cc);
result:=cc;
if cc<>'' then
//if cc[1]='£' then
  begin
  //cc:=copy(cc,2,length(cc)-1);
  Val(cc,cpar,err);
  if err=0 then
    begin
    i:=1;
    while (i<=NColCad)and(col_cad[i].colore<>Cpar) do inc(i);
    if col_cad[i].colore=Cpar then result:=col_cad[i].codice;
    end;
  end;
end;

{$Endif}



{$Endif}

Function CodIndPiano(Ind:string):string;
var tt:TTable;
    i:Integer;
begin
if length(Ind)>1 then ind:=copy(ind,2,length(ind)-1);
result:='';
tt:=TTable.create(nil);
with tt do
  begin
  databasename:=percorso_progetti;
  tablename:='Piani';
  open;
  first;
  i:=1;
  while (not eof)and(fieldbyname('Indice').asstring<>Ind) do
    begin
    inc(i);
    next;
    end;
  if fieldbyname('Indice').asstring=Ind then
  result:=fieldbyname('Codice').AsString;
  free;
  end;
end;

Function Cerca2Par(par1,Par2:string;Var pp1:boolean):string;
begin
buf:='';
  while (not eof(fiDXF))and(par1<>formst(buf))and(par2<>formst(buf)) do
    begin
    readln(fiDXF,Buf);
    readln(fiDXF,Buf1);
    end;
pp1:=par1=formst(buf);
result:=buf1;
end;

Function CercaPar(par:string):string;
begin
buf:='';
  while (not eof(fiDXF))and(par<>formst(buf)) do
    begin
    readln(fiDXF,Buf);
    readln(fiDXF,Buf1);
    end;
result:=buf1;
end;

function In_N(str1,str2:string):boolean;
begin
result:=false;
if upstring(copy(str1,1,length(str2)))=upstring(str2) then result:=true;
end;

procedure Leggi_Dxf(Piano:string;modo:integer);

Var
    x1,y1,z1,x2,y2,z2,colore,nomebl,codent,codentDXF,codamb,temp,temp1,temp2,temp3,temp4,DescrAmb,
    ZonaAmb,ImpAmb,TPavAmb,CPavamb,TSofAmb,CSofamb,
    LargFin,AltFin,CodFin,Pianoent,Tlinea,pianoedif:string;
    indline,Autoinc1,numerazione:integer;
    Prima,primopar,iscolle:Boolean;

function sostpianocol(layer:string):string;
var ii:Integer;
    ss:string;
begin
iscolle:=false;
result:=layer;
ii:=POS('_',layer);
if (i<>0)then
  begin
  ss:=copy(layer,ii,length(layer)-ii+1);
  if uppercase(ss)='_TUBICOL' then
    begin
    iscolle:=true;
    result:=copy(layer,1,ii)+'TUBI';
    end
  else
  if uppercase(ss)='_TUBISIMB' then
  result:=copy(layer,1,ii)+'TUBI';
  end;
end;

function CDL:string;
begin
inc(indline);
str(indline,result);
end;


Function Hex_to_intstr(valore:string):string;
Var BufBin:pchar;
    bufpas:string;
    i:integer;
    accum:integer;
function HexNum(c:char):integer;
begin
c:=upcase(c);
  case c of
  '0':result:=0;
  '1':result:=1;
  '2':result:=2;
  '3':result:=3;
  '4':result:=4;
  '5':result:=5;
  '6':result:=6;
  '7':result:=7;
  '8':result:=8;
  '9':result:=9;
  'A':result:=10;
  'B':result:=11;
  'C':result:=12;
  'D':result:=13;
  'E':result:=14;
  'F':result:=15;
  end;
end;
begin
accum:=0;
for i:=1 to length(Valore) do
accum:=accum+Hexnum(valore[i])*round(power(16,length(Valore)-i));
result:=inttostr(accum);
end;
begin
{$Ifdef Tubi}
InitCercacod;
Pianoedif:='';
i:=1;
while (i<Length(piano))and(Piano[i]<>'_') do
  begin
  inc(i);
  if Piano[i]<>'_' then pianoedif:=pianoedif+Piano[i];
  end;
{$Endif}
autoinc1:=0;
reset(fiDXF);
indline:=0;
buf:='';
Prima:=true;
Numerazione:=0;
while (not eof(fiDXF))and(buf<>'ENTITIES') do
readln(fiDXF,Buf);
while not eof(fiDXF) do
  begin
  while (not eof(fiDXF))and(buf<>'LINE')and(buf<>'INSERT'){and(buf<>'POLYLINE')} do
  readln(fiDXF,Buf);
  if buf='LINE' then
    begin

    {
    if prima then
      begin
      if not tubi then writeln(fo,'PIANO:'+Cercapar('8')+':');
      prima:=false;
      end;
    }
    PIANOent:=sostpianocol(Cercapar('8'));
    Tlinea:='Esterno';
    Colore:=Cerca2par('6','62',Primopar);
    if primopar then
      begin
      if formst(colore)<>'CONTINUOUS' then
      Tlinea:='£'+colore;
      Colore:=Cercapar('62');
      end;
    if Pianoent=Piano then
      begin
      x1:=Cercapar('10');
      y1:=Cercapar('20');
      z1:=Cercapar('30');
      x2:=Cercapar('11');
      y2:=Cercapar('21');
      z2:=Cercapar('31');
      if modo=0 then writeln(FoDXF,'M:'+CDL+':'+'£'+formst(Colore)+':'+x1+':'+y1+':'+x2+':'+y2+':0:0:'+Tlinea+':');
      if (modo=2)and(not vicino(str_tofloat(x1),str_tofloat(y1),str_tofloat(z1),str_tofloat(x2),str_tofloat(y2),str_tofloat(z2))) then
        begin
        {Inc(autoinc1);
        writeln(fo,'TUBO:');
        writeln(fo,'TIPOELEMENTO:T:');
        writeln(fo,'CODICE:'+inttostr(autoinc1)+':');
        writeln(fo,'INIZIO_LISTA_PUNTI');
        writeln(fo,x1+':'+y1+':0:');
        writeln(fo,x2+':'+y2+':0:');
        writeln(fo,'FINE_LISTA_PUNTI');
        writeln(fo,'TIPO:ASTM:');
        writeln(fo,'LUNGHEZZA:0:');
        writeln(fo,'DIAMETRO:0:');
        writeln(fo,'FISSO:0:');}
        {$Ifdef Tubi}
        { TODO -odiego -cpunti chiave : lettura z }
        //z1:='0';z2:='0';
        if iscolle then temp:='C' else temp:='';
        CaricaTubo(0, ' ', codIndPiano(Pianoedif),temp, cCad(Colore), str_tofloat(x1), str_tofloat(y1), str_tofloat(z1), str_tofloat(x2), str_tofloat(y2), str_tofloat(z2));
        {if UltRiga < LungDis then
           inc(ultriga);

        if dis^[ultriga]=Nil then new(dis^[ultriga]);
        dis^[Ultriga].color:=colore;
        dis^[Ultriga].Cl:=iscolle;
        dis^[Ultriga].Vl:=true;
        dis^[Ultriga].tipo:=CCad(colore);
        dis^[Ultriga].rimando:='';
        dis^[Ultriga].x1:=str_tofloat(x1);
        dis^[Ultriga].y1:=str_tofloat(y1);
        dis^[Ultriga].z1:=0;
        dis^[Ultriga].x2:=str_tofloat(x2);
        dis^[Ultriga].Y2:=str_tofloat(y2);
        dis^[Ultriga].z2:=0;
        dis^[Ultriga].Rid:='';
        dis^[Ultriga].tronco:=0;
        dis^[Ultriga].nlinea:=0;
        dis^[Ultriga].filtro:='';
        dis^[Ultriga].Lungtubo:=0;
        dis^[Ultriga].visitato:=false;
        dis^[Ultriga].piano:=PianoEdif;
        dis^[Ultriga].pianoCad:=PianoEdif;   }
        {$Endif}
        end;
      end;
    end;
  if buf='INSERT' then
    begin
    if prima then
      begin
      {
      writeln(fo,'PIANO:'+Cercapar('8')+':');
      prima:=false;
      }
      end;
    codentDXF:=Cercapar('5');
    PIANOent:=sostpianocol(Cercapar('8'));
    //showmessage(pianoent);
    if Pianoent=Piano then
      begin
      NomeBl:=upstring(Cercapar('2'));
      x1:=Cercapar('10');
      y1:=Cercapar('20');
      Z1:=Cercapar('30');
      if copy(NomeBl,1,4)='LOC_' then
      //if NomeBl='AMB' then
        begin
        //inc(numerazione);
        //codamb:=inttostr(numerazione);
        {$Ifdef Tubi}
        {$else}
        codamb:=inttostr(codice_amb(codentDXF));
        {$endif}
        codent:='L:';
        temp:=Cercapar('0');//ATTRIB
        descrAmb:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        ZonaAmb:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        ImpAmb:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        CPavamb:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        CSofamb:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        TPavAmb:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        TSofAmb:=Cercapar('1');
        writeln(FoDXF,Codent+Codamb+':'+x1+':'+y1+':'+DescrAmb+':'+''+':'+ZonaAmb+':'+ImpAmb+
                 ':'+TPavAmb+':'+CPavamb+':'+TSofAmb+':'+CSofamb+':');
        end;
      if copy(NomeBl,1,4)='FIN_' then
        // if NomeBl='H_FIN' then
        begin
        codent:='F:';
        temp:=Cercapar('0');//ATTRIB
        codFin:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        Largfin:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        Altfin:=Cercapar('1');
        writeln(FoDXF,Codent+CDL+':'+x1+':'+y1+':'+codfin+':'+'0'+':'+'0'+':');
        end;
      if copy(NomeBl,1,4)='PON_' then
        begin
        codent:='P:';
        temp:=Cercapar('0');//ATTRIB
        Largfin:=Cercapar('1');
        temp:=Cercapar('0');//ATTRIB
        codFin:=Cercapar('1');
        writeln(FoDXF,Codent+CDL+':'+x1+':'+y1+':'+codfin+':'+Largfin+':');
        end;
      if uppercase(NomeBl)='NORD' then
        begin
        codent:='P:';
        temp:=Cercapar('50');//ATTRIB
        temp:=floattostr(str_tofloat(temp)+90);
        writeln(FoDXF,'NORD:'+Temp+':');
        end;
      //if ((NomeBl='IRETE')and(modo=1))or((NomeBl='RAD')and(modo=3)) then
        if (modo=2)and((In_N(NomeBl,'VAL'))or(In_N(NomeBl,'IRETE'))or(in_N(NomeBl,'RAD'))or(in_N(NomeBl,'RIMRETE'))or(in_N(NomeBl,'RIPRETE'))) then
        begin
        {Inc(autoinc1);
        if (NomeBl='IRETE') then writeln(fo,'INIZIORETE:')
        else writeln(fo,'TERMINALE:');
        writeln(fo,'CODICE:'+inttostr(autoinc1)+':');
        writeln(fo,'X:'+x1+':');
        writeln(fo,'X:'+y1+':');
        writeln(fo,'Z:0:');
        writeln(fo,'DISEGNO::');
        writeln(fo,'TIPO::');
        writeln(fo,'SERIE::');
        writeln(fo,'MODELLO::');
        writeln(fo,'ELEMENTI:0:');
        writeln(fo,'PORTATA:0:');
        writeln(fo,'PERDITECARICO:0:');
        writeln(fo,'REGOLAZIONI::');
        }
        {$Ifdef Tubi}
        if (in_N(NomeBl,'IRETE')) then
          begin
          temp:=Cercapar('0');//Codice
          temp:=Cercapar('1');
          Temp1:=Cercapar('0');//tiporete
          Temp1:=Cercapar('1');

     (*
    p1  := leggiidentif1(buf); // I
    p1  := leggiidentif1(buf); // codice entità

    p1  := leggiidentif1(buf); // X
    p2  := leggiidentif1(buf); // Y
    p3  := leggiidentif1(buf); // Z
    p4  := leggiidentif1(buf); // codice rete
    // Emanuela 5/4/2004
    p5  := Leggiidentif1(buf); // perdite ammesse in pred
    p6  := Leggiidentif1(buf); // velocità ammesse in pred
    p7  := Leggiidentif1(buf); // perdite ammesse rami favo
    p8  := Leggiidentif1(buf); // velocità ammesse rami fav
    p9  := Leggiidentif1(buf); // piano di riferimento
    p10 := Leggiidentif1(buf); // angolo di rotazione
    p11 := Leggiidentif1(buf); // specchiatura
    //Cercarete(p4,p4,str_tofloat(p1),str_tofloat(p2),0);
    // Emanuela inserito il caricamento delle Z
    Cercarete(p4,p4,p9,p11,str_tofloat(p1),str_tofloat(p2),str_tofloat(p3),str_tofloat(p5),str_tofloat(p6),str_tofloat(p7),str_tofloat(p8),str_tofloat(p10));
      *)
          Cercarete(temp,temp1,codIndPiano(PianoEdif),'S',str_tofloat(X1),str_tofloat(y1),str_tofloat(Z1),200,1,400,2,0,0.5);
          end
        else
          begin
          if (In_n(NomeBl,'RIMRETE')) then
            begin
            temp:=Cercapar('0');//ATTRIB codice rete
            temp:=Cercapar('1');
            temp1:=Cercapar('0');//ATTRIB lunghezza
            temp1:=Cercapar('1');
            temp2:=Cercapar('0');//ATTRIB codice perdite
            temp2:=Cercapar('1');
            temp3:=Cercapar('0');//ATTRIB numero perdite
            temp3:=Cercapar('1');
            Cercarimando(temp,temp1,temp2,temp3,'',true,str_tofloat(X1),str_tofloat(y1),0,0,'');
            end
          else
            begin
            if (In_N(NomeBl,'RIPRETE')) then
              begin
              temp:=Cercapar('0');//ATTRIB
              temp:=Cercapar('1');
              Cercarimando(temp,'','','','',true,str_tofloat(X1),str_tofloat(y1),0,0,'');
              end
            else
              begin
              if (In_N(NomeBl,'VAL')) then
                begin
                temp:=Cercapar('0');//ATTRIB codiceperdita
                temp:=Cercapar('1');
                Inseriscivalvola(codIndPiano(PianoEdif),str_tofloat(X1),str_tofloat(y1),0,temp);
                end
              else
                begin
                 //CaricaTerminale(0, X1, Y1, 0, )
                if NGterm < MaxGTerm then
                   Inc(NGterm);
                if Gterm^[Ngterm]=nil then new(Gterm^[Ngterm]);
                temp:=Cerca2par('50','0',Primopar);
                if primopar then
                  begin
                  Gterm^[Ngterm]^.angolo:=str_tofloat(temp)+180;
                  temp:=Cercapar('0');//ATTRIB potenza
                  end
                else  Gterm^[Ngterm]^.angolo:=180;

                temp1:=Cercapar('1');//POtenza
                Gterm^[Ngterm]^.POt:=str_tofloat(temp1);
                Gterm^[Ngterm]^.TipoTerm:=copy(Nomebl,5,length(nomebl)-5);
                Gterm^[Ngterm]^.TipoTerm:=copy(Gterm^[Ngterm]^.TipoTerm,1,pos('_',Gterm^[Ngterm]^.TipoTerm)-2);
                //Gterm^[Ngterm]^.TipoTerm:=formst(
                //if uppercase(Gterm^[Ngterm]^.TipoTerm)<>'FANCOIL' then
                //Gterm^[Ngterm]^.TipoTerm:='RADIATORE';
                temp:=Cercapar('0');//perdita
                temp:=Cercapar('1');
                Gterm^[Ngterm]^.Perd:=str_tofloat(temp)/1000;

                temp1:=Cercapar('0');//elementi
                temp1:=Cercapar('1');
                temp1:=Cercapar('0');//modello
                temp1:=Cercapar('1');
                temp1:=Cercapar('0');//Cod
                temp1:=Cercapar('1');
                temp1:=Cercapar('0');//Lmax
                temp1:=Cercapar('1');
                temp1:=Cercapar('0');//Incr
                temp1:=Cercapar('1');
                temp1:=Cercapar('0');//POrt
                temp1:=Cercapar('1');
                temp1:=Cercapar('0');//serie
                temp1:=Cercapar('1');

                temp1:=Cercapar('0');//montaggio
                temp1:=Cercapar('1');
                Gterm^[Ngterm]^.Montaggio:=temp1;

                Gterm^[Ngterm]^.Dt:=5;
                Gterm^[Ngterm]^.piano:=codIndPiano(PianoEdif);
                Gterm^[Ngterm]^.Port:=Gterm^[Ngterm]^.pot*2.427184E-4/Gterm^[Ngterm]^.Dt;
                Gterm^[Ngterm]^.XTerm:=str_tofloat(X1);
                Gterm^[Ngterm]^.Yterm:=str_tofloat(Y1);
                Gterm^[Ngterm]^.Zterm:=str_tofloat(Z1);
                Gterm^[Ngterm]^.cod:='';//CaricaCodice(Gterm^[Ngterm]^.XTerm,Gterm^[Ngterm]^.YTerm,pianoent,Gterm^[Ngterm]^.Numamb);
                Gterm^[Ngterm]^.codEntDxf:=CodEntDXF;
                //Gterm^[Ngterm]^.ZTerm:=0;
                if Fgtb^[NGterm]=Nil then new(Fgtb^[NGterm]);
                Fgtb^[NGterm].IndM:=Ngterm;
                Gterm^[Ngterm]^.Taratura:='';
                Gterm^[Ngterm]^.NumTer:=0;
                //Gterm^[Ngterm]^.Montaggio:=0;
                Gterm^[Ngterm]^.Modello:='';
                Gterm^[Ngterm]^.Serie:='';
                Gterm^[Ngterm]^.Profondita:=0.3;
                Gterm^[Ngterm]^.Altezza:=1;
                Gterm^[Ngterm]^.Larghezza:=1;
                Gterm^[Ngterm]^.Xetic:=str_tofloat(X1);
                Gterm^[Ngterm]^.Yetic:=str_tofloat(Y1)+0.6;    

                end;
              end;
            end;
          end;
        {$Endif}

        end;
      end;
  {
  if buf='POLYLINE' then
    begin
    Colore:=Cercapar('5');
    if prima then
      begin
      writeln(fo,'PIANO:'+Cercapar('8')+':');
      prima:=false;
      end;
    primapoly:=false,
    repeat
      while (not eof(fi))and(buf<>'VERTEX')and(buf<>'VERTEX') do
      readln(fi,Buf);
      x1:=Cercapar('10');
      y1:=Cercapar('20');
      x2:=Cercapar('11');
      y2:=Cercapar('21');
      writeln(fo,'M:'+CDL+':'+Colore+':'+x1+':'+y1+':'+x2+':'+y2+':Tlinea:');
      end;
    until
    end;
  }
    end;
  end;
{$Ifdef Tubi}
CloseCercacod;
{$Endif}

end;

procedure Read_Dxf(Namefin,Namefout:string;Tubi:boolean);

Var k:integer;
    elPiani:array[1..20]of string;
    Npiani:Integer;

Procedure AggiornaLayer(Ly:string);
Var Trov:boolean;
    i:integer;
begin
if Tubi then
  begin

  if  (Upstring(copy(ly,length(ly)-4,5))<>'_TUBI') then exit;
  end
else
if (length(ly)>2)or(upcase(ly[1])<>'P') then exit;

trov:=false;
for i:=1 to NPiani do
if elpiani[i]=ly then trov:=true;
if not trov then
  begin
  inc(Npiani);
  elpiani[Npiani]:=ly;
  end;
end;
begin
Input_dxf(Namefin,true);
{$Ifdef Tubi}
InitColCad;
{$Else}
initarpot(1);
{$Endif}

{$Ifdef Tubi}
if (Tubi)and(fileexists(IncludeTrailingPathDelimiter(extractfilepath(namefin)) + 'tubi.txt'))
    and(not(fileexists(IncludeTrailingPathDelimiter(extractfilepath(namefin))  + 'disegno.dxf'))) then
    begin
    leggifiletubi(IncludeTrailingPathDelimiter(extractfilepath(namefin)) + 'tubi.txt');
    ScriviInterfDXF;;
    exit;
    end;
{else
  begin
  showmessage(extractfilepath(namefin)+'\tubi.txt'+' non trovato');
  exit;
  end;}
if (Tubi)and(not fileexists(namefin)) then
  begin
  showmessage(namefin+' non trovato');
  exit;
  end;
{$Endif}
NPIani:=0;
assignfile(fiDXF,NameFin);
Reset(fiDXF);
try
  assignfile(FoDXF,NameFout);
  Rewrite(FoDXF);
  try
    if not tubi then
    writeln(FoDXF,'NORD:45:');
    while (not eof(fiDXF))and(buf<>'ENTITIES') do
    readln(fiDXF,Buf);
    while not eof(fiDXF) do
      begin
      while (not eof(fiDXF))and(buf<>'LINE') do
      readln(fiDXF,Buf);
      if buf='LINE' then
        begin
        AggiornaLayer(Cercapar('8'));
        end;
      end;
    for k:=1 to Npiani do
      begin
      if not tubi then
        begin
        writeln(FoDXF,'PIANO:'+CodIndPiano(Elpiani[k])+':');
        Leggi_Dxf(Elpiani[k],0);
        end
      else
        begin
        {writeln(fo,'[LISTA_TERMINALI_INIZIORETE]');
        Leggi_Dxf(Elpiani[k],1);
        Leggi_Dxf(Elpiani[k],3);
        writeln(fo,'[LISTA_TUBI]');}
        Leggi_Dxf(Elpiani[k],2);
        {$Ifdef Tubi}
        spezzalinee;
        spezzaTerminali;
        {$endif}
        end;
      end;
    close(FoDXF);
  except
    close(FoDXF);
  end;
  close(fiDXF);
except
  close(fiDXF);
end;
{$Ifdef Tubi}
{$Else}
Closearpot;

{$Endif}
end;



end.
