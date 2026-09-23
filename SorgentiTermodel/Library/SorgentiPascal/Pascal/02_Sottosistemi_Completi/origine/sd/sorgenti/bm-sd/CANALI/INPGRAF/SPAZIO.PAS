{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit Spazio;

INTERFACE

uses definiz,genproc,globfunz,blocco,Wm,load_d,esiste,controll,defuti;

Function Spazio_ins(nome_bl:string):string;

{---------------------------------------------------------------------------}
implementation


Function Spazio_ins(nome_bl:string):string;

Var disegno:cadrec;
    dati   :calcrec;
    pezzi  :^recpezzi;
    F_dat  :file of calcrec;
    F_Dis  :file of cadrec;
    F_pez  :file of recpezzi;
    i      :integer;
    Compatta:Boolean;

Procedure Comprimi;
Var Risp:string;
begin
       repeat
{N}    Risp:=ReadCom('Necessario il salvataggio, conferma ? [s/n]',CH2,0); {*TR*}
{S,N}  Until (risp<>'')and((upcase(Risp[1])=CH1)or(upcase(Risp[1])=CH2));
if upcase(Risp[1])=CH1 then
  begin
  Compatta:=True;
  SaveBl(2);
  LoadDis(DriveProg+NomeProg);;
  end;
end;

begin
Compatta:=false;
Spazio_ins:='';
if exist(Nome_bl+'.ret') then
  begin
  assign(F_dis,Nome_bl+'.ret');
  reset(F_dis);
  i:=0;
  while not eof(F_dis) do
    begin
    read(f_dis,Disegno);
    i:=i+1;
    end;
  close(F_dis);
  if (i>=lungdis-ultriga)and(not Compatta) then Comprimi;
  if i>=lungdis-ultriga then Spazio_ins:='Spazio insufficiente per inserire le linee del blocco' {*TR*}
  else
    begin
      assign(F_dat,Nome_bl+'.dtr');
      reset(F_dat);
      i:=0;
      while not eof(F_dat) do
        begin
        read(f_dat,Dati);
        i:=i+1;
        end;
      close(F_dat);
      if (i>=lungdati-ulttronco)and(not Compatta) then Comprimi;
      if i>=lungdati-ulttronco then Spazio_ins:='Spazio insufficiente per inserire la struttura del blocco' {*TR*}
      else
        begin
          new(Pezzi);
          assign(F_Pez,Nome_bl+'.Pzz');
          reset(F_Pez);
          i:=0;
          while not eof(F_pez) do
            begin
            read(f_pez,Pezzi^);
            i:=i+1;
            end;
          close(F_pez);
          dispose(Pezzi);
          if (i>=lungpezzi-ultpezzo)and(not Compatta) then Comprimi;
          if i>=lungpezzi-ultpezzo then Spazio_ins:='Spazio insufficiente per inserire i pezzi del blocco' {*TR*}
        end
    end;
  end

else Spazio_ins:=W_M(22); { 'Rete non trovata' }

end;

end.