 { ---------- variabili per passaggio da gestDuct a canali.pas ---------- }
   type
      passpartout   = array [1..2] of integer;
    var
      Fit   : passpartout;
      FInt  : file of passpartout;
      dj    : integer;


      Procedure CaricaScelta(var Choise,Inside : integer);
      begin

        if exist ('graf.sce') then
          begin
            Assign(Fint,'calc.sce');  {'\cca'}
            Reset(Fint);
            Read(Fint,Fit);
            Close(Fint);

            Choise := Fit[1];
            Inside := Fit[2];

          end;

      end;
