unit GestDim;

interface
uses sysutils,Varcarichi,libreriagenerale,Dxf_in_out,angoli;
 type
      VetDimens=record
             descr:string[20];
             Codpezzo,gruppo:integer;
             Entita:string[1];
             Tlinea,Colore:string[20];
             X1,Y1,X2,Y2,Z1,Z2:real;
             R,R2:real;
             end;

 filedimens=record
            nome:string;
            fDimens:file of vetdimens;
            end;
Var F_dim:array[1..Maxpiani] of Filedimens;
    bufdimens:vetdimens;
    Attiva_dimens:boolean=false;

Procedure InitF_dim(Nomedis:string);
Procedure CloseF_dim;
Procedure Linea_Dim(Piano:string;xl1,yl1,xl2,yl2:real;layer,colore,tlinea:string);
Procedure PianoDim(piano:string);
Procedure Dxf_esecutivo(rete,piano:string);
Procedure Arco_Dim(Piano:string;xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
Procedure Cerchio_Dim(Piano:string;xl1,yl1,raggio:real;layer,colore,tlinea:string);
Procedure Testo_Dim(Piano,testo:string;xl1,yl1,angolo:real;layer,colore:string);
Procedure Lineadeb(piano:string;xa,ya,xb,yb:real;ind:integer;colore:string);
Procedure Crocedeb(Piano:string;xx,yy:real);


implementation
Var
Piano_dim:string='';
ind_pianoDim:integer;
Nome_2d:string;

Procedure Centrotesto(var xcc,ycc:real;testo:string);
const Htesto=0.15;
begin
xcc:=xcc-(length(testo)*htesto/2)/2;
ycc:=ycc-htesto/2;
end;


Procedure Lineadeb(piano:string;xa,ya,xb,yb:real;ind:integer;colore:string);
Var dir,dirz,xcc,ycc:real;
begin
if debug_2d then
  begin
  calc_d(xa,ya,0,xb,yb,0,dir,dirz);
  cerchio_Dim(piano,xa,ya,0.02,'ESECUTIVO_RETE',colore,'1');
  cerchio_Dim(piano,xb,yb,0.02,'ESECUTIVO_RETE',colore,'1');
  linea_Dim(piano,xa,ya,xb,yb,'ESECUTIVO_RETE',colore,'1');
  xcc:=0;
  ycc:=0;
  Centrotesto(xcc,ycc,inttostr(ind));
  angoli.ModiCord1(xcc,ycc,0,0,dir,1);
  if ind<>-1 then Testo_Dim(piano,inttostr(ind),(xa+xb)/2+xcc,(ya+yb)/2+ycc,dir,'ESECUTIVO_RETE',colore);
  end;
end;
Procedure Crocedeb(Piano:string;xx,yy:real);
begin
if debug_2d then
  begin
  linea_Dim(piano,xx-0.04,yy-0.04,xx+0.04,yy+0.04,'ESECUTIVO_RETE','1','1');
  linea_Dim(piano,xx-0.04,yy+0.04,xx+0.04,yy-0.04,'ESECUTIVO_RETE','1','1');
  end;
end;


Procedure PianoDim(piano:string);
begin
Piano:=uppercase(piano);
if Piano<>Piano_dim then
  begin
  ind_pianodim:=1;
  while (ind_pianodim<Npiani)and(uppercase(Piani_D^[ind_pianodim].Cod)<>Piano) do inc(ind_pianodim);
  Piano_dim:=uppercase(Piani_D^[ind_pianodim].Cod);
  with F_dim[ind_pianodim] do
    begin
    if nome='' then
      begin
      assign(fdimens,I_sl(percorsodrive)+nome_2d+'_'+Piani_D^[ind_pianodim].Cod+'.ddd');
      Rewrite(fdimens);
      nome:=nome_2d;
      end;
    end;
  end;
end;
Procedure InitF_dim(Nomedis:string);
Var i:integer;
begin
Nome_2d:=nomedis;
Piano_dim:='';
Attiva_dimens:=true;
for i:=1 to MaxPiani do F_dim[i].nome:='';
end;
Procedure CloseF_dim;
Var i:integer;
begin
for i:=1 to MaxPiani do
if  F_dim[i].nome<>'' then close(F_dim[i].fDimens);
Attiva_dimens:=false;
end;
Procedure Linea_Dim(Piano:string;xl1,yl1,xl2,yl2:real;layer,colore,tlinea:string);
begin
PianoDim(piano);
bufdimens.Entita:='L';
bufdimens.x1:=xl1;
bufdimens.y1:=yl1;
bufdimens.z1:=0;
bufdimens.x2:=xl2;
bufdimens.y2:=yl2;
bufdimens.z2:=0;
bufdimens.colore:=colore;
bufdimens.tlinea:=tlinea;
write(F_dim[ind_pianodim].fdimens,bufdimens);
end;
Procedure Arco_Dim(Piano:string;xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);
begin
PianoDim(piano);
bufdimens.Entita:='A';
bufdimens.x1:=xl1;
bufdimens.y1:=yl1;
bufdimens.z1:=0;
bufdimens.x2:=Angin;
bufdimens.y2:=Angfin;
bufdimens.z2:=Raggio;
bufdimens.colore:=colore;
bufdimens.tlinea:=tlinea;
write(F_dim[ind_pianodim].fdimens,bufdimens);
end;
Procedure Cerchio_Dim(Piano:string;xl1,yl1,raggio:real;layer,colore,tlinea:string);
begin
PianoDim(piano);
bufdimens.Entita:='C';
bufdimens.x1:=xl1;
bufdimens.y1:=yl1;
bufdimens.z1:=0;
bufdimens.z2:=Raggio;
bufdimens.colore:=colore;
bufdimens.tlinea:=tlinea;
write(F_dim[ind_pianodim].fdimens,bufdimens);
end;
Procedure Testo_Dim(Piano,testo:string;xl1,yl1,angolo:real;layer,colore:string);
begin
PianoDim(piano);
bufdimens.Entita:='T';
bufdimens.Descr:=testo;
bufdimens.x1:=xl1;
bufdimens.y1:=yl1;
bufdimens.z1:=0;
bufdimens.R:=angolo;
bufdimens.colore:=colore;
write(F_dim[ind_pianodim].fdimens,bufdimens);
end;

Procedure Dxf_esecutivo(rete,piano:string);
var fDimens:file of vetdimens;
begin
if fileexists(I_sl(percorsodrive)+rete+'_'+Piano+'.ddd') then
  begin
  assign(fdimens,I_sl(percorsodrive)+rete+'_'+Piano+'.ddd');
  reset(fdimens);
  while not eof(fdimens) do
    begin
    read(fdimens,bufdimens);
      with bufdimens do
      case entita[1] of
      'L':Add_LineaDxf(x1,y1,z1,x2,y2,z2,'ESECUTIVO_RETE',colore,tlinea);
      'A':Add_ArcoDxf(x1,y1,z1,z2,x2,y2,'ESECUTIVO_RETE',colore,tlinea);
      'C':Add_CerchioDxf(x1,y1,z1,z2,'ESECUTIVO_RETE',colore,tlinea);
      'T':begin
          if (r>0)and(r<=pi/2) then  //giustifica automatica
            begin
            Add_BloccoDxf_col(x1,y1,0,ang_Acad(R),'TESTO','ESECUTIVO_RETE',colore);
            Add_Attrib_Dxf('TESTO',Descr);
            end 
          else
            begin    
            r:=r+PI;
            Add_BloccoDxf_col(x1,y1,0,ang_Acad(R),'TESTOD','ESECUTIVO_RETE',colore);
            Add_Attrib_Dxf('&TESTO',Descr);
            end;
          end;
      end;
    end;
  close(fdimens);
  end;
end;
end.
