unit UCalcoli;
interface

uses math,dbtables;


Procedure initAmb(tt1:TTable);
Procedure initDefault(tt2,displayTable:Ttable);
Function TipoPan(ttt:integer):string;
Procedure CalcoloPann(Var bloccar:boolean;tt1:Ttable;tl:integer);

implementation
uses UDatalink,sofrad;

Function Cdec(v:real;dec:integer):real;
begin
result:=round(v*power(10,dec))/power(10,dec);
end;


Function TipoPan(ttt:integer):string;
begin
result:='';
Case ttt of
  1:result:='Proter QF';
  2:result:='Proter QM';
  3:result:='Proter FLY';
  4:result:='Proter alfa-PARALLEL';
  5:result:='Proter alfa-CROSS';
  6:result:='Doghe passo 200 mm';
  7:result:='Proter GKM';
  8:result :='Proter GP';
  end;
end;

Function  EmI(n:integer;dt:real):real;
begin
{ Resa inv. degli scambiatori }
  Case n of
  21:{ 2T105 }result:=6.03*power(dt,1.078);
  22:{ 2F105 }result:=4.73*power(dt,1.039);
  3:{ 3T70  }result:= 6.03*power(dt,1.078);
  4:{ 4T70  }result:=6.17*power(dt,1.116);
  end;
end;

Function EmE(n:integer;dt:real):real;
begin
{ Resa est. degli scambiatori }
  Case n of
  21:{ 2T105  }result:=6.453*power(dt,1.064);
  22:{ 2F105  }result:=5.65*power(dt,1.071);
  3:{ 3T70  }result:=6.453*power(dt,1.064);
  4:{ 4T70 }result:=6.751*power(dt,1.163);
  end;
end;

Function CalcResaI(p:integer;dt,ps:real;sc:integer):real;
begin
  case p of
  1: {  QF }
    case round(ps) of
    300:result:=5.8*power(dt,1.072);
    600:result:= 3.6*power(dt,1.021);
    end;
  2:{   QM  } result:=EmI(sc,dt);
  3:{ FLY } result:=EmI(sc,dt);
  4: { alfa-parallel }result:=EmI(sc,dt);
  5: { alfa-cross } result:=EmI(sc,dt);
  6: { doghe } result:=EmI(sc,dt);
  7: { Cartongesso GKM } result:=3.7*power(dt,1.024);
  8: { Cartongesso GP  }result:=3.11*power(dt,1.037);
  end;
result:=cdec(result,2);
end;

Function CalcResaE(p:integer;dt,ps:real;sc:integer):real;
begin
  case p of
  1: {  QF }
    case round(ps) of
    300:result:=4.9*power(dt,1.037);
    600:result:= 2.52*power(dt,1.016);
    end;
  2:{   QM  } result:=EmE(sc,dt);
  3:{ FLY } result:=EmE(sc,dt);
  4: { alfa-parallel }result:=EmE(sc,dt);
  5: { alfa-cross } result:=EmE(sc,dt);
  6: { doghe } result:=EmE(sc,dt);
  7: { Cartongesso GKM } result:=4.96*power(dt,1.096);
  8: { Cartongesso GP  }result:=4.65*power(dt,1.082);
  end;
result:=cdec(result,2);
end;



Procedure CalcoloPann(Var bloccar:boolean;tt1:Ttable;tl:integer);
Var deltat:real;
begin
bloccar:=true;
tt1.edit;
with V_amb do
  begin
  set_Tlamp(tl);
  set_slorda(L*H);
  Set_SLamp(TLamp*(Hlamp1/1000)*(Llamp1/1000));
  set_snetta(slorda-SLamp);
  if snetta<0 then set_snetta(0);
  set_TPOtlamp(POtLamp*Tlamp);
  set_Etotsens(Tpotlamp+persone+AltriC);
  DeltaT:=TiE-(ETmacq+ETracq)/2;
  set_ResaE(CalcResaE(tp,deltat,Lq1,ts));
  set_TotE(cdec(ResaE*snetta,0));
  set_ResaI(CalcResaI(tp,deltat,Lq1,ts));
  set_TotI(cdec(ResaI*snetta,0));
  end;
tt1.post;
bloccar:=false;
end;
Procedure initDefault(tt2,displayTable:Ttable);
begin
tt2.edit;
with V_Recdef do
  begin
  Set_POrtAp(2);
  Set_Alt(3);
  Set_TiI(20);
  Set_URI(40);
  Set_ITmaria(16);
  Set_ITmacq(45);
  Set_ITracq(48);
  Set_TiE(26);
  Set_URE(50);
  Set_ETmaria(18);
  Set_ETmacq(13);
  Set_ETracq(16);
  end;
tt2.post;
tt2.Refresh;
displaytable.refresh;
end;

Procedure initAmb(tt1:TTable);
begin
bloccaredraw:=true;
tt1.open;
tt1.edit;
with V_Recdef do
  begin
  V_amb.Set_Tipo('Rettangolo');
  V_amb.Set_Lq1(600);
  V_amb.Set_Hq1(600);
  V_amb.Set_Tp(1);
  V_amb.Set_Ts(0);
  V_amb.Set_DescrP(tipopan(1));
  V_amb.Set_POrtAp(POrtAp);
  V_amb.Set_Alt(Alt);
  V_amb.Set_TiI(TiI);
  V_amb.Set_URI(URI);
  V_amb.Set_ITmaria(ITmaria);
  V_amb.Set_ITmacq(ITmacq);
  V_amb.Set_ITracq(ITracq);
  V_amb.Set_TiE(TiE);
  V_amb.Set_URE(URE);
  V_amb.Set_ETmaria(ETmaria);
  V_amb.Set_ETmacq(ETmacq);
  V_amb.Set_ETracq(ETracq);
  end;
tt1.post;
bloccaredraw:=false;
end;


end.
