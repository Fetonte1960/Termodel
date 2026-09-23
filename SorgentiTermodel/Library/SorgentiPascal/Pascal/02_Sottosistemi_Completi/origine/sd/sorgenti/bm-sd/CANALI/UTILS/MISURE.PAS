unit misure;


interface
uses defuti{$Ifdef dos},crt {$endif};
var misurecor:integer;
procedure initum;
procedure initintern;
procedure initbtu;
procedure inittec;
procedure cambiamisure;
procedure cambiatemperature;
implementation
uses utilitie;
procedure initintern;
var i:integer;
begin

  with arkum^[0] do
  begin
    descrInt:='';{*TR}
    umint:='';
    with um[1] do
    begin
      descum:='øC';
    end;
  end;
  with arkum^[1] do
  begin
    descrInt:='Lunghezza';{*TR}
    umint:='m';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m';
      dec:=2;
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='mm';
    end;
  end;

  with arkum^[2] do
  begin
    descrInt:='Viscosit…';{*TR}
    umint:='Pa.s';
    with um[1] do
    begin
      coeffum:=1;
      descum:='Pa.s';
      dec:=7;
    end;
  end;
  with arkum^[3] do
  begin
    descrInt:='Conducibilit… lineare';{*TR}
    umint:='W/m.øC';
    with um[1] do
    begin
      coeffum:=1;
      descum:='W/m.øC';
      dec:=4
    end;
  end;
  with arkum^[4] do
  begin
    descrInt:='Cond, Trasm, Add';{*TR}
    umint:='W/mý.øC';
    with um[1] do
    begin
      coeffum:=1;
      descum:='W/mý.øC';
      dec:=3;
    end;
  end;
  with arkum^[5] do
  begin
    descrInt:='Densit…';{*TR}
    umint:='kg/m3';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kg/m3';
      dec:=4;
    end;
  end;
  with arkum^[6] do
  begin
    descrInt:='CpT,Entalpia';{*TR}
    umint:='kJ/kg';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kJ/kg';
      dec:=3
    end;
  end;

  with arkum^[7] do
  begin
    descrInt:='Portata';{*TR}
    umint:='m3/s';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m3/s';
      dec:=6;
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='l/s';
      dec:=4;
    end;
  end;
  with arkum^[8] do
  begin
    descrInt:='Potenza';{*TR}
    umint:='W';
    with um[1] do
    begin
      coeffum:=1;
      descum:='W';
      dec:=2;
    end;
    with um[2] do
    begin
      coeffum:=1;
      descum:='W';

    end;
  end;
  with arkum^[9] do
  begin
    descrInt:='Potenza specifica';{*TR}
    umint:='W/mý';
    with um[1] do
    begin
      coeffum:=1;
      descum:='W/mý';
    end;
  end;
  with arkum^[10] do
  begin
    descrInt:='Massa';{*TR}
    umint:='kg';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kg';
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='g';
    end;
  end;
  with arkum^[11] do
  begin
    descrInt:='Massa specifica';{*TR}
    umint:='kg/mý';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kg/mý';
      dec:=1;
    end;
  end;
  with arkum^[12] do
  begin
    descrInt:='Pressione';{*TR}
    umint:='kPa';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kPa';
      dec:=1;
    end;
    with um[2] do
    begin
      coeffum:=1;
      descum:='Pa';
    end;
  end;
  with arkum^[13] do
  begin
    descrInt:='Volume';{*TR}
    umint:='m3';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m3';
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='l';
    end;
  end;
  with arkum^[14] do
  begin
    descrInt:='Velocit…';{*TR}
    umint:='m/s';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m/s';
    end;
  end;
end;

