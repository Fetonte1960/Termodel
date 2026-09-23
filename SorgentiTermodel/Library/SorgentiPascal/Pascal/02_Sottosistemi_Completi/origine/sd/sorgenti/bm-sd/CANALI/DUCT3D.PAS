
program read_duct;

{$I deftype.uti }
{$i general.uti }
{$I defacad.uti }
{$I entities.uti }



  CONST
    Version = 402;
    Nlinee = 28;
    NUsc = 3;
    NPezzi = 260;
    NLabel = 100;
  TYPE
    SA1 = STRING [15];
    RecLab = RECORD
               X, Y : REAL;
               DeLab : STRING[20];
             END;
    Scritte = ARRAY[1..NLabel] OF RecLab;

    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : ST8;
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;           { 95 }
    Trig = ARRAY[0..359] OF REAL;
    Uscita = RECORD
               x, y, z, x1, y1, z1 : REAL;
             END;
    PuntiUsc = ARRAY[1..NUsc] OF Uscita;

    linea = RECORD
              Xp, Yp, Xa, Ya, Za, Zp : REAL;
            END;
    Componente = ARRAY[1..Nlinee] OF linea;

    pointer = ^Canale;

    Canale = RECORD
               Graph : Componente;
               Point : PuntiUsc;
               Cod : st5;
               D, A, B : INTEGER;
               CHFlag : STRING[1];
               Lungh : REAL;
               Ang : INTEGER;
               R : REAL;
               Perdita, PORT : REAL;
               Varie : REAL;
               NTab, Phi : INTEGER;
               Ps, Pd, Pc : pointer;
             END;

    Angoli = RECORD
               AngXY, AngXZ, AngYZ : INTEGER;
             END;

  VAR ch : CHAR;
    PhiPrec : INTEGER;
    C : Canale;
    X0Init, Y0Init : REAL;
    XMin, YMin, XMax, YMax : REAL;
    LXMin, LYMin, LXMax, LYMax : REAL;
    Rete : Pointer;
    xacad,yacad :real;
    xacad1,yacad1 : real;
    Rientro, FlagUscita : BOOLEAN;
    Prosp : Angoli;
    Sine, Cosine : Trig;
    Prog : st18;
    ARCHIVIO : ARRAY[1..NPezzi] OF RigaArch; { 4500 }
    DUCT : INTEGER;
    DATA_DRIVE : st80;
    Errore : INTEGER;
    Etic, PORT, Quote : Scritte;
    IndScritte : INTEGER;
    LabAble : BOOLEAN;
    Tf : TEXT; Head : st80;
    Fint : FILE OF INTEGER; PortMcHS : INTEGER;
    DescrPortMcHS : st80;
    XMAX_1,YMAX_1,XMIN_1,YMIN_1 : REAL;
    FF : TEXT;
    SSS1 : SA1;
    pulito : st8;
    start  : integer;

    {$I CHIAVE }

    procedure LoadAlbero;
    var
        f:file of Canale;
        g:file of real;
        RAngXY,RAngXZ,RAngYZ:real;
        Campo,Chiave:integer;
        fp:text;
        j : integer;

        procedure Leggi(Dir:integer;P:Pointer;X0,Y0,Z0:real);
        var P1:Pointer;
        begin
           read(f,P^);

           with p^ do
            begin
               for j := 1 to NLinee do
                with graph [j] do
                 begin

{                    entities_3dline ( (410*(xp+x0))/(xmax_1 - xmin_1) ,
                                      (410*(yp+y0))/(xmax_1 - xmin_1)+(((ymax_1+ymin_1)/2)+143),
                                      (410*(zp+z0))/(xmax_1 - xmin_1),
                                      (410*(xa+x0))/(xmax_1 - xmin_1),
                                      (410*(ya+y0))/(xmax_1 - xmin_1)+(((ymax_1+ymin_1)/2)+143),
                                      (410*(za+z0))/(xmax_1 - xmin_1));
}

(*                     writeln (xp:7:2,yp:7:2,zp:7:2,x0:7:2,y0:7:2,z0:7:2);repeat until keypressed; *)
                     entities_3dline ( xp+x0,yp+y0,zp+z0,xa+x0,ya+y0,za+z0 );

                 end;

            end;

           if P^.Pc <> nil then
           begin
              new(P1);P^.Pc:=P1;
              with P^.Point[1] do
                Leggi(1,P^.Pc,X0+X1,Y0+Y1,Z0+Z1);
           end;
           if P^.Ps <> nil then
           begin
              new(P1);P^.Ps:=P1;
              with P^.Point[2] do
                Leggi(2,P^.Ps,X0+X1,Y0+Y1,Z0+Z1);
           end;
           if P^.Pd <> nil then
           begin
              new(P1);P^.Pd:=P1;
              with P^.Point[3] do
                Leggi(3,P^.Pd,X0+X1,Y0+Y1,Z0+Z1);
           end;
        end;

    begin

       assign(g,DATA_DRIVE+Prog+'.3dG');
       assign(f,DATA_DRIVE+Prog+'.3dH');
       reset(f); reset(g);
       read(g,X0Init,Y0Init,XMin,XMax,YMin,YMax,LXMin,LXMax,LYMin,LYMax);
    
