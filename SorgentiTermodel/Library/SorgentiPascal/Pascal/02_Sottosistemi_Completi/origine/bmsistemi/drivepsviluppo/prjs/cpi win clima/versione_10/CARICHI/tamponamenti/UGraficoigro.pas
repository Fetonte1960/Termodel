unit UGraficoigro;

interface
uses Db, dbtables, LibreriaGenerale, ExtCtrls, Controls, windows, sysutils, classes;

Procedure GeneraImmagini(Var master,slave,SlaveIM:TTable);
procedure disegnagrafico(Image : TImage; Lf,Hf:integer;Rot, Igro:Boolean;cnv:integer;Var Imrec,Slaverec:Ttable);
Procedure LineaTemp(Image : TImage; x1,y1,x2,y2,sstot:real;Col:integer);
Procedure Lineapres(Image : TImage; x1,y1,x2,y2,sstot:real;Col:integer);
Procedure DisegnaMateriale(Image : TImage);

implementation

uses USolomuri, calcolo, Udb, UDataLink, Wizardusolomuri, UDisegnafinestra, Graphics;

Var Lfin,Hfin:Integer;
    ruotato:boolean;
    qua:Trect;
    SpessoreParete : Double;


Function MX(X,Y:real):Integer;
begin
if ruotato then result:=round(Y*LFin/100)
else
   result:=round(X*LFin/100);

//   result:=10 + round(X* (LFin - 20)/(SpessoreParete + 40));

end;

Function MY(X,Y:real):Integer;
begin
if ruotato then result:=round(X*HFin/100)
else result:=round(Hfin-Y*HFin/100);
end;


procedure quadrato(Image : TImage; XU,YL,XR,YD:real;dis:boolean);
begin
with qua do
  begin
  Left:=MX(XU,YL);
  Top:=MY(XU,YL);
  Right:=MX(XR,YD);
  Bottom:=MY(XR,YD);
  if dis then
    begin
    Image.Canvas.Moveto(left,bottom);
    Image.Canvas.Lineto(right,bottom);
    Image.Canvas.Lineto(right,top);
    Image.Canvas.Lineto(left,top);
    Image.Canvas.Lineto(left,bottom);
    end;
  end;
end;

Procedure Linea(Image : TImage; x1,y1,x2,y2:real);
begin
Image.Canvas.Moveto(mx(x1,y1),my(x1,y1));
Image.Canvas.Lineto(mx(x2,y2),my(x2,y2));
end;

Procedure LineaTemp(Image : TImage; x1,y1,x2,y2,sstot:real;Col:integer);
Var
  CC:Tcolor;
begin

  case col of
     1:cc:=clred;
     2:cc:=clYellow;
  end;
  Image.Canvas.pen.Style:=pssolid;
  Image.Canvas.pen.color:=cc;
  Image.Canvas.pen.Width:=3;
  Linea(Image, 50-sstot/2+x1,10+(Y1+10)*80/35,50-sstot/2+x2,10+(Y2+10)*80/35)
end;

Procedure Lineapres(Image : TImage; x1,y1,x2,y2,sstot:real;Col:integer);
Var
  CC:Tcolor;
begin
  case col of
     1:cc:=clred;
     2:cc:=clLime;
     3:cc:=clBlue;
  end;
  Image.Canvas.pen.Style:=pssolid;
  Image.Canvas.pen.color:=cc;
  Image.Canvas.pen.Width:=3;
  Linea(Image, 50-sstot/2+x1,10+Y1*80/3500,50-sstot/2+x2,10+Y2*80/3500)
end;

Procedure testo(Image : TImage; x1,y1:real;txt:string);
begin
Image.Canvas.TextOut(mx(x1,y1),my(x1,y1),txt);
end;

Procedure testoReal(Image : TImage; x1,y1,Valore:real;Cdec:integer);
Var st:string;
begin
  Str(Valore:2:Cdec,st);
  Testo(Image, x1,y1,st);
end;

Procedure DisegnaMateriale(Image : TImage);
var
  fname:string;
  bitmap:Tbitmap;