procedure initbtu;
var i:integer;
begin
  with arkum^[0] do
  begin
    descrInt:='';{*TR}
    umint:='';
    with um[1] do
    begin
      descum:='øF';
    end;
  end;
  with arkum^[1] do
  begin
    descrInt:='Lunghezza';{*TR}
    umint:='m';
    with um[1] do
    begin
      coeffum:=0.3048;
      descum:='ft';
      dec:=2;
    end;
    with um[2] do
    begin
      coeffum:=25.4;
      descum:='inch';
    end;
  end;
  with arkum^[2] do
  begin
    descrInt:='Viscosit…';{*TR}
    umint:='Pa.s';
    with um[1] do
    begin
      coeffum:=10;
      descum:='Poise';
      dec:=7;
    end;
  end;
  with arkum^[3] do
  begin
    descrInt:='Conducibilit… lineare';{*TR}
    umint:='W/m.øC';
    with um[1] do
    begin
      coeffum:=0.144;
      descum:='Btu.in/h.ftý.øF';
      dec:=4
    end;
  end;
  with arkum^[4] do
  begin
    descrInt:='Cond, Trasm, Add';{*TR}
    umint:='W/mý.øC';
    with um[1] do
    begin
      coeffum:=5.68;
      descum:='Btu/h.ftý.øF';
      dec:=3;
    end;
  end;
  with arkum^[5] do
  begin
    descrInt:='Densit…';{*TR}
    umint:='kg/m3';
    with um[1] do
    begin
      coeffum:=16.018463;
      descum:='lb/ft3';
      dec:=4;
    end;
  end;
  with arkum^[6] do
  begin
    descrInt:='Cpt,Entalpia';{*TR}
    umint:='kJ/kg';
    with um[1] do
    begin
      coeffum:=2.33;
      descum:='Btu/lb';
      dec:=3
    end;
  end;

  with arkum^[7] do
  begin
    descrInt:='Portata';{*TR}
    umint:='m3/s';
    with um[1] do
    begin
      coeffum:=0.0000631;
      descum:='gpm';
      dec:=6;
    end;
    with um[2] do
    begin
      coeffum:=0.000000105;
      descum:='gph';
      dec:=4;
    end;
  end;
  with arkum^[8] do
  begin
    descrInt:='Potenza';{*TR}
    umint:='W';
    with um[1] do
    begin
      coeffum:=0.293;
      descum:='Btu/h';
      dec:=2;
    end;
    with um[2] do
    begin
      coeffum:=0.293;
      descum:='Btu/h';
    end;
  end;
  with arkum^[9] do
  begin
    descrInt:='Potenza specifica';{*TR}
    umint:='W/mý';
    with um[1] do
    begin
      coeffum:=3.15;
      descum:='Btu/h.ftý';
    end;
  end;
  with arkum^[10] do
  begin
    descrInt:='Massa';{*TR}
    umint:='kg';
    with um[1] do
    begin
      coeffum:=2.20462;
      descum:='lb';
    end;
    with um[2] do
    begin
      coeffum:=0.0000648;
      descum:='grain';
    end;
  end;
  with arkum^[11] do
  begin
    descrInt:='Massa specifica';{*TR}
    umint:='kg/mý';
    with um[1] do
    begin
      coeffum:=4.88;
      descum:='lb/ftý';
      dec:=1;
    end;
  end;
  with arkum^[12] do
  begin
    descrInt:='Pressione';{*TR}
    umint:='kPa';
    with um[1] do
    begin
      coeffum:=6.89;
      descum:='psi';
      dec:=1;
    end;
    with um[2] do
    begin
      coeffum:=0.249;
      descum:='inh2o';
    end;
  end;
  with arkum^[13] do
  begin
    descrInt:='Volume';{*TR}
    umint:='m3';
    with um[1] do
    begin
      coeffum:=0.0283;
      descum:='ft3';
    end;
    with um[2] do
    begin
      coeffum:=3.79;
      descum:='gallon';
    end;
  end;
  with arkum^[14] do
  begin
    descrInt:='Velocit…';{*TR}
    umint:='m/s';
    with um[1] do
    begin
      coeffum:=0.3048;
      descum:='fps';
    end;
  end;
