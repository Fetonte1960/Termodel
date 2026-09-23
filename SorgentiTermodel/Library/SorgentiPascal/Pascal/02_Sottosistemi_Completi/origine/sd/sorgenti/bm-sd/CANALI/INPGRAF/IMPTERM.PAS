{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit ImpTerm;

INTERFACE

uses definiz,genproc,esiste;

Function AssegnaCod:String;

{---------------------------------------------------------------------------}
implementation

Const
  MaxNumFr=250;
  MaxEpiante=20;

TYPE
  Bocc   = record
            Amb     :REAL;
            Pot     :Real;
            S_T1    :Real;
            NBoc    :Integer;
            Port    :Real;
            Ric_VH  :Real;
            Ric_Lsp :Real;
            TBoc    :String[8];
            Lancio  :Real;
            Rum     :integer;
            Def     :integer;
            A_D     :Integer;
            B       :Integer;
            Perd    :Real;
          end;



  FRONTHT = Record
                NZon    :integer;
                NAmb    :integer;
                x0      : real;
                y0      : real;
                x1      : real;
                y1      : real;
             end;


    RecPiante = record
                    NomeP  : string[8];
                    ZPMin  : real;
                    ZPMax  : real;
                end;

    EPianteAr = array[1..maxEPiante] of RecPiante;
    EFr = array[1..MaxNumFr] of FrontHt;


  var
      FtHt                       : FrontHt;
      fFtHt                      : file of Frontht;
      TabFtht                    : ^EFr;
      Inizio,Fine                : Boolean;
      NZ                         : integer;
      EPt                        : EPianteAr;
      Fept                       : file of EPianteAr;
      RigaImp                    : Bocc;
      FImp                       : File of Bocc;


Procedure Carica(Nome:string;Var NA,NZ:Integer);
var i:integer;


procedure InitFtHt;
var j : integer;
begin
  for j :=1 to MaxNumFr do
   with TabFtHt^[j] do
    begin
       NZon:=0;
       NAmb:=0;
       x0 := 0;
       y0 := 0;
       x1 := 0;
       y1 := 0;
    end;
end;

begin
   If Inizio then
     begin
     Inizio:=false;
     assign(Fftht,Nome);
     reset(Fftht);
     if not eof(Fftht) Then read(Fftht,Ftht);
     end;

   i:=1;

   NZ:=FtHt.NZon;
   InitFtht;

   Repeat
     NA:=FtHt.NAmb;
     NZ:=FtHt.NZon;

     TabFtht^[i]:=FtHt;
{     writeln(lst,' frontiera ',i,' zona ',TabFtht^[i].Nzon,' amb ',TabFtht^[i].Namb,
     ' x0 ',TabFtht^[i].x0:6:1,' y0 ',TabFtht^[i].y0:6:1,
     ' x1 ',TabFtht^[i].x1:6:1,' y1 ',TabFtht^[i].y1:6:1);}
     i:=i+1;
     if i > MaxNumFr then NA:=0;
     If not(eof(Fftht)) then read(Fftht,Ftht);

     if (eof(Fftht)) and (FtHt.NAmb = NA) then TabFtht^[i]:=FtHt;

   Until (eof(Fftht)) or (FtHt.NAmb <> NA);

   if eof(Fftht) Then
     begin
     close(Fftht);
     fine:=true;
     end;

end;

function TrovaAmb(Xin,YIn : real):boolean;
var
  fr,Count,Risultato        : integer;
  Infx,Infy,xx,yy           : real;
  apr                       : real;


{ ---------------------------- main CercaAmb ------------------------------ }
{$I Inters1 }
begin

{  Writeln(lst,' X1:',XIn:6:1,'  Y1:',Yin:6:1);}
  apr:=0.0001;
  xx := 0;  yy := 0;
  Risultato := 0;

  Infx := 0;
  Infy := 0;
  Fr   := 1;
  Count:= 0;

   while (fr <= MaxNumFr) do
    begin
       if TabFtHt^[fr].NAmb > 0 then
        begin
           inters(xx,yy,Risultato,Infx,Xin, TabFtHt^[fr].x0,TabFtHt^[fr].x1,
                  Infy,Yin, TabFtHt^[fr].y0,TabFtHt^[fr].y1);
           if Risultato = 1 then
            begin
               if ( ((abs(xx - TabFtHt^[fr].x0)) <= 0.01 ) and ((abs(yy - TabFtHt^[fr].y0)) <= 0.01 ) ) or
                  ( ((abs(xx - TabFtHt^[fr].x1)) <= 0.01 ) and ((abs(yy - TabFtHt^[fr].y1)) <= 0.01 ) )then
                begin
                   Infx := Infx + 0.1;
                   count:=0;
                   fr:=0;
                end
               else count:=count+1;
            end;
           fr:=fr+1;
        end
       else fr:=MaxNumFr+1;
    end;
{   writeln(lst,'Contatore intersezioni ',count:4);}
   if ( count mod 2 ) = 0 then TrovaAmb:=false
   else TrovaAmb:=true;
end;

function NomeTerm(i,Num_A,NumTer:integer):string;

var
  st:string;
  NumTerm:string;
begin
   NumTerm:='--------';
   if i<10 Then str(i:1,St)
   else st:=chr(55+i);
   st:=setleft(setright(st));
   insert(st,NumTerm,1);

   str(NZ,St);
   st:=setleft(setright(st));
   insert(st,NumTerm,4-length(st));

   str(Num_A,St);
   st:=setleft(setright(st));
   insert(st,NumTerm,7-length(st));

   str(NumTer,St);
   st:=setleft(setright(st));
   insert(st,NumTerm,9-length(st));
   NomeTerm:=NumTerm;
end;


Function AssegnaCod:String;

var i,j,k,L,NumTer,Num_A,Num_Z:integer;
    StZona:String;
    Esci,trovato:Boolean;
    nambint,numpiano:integer;

Begin
{writeln(lst,DataDrive+Nomeprog+'.pnt');}
AssegnaCod:='';
if exist(DrivePlt+'work.pnt') then
  begin
  New(TabFtHt);
  assign(fept,Driveplt+'work.pnt');
  reset(fept);
  read(fept,Ept);
  close(Fept);
  i:=1;
  Num_A:=0;
  nambint:=0;
    repeat
      with EpT[i] do
        begin
        Nomepianta:=NomeP;
        ZMax_P:=ZPmax*40000/conf^.AltNum;
        ZMin_P:=ZPmin*40000/conf^.AltNum;
        end;

    {writeln(lst,'Cerca ',CartDrive+NomePianta+'.FHT');}

    if Exist(DriveCart+NomePianta+'.FHT') then
      begin
        {writeln(lst,'trovato fht '+NomePianta);}
        inizio:=True;
        fine:=false;
        repeat
        NumTer:=1;
        Carica(Drivecart+NomePianta+'.FHT',Num_A,Num_Z);
        if Num_A<>0 then
          begin
          for j:=1 To UltRiga Do
          if Dis^[j]^.Entita='L' Then
          if Dis^[j]^.NLinea=0 Then
          if Dis^[j]^.Tronco<>0 Then
          if Dati^[Dis^[j]^.Tronco]^.Pros[1]=0 then
          if Dati^[Dis^[j]^.Tronco]^.Pezzi[1]<>0 then
          if (Dis^[j]^.Z2>=ZMin_P)and(Dis^[j]^.Z2<=ZMax_P) Then
          if TrovaAmb(Dis^[j]^.X2/40*conf^.AltNum/100,Dis^[j]^.Y2/40*conf^.AltNum/100)
          Then
           begin
              {Writeln(lst,' Trovato ',Dati^[Dis^[j].Tronco].Num:3,' Amb:',Num_a:3);}
              str(Num_Z:2,STZona);
              Stzona:=SetLeft(StZona);
              {Writeln(lst,' Cerco ',AriaDrive+NomeProg+'.Z'+StZona);}
              if Exist(DriveAria+NomeProg+'.Z'+StZona) then
                begin
                {writeln(lst,'Trovato '+CartDrive+NomeProg+'.Z'+StZona);}
                assign(Fimp,DriveAria+NomeProg+'.Z'+StZona);
                reset(FImp);
                numpiano:=0;
                trovato:=false;{messieur}
                while (Not(eof(Fimp))) and not trovato  do
                if (nambint=Num_A) and (i=numpiano) then trovato:=true
                else
                BEGIN
                  Read(FImp,RigaImp);
                  nambint:=trunc(rigaimp.amb-i*1000);
                  numpiano:=TRUNC(rigaimp.amb/1000);
                END;
                if (nambint=Num_A)and (i=numpiano)  then
                  begin
                  k:=1;
                  if Dati^[Dis^[j]^.Tronco]^.Ti<>j then
                    begin
                    l:=Dati^[Dis^[j]^.Tronco]^.Ti;
                    while (dis^[l]^.Nlinea<>j)and(dis^[l]^.Nlinea<>0) do
                    l:=Dis^[l]^.NLinea;

                    if Dis^[l]^.NPezzo<>0 then
                    k:=Dis^[l]^.NPezzo+1;
                    end;
                  esci:=false;
                  while Not Esci Do
                    begin
                    if Dati^[Dis^[j]^.Tronco]^.Pezzi[k]<>0 then
                    if VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.Codice<>'' then
                      begin
                      VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.Flag:='*';
                      if RigaImp.B=0 then
                      VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.R:=RigaImp.A_D
                      else
                        begin
                        VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.A:=RigaImp.A_D;
                        VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.B:=RigaImp.B;
                        end;
                      end;
                    if k=Pezzitr then esci:=true
                    else
                      begin
                      if Dati^[Dis^[j]^.Tronco]^.Pezzi[k+1]=0 then esci:=true
                      else k:=k+1;
                      end;
                    if (esci) then
                      begin
                      VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.Port:=RigaImp.Port/3600/RigaImp.NBoc;
                      VPezzi^[Dati^[Dis^[j]^.Tronco]^.Pezzi[k]]^.Perd:=RigaImp.Perd;
                      end;
                    end;
                  end;
                Close(Fimp);
                end;

               NumTer:=NumTer+1;
{              writeln(lst,' terminale',GTerm^[Dis^[j].Tronco].Cod);}
           end;
          end
        else AssegnaCod:='Troppe frontiere su uno stesso ambiente';
        until Fine
      end;
    i:=I+1;
    until (i>MaxEPiante);
  dispose(TabFtHt);
  end;
end;
end.