(*   writeln ('x0init = ',x0init:8:2);
       writeln ('y0init = ',y0init:8:2);
       writeln ('xmin = ',xmin:8:2);
       writeln ('xmax = ',xmax:8:2);
       writeln ('ymin = ',ymin:8:2);
       writeln ('ymax = ',ymax:8:2);
       writeln ('lxmin = ',lxmin:8:2);
       writeln ('lxmax = ',lxmax:8:2);
       writeln ('lymin = ',lymin:8:2);
       writeln ('lymax = ',lymax:8:2); repeat until keypressed; *)
       with Prosp do
           begin
                read(g,RAngXY,RAngXZ,RAngYZ);
                AngXY:=round(RAngXY);  AngXZ:=round(RAngXZ);  AngYZ:=round(RAngYZ);
           end;
       close(g);
       new(Rete);
       if not eof(f) then Leggi(1,Rete,0,0,0);
       close(f);
    end;

    procedure scansione;
    var f:file of Canale;
        g:file of real;
        RAngXY,RAngXZ,RAngYZ:real;
        Campo,Chiave:integer;
        fp:text;
        j : integer;

        procedure minmax(Dir:integer;P:Pointer;X0,Y0,Z0:real);
        var P1:Pointer;
        begin
           read(f,P^);

           with p^ do
            begin
               for j := 1 to NLinee do
                with graph [j] do
                 begin

                    if xp+x0 < xmin_1 then xmin_1 := xp+x0;
                    if xa+x0 < xmin_1 then xmin_1 := xa+x0;
                    if xp+x0 > xmax_1 then xmax_1 := xp+x0;
                    if xa+x0 > xmax_1 then xmax_1 := xa+x0;

                    if yp+y0 < ymin_1 then ymin_1 := yp+y0;
                    if ya+y0 < ymin_1 then ymin_1 := ya+y0;
                    if yp+y0 > ymax_1 then ymax_1 := yp+y0;
                    if ya+y0 > ymax_1 then ymax_1 := ya+y0;

                 end;

            end;

           if P^.Pc <> nil then
           begin
              new(P1);P^.Pc:=P1;
              with P^.Point[1] do
                minmax (1,P^.Pc,X0+X1,Y0+Y1,Z0+Z1);
           end;
           if P^.Ps <> nil then
           begin
              new(P1);P^.Ps:=P1;
              with P^.Point[2] do
                minmax(2,P^.Ps,X0+X1,Y0+Y1,Z0+Z1);
           end;
           if P^.Pd <> nil then
           begin
              new(P1);P^.Pd:=P1;
              with P^.Point[3] do
                minmax(3,P^.Pd,X0+X1,Y0+Y1,Z0+Z1);
           end;
        end;

    begin

       assign(g,DATA_DRIVE+Prog+'.3dG');
       assign(f,DATA_DRIVE+Prog+'.3dH');
       reset(f); reset(g);
       read(g,X0Init,Y0Init,XMin,XMax,YMin,YMax,LXMin,LXMax,LYMin,LYMax);
       xacad := lxmax;   xacad1 := x0init;
       yacad := lymax;   yacad1 := y0init;
       with Prosp do
           begin
                read(g,RAngXY,RAngXZ,RAngYZ);
                AngXY:=round(RAngXY);  AngXZ:=round(RAngXZ);  AngYZ:=round(RAngYZ);
           end;
       close(g);
       new(Rete);
       if not eof(f) then minmax(1,Rete,0,0,0);
       close(f);
    end;


begin (* main *)
   DATA_DRIVE := 'C:\daticca\';
   ASSIGN (FF, DATA_DRIVE+'PROG.CAN');
   RESET (FF);
   READLN (FF,PROG);
   CLOSE (FF);
   xmin_1 := 9999999.;
   xmax_1 :=-9999999.;
   ymin_1 := 9999999.;
   ymax_1 :=-9999999.;
   DUCT := 4;
   CONTROLLOCHIAVE (CTRLKEY,DUCT);

   start := POS('\', prog);
   pulito := COPY(prog , start+1, 8);
   scansione;
   assign ( fileinp , 'dxf.std' );
   assign ( filedxf , '\I2644\'+pulito+'.dxf' );
   reset ( fileinp );
   rewrite ( filedxf );
   SSS1 := '';
   while SSS1 <> 'ENTITIES' do
     begin
        readln ( fileinp , SSS1 );

        if SSS1='$LIMMIN' then
           begin
             writeln (filedxf,sss1);
             readln  (fileinp,sss1);
             writeln (filedxf,' 10');
             readln  (fileinp,sss1);
             writeln (filedxf,xacad1:5:1);
             readln  (fileinp,sss1);
             writeln (filedxf,' 20');
             readln  (fileinp,sss1);
             writeln (filedxf,yacad1:5:1);
             readln  (fileinp,sss1);
             writeln (filedxf,'  9');
           end
         ELSE if SSS1='$LIMMAX' then
                begin
                  writeln (filedxf,sss1);
                  readln  (fileinp,sss1);
                  writeln (filedxf,' 10');
                  readln  (fileinp,sss1);
                  writeln (filedxf,xacad:5:1);
                  readln  (fileinp,sss1);
                  writeln (filedxf,' 20');
                  readln  (fileinp,sss1);
                  writeln (filedxf,yacad:5:1);
                  readln  (fileinp,sss1);
                  writeln (filedxf,'  9');
                end
             else writeln ( filedxf , SSS1 );
     end;
   writeln ( filedxf , '  0');
(*   scansione; *)
   writeln;
   loadalbero;
   writeln ( filedxf , 'ENDSEC');
   writeln ( filedxf , '  0');
   writeln ( filedxf , 'EOF');
   close ( fileinp );
   close ( filedxf );
   gotoxy (15,4);
   textcolor (30);
   writeln ('Creato un file ',PULITO,'.DXF nel dir. \I2644 ');
   repeat until keypressed;
end.