begin
Fname:=WizardFSoloMuri.Table2.DatabaseName+'\disegni\'+WizardFSoloMuri.Table2.fields[10].asstring+'.bmp';
if  not fileexists(Fname) then
Fname:=WizardFSoloMuri.Table2.DatabaseName+'\disegni\bianco.bmp';
bitmap:=Tbitmap.Create;
  try
    Bitmap.LoadFromFile(Fname{'MyBitmap.png'});
    image.Canvas.brush.Bitmap:=bitmap;
    if upstring(WizardFSoloMuri.Table2formabmp.AsString)='S'then
    image.Canvas.FillRect(rect(0,0,145,137))
    else
    begin
      image.Canvas.brush.Bitmap:=nil;
      image.Canvas.FillRect(rect(0,0,145,137));
      image.Canvas.stretchDraw(rect(0,0,bitmap.Width,bitmap.Height),bitmap);
    end;
  finally
    image.Canvas.brush.Bitmap:=nil;
    bitmap.Free;
  end;
end;

Procedure DisegnaStrato(Canvas:tcanvas;Fname:string);
var bitmap:Tbitmap;
    Hbmp:integer;
    MyRgn: HRGN ;

begin
with qua do
MyRgn := CreateRectRgn(right,top,left,bottom+2);
SelectClipRgn(Canvas.Handle,MyRgn);

if not fileexists(Fname) then
   //Fname := WizardFSoloMuri.Table2.DatabaseName+'\disegni\bianco.bmp';
   Fname := Percorso_Archivi + '\disegni\bianco.bmp';
bitmap:=Tbitmap.Create;
  try
  Bitmap.LoadFromFile(Fname);
  Canvas.brush.Bitmap:=bitmap;
  with qua do
    begin
    top:=top-3;
    Hbmp:=round((right-left)*bitmap.Height/bitmap.Width);
    end;
  if upstring(V_Recstrati.Stretch)='S'then
  Canvas.fillrect(qua)
  else
  if hbmp<>0 then
  while qua.top>Qua.bottom do
    begin
    Canvas.stretchDraw(rect(Qua.left,Qua.top,Qua.right,Qua.top-hbmp),bitmap);
    qua.top:=qua.top-Hbmp;
    end;
  finally
    Canvas.brush.Bitmap:=nil;
    bitmap.Free;
  end;


DeleteObject(MyRgn);

end;


procedure DisegnaAssi(Image : TImage);
Var
   ScalaX, ScalaY, Valore : Double;
   i : Integer;
begin
exit;
    ScalaY := (Image.Height) / 35;
    ScalaX := (Image.Width) / SpessoreParete;

    i := 30;
    Valore := 3;


    Image.Canvas.TextOut(Round(12 * ScalaX), Image.Height - Round(32 * ScalaY), '[°C]');
    Image.Canvas.TextOut(Image.Width - Round(12 * ScalaX), Image.Height - Round(32 * ScalaY), '[kPa]');
    Image.Canvas.TextOut(Image.Width - Round(12 * ScalaX), Image.Height - Round(3 * ScalaY), '[cm]');

    while i > 0 do
       begin

            Image.Canvas.TextOut(Round(12 * ScalaX), Image.Height - Round(i * ScalaY), IntToStr(i - 10));
            image.Canvas.Pen.Style:=psDot;

            Image.Canvas.MoveTo(Round(15 * ScalaX), Image.Height - Round(i * ScalaY));
            Image.Canvas.LineTo(Image.Width - Round(15 * ScalaX), Image.Height - Round(i * ScalaY));

            Image.Canvas.TextOut(Image.Width - Round(12 * ScalaX), Image.Height - Round(i * ScalaY), Format('%.2f', [Valore]));
            Valore := Valore - 0.5;

            i := i - 5;
       end;


    Image.Canvas.TextOut(Round(20 * ScalaX), Image.Height - Round(2 * ScalaY), 'Li');
    Image.Canvas.TextOut(Image.Width  - 20 - Round(SpessoreParete * ScalaX), Image.Height - Round(2 * ScalaY), 'Le');
end;

