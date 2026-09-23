Program prnwin;
{$R prnwin.RES}
{$F+}
uses OWindows, Objects, ODialogs, WinTypes, WinProcs, Strings,validate,defuti,
     bwcc,main_w,utilitie,inituti,wm,prntesto;


type

  TGesthvacApp = object(TApplication)
    procedure InitMainWindow; virtual;
  end;

  PHvacWindow = ^THvacWindow;
    tHvacwindow=object(tmainwindow)
    constructor init(Aparent:pwindowsobject;Thetitle:pchar);
    procedure stampa; virtual cm_first+101;
  end;


{--------------------------------------------------------------------------}






Constructor ThvacWindow.Init(Aparent:pwindowsobject; TheTitle: PChar);
var fp:text;
    sm,si:string[20];

    pc:array[0..20] of char;
begin
  inherited init(aparent,Thetitle);
  Attr.Menu := LoadMenu(HInstance, 'Menu_1');
  nomeprogetto:='Mc4-software - esecuzione stampa [stampe.lst]';
end;
procedure ThvacWindow.stampa;
begin
  eseguistampa;
end;
procedure TGestHvacApp.InitMainWindow;
var sm:string[20];
    pc:array[0..20] of char;
begin
  sm:='';
  strpcopy(pc,sm);
  MainWindow := New(PhvacWindow, Init(nil, pc));
end;



var
  GestHvacapp: TGestHvacApp;
  r:trect;
begin

  hd:=findwindow('TurboWindow','Mc4-software - esecuzione stampa [stampe.lst]');
  if hd=0 then
  begin

    @Win31LockWindowUpdate :=
    GetProcAddress(GetModuleHandle('User'), PChar(294));
    {visbit(r,'HVACBIT');}
    Gesthvacapp.Init('Hvacbit');
    {w_usamaskera(daticlie,'hvacbit.msk',procarr,false,code,fill_listagen,nil);}
    showwindow(pmainwin^.hwindow,sw_Showmaximized);
    GestHvacapp.Run;
    GestHvacapp.Done;
  end
  else
  setactivewindow(hd);
end.
