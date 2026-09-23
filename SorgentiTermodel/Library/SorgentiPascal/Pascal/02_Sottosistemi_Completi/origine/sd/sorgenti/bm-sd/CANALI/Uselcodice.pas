unit Uselcodice;

interface

Procedure Selcodice(Var codin:Pchar);

implementation
uses u3dsd,sysutils;

Procedure Selcodice(Var codin:Pchar);

Function RetCirc(Tipo:Char):string;
begin
If Upcase(tipo)='R' then result:='Rettangolare'
else result:='Circolare';
end;

Var ss:string;

begin
ss:=strpas(codin);
form1:=Tform1.create(nil);

with form1 do
  begin
  Height:=450;
  width:=600;
  cbcodpezzo.Text:=ss;
  cbentrata.text:=RetCirc(ss[1]);
  CBNuscite.text:=ss[2];
  if strtoint(CBNuscite.text)>0 then
  cbUscita1.text:=RetCirc(ss[3])
  else
    begin
    Label15.Visible:=false;
    CBUscita1.Visible:=false;
    end;
  
  Gbvarie.Visible:=true;
  Label9.Visible:=false;
  CBNuscite.Visible:=false;
  Label10.Visible:=false;
  CBTipo.Visible:=false;
  if strtoint(CBNuscite.text)<2 then
    begin
    Label15.Visible:=false;
    CBUscita2.Visible:=false;
    end
  else cbUscita2.text:=RetCirc(ss[4]);

  showmodal;
  codin:=Pchar(cbcodpezzo.Text);
  end;
form1.free;
end;
end.
