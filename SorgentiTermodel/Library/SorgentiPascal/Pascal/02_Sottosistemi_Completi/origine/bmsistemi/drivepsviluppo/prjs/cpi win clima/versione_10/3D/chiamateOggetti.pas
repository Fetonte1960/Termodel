unit ChiamateOggetti;

interface
Uses Uoggetti,variabili3d;

Procedure SettaIngr;
Procedure SnapOggetto;
Procedure Parallelepi(Q,x1,y1,dir,lung,spes,alt:real;Colore:Tcolori3d);
Procedure ParallelepiIncl(Incl,Q,x1,y1,dir,lung,spes,alt:real;Colore:Tcolori3d);
Procedure Linea(x1,y1,z1,x2,y2,z2,spes:real;Color:Tcolori3d);
Procedure Parete(Q,upa,upb,x1,y1,x2,y2,spes,alt:real;filo:char;h1,h2:real;colore:Tcolori3d);
Procedure Pavimento(spes,Quota:real;Colore:Tcolori3d;ox,oy,fing,incfalda,orifalda:real);
Procedure DisegnaCanali(Nome:string;colore:Tcolori3d);

implementation
uses u3dsd;
Procedure DisegnaCanali(Nome:string;colore:Tcolori3d);
begin
Disegna_Canali(form1.DcOggetti,Nome,colore);
end;
Procedure Pavimento(spes,Quota:real;Colore:Tcolori3d;ox,oy,fing,incfalda,orifalda:real);
begin
Pavimen_to(form1.DcOggetti,form1.RBscheletro,spes,Quota,Colore,ox,oy,fing,incfalda,orifalda);
end;
Procedure Parete(Q,upa,upb,x1,y1,x2,y2,spes,alt:real;filo:char;h1,h2:real;colore:Tcolori3d);
Begin
Pare_te(form1.DcOggetti,form1.RBscheletro,Q,upa,upb,x1,y1,x2,y2,spes,alt,filo,h1,h2,colore);
end;
Procedure Linea(x1,y1,z1,x2,y2,z2,spes:real;Color:Tcolori3d);
begin
Line_a(form1.DcOggetti,x1,y1,z1,x2,y2,z2,spes,Color);
end;

Procedure Parallelepi(Q,x1,y1,dir,lung,spes,alt:real;Colore:Tcolori3d);
begin
Parallele_pi(form1.DcOggetti,Q,x1,y1,dir,lung,spes,alt,Colore);
end;
Procedure ParallelepiIncl(Incl,Q,x1,y1,dir,lung,spes,alt:real;Colore:Tcolori3d);
begin
Parallele_piIncl(form1.DcOggetti,incl,Q,x1,y1,dir,lung,spes,alt,Colore);
end;
Procedure SnapOggetto;
begin
  Snap_Oggetto(form1.DcOggetti,form1.Dcgenerale);
end;
Procedure SettaIngr;
Var maxass:real;
    ingra:real;
begin
//disegnalimiti;
Form1.DCOggetti.position.Y:=-(Miny+Maxy)/2+(Form1.Trackbar4.position-250)/500*(Miny+Maxy);
Form1.DCOggetti.position.X:=-(Minx+Maxx)/2+(Form1.Trackbar2.position-50)/100*(Minx+Maxx);
Form1.DCOggetti.position.Z:=-(Minz+Maxz)/2+(Form1.Trackbar5.position-50)/100*(Minz+Maxz);

Form1.DCgenerale.ShowAxes:=(form1.cbassi.checked)and (Not (form1.CBdentro.Checked));
if form1.CBdentro.Checked then
  begin
  MaxAss:=5;
  end
else
  begin
  MaxAss:=(Maxx-Minx);
  if (Maxy-Miny)> MaxAss then MaxAss:=(Maxy-Miny);
  if (Maxz-Minz)*2> MaxAss then MaxAss:=(Maxz-Minz)*3;
  end;
ingrbase:=15/Maxass;

//Form1.DCGenerale.Scale.X:=ingrbase;
//Form1.DCGenerale.Scale.y:=ingrbase;
//Form1.DCGenerale.Scale.z:=ingrbase;
trackchange;
//ingra:=(form1.trackbar1.position)/100*2*ingrbase;
//Form1.DCGenerale.Scale.X:=ingra;
//Form1.DCGenerale.Scale.y:=ingra;
//Form1.DCGenerale.Scale.z:=ingra;

end;

end.