end;
procedure inittec;
begin
  with arkum^[0] do
  begin
    descrInt:='';{*TR}
    umint:='';
    with um[1] do
    begin
      descum:='øC';
    end;
  end;
  with arkum^[1] do
  begin
    descrInt:='Lunghezza';{*TR}
    umint:='m';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m';
      dec:=2;
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='mm';
    end;
  end;

  with arkum^[2] do
  begin
    descrInt:='Viscosit…';{*TR}
    umint:='Pa.s';
    with um[1] do
    begin
      coeffum:=1;
      descum:='Pa.s';
      dec:=7;
    end;
  end;
  with arkum^[3] do
  begin
    descrInt:='Conducibilit… lineare';{*TR}
    umint:='W/m.øC';
    with um[1] do
    begin
      coeffum:=1.161;
      descum:='kcal/h.m.øC';
      dec:=4
    end;
  end;
  with arkum^[4] do
  begin
    descrInt:='Cond, Trasm, Add';{*TR}
    umint:='W/mý.øC';
    with um[1] do
    begin
      coeffum:=1.161;
      descum:='kcal/h.mý.øC';
      dec:=3;
    end;
  end;
  with arkum^[5] do
  begin
    descrInt:='Densit…';{*TR}
    umint:='kg/m3';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kg/m3';
      dec:=4;
    end;
  end;
  with arkum^[6] do
  begin
    descrInt:='Cpt, Entalpia';{*TR}
    umint:='kJ/kg';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kJ/kg';
      dec:=3
    end;
  end;

  with arkum^[7] do
  begin
    descrInt:='Portata';{*TR}
    umint:='m3/s';
    with um[1] do
    begin
      coeffum:=0.00028;
      descum:='m3/h';
      dec:=1;
    end;
    with um[2] do
    begin
      coeffum:=0.00000028;
      descum:='l/h';
      dec:=0;
    end;
  end;
  with arkum^[8] do
  begin
    descrInt:='Potenza';{*TR}
    umint:='kW';
    with um[1] do
    begin
      coeffum:=1.16;
      descum:='kcal/h';
      dec:=2;
    end;
    with um[2] do
    begin
      coeffum:=1.16;
      descum:='kcal/h';

    end;
  end;
  with arkum^[9] do
  begin
    descrInt:='Potenza specifica';{*TR}
    umint:='W/mý';
    with um[1] do
    begin
      coeffum:=1.16;
      descum:='kcal/h.mý';
    end;
  end;
  with arkum^[10] do
  begin
    descrInt:='Massa';{*TR}
    umint:='kg';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kg';
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='g';
    end;
  end;
  with arkum^[11] do
  begin
    descrInt:='Massa specifica';{*TR}
    umint:='kg/mý';
    with um[1] do
    begin
      coeffum:=1;
      descum:='kg/mý';
      dec:=1;
    end;
  end;
  with arkum^[12] do
  begin
    descrInt:='Pressione';{*TR}
    umint:='kPa';
    with um[1] do
    begin
      coeffum:=10;
      descum:='mh20';
      dec:=1;
    end;
    with um[2] do
    begin
      coeffum:=10000;
      descum:='mmh20';
    end;
  end;
  with arkum^[13] do
  begin
    descrInt:='Volume';{*TR}
    umint:='m3';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m3';
    end;
    with um[2] do
    begin
      coeffum:=0.001;
      descum:='l';
    end;
  end;
  with arkum^[14] do
  begin
    descrInt:='Velocit…';{*TR}
    umint:='m/s';
    with um[1] do
    begin
      coeffum:=1;
      descum:='m/s';
    end;
  end;
end;

Procedure initum;
var i,j:integer;
begin
  for i:= 1 to maxunmisure do
  with arkum^[i] do
  begin
    descrInt:='';
    umint:='';
    for j:=1 to 2 do
    with um[j] do
    begin
      descum:='';
      coeffum:=0;
      dec:=0;
    end;
  end;

{  if exist ('unmisure.ult') then
  begin
    assign(fum,'unmisure.ult');
    reset(fum);
    read(fum,arkum^);
    close(fum);
  end
  else}
  initintern;
END;

procedure clrmp(l:integer);
var s:string[10];
    i:integer;
begin
  s:='';
  for i:=1 to l do s:=s+' ';
  write(s);
end;

procedure cambiamisure;
var i,xx:integer;
begin
  misurecor:=misurecor+1;
  case misurecor of
  1:begin
     initintern;
     UnMistemperatura:=1;
    end;
  2:begin
     initbtu;
     UnMistemperatura:=2;
    end;
  3:begin
     inittec;
     misurecor:=0;
     UnMistemperatura:=1;
    end;
 end;
 {$ifdef dos}
 cambiatemperature;
 textcolor(col[2]);
 for i:=1 to ninfoum do
   with infoum^[i] do
   with messum^[i] do
   begin
     arkum^[n1].um[n2].descum:=setleft(setright(arkum^[n1].um[n2].descum));
     xx:=Length(arkum^[n1].um[n2].descum);
     gotoxy(ix-(xx div 2),iy);
     {clrmp(lp);
     gotoxy(ix-(xx div 2),iy);}
     write(arkum^[n1].um[n2].descum);
     lp:=length(arkum^[n1].um[n2].descum);
   end;
  textcolor(col[4]);
  {$endif}
  {$ifdef win}
  {$endif}
end;

procedure cambiatemperature;
begin
case UnMistemperatura of
1:begin
    costMoltTemp:=1;
    costAddTemp:=0;
  end;
2:begin
    costMoltTemp:=1.5;
    costAddTemp:=32;
  end;
3:begin
    costMoltTemp:=2;
    costAddTemp:=40;
  end;
4:;
end;
end;


end.