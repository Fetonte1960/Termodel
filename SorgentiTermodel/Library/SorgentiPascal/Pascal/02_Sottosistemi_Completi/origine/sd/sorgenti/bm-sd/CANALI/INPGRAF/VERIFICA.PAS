{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit verifica;

interface

uses definiz,globfunz,angoli,genproc,WM,controll,graph{$ifdef win},def_win{$endif} ;
FUNCTION st_ok(TRout:Stacchi):boolean;

implementation

{----------------------------------------------------------------------------}
{***************************  st_ok     *****************************}


FUNCTION st_ok(TRout:Stacchi):boolean;

var TPN,i,orient:integer;
    Dir,DirZ,Dev,DevZ:array[0..6]of real;
    Usc_Dr,USc_Dr1,ing_vert,Stac_Lat,Vert:Boolean;
    Errore:String;

begin

orient:=1;
vert:=false;
errore  :='';

TPN:=TipoNodo(Trout[0]);
if TPN=2 then st_ok:=true
else
  begin

  Usc_Dr  :=False;
  CalcDirez(TROut[0],Dir[0],DirZ[0]);
  if Ug(abs(DIRz[0]),Pi/2,1) then Dir[0]:=0;

  CalcDirez(TROut[6],Dir[6],DirZ[6]);
  if Ug(abs(DIRz[6]),Pi/2,1) then Dir[6]:=0;
  if (ug(dir[0],dir[6],1))and(ug(dirZ[0],dirZ[6],1)) then
  Usc_Dr:=True;
  CalcAng(TRout[0],TRout[6],Dev[6],DevZ[6],orient,Vert,0);

  Stac_Lat:=False;
  For i:=0 to 5 do
  if TROut[i]<>0 then
    begin
    Usc_Dr1:=False;

    if (i>0)and(TROut[i]>0)and(errore='') then  {- stacchi in uscita -}

      begin
      CalcDirez(TROut[i],Dir[i],DirZ[i]);
      if Ug(abs(DIRz[i]),Pi/2,1) then Dir[i]:=0;
      if (ug(dir[0],dir[i],1))and(ug(dirZ[0],dirZ[i],1)) then
      Usc_Dr1:=true;

      if (ug(dir[6],dir[i],1))and(ug(dirZ[6],dirZ[i],1)) then
      Errore:=W_M(28); {'Due tronchi sovrapposti !'}

      if errore='' then
        begin
        if Ing_Vert then
          begin
          if (not(Usc_Dr))and(not(Usc_Dr1)) Then
            begin
            if (not(Ug(dirZ[6],DirZ[i],1)))or(not(Ug(dir[6],format360(Dir[i]+PI),1)))
            then Errore:=W_M(101);   {'Stacco non simmetrico !'}
            end
          end
        else
          begin
          if (not(Usc_Dr))and(not(Usc_Dr1)) Then
            begin
            CalcAng(TRout[0],TRout[i],Dev[i],DevZ[i],orient,Vert,0);
            if not(Ug(devz[i],0,1)) then
              begin
              if (not(Ug(dir[6],Dir[i],1)))or(not(Ug(devz[6],-Devz[i],1)))
              then Errore:=W_M(101); {'Stacco non simmetrico !'}
              end
            else
              begin
              if not(Ug(dev[6],-Dev[i],1))
              then Errore:=W_M(101); {'Stacco non simmetrico !'}
              end
            end
          end;
        end;

      end

    else

      begin  {- tronco in arrivo -}

      if UG(DirZ[0],0,1) then Ing_Vert:=false
      else
        begin
        Ing_Vert:=true;
        if abs(abs(dirz[0])-Pi/2)>=0.1 then
        errore:=W_M(102); {'Diramazioni vietate su tratti inclinati !'}
        end;

      end

    end;

  end;

st_ok:=true;
if errore<>'' then
  begin
  {$ifdef win}
  Win_er:=errore;
  {$endif}
  {write(chr(7));}
  richiesta(errore);
  ST_ok:=false;
  end

end;


end.