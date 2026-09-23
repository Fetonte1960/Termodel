unit UnitCompilaDatiZona;
//1.2
interface

uses
{$Ifdef climacad}
varcarichi,sysutils,Uleggiscrividati;
{$else}
  UDB, dbtables, Uvariabililettura, VarCarichi, sysutils, grafica;
{$Endif}
procedure Copiadatizona(Nz,NP:integer; a_cor: integer);

implementation

procedure Copiadatizona(Nz,NP:integer; a_cor: integer);
var
 CodL: String;
 i: Integer;
 Uguale: Boolean;
 VolumeLoc: Real;
begin
leggi_mem_piani;
 if Zone_D <> nil then
 begin
  if NZ <> 0 then
  begin
    // Emanuela 7/10/2004 inserita la condizione di non modificare l'altezza del locale se essa
    // esiste già, impostata dall'utente
    //  if ambienti_d^[a_cor]^.Hsoffitto = 0 then
    //   ambienti_d^[a_cor]^.Hsoffitto := Zone_d^[nz].HSoffittoRicorr;
    //PJB 050 diego 12-12-2011 per conservaee il dato specificato in grafica
    if ambienti_d^[a_cor]^.Hsoffitto = 0 then
    ambienti_d^[a_cor]^.Hsoffitto := piani_d^[np].AltN;
    //diego 12-12-2011
    VolumeLoc := ambienti_d^[a_cor]^.Hsoffitto * ambienti_d^[a_cor]^.Superficie;
    if ambienti_d^[a_cor]^.codzona = '' then ambienti_d^[a_cor]^.codzona := Zone_d^[nz].Cod;
    if Pos('AGGRE-', UpperCase(ambienti_d^[a_cor]^.Denom)) = 0 then
    begin
        if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
        begin
          if ambienti_d^[a_cor]^.NPersone = 0 then
          begin
            if Zone_d^[nz].AffollPersona <> 0 then
               ambienti_d^[a_cor]^.NPersone := Round(ambienti_d^[a_cor]^.Superficie/Zone_d^[nz].AffollPersona)
            else ambienti_d^[a_cor]^.NPersone := 0;
          end;
        end;
        if CompareStr(UpperCase(Zone_d^[nz].TipoImpianto), UpperCase('Ventilazione naturale o Aerazione')) = 0 then
        begin
           if (CompareStr(UpperCase(Zone_d^[nz].Classif), UpperCase('E1(1)')) = 0) or
              (CompareStr(UpperCase(Zone_d^[nz].Classif), UpperCase('E1(2)')) = 0) or
              (CompareStr(UpperCase(Zone_d^[nz].Classif), UpperCase('E8')) = 0)
           then
           begin
             ambienti_d^[a_cor]^.InfInv  := Zone_d^[nz].InfInv;
             if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
             begin
                ambienti_d^[a_cor]^.InfEst  := Zone_d^[nz].InfInv;
                ambienti_d^[a_cor]^.RicambioPersona := 0;
             end
             else
             begin
               if VolumeLoc <> 0 then
                  ambienti_d^[a_cor]^.InfEst  := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc;
               ambienti_d^[a_cor]^.RicambioPersona := 0;
             end;
            { if VolumeLoc <> 0 then
                ambienti_d^[a_cor]^.RicambioPersona := (Zone_d^[nz].InfInv * VolumeLoc) * 0.277777;  }
           end
           else
           begin
             if VolumeLoc <> 0 then
             begin
               ambienti_d^[a_cor]^.InfInv := Zone_d^[nz].RicAriaNTratVH * ambienti_d^[a_cor]^.NPersone/volumeloc;
             end;
             if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
             begin
               if VolumeLoc <> 0 then
               begin
                 ambienti_d^[a_cor]^.InfEst := Zone_d^[nz].RicAriaNTratVH * ambienti_d^[a_cor]^.NPersone/volumeloc;
               end;
               ambienti_d^[a_cor]^.RicambioPersona := 0;
             end
             else
             begin
               if VolumeLoc <> 0 then
                  ambienti_d^[a_cor]^.InfEst  := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc;
               ambienti_d^[a_cor]^.RicambioPersona := 0;
             end;
           end;
           ambienti_d^[a_cor]^.Ventilazione := 0;
        end
        else
        begin
           if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
           begin
              if Zone_d^[nz].CalcRTA = 'T' then
                 ambienti_d^[a_cor]^.Ventilazione := Zone_d^[nz].VentMecTratt
              else
                 ambienti_d^[a_cor]^.InfEst       := Zone_d^[nz].VentMecTratt;
              ambienti_d^[a_cor]^.RicambioPersona := 0;
              ambienti_d^[a_cor]^.InfInv          := 0;
           end
           else
           begin
             if VolumeLoc <> 0 then
             begin
               if Zone_d^[nz].CalcRTA = 'T' then
                  ambienti_d^[a_cor]^.Ventilazione := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc
               else
                  ambienti_d^[a_cor]^.InfEst       := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc;
             end;
             ambienti_d^[a_cor]^.RicambioPersona := 0;
             ambienti_d^[a_cor]^.InfInv          := 0;
           end;
        end;
      if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
      begin
        if ambienti_d^[a_cor]^.CodPROccupaz      = '' then ambienti_d^[a_cor]^.CodPROccupaz     := Zone_d^[nz].ProfiloOccupaz;
        if ambienti_d^[a_cor]^.SensibilePersona  = 0  then ambienti_d^[a_cor]^.SensibilePersona := Zone_d^[nz].SensibilePersona;
        if ambienti_d^[a_cor]^.LatentePersona    = 0  then ambienti_d^[a_cor]^.LatentePersona   := Zone_d^[nz].LatentePersona;
        if ambienti_d^[a_cor]^.CodPRApparecch    = '' then ambienti_d^[a_cor]^.CodPRApparecch   := Zone_d^[nz].ProfiloApparecch;
        if ambienti_d^[a_cor]^.CodPRIlluminaz    = '' then ambienti_d^[a_cor]^.CodPRIlluminaz   := Zone_d^[nz].ProfiloIlluminaz;
      end;
    end
    else
    begin
      CodL := Copy(UpperCase(ambienti_d^[a_cor]^.Denom), 7, Length(UpperCase(ambienti_d^[a_cor]^.Denom)) - 6);
      i := 1;
      while (i < Nambienti) and (Ambienti_D^[i]^.CodNum <> CodL) do INC(I);
      if (Ambienti_D^[i].CodNum = CodL) then
         Uguale := CompareStr(UpperCase(Ambienti_D^[i]^.Piano), UpperCase(ambienti_d^[a_cor]^.Piano)) = 0;
      if Uguale then
      begin
        if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
        begin
          if ambienti_d^[a_cor]^.NPersone = 0 then
          begin
            if Zone_d^[nz].AffollPersona <> 0 then
               ambienti_d^[a_cor]^.NPersone := Round(ambienti_d^[a_cor]^.Superficie/Zone_d^[nz].AffollPersona)
            else ambienti_d^[a_cor]^.NPersone := 0;
          end;
        end;
        if CompareStr(UpperCase(Zone_d^[nz].TipoImpianto), UpperCase('Ventilazione naturale o Aerazione')) = 0 then
        begin
           if (CompareStr(UpperCase(Zone_d^[nz].Classif), UpperCase('E1(1)')) = 0) or
              (CompareStr(UpperCase(Zone_d^[nz].Classif), UpperCase('E1(2)')) = 0) or
              (CompareStr(UpperCase(Zone_d^[nz].Classif), UpperCase('E8')) = 0)
           then
           begin
             ambienti_d^[a_cor]^.InfInv  := Zone_d^[nz].InfInv;
             if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
             begin
                ambienti_d^[a_cor]^.InfEst  := Zone_d^[nz].InfInv;
                ambienti_d^[a_cor]^.RicambioPersona := 0;
             end
             else
             begin
               if VolumeLoc <> 0 then
                  ambienti_d^[a_cor]^.InfEst  := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc;
               ambienti_d^[a_cor]^.RicambioPersona := 0;
             end;
           end
           else
           begin
             if VolumeLoc <> 0 then
             begin
               ambienti_d^[a_cor]^.InfInv := Zone_d^[nz].RicAriaNTratVH * ambienti_d^[a_cor]^.NPersone/volumeloc;
             end;
             if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
             begin
               if VolumeLoc <> 0 then
               begin
                 ambienti_d^[a_cor]^.InfEst := Zone_d^[nz].RicAriaNTratVH * ambienti_d^[a_cor]^.NPersone/volumeloc;
               end;
               ambienti_d^[a_cor]^.RicambioPersona := 0;
             end
             else
             begin
               if VolumeLoc <> 0 then
                  ambienti_d^[a_cor]^.InfEst  := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc;
               ambienti_d^[a_cor]^.RicambioPersona := 0;
             end;
           end;
           ambienti_d^[a_cor]^.Ventilazione := 0;
        end
        else
        begin
           if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
           begin
              if Zone_d^[nz].CalcRTA = 'T' then
                 ambienti_d^[a_cor]^.Ventilazione := Zone_d^[nz].VentMecTratt
              else
                 ambienti_d^[a_cor]^.InfEst       := Zone_d^[nz].VentMecTratt;
              ambienti_d^[a_cor]^.RicambioPersona := 0;
              ambienti_d^[a_cor]^.InfInv          := 0;
           end
           else
           begin
             if VolumeLoc <> 0 then
             begin
               if Zone_d^[nz].CalcRTA = 'T' then
                  ambienti_d^[a_cor]^.Ventilazione := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc
               else
                  ambienti_d^[a_cor]^.InfEst       := ((ambienti_d^[a_cor]^.RicambioPersona * 3.6) * ambienti_d^[a_cor]^.NPersone) / VolumeLoc;
             end;
             ambienti_d^[a_cor]^.RicambioPersona := 0;
             ambienti_d^[a_cor]^.InfInv          := 0;
           end;
        end;
        if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
        begin
          if ambienti_d^[a_cor]^.CodPROccupaz      = '' then ambienti_d^[a_cor]^.CodPROccupaz     := Zone_d^[nz].ProfiloOccupaz;
          if ambienti_d^[a_cor]^.SensibilePersona  = 0  then ambienti_d^[a_cor]^.SensibilePersona := Zone_d^[nz].SensibilePersona;
          if ambienti_d^[a_cor]^.LatentePersona    = 0  then ambienti_d^[a_cor]^.LatentePersona   := Zone_d^[nz].LatentePersona;
          if ambienti_d^[a_cor]^.CodPRApparecch    = '' then ambienti_d^[a_cor]^.CodPRApparecch   := Zone_d^[nz].ProfiloApparecch;
          if ambienti_d^[a_cor]^.CodPRIlluminaz    = '' then ambienti_d^[a_cor]^.CodPRIlluminaz   := Zone_d^[nz].ProfiloIlluminaz;
        end;
      end
      else
      begin
        ambienti_d^[a_cor]^.NPersone         := 0;
        ambienti_d^[a_cor]^.IlluminazFissa   := 0;
        ambienti_d^[a_cor]^.SensApparecch    := 0;
        ambienti_d^[a_cor]^.LatenteApparecch := 0;
        ambienti_d^[a_cor]^.InfInv           := 0;
        ambienti_d^[a_cor]^.RicambioPersona  := 0;
        ambienti_d^[a_cor]^.CodPROccupaz     := '';
        ambienti_d^[a_cor]^.SensibilePersona := 0;
        ambienti_d^[a_cor]^.LatentePersona   := 0;
        ambienti_d^[a_cor]^.CodPRApparecch   := '';
        ambienti_d^[a_cor]^.CodPRIlluminaz   := '';
        ambienti_d^[a_cor]^.InfEst           := 0;
        ambienti_d^[a_cor]^.Ventilazione     := 0;
      end;
    end;
    ambienti_d^[a_cor]^.RappRS          := 0.45;
    ambienti_d^[a_cor]^.CircolazAria    := 1;
    ambienti_d^[a_cor]^.AmbientiUguali := 1;
    if ambienti_d^[a_cor]^.DatiManEstivo = 0 then
    begin
      ambienti_d^[a_cor]^.IlluminazVar     := Zone_d^[nz].IlluminazVar;
      ambienti_d^[a_cor]^.TipoIlluminaz    := Zone_d^[nz].TipoIlluminaz;
      ambienti_d^[a_cor]^.SensApparecch    := Zone_d^[nz].SensApparecch*ambienti_d^[a_cor]^.Superficie;
      ambienti_d^[a_cor]^.LatenteApparecch := Zone_d^[nz].LatenteApparecch*ambienti_d^[a_cor]^.Superficie;
      ambienti_d^[a_cor]^.TotWattMatElettr := Zone_d^[nz].NumMatElettr * Zone_d^[nz].WattMatElettr;
      ambienti_d^[a_cor]^.TotWattLampDat   := Zone_d^[nz].NumLampDat   * Zone_d^[nz].WattLampDat;
      ambienti_d^[a_cor]^.NumAppElettr  := Zone_d^[nz].NumLampDat;
      ambienti_d^[a_cor]^.NumMacch  := Zone_d^[nz].NumMatElettr;
      ambienti_d^[a_cor]^.IlluminazFissa   := Zone_d^[nz].IlluminazFissa;

      if CompareStr(UpperCase(Zone_d^[nz].DescAppIll), UpperCase('Illum. fluorescente apparecchi non incassati')) = 0 then
         ambienti_d^[a_cor]^.DescAppIll := 1
      else
      if (CompareStr(UpperCase(Zone_d^[nz].DescAppIll), UpperCase('Illum. fluorescente apparecchi incassati')) = 0) or
         (CompareStr(UpperCase(Zone_d^[nz].DescAppIll), UpperCase('Illum. incandescenti apparecchi non incassati')) = 0)
      then
         ambienti_d^[a_cor]^.DescAppIll := 1
      else
      if CompareStr(UpperCase(Zone_d^[nz].DescAppIll), UpperCase('Apparecchi d''illum. incassati nei controsoffitti')) = 0 then
         ambienti_d^[a_cor]^.DescAppIll := 2;
      ambienti_d^[a_cor]^.TipoAppIll := Zone_d^[nz].TipoAppIll;
      ambienti_d^[a_cor]^.PotLamb    := Zone_d^[nz].WattLampDat;
      ambienti_d^[a_cor]^.PotMacch   := Zone_d^[nz].WattMatElettr;
      ambienti_d^[a_cor]^.CoeffSP    := Zone_d^[nz].CoeffSP;
      ambienti_d^[a_cor]^.CoeffSI    := Zone_d^[nz].CoeffSI;
      ambienti_d^[a_cor]^.CoeffSA    := Zone_d^[nz].CoeffSA;
    end
    else
      begin
      if ambienti_d^[a_cor]^.Superficie<>0 then
      ambienti_d^[a_cor]^.IlluminazFissa   :=ambienti_d^[a_cor]^.TotWattLampDat/ambienti_d^[a_cor]^.Superficie;
      end;
  end;
 end;
end;

end.