procedure disegnagrafico(Image : TImage; Lf,Hf:integer; Rot, Igro:Boolean; cnv:integer; Var Imrec, Slaverec:Ttable);
Var Nomefile:string;
    spes,spestot,fattconv:real;
    bmp:Tbitmap;
    MS: TMemoryStream;
    i:integer;
    ScalaY, Massas : Double;
begin
  SlaveRec.DisableControls;
  Lfin:=Lf;
  Hfin:=Hf;
  ruotato:=rot;
  Fattconv:=1;
  slaverec.First;
  spes:=0;
  while not slaverec.eof do
  begin
     spes := spes + V_Recstrati.Spessore * Fattconv;
     slaverec.Next;
  end;
  spestot:=spes;
  SpessoreParete := spes;
  slaverec.First;
  spes:=0;

  if cnv = 2 then
     image.Canvas.Brush.Color:=clwhite
  else
  begin
   if Igro then
      image.Canvas.Brush.Color:=clwhite
   else
     image.Canvas.Brush.Color:=clBtnFace;
  end;

  Quadrato(Image, 0,0,100,100,false);
  image.Canvas.fillrect(qua);

  if (cnv = 1) or Igro then
  begin
    image.Canvas.Pen.Style:=psSolid;
    image.Canvas.Pen.Color:=clBlack;
    image.Canvas.Pen.Width:=2;
    Linea(Image, 10,10,90,10);
    Linea(Image, 10,10,10,90);
    image.Canvas.Pen.Width:=1;
    Linea(Image, 10,90,90,90);
    Linea(Image, 90,10,90,90);
    image.Canvas.Pen.Style:=psDot;
    for i:=1 to 6 do
    begin
      Linea(Image, 10,i*(80/7)+10,90,i*(80/7)+10);
      Testoreal(Image, 4,i*(80/7)+10+3,-10+i*5,0);
    end;
    Testo(Image, 3,7*(80/7)+10+6,'[°C]');
    for i:=1 to 6 do
      Testoreal(Image, 91,i*(80/7)+10+3,i*0.5,2);
    Testo(Image, 90-2,7*(80/7)+10+6,'[kPa]');
    TestoReal(Image, 50+spestot/2-3,9,spestot,0);
    Testo(Image, 90-3,9,'[cm]');
    Linea(Image, 50-spestot/2-5,10,50-spestot/2-5,90);
    Testo(Image, 50-spestot/2-5-3,9,'Li');
    Linea(Image, 50+spestot/2+5,10,50+spestot/2+5,90);
    Testo(Image, 50+spestot/2+5,9,'Le');     
  end;

  while not slaverec.eof do
  begin
   try
    bmp := TBitmap.Create;
    NomeFile := Percorso_Archivi +'Disegni\'+V_Recstrati.Disegno+'.bmp';
    if V_Recstrati.Disegno<>'' then
      if Fileexists(Nomefile) then
      begin
       bmp.loadfromfile(NomeFile);
       image.Canvas.brush.Bitmap:=bmp;
      end;
    Quadrato(Image, 50-spestot/2+spes,10,50-spestot/2+spes+V_Recstrati.Spessore*Fattconv,90,false);
    if cnv=1 then
      begin
      if Igro then
        image.Canvas.Brush.Color:=clWhite
      else
        image.Canvas.Brush.Color:=clBtnFace;
      TestoReal(Image, 50-spestot/2+spes-3,9,spes,0);
      end;
      DisegnaStrato(image.Canvas,NomeFile);
   finally
    image.Canvas.brush.Bitmap:=Nil;
    bmp.Free;
   end;
    spes:=spes+V_Recstrati.Spessore*Fattconv;
    slaverec.Next;
  end;

  if (cnv=2) then
  begin
    if not Igro then
    begin
      imrec.First;
      if imrec.eof then
      imrec.append;
      imrec.edit;
    end;
    
    MS := TMemoryStream.Create();
    image.Picture.Bitmap.SaveToStream(MS);

    if not Igro then
    begin
      (Imrec.FieldByName('immagine')as Tgraphicfield).Clear;
      (Imrec.FieldByName('immagine')as Tgraphicfield).LoadFromStream(MS);
      Imrec.FieldByName('Descrizione').AsString:=V_TabStruttura.Descr;
      Imrec.FieldByName('Codice').AsString:=V_TabStruttura.Nfile;
      imrec.Post;
    end;
    Ms.free;
  end;

  if (not generaim) and (not Igro) then
  begin
  // 5-08-2004 Emanuela - Verifica igrometrica - forziamo il calcolo x mese Gennaio
  //                      nel caso in cui l'utente ha selezionato mese diverso.
   if wizardFsolomuri <> nil then
   begin
    {$IFDEF VERSIONE_12}
      if wizardFsolomuri.combomese.itemindex+1 <> 1 then
         CALCOLOIGRO(Image, WizardFSoloMuri.dirfile, WizardFSoloMuri.Panel4, 1, true, wizardFsolomuri.LBSB_InfoCond);
    {$ENDIF}
    
     CALCOLOIGRO(Image, WizardFSoloMuri.dirfile, WizardFSoloMuri.Panel4, wizardFsolomuri.combomese.itemindex+1,true, wizardFsolomuri.LBSB_InfoCond);
   end
   else
   begin
      if FSoloMuri <> nil then
         CALCOLOIGRO(Image, Fsolomuri.DirFile, FSoloMuri.panel5, 1, true, nil);
   end;
  end
  else
  if Igro then
     CALCOLOIGRO(Image, '', nil, 1, True, nil);
  SlaveRec.First;
  SlaveRec.EnableControls;
