
Functiom CambiaMisure(NomeFile:st18; Cambia:boolean):string[20];
 Var Miscor:integer;
    BEGIN
      if Exist(data_drive+nomefile+'.msc') then
       begin
          ASSIGN(FInt, data_drive+nomefile+'.msc');
          RESET(FInt);
          READ(FInt, miscor);
          CLOSE(FInt);
       end
      else
       begin
          if Cambia then Miscor:=1
          else Miscor:=3600;
       end;
      if Cambia then
       begin
          IF miscor = 1 THEN  miscor := 3600
          ELSE  miscor := 1;
       end;
      ASSIGN(FInt, data_drive+nomefile+'.msc');
      rewrite(FInt);
      WRITE(FInt, miscor);
      CLOSE(FInt);
      GOTOXY(1, 1);  TEXTCOLOR(Col[4]);
      IF (miscor = 1) THEN
         WRITE('                                                       Portate in : mc/sec ')
      ELSE
       IF miscor = 3600 THEN
         WRITE('                                                       Portate in : mc/h   ');
    END;

procedure ProgCorr(NProg,Sotto:st80);

begin
    Sottorete:=sotto;

    nomeprogetto:='   MC4 Software ==> DUCT rev. '+VersTXT;

    if NProg >'' then
      begin
      nomeprogetto:=Nomeprogetto+'  Progetto Nø '+NProg;

      if Sottorete >'' then
      nomeprogetto:=Nomeprogetto+'('+Sottorete+')';
      end;

      nomeprogetto:=Nomeprogetto+CambiaMisure(NProg,false);

    window(1,2,80,24);
    textcolor(col[18]);
    textbackground(col[17]);
    gotoxy(1,1);
    write(nomeprogetto);
    clreol;
end;
