program provacd;
uses mmsystem,strings;

function suonapezzo(n:string):string;
var errore:string;
    ritorno:array[0..255] of char;
    lrit:longint;
    pcomando:array[0..80] of char;
    comando:string[80];
    error:longint;
    lpstrBuffer: PChar; uLength: Word;
begin
  lrit:=256;
  comando:='open cdaudio';
  strpcopy(pcomando,comando);
  error:=mcisendstring(pcomando,ritorno,lrit,0);
  if error=0 then
  begin
    errore:=strpas(ritorno);
    if errore='0' then
    begin
    suonapezzo:='Cd non presente';
    exit;
    end
    else suonapezzo:='';
  end;

  comando:='status cdaudio media present';
  strpcopy(pcomando,comando);
  error:=mcisendstring(pcomando,ritorno,lrit,0);
  if error=0 then
  begin
    errore:=strpas(ritorno);
    if errore='falso' then
    begin
    suonapezzo:='Disco non inserito';
    exit;
    end
    else suonapezzo:='';
  end;

  comando:='set cdaudio time format tmsf';
  strpcopy(pcomando,comando);
  error:=mcisendstring(pcomando,ritorno,lrit,0);
  if error<>0 then mciGetErrorString(Error, lpstrBuffer, uLength) ;


  comando:='play cdaudio from '+n;
  strpcopy(pcomando,comando);
  mcisendstring(pcomando,ritorno,lrit,0);
end;
begin
  suonapezzo('4 to 5')
end.