# Riferimenti Desktop: XML APE e pannelli radianti

Aggiornamento: 21 settembre 2026.

I file elencati sono copie non modificate dei sorgenti Desktop locali. Per ogni
riga il percorso relativo dell'originale coincide con quello sotto
`SorgentiTermodel/Library/`. Le impronte SHA-256 dell'originale e della copia
sono state confrontate e risultano uguali byte per byte.

## XML APE nazionale

| Percorso relativo Desktop e Library | SHA-256 |
|---|---|
| `GestXml.cs` | `906CDE73C919FA90359DAAE0DF0C00A1A088E318E3C2B9130B293AB1E51C0736` |
| `CalcoliXML.cs` | `FDBECD3B2A47E948D09ECA57211F8E62E7BE5FF7C0AA1C0AA19584A1D18C1CCA` |
| `Calcoli/CalcoloAPE.cs` | `D2DDEA012C0936B4C267A09CEA01C05ACEF5CF2E3E17D965BFFC355A5BF3BDBD` |
| `output/Cened.cs` | `8ACF9FA9A0160C271EA773CA3586C1809D04990CC2491E759EA9A91867D79CB6` |

`GestXml.GeneraXml` orchestra archivi, geometria `Polig3D`, conversione JSON,
supporto CENED, calcolo APE e calcolo pannelli. Le dipendenze generali
`Modello.cs`, `leggidxf/Polig3D.cs`, `utilities/Utidb.cs`,
`utilities/GestProg.cs`, `utilities/ErrorManager.cs` e `MainWindow.xaml.cs`
erano già disponibili nella Library.

Dipendenze non headless ancora presenti negli originali: WPF e `MainWindow`,
Xbim/IFC, netDxf, Newtonsoft.Json, ESENT e Windows Forms. `GestXml.cs` contiene
logica e interazione UI non separate; è stato quindi conservato integralmente.
Queste dipendenze dovranno essere isolate soltanto nella futura estrazione nel
Core, non nella Library consultiva.

## Pannelli radianti e spirali

| Percorso relativo Desktop e Library | SHA-256 |
|---|---|
| `PannelliRadianti.cs` | `C4D3340499490C545635C8D4F2C369110B80671452C53D127117E2469708CF41` |
| `Impianti/Pannelli/IoPannelli.cs` | `6A66A5714C54DFB297A3E3BB6B084FEA8281CCC92BF7C8998301E9E10C79FDEB` |
| `Impianti/Pannelli/IoTubi.cs` | `CCD9789CB971BDB41E4A110D243E6C5701F18A2DC7C153AF00A349A2C5705561` |
| `Impianti/Pannelli/CalcoloPannelli.cs` | `89583F4E119DF561F446B8D2F34114D3EDF70BCFE950B2268BF300FC06C73350` |
| `Impianti/Pannelli/SpiraliGPT/ChiudiSpirale.cs` | `F4E10E6D00D3D461676C59A016EB72F31AECD278F4E9D1C444B3637C630E649E` |
| `Impianti/Pannelli/SpiraliGPT/Program.cs` | `77B02412C8700A8A757962FA46399E9353D56CC8933D6304414A2D7E12B3AAC6` |
| `Impianti/Pannelli/SpiraliGPT/SpiralDiagnostics.cs` | `63C8F20FB2751E924C945C11EA0A55774F2AE59ABF3B5B6875A4D0E9A5C5DC4F` |
| `Impianti/Pannelli/SpiraliGPT/Spiralgenerator.cs` | `D3FEAD8A6E7BFF2745927806525C2BB8050BCFC867D098341739959307210DE6` |
| `Impianti/Pannelli/SpiraliGPT/Utilityfunctions.cs` | `D4EBA9CC56953F1C411EC602D676C9F6CD25606B6AB4C329826F4C4A0A5FC509` |
| `Impianti/Pannelli/SpiraliGPT/SpiraliGPT.csproj` | `FBCF148246F8998D804FF9DE843E0F043BFAECC688DB486FD5813F13532E2ED8` |
| `Impianti/Pannelli/SpiraliGPT/README.md` | `F34BFD68A8437428506D7F9C8D29C0FEE311F3D74096C50AF5ABE5BC9502555C` |
| `Impianti/Pannelli/SpiraliGPT/PatternDifettosi/README.md` | `21B8FCC633529B915552D555E2D3C645DF2327CDD4EECC4BF5BA3DE00251CD16` |
| `Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/ChiudiSpirale.cs` | `7EA5DBAF217705BF4AB8269E411497FD5AAE595FD674379C58EF68CB7DCDC02E` |
| `Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Program.cs` | `DF758AE10069D2E0617D01131A4E4821C19A607FFD2282FBE34865C784E367B7` |
| `Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs` | `9EA285924E0028D46044DE734D7A9748D7265648FBCFC062D55830D209769822` |
| `Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Utilityfunctions.cs` | `106C825B93894A8A8E5D060365A441AB33AAFB2CCE1B1684BEB063732142CCF3` |
| `Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralheating.CSPROJ` | `BC7F467A0ECEB289DDB4FEB6EF093F2784D7F9A442C7171028427A3FC183B7E4` |

`CalcoloPannelli.cs` contiene anche DTO e risultati (`DatiProgettoPannelli`,
`RisultatoCalcoloPannelli`, piani, locali, circuiti e segnalazioni) e dipende da
`CalcoliXML`. `IoPannelli` collega entrambi i motori di spirale e `IoTubi`.

Dipendenze esterne rilevate: NetTopologySuite, netDxf, Clipper2 1.4.0,
HelixToolkit.Wpf e tipi WPF 3D. Le funzioni di disegno Helix convivono nello
stesso file della logica XML/DXF e non sono state separate.

Non sono stati copiati output `bin`/`obj`, DLL, immagini PNG, `locale.xml`,
`locale.svg`, il runner ausiliario, `PannelliHeadlessService.cs` dipendente dal
Workbench e `genera_spirali_old.cs`, sorgente storico escluso anche dal progetto
Desktop. Nessuna eccezione alla corrispondenza dei percorsi relativi.

## Stato

- XML APE nazionale: **COMPLETA come riferimento Desktop**, con dipendenze UI e
  librerie esterne esplicitamente documentate.
- Pannelli radianti / spirali: **COMPLETA come riferimento Desktop** per il
  flusso attivo e per entrambi i motori di generazione; esclusi soltanto
  strumenti, dati di esempio, binari e sorgenti storici non compilati.

Questo stato non significa che le funzioni siano implementate o compilabili nel
WebService. La futura estrazione headless resta un'attività separata.
