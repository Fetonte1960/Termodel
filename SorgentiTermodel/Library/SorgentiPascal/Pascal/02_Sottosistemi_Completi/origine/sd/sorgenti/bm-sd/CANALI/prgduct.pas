{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit prgDUCT;

Interface

Uses
 // WinDos, {Unit found in TURBO.TPL}
//  gruti,
  {$ifdef ducttubi}
  load_P,
  {$endif}
  WINtypes,
  winprocs,
 // main_w,
  utilitie,
  defuti,
  definizcan,definiz,
  owindows,
  //def_win,
  ioduct,
  WM
  {$ifdef ducttubi}
  ,u_winput
  {$endif}

  {$ifdef delphi}
  ,messages,dummyfunction
  {$endif}
  ;

procedure ProgCorr(NProg,Sotto:string);

Function CaricaMisure(NomeFile:st18):string;

procedure eraseduct(nome:st18);

procedure ArchProgetti(var uscita:integer);

  {$Ifdef Win}

procedure W_caricamisure;

  {$endif}
{===========================================================================}

Implementation

{var nomearch:st80;}


Procedure CambiaMisure(NomeFile:st18);
 Var Miscor,i,nrt:integer;
     trovato:boolean;
 const risp=2;
    BEGIN
{$ifdef ducttubi}
      if Exist(driveprog+nomefile+'.msc') then
       begin
          ASSIGN(FInt, driveprog+nomefile+'.msc');
          RESET(FInt);
          READ(FInt, miscor);
          CLOSE(FInt);
       end
      else  Miscor:=1;

      IF miscor = 1 THEN  miscor := 3600
      ELSE  miscor := 1;
      if unmis<>miscor then
      begin
        if dueres then
        begin
          chdir(get_drive+'\cca\inpgraf');
          if UnMis=1 then NomeMskw:='dd1024s' else NomeMskw:='dd1024';
          a_w:=numerotabella(NomeMskw,hd,2);
          tabellacorrente^[a_w].dialog^.done;
          tabellacorrente^[a_w].nome:='';
          i:=0;
          trovato:=false;
          unmis:=miscor;
          if UnMis=1 then NomeMskw:='dd1024s' else NomeMskw:='dd1024';

          while (not trovato) or (i=max_res) do
          begin
            inc(i);
            trovato:=el_res[i].cod=cost_dial1;
          end;
          if trovato then
          begin
            el_res[i].nome:=NomeMskw;
            nrt:=n_res;
            n_res:=i;
          end;
          procarr[1]:=copia2;
          tab_testo:=false;
          posx:=el_win[1].w_win+3*risp;
          posy:=el_win[3].y_ang+3*risp+el_win[3].h_win;;
          w_iotabella(CATI^,NumPezzi+1,1,11,NomeMskw+'.msk',false,procarr,false,cod,fill_listagen,nil);
          n_res:=nrt;
        end
        else
        unmis:=miscor;
        chdir(get_drive+'\cca');
      end;
      ASSIGN(FInt, driveprog+nomefile+'.msc');
      rewrite(FInt);
      WRITE(FInt, miscor);
      CLOSE(FInt);
      {$endif}
    END;


{$Ifdef Win}

procedure w_progcorr; far;
var hd:hwnd;
    msg:dummyfunction.tmessage;
begin
  {$ifdef ducttubi}
  hd:=0;
  st_8:='ARCHPROG';
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  begin

  NumeroProg:=vprog^[numerolineatabella].nome;
  if controlnom(NumeroProg) then
  begin
    if nomeprog<>'' then
    begin
      pdw^.salva_dis;
      trattosel:=0;
      nomeprog:=numeroprog;
      sendmessage(Pmainwin^.hwindow,wm_command,10100,0);
    end
    else
    nomeprog:=numeroprog;
    progcorr(numeroprog,'');
    pmainwin^.setupwindow;
    tabellacorrente^[a_w].dialog^.ok(msg);
  end;
  end;
  {$endif}
end;

procedure W_caricamisure;
begin

  if NumeroProg > '' then
               begin
                  CambiaMisure(NumeroProg);
                  progCorr(NumeroProg,'');
               end;
//  pmainwin^.setupwindow;
end;
(*
procedure w_eraseduct; f
var i:integer;
    st:st80;
    hd:hwnd;
begin
  hd:=0;
  st_8:='ARCHPROG';
  a_w:=numerotabella(st_8,hd,2);
  with tabellacorrente^[a_w].dialog^ do
  begin
  st:=' '+VProg^[numerolineatabella].Nome+' '+W_M(9);
  if Conferma('Duct.msg',st,1) then
                     { ' sara`  cancellato ,conferma (s/n):}
  begin
    EraseDuct(VProg^[numerolineatabella].Nome);
    for i:=numerolineatabella to NProgetti-1 do
    VProg^[i]:=VProg^[i+1];
    with VProg^[NProgetti] do
    begin
      Descr:='';
      Nome:='';
    end;
    progCorr('','');
  end;
  end;
end;
*)
{$endif}

Function CaricaMisure(NomeFile:st18):string;
 Var Miscor:integer;
    BEGIN
      if Exist(driveprog+nomefile+'.msc') then
       begin
          ASSIGN(FInt, driveprog+nomefile+'.msc');
          RESET(FInt);
          READ(FInt, miscor);
          CLOSE(FInt);
       end
      else
       begin
          Miscor:=1;
          ASSIGN(FInt, driveprog+nomefile+'.msc');
          REWRITE(FInt);
          WRITE(FInt, miscor);
          CLOSE(FInt);
       end;

      IF miscor = 1 THEN CaricaMisure:=W_M(3);   {'Port.: mc/sec';}
      IF miscor = 3600 THEN CaricaMisure:=W_M(4);  {'Port.: mc/h';}
    END;


procedure ProgCorr(NProg,Sotto:string);
var pc:array[0..80] of char;
    f:text;
begin
    Sottorete:=sotto;
    nomeprogetto:=W_M(5)+' '+VersTXT;  { MC4 Software ==> DUCT rev.}
    if NProg >'' then
      begin
         nomeprogetto:=Nomeprogetto+'  '+W_M(1)+NProg;
         nomeprogetto:=Nomeprogetto+'  '+CaricaMisure(NProg);
      end;
    {$Ifdef dos}
    //window(1,2,80,2);
    //textcolor(col[18]);
    //textbackground(col[17]);
    //gotoxy(1,1);
    //write(nomeprogetto);
    //clreol;
    //window(1,3,80,25);
    {$endif}
    assign(f,driveprog+'prog.can');
    rewrite(f);
    write(f,nprog);
    close(f);
end;

procedure SaveArch; far;
begin
 //  assign(farc,driveprog+'duct.ark'{NomeArch});
 //  rewrite(farc);
 //  write(farc,VProgcan^);
  // close(farc);
end;

procedure  canclose;far;

begin

  archivioprogetti:=true;

end;



PROCEDURE EraseDUCT(Nome : st18);
 var i:integer;
 {Estensioni prese da ARCPROG.PAS procedure eraseprog --> duct 4.02}

  procedure CancFile(NomeFile:st80);
  var f:file;
  begin
     if Exist (NomeFile) then
      begin
         assign(f,NomeFile);
         Erase(f);
      end;
  end;



 BEGIN
    if Conferma('Duct.msg','',9) then
    BEGIN
    if Exist (Driveplt+Nome+'.PNT') then
     begin
        i:=1;
        TRANSFER_ElencoPiante(DRIVEplt+ Nome+'.PNT','L');
        repeat
          if (EPt^[i].NomeP > '') then
           begin
              CancFile(Driveplt+EPt^[i].NomeP+'.DLT'); {'Progetti\'}
              CancFile(Driveplt+EPt^[i].NomeP+'.PLT');
           end;
          if (EPt^[i].NomeP = '') then i:=MaxEPiante+1
          else i:=i+1;
        until (i > MaxEPiante);
     end;
    if Exist (Driveplt+Nome+'.SEZ') then
     begin
        i:=1;
        TRANSFER_Sezioni(DRIVEPlt+ Nome+'.SEZ','L');
        repeat
          if (Sez^[i].NomeP > '') then
           begin
              CancFile(Driveplt+Sez^[i].NomeP+'.PLT');  {'Progetti\'}
              CancFile(Driveplt+Sez^[i].NomeP+'.DLT');
           end;
          if (Sez^[i].NomeP = '') then i:=MaxSez+1
          else i:=i+1;
        until (i > MaxSez);
     end;
    END;


    CancFile(driveprog+Nome+'.GN1');
    CancFile(driveprog+Nome+'.GN2');
    CancFile(driveprog+Nome+'.PNT');
    CancFile(driveprog+Nome+'.Sez');
    CancFile(driveprog+Nome+'.CAN');
    CancFile(driveprog+Nome+'.SCH');
    CancFile(driveprog+Nome+'.SCG');
    CancFile(driveprog+Nome+'.TRL');
    CancFile(driveprog+Nome+'.CRL');
    CancFile(driveprog+Nome+'.3DH');
    CancFile(driveprog+Nome+'.LS1');
    CancFile(driveprog+Nome+'.LST');
    CancFile(driveprog+Nome+'.3DG');
    CancFile(driveprog+Nome+'.RNF');
    CancFile(driveprog+Nome+'.SPS');
    CancFile(driveprog+Nome+'.BUL');
    CancFile(driveprog+Nome+'.MSC');
    CancFile(driveprog+Nome+'.RET');
    CancFile(driveprog+Nome+'.DTR');
    CancFile(driveprog+Nome+'.PZZ');
    CancFile(driveprog+Nome+'.TER');
    CancFile(driveprog+Nome+'.CON');
    CancFile(driveprog+Nome+'.RIS');
    CancFile(driveprog+Nome+'.DIM');
    CancFile(driveprog+Nome+'.LSP');
 END;


procedure ArchProgetti(var uscita:integer);




var i,Chiave,Scelta,Campo,Riga :integer;
    Maschera                   :st80;

    NProg                       :st18;
    InitMask,initmenu           :boolean;
    Old_drive                   :st80;
    Errore,esci                 :boolean;
    Dato                        :linestr;
    StartPos                    :integer;
    Exitchar                    :char;
    G                           :boolean;
    NT                          :ST8;

{$IFDEF WIN }
VAR HD:HWND;
{$ENDIF}


procedure LoadArch;
 var i:integer;
 begin
    if Exist(driveprog+'duct.ark'{NomeArch}) then
     begin
        assign(farc,driveprog+'duct.ark'{NomeArch});
        reset(farc);
        //read(farc,VProgcan^);
        close(farc);
     end
    else
     begin
        fillchar(VProg^,sizeof(VProg^),0);
        {for i:=1 to NProgetti do
         with VProg^[i] do
          begin
             Descr:='';
             Nome:='';
          end;}
      end;
  end;


{ -------------------------- main ----------------------------------------- }

begin
(*
  if uscita=21 then
  begin
    Maschera:='Archprog.msk';
  end
  else
  begin
    Maschera:='Sottor.msk';
  end;
  Posx:=0;
  tab_testo:=true;
  LoadArch;
  mess^[1]:=nomecommessa;
  procarr[1]:=w_caricamisure;
  procarr[2]:=w_eraseduct;
  procarr[3]:=W_progcorr;
  procarr[12]:=savearch;
  procarr[11]:=canclose;
  repeat
    W_IOTabella(VProg^,nprogetti,10,2,Maschera,false,procarr,true,code,fill_listagen,nil);
  until ((code=id_ok) and (nomeprog>'')) or (code=id_cancel);
  if ((code=id_cancel) and (nomeprog='')) then halt;
*)  
end;
End.

