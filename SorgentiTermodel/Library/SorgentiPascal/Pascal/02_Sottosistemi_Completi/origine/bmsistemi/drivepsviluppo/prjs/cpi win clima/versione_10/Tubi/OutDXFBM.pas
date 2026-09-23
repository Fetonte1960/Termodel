unit OutDXFBM;

interface

  uses SysUtils, LibreriaGenerale;

  procedure OutLineaBM(xl1,yl1,xl2,yl2:real; Piano, Layer, colore: String);
  procedure OutArcoBM(xl1,yl1,raggio,angin,angfin:real; Piano, Colore, Layer: String);
  procedure ApriFileOutBM(NomeFile: String);
  procedure ChiudiFileOutBM;
  procedure OutQuotaBM(xl1,yl1,zl1: real; Piano, DN: String);

var
  FGenerato: TextFile;

implementation

  procedure ApriFileOutBM(NomeFile: String);
  begin
    AssignFile(Fgenerato, IncludeTrailingPathDelimiter(percorsodrive) + 'tubirit.txt');
    try
      Rewrite(Fgenerato);
    except
      CloseFile(FGenerato);
    end;
  end;

  procedure ChiudiFileOutBM;
  begin
    CloseFile(FGenerato);
  end;

  procedure OutLineaBM(xl1,yl1,xl2,yl2:real; Piano, Layer, colore: String);
  Var
    Xi, Yi, Xf, Yf: String;
  begin
    if Pos('RITCOLLE', Layer) <> 0 then exit;
    Xi := Format('%1.4f', [xl1]);
    Yi := Format('%1.4f', [yl1]);
    Xf := Format('%1.4f', [xl2]);
    Yf := Format('%1.4f', [yl2]);
    writeln(Fgenerato,'T:' + Piano + ':' + Xi +':'+ Yi +':'+ Xf +':'+ Yf +':'+Colore+':'+Layer+':');
  end;

  procedure OutArcoBM(xl1,yl1,raggio,angin,angfin:real; Piano, Colore, Layer: String);
  Var
    Xi, Yi, rg, ani, anf: String;
  begin
    Xi := Format('%1.4f', [xl1]);
    Yi := Format('%1.4f', [yl1]);
    rg := Format('%1.4f', [raggio]);
    ani := Format('%1.4f', [angin]);
    anf := Format('%1.4f', [angfin]);
    writeln(Fgenerato,'A:' + Piano + ':' + Xi +':'+ Yi +':'+ rg +':'+ ani +':'+anf+':'+colore+':'+Layer+':');
  end;

  procedure OutQuotaBM(xl1,yl1,zl1: real; Piano, DN: String);
  Var
    Xi, Yi, Zi, PianoEff: String;
  begin
    PianoEff := Copy(Piano, 1, Length(Piano) - 6);
    Xi := Format('%1.4f', [xl1]);
    Yi := Format('%1.4f', [yl1]);
    Zi := Format('%1.4f', [zl1]);
    writeln(Fgenerato,'Q:' + PianoEff + ':' + Xi +':'+ Yi +':'+ Zi +':'+ DN +':');
  end;


end.
