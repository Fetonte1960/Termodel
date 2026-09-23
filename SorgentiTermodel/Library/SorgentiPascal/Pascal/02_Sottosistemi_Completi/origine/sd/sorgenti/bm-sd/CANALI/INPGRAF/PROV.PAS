program prov;

{$R+}    {Range checking off}
{$B-}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}


{$R duct.res}

uses owindows,wintypes,definiz,bwcc,defuti,utiwin;


type
  TMyApplication = object(TApplication)
    procedure InitMainWindow; virtual;
    Function CanClose:Boolean;Virtual;
  end;

 type datirec=array[0..pezzitr]of recpezzi;



   pmywindow=^Tmywindow;
   tmywindow=object(twindow)
   constructor init(aparent:pwindowsobject;atitle:pchar);

   procedure input;virtual wm_first+wm_Rbuttonup;
   end;

var  cati:datirec;
     chiave,riga:integer;

{----------------------------------------------------------------------------}


constructor tmywindow.init(aparent:pwindowsobject;atitle:pchar);
begin
   inherited init(aparent,atitle);
   pmainwindow:=@self;

end;

procedure tmywindow.input;
begin
  notok;
  notcl;
  fillchar(cati,sizeof(cati),0);
  {uti_primavolta:=true;}
  W_IOTabella(cati,33+1,1,11,'icona2'{Chiave,Riga,
                  'icona2.prv',true,false,false,884,0});

end;

procedure TMyApplication.InitMainWindow;
begin
  MainWindow := New(pmywindow, Init(nil, 'Principale'));
end;
{----------------------------------------------------------------------------}
Function TMyApplication.CanClose;
Var risposta:integer;
begin
CanClose:=true;
Risposta:=MessageBox(0,'Volete salvare le modifiche','Mc4 , DUCT : richiesta di uscita',
           Mb_yesNoCancel or Mb_systemModal or Mb_iconexclamation);{*TR*}
  case risposta of
  {idyes:Savedis(DataDrive+NomeProg);}
  idcancel:CanClose:=False;
  end;
end;



(*
{----------------------------------------------------------------------------}
Procedure TMYwindow.WMMenuSelect(var Msg: TMessage);
var i,a:Integer;
begin
{messagebeep(Mb_iconExclamation);}
for i:=1 to 10000 do a:=round(i/i);
{if (msg.LParamLo And MF_popup)=0  then messagebeep(10);}
if msg.LParamLo <>-1  then
if (msg.LParamLo And MF_popup)=0  then
if (msg.LParamLo And MF_SysMenu)=0 then
if (msg.LParamLo And MF_MouseSElect)<>0  then
  begin
  {messagebeep(10);}
    Case Msg.WParam of
    Dis_dim,Dis_nodi,dis_unif,M_osnap:
        begin
        if (msg.LParamLo And MF_Checked)=0  then
        CheCkMenuItem(msg.LParamHi,Msg.WParam,Mf_cheCked)
        else CheCkMenuItem(msg.LParamHi,Msg.WParam,Mf_UncheCked)
        end;
    end;
    Case Msg.WParam of
    M_osnap:
        begin           { Osnap }
        CancCur;
        C_osnap:=Not C_osnap;
        if (NumCom=Tronco_dal)and(Fase=2) then
          begin
          if C_osnap then Cod_cur:=3
          else
            begin
            if vuoto then Cod_cur:=11 else cod_cur:=5 ;
            end;
          end;
        end;
    else Menu(Msg.WParam);
    end;
  end;
end;
*)



var miafin:tmyapplication;

begin
miafin.init('DUCT');
miafin.run;
miafin.done;
end.