end;

Procedure GeneraImmagini(Var master,slave,SlaveIm:TTable);
Var i:integer;
    Image, ImageIgro : TImage;
begin
     Image := TImage.Create(Nil);
     ImageIgro := TImage.Create(Nil);
     master.Open;
     master.First;
     slaveIM.Open;
     slave.open;

     master.First;
     while not master.Eof do
     begin
          If pareti then
             begin
                 // image.Width := 269;
                 // image.Height := 260;
                 // disegnagrafico(image, 269,260, false,2,slaveim,Slave);
                 image.Width := 245;
                 image.Height := 240;
                 imageIgro.Width := 245;
                 imageIgro.Height := 240;
                 imageIgro.Transparent := False;
                 disegnagrafico(image,  245, 240, False, False, 2, slaveim, Slave);
                 if FileExists(Percorso_progetti + 'DataBase\Immagini_Pareti\' + master.findfield('codice').AsString +'.bmp') then
                    DeleteFile(Percorso_progetti + 'DataBase\Immagini_Pareti\' + master.findfield('codice').AsString +'.bmp');
                 image.Picture.SaveToFile(Percorso_progetti + '\Immagini_Pareti\' + master.findfield('codice').AsString + '.bmp');
                 disegnagrafico(imageIgro, 245, 240, False, True,  2, slaveim, Slave);
                 if FileExists(Percorso_progetti + 'DataBase\Immagini_Igro\' + master.findfield('codice').AsString +'_igro.bmp') then
                    DeleteFile(Percorso_progetti + 'DataBase\Immagini_Igro\' + master.findfield('codice').AsString +'_igro.bmp');
                 ImageIgro.Picture.SaveToFile(Percorso_progetti + '\Immagini_igro\' + master.findfield('codice').AsString + '_igro.bmp');
             end
          else
             begin
                 { image.Width := 440;
                  image.Height := 440;
                  disegnaFinestra(image, 440, 440,true,2,slaveim,Slave);}
                  image.Width := 140;
                  image.Height := 140;
                  disegnaFinestra(image, 140, 140, true, 2, slaveim, Slave);
                  if FileExists(Percorso_progetti + 'DataBase\Immagini_Pareti\' + master.findfield('codice').AsString +'.bmp') then
                     DeleteFile(Percorso_progetti + 'DataBase\Immagini_Pareti\' + master.findfield('codice').AsString +'.bmp');
                  image.Picture.SaveToFile(Percorso_progetti + '\Immagini_Pareti\' + master.findfield('codice').AsString + '.bmp');
             end;

            master.Next;
     end;
     FreeAndNil(Image);
     FreeAndNil(ImageIgro);
end;

end.
