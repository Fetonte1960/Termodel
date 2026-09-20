import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { generaPiantaDaSvg } from './genera-pianta.js';
import { generaDxfDaPianta, DXF_EXPORT_INFO } from './export-dxf.js';
import {
  initArchivioWeb,
  isTermodelProjectText,
  loadTermodelProjectText,
  openArchivioWeb,
  getArchivioWebRecords,
  getArchivioWebSchema
} from './archivio-web.js?v=0.52';

const MODEL_URL = './TermodelWebModel.json';
const WEB_SERVICE_BASE_URL = 'http://localhost:5080';
const WEB_SERVICE_CAPABILITIES_URL = `${WEB_SERVICE_BASE_URL}/api/model/capabilities`;
const WEB_SERVICE_NEW_PROJECT_URL = `${WEB_SERVICE_BASE_URL}/api/projects/new`;

const appRoot = document.getElementById('app');
const appTitleText = document.getElementById('appTitleText');
const APP_MAIN_TITLE = 'Termodel 3.2 — Web — GeneraPianta + ArchivioWeb v0.52';
const APP_CAD_TITLE = 'Termodel Cad 2d Versione 0.52';

const viewer = document.getElementById('viewer');
const modelPage = document.getElementById('modelPage');
const cadPage = document.getElementById('cadPage');
const cadCanvas = document.getElementById('cadCanvas');
const cadContextMenu = document.getElementById('cadContextMenu');
const cadRepeatLastCommand = document.getElementById('cadRepeatLastCommand');
const cadCloseSequence = document.getElementById('cadCloseSequence');
const cadCloseOrthogonalSequence = document.getElementById('cadCloseOrthogonalSequence');
const cadStopSequence = document.getElementById('cadStopSequence');
const cadAddBackground = document.getElementById('cadAddBackground');
const cadBackgroundFile = document.getElementById('cadBackgroundFile');
const cadShowBackground = document.getElementById('cadShowBackground');
const cadShowInput = document.getElementById('cadShowInput');
const cadReturnModel = document.getElementById('cadReturnModel');
const cadExportArchitectural = document.getElementById('cadExportArchitectural');
const cadSnap = document.getElementById('cadSnap');
const cadOrtho = document.getElementById('cadOrtho');
const cadUndo = document.getElementById('cadUndo');
const cadRedo = document.getElementById('cadRedo');
const cadDelete = document.getElementById('cadDelete');
const cadRegenerate = document.getElementById('cadRegenerate');
const cadNewLine = document.getElementById('cadNewLine');
const cadInsertAlign = document.getElementById('cadInsertAlign');
const cadInsertOpening = document.getElementById('cadInsertOpening');
const cadInsertBridge = document.getElementById('cadInsertBridge');
const cadInsertRoom = document.getElementById('cadInsertRoom');
const cadNewLineType = document.getElementById('cadNewLineType');
const cadEditStatus = document.getElementById('cadEditStatus');
const cadPropertiesHead = document.getElementById('cadPropertiesHead');
const cadPropertiesEmpty = document.getElementById('cadPropertiesEmpty');
const cadPropertiesBody = document.getElementById('cadPropertiesBody');
const cadPropPiano = document.getElementById('cadPropPiano');
const cadPropTipoParete = document.getElementById('cadPropTipoParete');
const cadPropConfineParete = document.getElementById('cadPropConfineParete');
const cadPropTipoLinea = document.getElementById('cadPropTipoLinea');
const cadPropColore = document.getElementById('cadPropColore');
const cadPropColorSwatch = document.getElementById('cadPropColorSwatch');
const cadPropStart = document.getElementById('cadPropStart');
const cadPropEnd = document.getElementById('cadPropEnd');
const cadPropLength = document.getElementById('cadPropLength');
const cadPropConfirm = document.getElementById('cadPropConfirm');
const cadWallPropertiesSection = document.getElementById('cadWallPropertiesSection');
const cadWallGeometrySection = document.getElementById('cadWallGeometrySection');
const cadBackgroundCalibrationSection = document.getElementById('cadBackgroundCalibrationSection');
const cadCalibrationReference = document.getElementById('cadCalibrationReference');
const cadCalibrationRealMeters = document.getElementById('cadCalibrationRealMeters');
const cadCalibrateBackground = document.getElementById('cadCalibrateBackground');
const cadCalibrationNote = document.getElementById('cadCalibrationNote');
const cadSymbolPropertiesSection = document.getElementById('cadSymbolPropertiesSection');
const cadSymbolSectionTitle = document.getElementById('cadSymbolSectionTitle');
const cadSymbolPosition = document.getElementById('cadSymbolPosition');
const cadSymbolFields = document.getElementById('cadSymbolFields');
const cadSymbolApply = document.getElementById('cadSymbolApply');
const cadOpenPianiArchive = document.getElementById('cadOpenPianiArchive');
const cadOpenParetiArchive = document.getElementById('cadOpenParetiArchive');
const cadOpenConfiniArchive = document.getElementById('cadOpenConfiniArchive');
const cadNorthPropertiesSection = document.getElementById('cadNorthPropertiesSection');
const cadNorthClose = document.getElementById('cadNorthClose');
const cadNorthDefined = document.getElementById('cadNorthDefined');
const cadNorthRange = document.getElementById('cadNorthRange');
const cadNorthAngle = document.getElementById('cadNorthAngle');
const cadNorthNeedle = document.getElementById('cadNorthNeedle');
const cadNorthUnknown = document.getElementById('cadNorthUnknown');
const status = document.querySelector('.viewport-status');
const scene = new THREE.Scene();
scene.background = new THREE.Color(0xd3d3d3);

const camera = new THREE.PerspectiveCamera(38, 1, 0.05, 1000);
const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
renderer.shadowMap.enabled = false;
viewer.appendChild(renderer.domElement);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.dampingFactor = 0.08;
controls.maxPolarAngle = Math.PI * 0.495;

scene.add(new THREE.HemisphereLight(0xffffff, 0x777777, 1.8));
const sun = new THREE.DirectionalLight(0xffffff, 2.0);
sun.position.set(15, 25, 18);
scene.add(sun);

const modelGroup = new THREE.Group();
const edgeGroup = new THREE.Group();
const north3DGroup = new THREE.Group();
scene.add(modelGroup);
scene.add(edgeGroup);
scene.add(north3DGroup);

let floor = null;
let homeView = null;
let loading = false;
let lastModelData = null;
let currentModelLabel = 'PROGETTO ORIGINALE';
let currentModelMode = 'project';
let structuredProjectActive = false;
let webServiceAvailable = false;
let webServiceCapabilities = null;
let lastAiPreviewData = null;
let lastCleanPlanSvg = '';
let lastGeneratedPlan = null;
let northOrientationDeg = null;

// Edita nel CAD v0.10: editor SVG semantico E/W con costruzione, snap
// e pannello proprietà ispirato a Grid_DatiCad/Grid_pareti del desktop.
// La geometria architettonica continua ad essere rigenerata dal motore GeneraPianta.
let cadWorkingDoc = null;
let cadCommittedSvg = '';
let cadSelectedLineId = '';
let cadSelectedSymbolId = '';
let cadUndoStack = [];
let cadRedoStack = [];
let cadDragState = null;
let cadViewportBase = null;
let cadViewport = null;
let cadPanState = null;
let cadCalibrationLineId = '';
let cadToolMode = 'select';
let cadNewLineState = null;
let cadSymbolInsertType = '';
let cadLastRepeatableCommand = '';
let cadToolbarState = {
  piano: '',
  tipoParete: '',
  confineParete: ''
};
let cadCleanPlanByPlane = new Map();
let cadGeneratedPlanByPlane = new Map();
const CAD_SNAP_DISTANCE = 12;
const CAD_JOIN_EPSILON = 0.05;
const CAD_CALIBRATION_ORTHO_EPSILON = 0.05;

const COMPONENTI = [
  ['Parete', true],
  ['Pavimento', true],
  ['Soffitto', true],
  ['Finestra', true],
  ['Ponte', true],
  ['Falda', true],
  ['Mansardato', true],
  ['Pannelli', false]
];

const CONFINI = [
  ['Esterno', true],
  ['Terreno', true],
  ['AmbienteNonClimatizzato', true],
  ['AmbienteClimatizzato', true],
  ['StessaZona', true]
];

const SEPARAZIONE = [
  ['Separatori', true],
  ['NonSeparatori', true],
  ['Fittizie', false]
];

const DEMO_HELP = {
  'Benvenuto': {
    title: 'Termodel — demo interattiva senza installazione',
    body: `
      <p><strong>Esplora liberamente:</strong> questa pagina riproduce l'interfaccia di Termodel e visualizza un vero modello generato dal programma.</p>
      <p>Termodel parte da un disegno schematico CAD, ricostruisce il modello termico 3D, rileva automaticamente molti confini tra ambienti, gestisce locali mansardati e genera ponti termici; il risultato può essere esportato nel formato XML Nazionale.</p>
      <p class="demo-help-note">In questa demo i comandi non modificano il tuo computer e non avviano AutoCAD: cliccandoli scopri cosa fanno nel programma reale.</p>
    `
  },
  'File': {
    title: 'Menu File',
    body: '<p>Raccoglie le operazioni sul progetto: creazione, apertura, trasferimento ZIP, importazione/esportazione XML e uscita verso formati BIM.</p>'
  },
  'Nuovo': {
    title: 'File → Nuovo',
    body: '<p>Crea un nuovo progetto Termodel scegliendo cartella, nome e dati/modelli di partenza. Nel normale flusso, dopo la creazione si prepara o si disegna il DXF del progetto e poi si genera il modello.</p>'
  },
  'Apri...': {
    title: 'File → Apri',
    body: '<p>Apre una cartella che contiene un progetto Termodel esistente, la rende progetto corrente e ne aggiorna dati e modello.</p>'
  },
  'Carica progetto ZIP': {
    title: 'File → Carica progetto ZIP',
    body: '<p>Importa un progetto Termodel impacchettato in ZIP, lo estrae, lo imposta come progetto corrente e lo aggiorna. È utile per trasferire un progetto completo tra computer o utenti.</p>'
  },
  'Salva': {
    title: 'File → Salva',
    body: '<p>Nel programma desktop il disegno CAD viene salvato in DXF tramite il comando della toolbar CAD. Gli archivi alfanumerici del progetto dispongono invece dei propri comandi di salvataggio.</p>'
  },
  'Salva progetto ZIP': {
    title: 'File → Salva progetto ZIP',
    body: '<p>Raccoglie la cartella del progetto corrente in un archivio ZIP, utile per backup, trasferimento o assistenza.</p>'
  },
  'Salva con nome': {
    title: 'File → Salva con nome',
    body: '<p>Copia il progetto corrente in una nuova cartella/nome, imposta la copia come progetto attivo e rigenera il modello.</p>'
  },
  'Importa XML nazionale': {
    title: 'File → Importa XML nazionale',
    body: '<p>Seleziona un XML Nazionale, lo copia come <code>xml/input.xml</code> del progetto e aggiorna i dati Termodel a partire dal file importato.</p>'
  },
  'Esporta XML nazionale': {
    title: 'File → Esporta XML nazionale',
    body: '<p>Produce il file XML Nazionale completo del modello termico. Il file può poi essere importato nei programmi di calcolo energetico compatibili con questo standard.</p>'
  },
  'Esporta BIM (ifc)': {
    title: 'File → Esporta BIM (IFC)',
    body: '<p>Esporta il modello in formato IFC per l\'interscambio BIM e l\'uso del modello geometrico in altri strumenti compatibili.</p>'
  },
  'Modifica': {
    title: 'Menu Modifica',
    body: '<p>Da qui si raggiungono il disegno CAD del progetto e gli archivi tecnici che descrivono pareti, finestre, ponti termici, confini, zone e dati climatici.</p>'
  },
  'Visualizza/Edita disegni di input nel CAD': {
    title: 'Visualizza / Edita disegni di input nel CAD',
    body: '<p>Apre il disegno del progetto in AutoCAD/AutoCAD LT. Termodel rimane aperto: dopo le modifiche si salva il DXF dal CAD e si torna in Termodel con <strong>Aggiorna Modello</strong>.</p>'
  },
  'Archivio dati climatici': {
    title: 'Archivio dati climatici',
    body: '<p>Apre l\'archivio dedicato ai dati climatici utilizzati dal progetto. La pagina “Info Termodel GPT” non descrive i singoli campi di questo archivio.</p>'
  },
  'Archivio Pareti': {
    title: 'Archivio Pareti',
    body: '<p>Gestisce le tipologie di parete e i relativi dati alfanumerici usati nel modello e nell\'XML.</p>'
  },
  'Archivio Finestre': {
    title: 'Archivio Finestre',
    body: '<p>Gestisce le tipologie di finestra associate ai blocchi FIN inseriti sulle pareti del disegno CAD.</p>'
  },
  'Archivio Ponti termici': {
    title: 'Archivio Ponti termici',
    body: '<p>Gestisce i dati dei ponti termici. Termodel può inoltre generarne automaticamente lungo spigoli orizzontali, verticali e contorni delle finestre.</p>'
  },
  'Archivio Confini': {
    title: 'Archivio Confini',
    body: '<p>Gestisce i tipi di confine. Termodel è in grado di rilevare automaticamente confini verticali tra ambienti e orizzontali tra piani.</p>'
  },
  'Archivio Zone': {
    title: 'Archivio Zone',
    body: '<p>Gestisce le zone termiche a cui appartengono i locali del modello.</p>'
  },
  'Visualizza': {
    title: 'Menu Visualizza',
    body: '<p>Permette di passare tra modello, archivi e modalità Plugin CAD, oltre alle opzioni di tutor e generazione automatica.</p>'
  },
  'Modello': {
    title: 'Visualizza → Modello',
    body: '<p>Mostra il modello 3D prodotto da Termodel. La generazione comprende analisi DXF, poligonizzazione, estrusione, allineamento dei piani, orientamento, finestre, ponti termici e analisi dei confini.</p>'
  },
  'Archivi': {
    title: 'Visualizza → Archivi',
    body: '<p>Mostra gli archivi alfanumerici del progetto. Qui si configurano e si salvano le proprietà tecniche usate per completare il modello e l\'XML.</p>'
  },
  'Plugin Autocad': {
    title: 'Visualizza → Plugin AutoCAD',
    body: '<p>Riduce Termodel a una finestra compatta, sempre in primo piano, da affiancare al CAD. Serve per impostare e confermare i parametri prima di inserire Pareti, Finestre, Locali, Ponti termici e altri blocchi tramite la toolbar.</p>'
  },
  'Visualizza tutor': {
    title: 'Visualizza tutor',
    body: '<p>Apre l\'area di supporto/tutor. Le istruzioni ufficiali rimandano anche al canale YouTube di Termodel per guide operative e progetti commentati.</p>'
  },
  'Genera il modello all\'avvio': {
    title: 'Genera il modello all’avvio',
    body: '<p>Abilita la rigenerazione automatica del modello quando viene aperto o aggiornato il progetto.</p>'
  },
  'Calcoli': {
    title: 'Menu Calcoli',
    body: '<p>Raccoglie le funzioni collegate ai risultati di calcolo. La documentazione AI pubblica è concentrata soprattutto sul flusso CAD → modello → XML.</p>'
  },
  'Visualizza risultati dell\'ultimo calcolo': {
    title: 'Risultati dell’ultimo calcolo',
    body: '<p>Richiama i risultati disponibili dell\'ultima elaborazione. In questa demo la sezione è illustrativa e non esegue il motore di calcolo desktop.</p>'
  },
  'Gestione Piani': {
    title: 'Gestione Piani',
    body: '<p>Configura i piani del progetto: ogni piano è associato a un layer CAD e può avere quota, altezza e proprietà specifiche. I blocchi ALLINEA permettono di ricostruire correttamente la posizione dei piani nello spazio.</p>'
  },
  'Crea piano da raster con AI': {
    title: 'Crea piano da raster con AI',
    body: '<p>Comando attivo nella demo: selezioni una pianta, copi le istruzioni Termodel, apri il tuo ChatGPT e alleghi la stessa immagine. Al ritorno puoi incollare il blocco <code>TERMODEL-SVG-TEXT-V1</code>: la demo lo decodifica, valida lo SVG, genera un <strong>TermodelWebModel JSON 3D provvisorio</strong> e lo visualizza nel viewer.</p>'
  },
  'Ritorna al progetto': {
    title: 'Ritorna al progetto',
    body: '<p>Abbandona soltanto la visualizzazione 3D provvisoria costruita dallo SVG AI e ricarica il <code>TermodelWebModel.json</code> originale del progetto. Lo SVG incollato e la pianta selezionata restano disponibili nella finestra AI.</p>'
  },
  'DisegnoInput': {
    title: 'DisegnoInput',
    body: '<p>Seleziona il disegno di input associato al progetto. Il modello Termodel viene costruito interpretando i DXF e i layer configurati nei piani.</p>'
  },
  'Edita nel Cad': {
    title: 'Edita nel CAD — viewer Web',
    body: '<p>Nella demo Web apre il confronto 2D: la <strong>pianta pulita</strong> prodotta da GeneraPianta/JSTS viene mostrata in grigio e il <strong>DisegnoInput.svg</strong> viene sovrapposto con linee colorate e più spesse. Il pulsante <strong>Esporta pianta CAD (.DXF)</strong> scarica la geometria ripulita in DXF AutoCAD 2013, in millimetri.</p>'
  },
  'Visualizza Plugin Cad': {
    title: 'Visualizza Plugin CAD',
    body: '<p>Attiva la modalità Plugin: Termodel diventa compatto e resta visibile accanto ad AutoCAD per configurare i parametri delle entità prima dell\'inserimento.</p>'
  },
  'Aggiorna Modello': {
    title: 'Aggiorna Modello',
    body: `
      <p>È il cuore del flusso Termodel. Dopo aver salvato il DXF, il programma:</p>
      <ol>
        <li>analizza il disegno e poligonizza i locali;</li>
        <li>estrude pareti, pavimenti, soffitti e locali mansardati;</li>
        <li>allinea e orienta i piani;</li>
        <li>genera finestre e ponti termici, compresi quelli automatici;</li>
        <li>analizza i confini tra volumi;</li>
        <li>prepara l\'output XML.</li>
      </ol>
      <p class="demo-help-note">In questa demo il pulsante ricarica il modello Web già esportato, così puoi vedere il risultato senza installare Termodel.</p>
    `
  },
  'Mostra Filtri Grafici': {
    title: 'Mostra Filtri Grafici',
    body: '<p>Mostra o nasconde il pannello di filtraggio del modello. Puoi isolare piani, componenti, confini e separazione tra vani direttamente nel viewer 3D.</p>'
  },
  'Informazioni sul modello': {
    title: 'Informazioni sul modello',
    body: '<p>Raccoglie le informazioni generali sul progetto e sul modello caricato. Nella demo mostra anche il numero di primitive 3D lette dal JSON Termodel.</p>'
  }
};

function installDemoHelpStyles() {
  const style = document.createElement('style');
  style.textContent = `
    .demo-help-panel {
      position: absolute;
      left: 18px;
      top: 42px;
      width: min(420px, calc(100% - 285px));
      max-height: calc(100% - 70px);
      overflow: auto;
      z-index: 20;
      background: rgba(250,250,250,.97);
      border: 1px solid #888;
      box-shadow: 3px 4px 14px rgba(0,0,0,.24);
      padding: 0;
      color: #111;
    }
    .demo-help-panel[hidden] { display: none; }
    .demo-help-head {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 8px;
      padding: 7px 9px;
      background: #e7e7e7;
      border-bottom: 1px solid #aaa;
    }
    .demo-help-head strong { font-size: 13px; }
    .demo-help-close {
      border: 1px solid #999;
      background: #f7f7f7;
      width: 23px;
      height: 22px;
      line-height: 18px;
      padding: 0;
      cursor: pointer;
    }
    .demo-help-body {
      padding: 10px 12px 8px;
      font-size: 12px;
      line-height: 1.42;
    }
    .demo-help-body p { margin: 0 0 8px; }
    .demo-help-body ol { margin: 5px 0 9px 20px; padding: 0; }
    .demo-help-note {
      background: #fff8cf;
      border: 1px solid #d7c46b;
      padding: 6px 7px;
    }
    .demo-help-links {
      padding: 7px 12px 9px;
      border-top: 1px solid #ccc;
      background: #f4f4f4;
      font-size: 11px;
    }
    .demo-help-links a { margin-right: 12px; }
    @media (max-width: 760px) {
      .demo-help-panel {
        left: 8px;
        top: 38px;
        width: calc(100% - 16px);
        max-height: 58%;
      }
    }
  `;
  document.head.appendChild(style);
}

function createDemoHelpPanel() {
  installDemoHelpStyles();
  const panel = document.createElement('section');
  panel.id = 'demoHelpPanel';
  panel.className = 'demo-help-panel';
  panel.innerHTML = `
    <div class="demo-help-head">
      <strong id="demoHelpTitle">Termodel</strong>
      <button class="demo-help-close" id="demoHelpClose" type="button" aria-label="Chiudi">×</button>
    </div>
    <div class="demo-help-body" id="demoHelpBody"></div>
    <div class="demo-help-links">
      <a href="../infotermodelGPT.html" target="_blank" rel="noopener">Info Termodel GPT</a>
      <a href="https://www.youtube.com/@Termodel" target="_blank" rel="noopener">Video tutorial</a>
    </div>
  `;
  document.querySelector('.workspace').appendChild(panel);
  panel.querySelector('#demoHelpClose').addEventListener('click', () => {
    panel.hidden = true;
  });
  return panel;
}

let demoHelpPanel = null;

function showDemoHelp(key) {
  const info = DEMO_HELP[key];
  if (!info) return;
  if (!demoHelpPanel) demoHelpPanel = createDemoHelpPanel();
  document.getElementById('demoHelpTitle').textContent = info.title;
  document.getElementById('demoHelpBody').innerHTML = info.body;
  demoHelpPanel.hidden = false;
}

function helpKeyFromElement(element) {
  if (!element) return '';
  return element.dataset.helpKey || element.textContent.trim();
}

function installFilterStyles() {
  const style = document.createElement('style');
  style.textContent = `
    .web-filter-panel {
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      width: 228px;
      background: #f2f2f2;
      border-left: 1px solid #aaa;
      padding: 7px 8px;
      overflow: auto;
      z-index: 8;
      display: none;
      color: #111;
      font-family: "Segoe UI", Arial, sans-serif;
      font-size: 12px;
    }
    .web-filter-panel.visible { display: block; }
    .web-filter-tree {
      min-height: 100%;
      border: 1px solid #999;
      background: #fafafa;
      padding: 4px 5px 7px;
    }
    .web-filter-tree details { margin: 0; }
    .web-filter-tree summary {
      cursor: default;
      user-select: none;
      padding: 2px 0;
      list-style-position: outside;
    }
    .web-filter-items { padding-left: 23px; }
    .web-filter-row {
      display: flex;
      align-items: center;
      min-height: 18px;
      white-space: nowrap;
    }
    .web-filter-row input { margin: 0 4px 0 0; }
    .web-filter-note {
      margin: 7px 3px 1px;
      padding-top: 6px;
      border-top: 1px solid #ccc;
      color: #666;
      font-size: 11px;
      line-height: 1.25;
    }
  `;
  document.head.appendChild(style);
}

function createFilterPanel() {
  installFilterStyles();

  const panel = document.createElement('aside');
  panel.id = 'webFilterPanel';
  panel.className = 'web-filter-panel';
  panel.innerHTML = `
    <div class="web-filter-tree">
      <details open>
        <summary>Piani</summary>
        <div class="web-filter-items" data-filter-container="piani"></div>
      </details>
      <details open>
        <summary>Componenti</summary>
        <div class="web-filter-items" data-filter-container="componenti"></div>
      </details>
      <details open>
        <summary>Confini</summary>
        <div class="web-filter-items" data-filter-container="confini"></div>
      </details>
      <details open>
        <summary>Separazione tra vani</summary>
        <div class="web-filter-items" data-filter-container="separazione"></div>
      </details>
      <div class="web-filter-note" id="webFilterNote"></div>
    </div>
  `;
  modelPage.appendChild(panel);

  COMPONENTI.forEach(([name, checked]) => addFilterCheckbox('componenti', name, checked));
  CONFINI.forEach(([name, checked]) => addFilterCheckbox('confini', name, checked));
  SEPARAZIONE.forEach(([name, checked]) => addFilterCheckbox('separazione', name, checked));

  return panel;
}

function addFilterCheckbox(group, name, checked) {
  const container = document.querySelector(`[data-filter-container="${group}"]`);
  if (!container) return null;

  const row = document.createElement('label');
  row.className = 'web-filter-row';

  const input = document.createElement('input');
  input.type = 'checkbox';
  input.checked = checked;
  input.dataset.filterGroup = group;
  input.dataset.filterName = name;
  input.addEventListener('change', applyFilters);

  const text = document.createElement('span');
  text.textContent = name;

  row.appendChild(input);
  row.appendChild(text);
  container.appendChild(row);
  return input;
}

const filterPanel = createFilterPanel();

function rebuildPianoFilters(primitives) {
  const container = document.querySelector('[data-filter-container="piani"]');
  if (!container) return;

  const previous = new Map();
  container.querySelectorAll('input[data-filter-name]').forEach((input) => {
    previous.set(input.dataset.filterName, input.checked);
  });

  container.innerHTML = '';

  const piani = [...new Set(
    primitives
      .filter((p) => p.filterMetadata && typeof p.piano === 'string' && p.piano.trim())
      .map((p) => p.piano.trim())
  )];

  if (piani.length === 0) {
    const row = document.createElement('div');
    row.className = 'web-filter-row';
    row.textContent = '—';
    container.appendChild(row);
    return;
  }

  piani.forEach((piano) => {
    addFilterCheckbox('piani', piano, previous.has(piano) ? previous.get(piano) : true);
  });
}

function isChecked(group, name, fallback = true) {
  const input = document.querySelector(
    `input[data-filter-group="${group}"][data-filter-name="${CSS.escape(name)}"]`
  );
  return input ? input.checked : fallback;
}

function primitiveFilterData(primitive) {
  return {
    filterMetadata: primitive.filterMetadata === true,
    piano: primitive.piano || '',
    confine: primitive.confine || '',
    separatore: primitive.separatore === true,
    stessaZona: primitive.stessaZona === true,
    fittizia: primitive.fittizia === true,
    falda: primitive.falda === true,
    tipo: primitive.tipo || ''
  };
}

function passesFilters(meta) {
  // Componenti funziona anche con i vecchi JSON v2, perche' "tipo" esisteva gia'.
  const pannelliMode = isChecked('componenti', 'Pannelli', false);
  if (pannelliMode && meta.tipo !== 'Ponte' && meta.tipo !== 'Pannelli')
    return false;

  if (meta.tipo && meta.tipo !== 'Pannelli' && !isChecked('componenti', meta.tipo, true))
    return false;

  if (!meta.filterMetadata)
    return true;

  // Stesso ordine logico usato dal Redraw desktop di Polig3D.
  if (meta.piano && !isChecked('piani', meta.piano, true))
    return false;

  if (meta.stessaZona && !isChecked('confini', 'StessaZona', true))
    return false;

  // Falde e separatori bypassano il filtro Confine nel desktop.
  if (!meta.falda && !meta.separatore) {
    if (meta.tipo === 'Mansardato') {
      if (!isChecked('confini', 'Esterno', true))
        return false;
    } else if (meta.confine && !isChecked('confini', meta.confine, true)) {
      return false;
    }
  }

  // I ponti bypassano il filtro Separatore/NonSeparatore nel desktop.
  if (meta.tipo !== 'Ponte') {
    if (meta.separatore) {
      if (!isChecked('separazione', 'Separatori', true))
        return false;
    } else if (!isChecked('separazione', 'NonSeparatori', true)) {
      return false;
    }
  }

  if (meta.separatore && meta.fittizia && !isChecked('separazione', 'Fittizie', false))
    return false;

  return true;
}

function applyFilters() {
  let visible = 0;
  let total = 0;

  modelGroup.children.forEach((obj) => {
    const meta = obj.userData.filter || {};
    obj.visible = passesFilters(meta);
    total += 1;
    if (obj.visible) visible += 1;
  });

  edgeGroup.children.forEach((obj) => {
    const meta = obj.userData.filter || {};
    obj.visible = passesFilters(meta);
  });

  if (!loading && lastModelData) {
    const count = lastModelData.primitiveCount ?? lastModelData.primitives.length;
    status.textContent = `${currentModelLabel} · ${count} primitive · visibili ${visible}/${total}`;
  }
}

function updateFilterNote(data) {
  const note = document.getElementById('webFilterNote');
  if (!note) return;

  const hasMetadata = data.primitives.some((p) => p.filterMetadata === true);
  if (hasMetadata) {
    note.textContent = 'Filtri Web applicati localmente alle primitive già caricate.';
  } else {
    note.textContent = 'JSON precedente: Componenti attivo; Piani, Confini e Separazione richiedono un nuovo JSON v3.';
  }
}

function disposeObject(root) {
  root.traverse((obj) => {
    if (obj.geometry) obj.geometry.dispose();
    if (obj.material) {
      const materials = Array.isArray(obj.material) ? obj.material : [obj.material];
      materials.forEach((material) => material.dispose());
    }
  });
  root.clear();
}

function disposeNorth3DMarker() {
  north3DGroup.traverse((obj) => {
    if (obj.geometry) obj.geometry.dispose();
    if (obj.material) {
      const materials = Array.isArray(obj.material) ? obj.material : [obj.material];
      materials.forEach((material) => {
        if (material.map) material.map.dispose();
        material.dispose();
      });
    }
  });
  north3DGroup.clear();
}

function createNorth3DLabel(text, worldScale) {
  const canvas = document.createElement('canvas');
  canvas.width = 256;
  canvas.height = 128;
  const ctx = canvas.getContext('2d');
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  ctx.fillStyle = 'rgba(255,255,255,0.92)';
  ctx.strokeStyle = '#333';
  ctx.lineWidth = 4;
  ctx.fillRect(4, 4, 248, 120);
  ctx.strokeRect(4, 4, 248, 120);
  ctx.fillStyle = '#111';
  ctx.font = 'bold 52px Segoe UI, Arial, sans-serif';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'middle';
  ctx.fillText(text, 128, 64);

  const texture = new THREE.CanvasTexture(canvas);
  texture.needsUpdate = true;
  const material = new THREE.SpriteMaterial({
    map: texture,
    transparent: true,
    depthTest: false
  });
  const sprite = new THREE.Sprite(material);
  sprite.scale.set(worldScale * 1.55, worldScale * 0.78, 1);
  sprite.renderOrder = 50;
  return sprite;
}

function updateNorth3DMarker() {
  disposeNorth3DMarker();

  const box = new THREE.Box3().setFromObject(modelGroup);
  if (box.isEmpty()) return;

  const size = new THREE.Vector3();
  box.getSize(size);
  const modelSize = Math.max(size.x, size.z, 1);
  const markerLength = Math.max(modelSize * 0.18, 1.2);
  const origin = new THREE.Vector3(
    box.max.x + modelSize * 0.05,
    box.min.y + 0.06,
    box.max.z + modelSize * 0.05
  );

  if (northOrientationDeg === null) {
    const label = createNorth3DLabel('N ?', Math.max(modelSize * 0.12, 0.9));
    label.position.copy(origin).add(new THREE.Vector3(0, modelSize * 0.08, 0));
    north3DGroup.add(label);
    return;
  }

  // 0° = alto della pianta. SVG Y cresce verso il basso; nel 3D tale verso
  // corrisponde a +Z. Gli angoli positivi sono orari: 90° -> +X.
  const radians = THREE.MathUtils.degToRad(northOrientationDeg);
  const direction = new THREE.Vector3(
    Math.sin(radians),
    0,
    Math.cos(radians)
  ).normalize();

  const arrow = new THREE.ArrowHelper(
    direction,
    origin,
    markerLength,
    0xc62828,
    markerLength * 0.28,
    markerLength * 0.16
  );
  north3DGroup.add(arrow);

  const label = createNorth3DLabel(
    `N ${Math.round(northOrientationDeg)}°`,
    Math.max(modelSize * 0.10, 0.8)
  );
  label.position.copy(origin)
    .add(direction.clone().multiplyScalar(markerLength * 1.18))
    .add(new THREE.Vector3(0, modelSize * 0.06, 0));
  north3DGroup.add(label);
}

function fromTermodelPoint(vertex) {
  // Termodel/Helix usa Z-up. Three.js usa Y-up.
  return [vertex[0], vertex[2], -vertex[1]];
}

function createMeshPrimitive(primitive) {
  if (!Array.isArray(primitive.vertices) || primitive.vertices.length === 0) return;

  const positions = [];
  primitive.vertices.forEach((vertex) => positions.push(...fromTermodelPoint(vertex)));

  const geometry = new THREE.BufferGeometry();
  geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));

  if (Array.isArray(primitive.indices) && primitive.indices.length >= 3)
    geometry.setIndex(primitive.indices);

  geometry.computeVertexNormals();
  geometry.computeBoundingBox();
  geometry.computeBoundingSphere();

  const opacity = Number.isFinite(primitive.opacity) ? primitive.opacity : 1;
  const material = new THREE.MeshStandardMaterial({
    color: primitive.color || '#A0522D',
    roughness: 0.82,
    metalness: 0,
    side: THREE.DoubleSide,
    transparent: opacity < 1,
    opacity
  });

  const filter = primitiveFilterData(primitive);
  const mesh = new THREE.Mesh(geometry, material);
  mesh.userData = {
    numero: primitive.numero,
    id: primitive.id || '',
    tipo: primitive.tipo || '',
    descrizione: primitive.descrizione || '',
    parte: primitive.parte || '',
    filter
  };
  modelGroup.add(mesh);

  const edgeGeometry = new THREE.EdgesGeometry(geometry, 20);
  const edges = new THREE.LineSegments(
    edgeGeometry,
    new THREE.LineBasicMaterial({ color: 0x00e58a })
  );
  edges.userData = { filter };
  edgeGroup.add(edges);
}

function createLinePrimitive(primitive) {
  if (!Array.isArray(primitive.vertices) || primitive.vertices.length < 2) return;

  const positions = [];
  primitive.vertices.forEach((vertex) => positions.push(...fromTermodelPoint(vertex)));

  const geometry = new THREE.BufferGeometry();
  geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));

  if (Array.isArray(primitive.indices) && primitive.indices.length >= 2)
    geometry.setIndex(primitive.indices);

  const line = new THREE.LineSegments(
    geometry,
    new THREE.LineBasicMaterial({ color: primitive.color || '#00e58a' })
  );
  line.userData = { filter: primitiveFilterData(primitive) };
  modelGroup.add(line);
}

function updateFloor(box) {
  if (floor) {
    scene.remove(floor);
    floor.geometry.dispose();
    floor.material.dispose();
  }

  const size = new THREE.Vector3();
  box.getSize(size);
  const floorSize = Math.max(size.x, size.z, 10) * 2.2;

  floor = new THREE.Mesh(
    new THREE.PlaneGeometry(floorSize, floorSize),
    new THREE.MeshStandardMaterial({ color: 0xd3d3d3, roughness: 1 })
  );
  floor.rotation.x = -Math.PI / 2;
  floor.position.y = box.min.y - 0.03;
  scene.add(floor);
}

function fitView() {
  const box = new THREE.Box3().setFromObject(modelGroup);
  if (box.isEmpty()) return;

  const center = new THREE.Vector3();
  const size = new THREE.Vector3();
  box.getCenter(center);
  box.getSize(size);

  const maxSize = Math.max(size.x, size.y, size.z, 1);
  const fov = THREE.MathUtils.degToRad(camera.fov);
  const distance = (maxSize / (2 * Math.tan(fov / 2))) * 1.35;
  const direction = new THREE.Vector3(1.2, 0.82, 1.25).normalize();
  const position = center.clone().add(direction.multiplyScalar(distance));

  camera.near = Math.max(0.01, distance / 1000);
  camera.far = Math.max(1000, distance * 50);
  camera.position.copy(position);
  camera.updateProjectionMatrix();

  controls.target.copy(center);
  controls.minDistance = Math.max(maxSize * 0.04, 0.3);
  controls.maxDistance = Math.max(maxSize * 12, 30);
  controls.update();

  homeView = { position: position.clone(), target: center.clone() };
  updateFloor(box);
}

function resetView() {
  if (!homeView) return;
  camera.position.copy(homeView.position);
  controls.target.copy(homeView.target);
  controls.update();
}

function setReturnProjectState(enabled) {
  const button = document.getElementById('returnProject');
  if (button) button.disabled = !enabled;
}

function setStructuredProjectState(enabled) {
  structuredProjectActive = Boolean(enabled);
  const needsProject = !structuredProjectActive;
  const inviteTitle = 'Crea o importa il tuo progetto Termodel per usare questa funzione.';

  document.querySelectorAll('[data-archive]').forEach(button => {
    button.disabled = false;
    button.title = needsProject ? inviteTitle : '';
    button.setAttribute('aria-disabled', needsProject ? 'true' : 'false');
  });

  const cadButton = document.querySelector('[data-action="Edita nel Cad"]');
  if (cadButton) {
    cadButton.disabled = false;
    cadButton.title = needsProject ? inviteTitle : '';
    cadButton.setAttribute('aria-disabled', needsProject ? 'true' : 'false');
  }
}

function webServiceCanCreateProject() {
  return webServiceAvailable && webServiceCapabilities?.newProjectAvailable === true;
}

async function refreshWebServiceCapabilities() {
  try {
    const response = await fetch(WEB_SERVICE_CAPABILITIES_URL, { cache: 'no-store' });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);

    webServiceCapabilities = await response.json();
    webServiceAvailable = true;
    console.info('Termodel WebService disponibile:', webServiceCapabilities);
    return webServiceCapabilities;
  } catch (error) {
    webServiceCapabilities = null;
    webServiceAvailable = false;
    console.warn('Termodel WebService non disponibile:', error.message);
    return null;
  }
}

function extractProjectTextFromServerResponse(rawText) {
  const raw = String(rawText ?? '').trim();
  if (isTermodelProjectText(raw)) return raw;

  let json;
  try {
    json = JSON.parse(raw);
  } catch (_) {
    throw new Error('La risposta del WebService non contiene TERMODEL-PROJECT-TEXT-V1.');
  }

  const queue = [json];
  const visited = new Set();

  while (queue.length) {
    const value = queue.shift();

    if (typeof value === 'string' && isTermodelProjectText(value))
      return value;

    if (!value || typeof value !== 'object' || visited.has(value))
      continue;

    visited.add(value);

    if (Array.isArray(value))
      queue.push(...value);
    else
      queue.push(...Object.values(value));
  }

  throw new Error('La risposta JSON del WebService non contiene TERMODEL-PROJECT-TEXT-V1.');
}

function replaceProjectTextSection(projectText, sectionName, sectionText) {
  const begin = `---BEGIN:${sectionName}---`;
  const end = `---END:${sectionName}---`;
  const beginIndex = projectText.indexOf(begin);

  if (beginIndex < 0)
    throw new Error(`Il progetto server non contiene la sezione ${sectionName}.`);

  const bodyStart = beginIndex + begin.length;
  const endIndex = projectText.indexOf(end, bodyStart);

  if (endIndex < 0)
    throw new Error(`La sezione ${sectionName} del progetto server non è chiusa.`);

  return (
    projectText.slice(0, bodyStart) +
    '\n' + String(sectionText ?? '').trim() + '\n' +
    projectText.slice(endIndex)
  );
}

async function createStructuredProjectFromSvg(svgText) {
  if (!webServiceCanCreateProject())
    await refreshWebServiceCapabilities();

  if (!webServiceCanCreateProject())
    throw new Error('NuovoProgetto non è disponibile nel WebService.');

  const response = await fetch(WEB_SERVICE_NEW_PROJECT_URL, {
    method: 'POST',
    headers: {
      'Accept': 'text/plain, application/json',
      'Content-Type': 'application/json'
    },
    // Richiesta minima di progetto vuoto: nessun campo backend inventato.
    body: '{}'
  });

  const rawResponse = await response.text();

  if (!response.ok) {
    const detail = rawResponse.trim().slice(0, 600);
    throw new Error(
      `NuovoProgetto HTTP ${response.status}` +
      (detail ? `: ${detail}` : '')
    );
  }

  const emptyProjectText = extractProjectTextFromServerResponse(rawResponse);
  const projectSvgText = ensureNorthSymbolInSvgText(svgText);
  const structuredProjectText = replaceProjectTextSection(
    emptyProjectText,
    'geometry/project.svg',
    projectSvgText
  );

  const project = await loadTermodelProjectText(structuredProjectText);
  setStructuredProjectState(true);
  return project;
}

function renderModelData(data, options = {}) {
  if (data.format !== 'TermodelWebModel' || !Array.isArray(data.primitives))
    throw new Error('Formato TermodelWebModel non valido');

  currentModelMode = options.mode || 'project';
  currentModelLabel = options.label || 'Termodel Web Model';
  lastModelData = data;

  disposeObject(modelGroup);
  disposeObject(edgeGroup);
  rebuildPianoFilters(data.primitives);
  updateFilterNote(data);

  data.primitives.forEach((primitive) => {
    if (primitive.kind === 'mesh')
      createMeshPrimitive(primitive);
    else if (primitive.kind === 'lineSegments')
      createLinePrimitive(primitive);
  });

  fitView();
  updateNorth3DMarker();
  edgeGroup.visible = true;
  applyFilters();
  setReturnProjectState(currentModelMode === 'ai');

  const objectInfo = document.querySelector('#infoPage .classic-row:nth-child(3) strong');
  if (objectInfo) {
    if (currentModelMode === 'ai') {
      const h = data.previewAssumptions?.wallHeightMeters;
      const t = data.previewAssumptions?.wallThicknessMeters;
      const counts = data.previewCounts;
      objectInfo.textContent =
        `${data.primitiveCount ?? data.primitives.length} primitive da SVG AI · anteprima provvisoria` +
        (counts ? ` · ${counts.walls} pareti · ${counts.floors} pavimenti · ${counts.ceilings} soffitti` : '') +
        (Number.isFinite(h) && Number.isFinite(t) ? ` · h ${h.toFixed(2)} m · sp. pareti ${t.toFixed(2)} m` : '');
    } else {
      objectInfo.textContent = `${data.primitiveCount ?? data.primitives.length} primitive dal JSON Termodel`;
    }
  }
}

async function loadModel() {
  if (loading) return;
  loading = true;
  status.textContent = 'Caricamento TermodelWebModel.json...';

  try {
    const response = await fetch(`${MODEL_URL}?t=${Date.now()}`, { cache: 'no-store' });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);

    const data = await response.json();
    northOrientationDeg = null;
    cadUpdateNorthControls();
    renderModelData(data, {
      mode: 'project',
      label: 'PROGETTO ORIGINALE'
    });
    setStructuredProjectState(false);
  } catch (error) {
    console.error(error);
    status.textContent = `Errore caricamento modello: ${error.message}`;
  } finally {
    loading = false;
  }
}

function resize() {
  const w = Math.max(1, viewer.clientWidth);
  const h = Math.max(1, viewer.clientHeight);
  camera.aspect = w / h;
  camera.updateProjectionMatrix();
  renderer.setSize(w, h, false);
}

const ro = new ResizeObserver(resize);
ro.observe(viewer);
window.addEventListener('resize', resize);

document.getElementById('resetView').addEventListener('click', async () => {
  showDemoHelp('Aggiorna Modello');
  await loadModel();
  resetView();
});

const returnProjectButton = document.getElementById('returnProject');
if (returnProjectButton) {
  returnProjectButton.addEventListener('click', async () => {
    showDemoHelp('Ritorna al progetto');
    await loadModel();
    resetView();
  });
}

const filtersCheck = document.getElementById('filtersCheck');
const viewCube = document.querySelector('.view-cube');

function setFilterPanelVisibility(visible) {
  filterPanel.classList.toggle('visible', visible);
  viewer.style.right = visible ? '228px' : '0';
  if (viewCube) viewCube.style.right = visible ? '248px' : '20px';
  requestAnimationFrame(resize);
}

filtersCheck.addEventListener('change', (event) => {
  setFilterPanelVisibility(event.target.checked);
  showDemoHelp('Mostra Filtri Grafici');
});

// Come nel desktop: all'avvio il check e il pannello Filtri Grafici sono visibili.
setFilterPanelVisibility(filtersCheck.checked);

document.querySelectorAll('.tab').forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
    tab.classList.add('active');
    document.getElementById(tab.dataset.page).classList.add('active');
    showDemoHelp(helpKeyFromElement(tab));
    if (tab.dataset.page === 'modelPage') requestAnimationFrame(resize);
  });
});

const cadToolMenus = Array.from(document.querySelectorAll('.cad-tool-menu'));

function cadCloseToolMenus(except = null) {
  cadToolMenus.forEach(menu => {
    if (menu !== except) menu.open = false;
  });
}

cadToolMenus.forEach(menu => {
  menu.addEventListener('toggle', () => {
    if (menu.open) cadCloseToolMenus(menu);
  });
});

document.querySelectorAll('.cad-tool-dropdown button').forEach(button => {
  button.addEventListener('click', () => {
    button.closest('.cad-tool-menu')?.removeAttribute('open');
  });
});

document.addEventListener('pointerdown', event => {
  if (!event.target.closest('.cad-tool-menu')) cadCloseToolMenus();
});

document.querySelectorAll('.menu > button').forEach(button => {
  button.addEventListener('click', (event) => {
    event.stopPropagation();
    const menu = button.parentElement;
    document.querySelectorAll('.menu').forEach(m => {
      if (m !== menu) m.classList.remove('open');
    });
    menu.classList.toggle('open');
    showDemoHelp(helpKeyFromElement(button));
  });
});

document.querySelectorAll('.dropdown button').forEach(button => {
  button.addEventListener('click', (event) => {
    event.stopPropagation();
    if (!button.dataset.archive)
      showDemoHelp(helpKeyFromElement(button));
    button.closest('.menu')?.classList.remove('open');
  });
});

document.addEventListener('click', () => {
  document.querySelectorAll('.menu').forEach(m => m.classList.remove('open'));
});

document.querySelectorAll('[data-archive]').forEach(button => {
  button.addEventListener('click', async (event) => {
    event.preventDefault();
    event.stopPropagation();
    if (demoHelpPanel) demoHelpPanel.hidden = true;

    if (!structuredProjectActive) {
      openProjectStartDialog({
        target: 'archive',
        archiveName: button.dataset.archive || 'Piani'
      });
      return;
    }

    try {
      await openArchivioWeb(button.dataset.archive || 'Piani');
    } catch (error) {
      window.alert('Archivio Termodel non disponibile: ' + error.message);
    }

    button.closest('.menu')?.classList.remove('open');
  });
});


const TERMODEL_GENERAL_PROMPT_URL = './TermodelGenerale.md';
const RASTER_PROMPT_URL = './CreaPianoTermodelDaRaster.md';
const TERMODEL_AI_INDEX_URL = 'https://www.termodel.it/termodel-ui-demo/IndiceAI.html?v=0.21';

const instructAiButton = document.getElementById('instructAiButton');
const importAiButton = document.getElementById('importAiButton');
const aiInstructModal = document.getElementById('aiInstructModal');
const aiInstructClose = document.getElementById('aiInstructClose');
const aiInstructCloseBottom = document.getElementById('aiInstructCloseBottom');

const projectStartModal = document.getElementById('projectStartModal');
const projectStartMessage = document.getElementById('projectStartMessage');
const projectStartClose = document.getElementById('projectStartClose');
const projectStartCloseBottom = document.getElementById('projectStartCloseBottom');
const projectStartBlank = document.getElementById('projectStartBlank');
const projectStartInstructAi = document.getElementById('projectStartInstructAi');
const projectStartImportAi = document.getElementById('projectStartImportAi');
const newProjectButton = document.getElementById('newProjectButton');
let projectStartContext = { target: 'cad', archiveName: '' };

const TERMODEL_AI_BOOTSTRAP = `Lavora con Termodel Web.
Apri e segui le istruzioni aggiornate pubblicate qui:
${TERMODEL_AI_INDEX_URL}`;

function setMainAiStatus(message) {
  if (status) status.textContent = message;
}

function openAiInstructDialog() {
  if (!aiInstructModal) return;
  aiInstructModal.classList.add('visible');
  aiInstructModal.setAttribute('aria-hidden', 'false');
}

function closeAiInstructDialog() {
  if (!aiInstructModal) return;
  aiInstructModal.classList.remove('visible');
  aiInstructModal.setAttribute('aria-hidden', 'true');
}

function openProjectStartDialog(context = {}) {
  projectStartContext = {
    target: context.target || 'cad',
    archiveName: context.archiveName || ''
  };

  if (projectStartMessage) {
    projectStartMessage.textContent =
      projectStartContext.target === 'archive'
        ? `Il modello iniziale è una demo. Per aprire l'archivio "${projectStartContext.archiveName}" crea o importa prima il tuo progetto Termodel.`
        : 'Il modello iniziale è una demo. Scegli come vuoi iniziare il tuo progetto Termodel.';
  }

  if (!projectStartModal) return;
  projectStartModal.classList.add('visible');
  projectStartModal.setAttribute('aria-hidden', 'false');
}

function closeProjectStartDialog() {
  if (!projectStartModal) return;
  projectStartModal.classList.remove('visible');
  projectStartModal.setAttribute('aria-hidden', 'true');
}

function createBlankProjectSvg() {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800" width="1200" height="800">
  <g id="calpestabile"></g>
  <g id="copertura"></g>
</svg>`;
}

function createBlankCleanSvg() {
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 800" width="1200" height="800">
  <g id="locali-puliti"></g>
  <g id="pareti-architettoniche"></g>
  <g id="contorni-architettonici"></g>
  <g id="etichette-locali"></g>
</svg>`;
}

async function continueAfterProjectStart() {
  const context = projectStartContext;
  if (context.target === 'archive' && context.archiveName) {
    try {
      await openArchivioWeb(context.archiveName);
    } catch (error) {
      window.alert('Archivio Termodel non disponibile: ' + error.message);
    }
    return;
  }

  activateCadPage();
}

async function startBlankProjectFromCad() {
  closeProjectStartDialog();
  setMainAiStatus('Creazione progetto Termodel vuoto...');

  try {
    const svg = createBlankProjectSvg();
    const project = await createStructuredProjectFromSvg(svg);

    validatedSvg = svg;
    lastCleanPlanSvg = createBlankCleanSvg();
    lastGeneratedPlan = null;
    lastAiPreviewData = null;
    cadSetWorkingSvg(svg);
    validatedSvg = cadSerializeWorkingSvg();
    rasterSvgText.value = validatedSvg;

    setStructuredProjectState(true);
    setMainAiStatus(`✓ Progetto vuoto creato: ${project.projectName} · archivi e CAD attivi`);

    projectStartContext = { target: 'cad', archiveName: '' };
    activateCadPage();
    cadSetStatus('Progetto vuoto · usa ＋ Nuova parete per iniziare il disegno');
  } catch (error) {
    setStructuredProjectState(false);
    console.error('Creazione progetto vuoto non riuscita:', error);
    setMainAiStatus(`⚠ Progetto vuoto non creato: ${error.message}`);
    window.alert('Impossibile creare il progetto Termodel vuoto.\n\n' + error.message);
  }
}

async function instructAiFromMainForm(event) {
  event?.preventDefault();
  event?.stopPropagation();
  if (demoHelpPanel) demoHelpPanel.hidden = true;

  try {
    if (!navigator.clipboard?.writeText)
      throw new Error('Clipboard non disponibile');
    await navigator.clipboard.writeText(TERMODEL_AI_BOOTSTRAP);
    setMainAiStatus('✓ Istruzioni AI copiate negli appunti');
    openAiInstructDialog();
  } catch (_) {
    window.alert('Impossibile copiare le istruzioni AI negli appunti.');
  }
}

async function importAiFromMainForm(event) {
  event?.preventDefault();
  event?.stopPropagation();
  if (demoHelpPanel) demoHelpPanel.hidden = true;

  let text = '';
  try {
    if (!navigator.clipboard?.readText)
      throw new Error('Clipboard non disponibile');
    text = await navigator.clipboard.readText();
  } catch (_) {
    window.alert("Nella clipboard non c'è un progetto MyHome3D.");
    return;
  }

  if (!text.trim()) {
    window.alert("Nella clipboard non c'è un progetto MyHome3D.");
    return;
  }

  let imported = false;

  if (isTermodelProjectText(text)) {
    try {
      const project = await loadTermodelProjectText(text);
      imported = true;

      // Il file progetto completo è già sufficiente per compilare ArchivioWeb.
      // Se contiene anche geometry/project.svg proviamo ad aggiornare il viewer,
      // senza invalidare l'importazione degli archivi se la geometria richiede
      // ancora funzioni server non disponibili nel prototipo JS.
      if (project.geometrySvg) {
        const geometryImported = processSvgText(project.geometrySvg);
        if (!geometryImported)
          console.warn('Progetto completo importato; geometry/project.svg non elaborato dal viewer Web corrente.');
      }

      setStructuredProjectState(true);
      setMainAiStatus(`✓ Progetto completo importato: ${project.projectName} · editing attivo`);
    } catch (error) {
      window.alert('Progetto Termodel non importato: ' + error.message);
      return;
    }
  } else {
    const hadStructuredProject = structuredProjectActive;
    imported = processSvgText(text);

    if (imported) {
      if (hadStructuredProject) {
        setStructuredProjectState(true);
        setMainAiStatus('✓ Pianta SVG aggiornata nel progetto strutturato esistente · editing attivo');
      } else if (webServiceCanCreateProject()) {
        setMainAiStatus('Pianta SVG importata · creazione progetto Termodel strutturato...');

        try {
          const project = await createStructuredProjectFromSvg(validatedSvg);

          // Il primo processSvgText() avviene prima della creazione del progetto:
          // in quel momento l'archivio Piani può non essere ancora disponibile.
          // Ora che il progetto strutturato e Piani sono caricati, rileggiamo lo
          // stesso SVG nel CAD per assegnare le entità legacy al piano corrente.
          cadSetWorkingSvg(validatedSvg);
          validatedSvg = cadSerializeWorkingSvg();
          rasterSvgText.value = validatedSvg;

          setMainAiStatus(
            `✓ Progetto strutturato creato: ${project.projectName} · geometria assegnata al piano ${cadCurrentPlane()} · archivi e CAD attivi`
          );
        } catch (error) {
          setStructuredProjectState(false);
          console.error('Creazione progetto strutturato non riuscita:', error);
          setMainAiStatus(`⚠ Pianta importata ma progetto strutturato non creato: ${error.message}`);
          window.alert(
            'Pianta AI importata, ma il WebService non ha creato il progetto strutturato.\n\n' +
            error.message
          );
        }
      } else {
        setStructuredProjectState(false);
        setMainAiStatus('✓ Pianta SVG importata dall\'AI · WebService non disponibile o NuovoProgetto non dichiarato');
      }
    }
  }

  if (!imported) {
    window.alert("Nella clipboard non c'è un progetto MyHome3D.");
    return;
  }

  activateModelPage();
  requestAnimationFrame(resize);
}

if (instructAiButton)
  instructAiButton.addEventListener('click', instructAiFromMainForm);
if (importAiButton)
  importAiButton.addEventListener('click', importAiFromMainForm);
if (aiInstructClose)
  aiInstructClose.addEventListener('click', closeAiInstructDialog);
if (aiInstructCloseBottom)
  aiInstructCloseBottom.addEventListener('click', closeAiInstructDialog);
if (aiInstructModal)
  aiInstructModal.addEventListener('click', (event) => {
    if (event.target === aiInstructModal) closeAiInstructDialog();
  });

const rasterAiModal = document.getElementById('rasterAiModal');
const rasterFileInput = document.getElementById('rasterFileInput');
const rasterSvgFileInput = document.getElementById('rasterSvgFileInput');
const rasterPreviewImage = document.getElementById('rasterPreviewImage');
const rasterPreviewPlaceholder = document.getElementById('rasterPreviewPlaceholder');
const rasterFileName = document.getElementById('rasterFileName');
const rasterCopyPrompt = document.getElementById('rasterCopyPrompt');
const rasterOpenChatGpt = document.getElementById('rasterOpenChatGpt');
const rasterSvgText = document.getElementById('rasterSvgText');
const rasterValidation = document.getElementById('rasterValidation');
const svgPreviewImage = document.getElementById('svgPreviewImage');
const svgPreviewPlaceholder = document.getElementById('svgPreviewPlaceholder');
const rasterExportSvg = document.getElementById('rasterExportSvg');
const rasterDownloadAiJson = document.getElementById('rasterDownloadAiJson');
const rasterDownloadCleanSvg = document.getElementById('rasterDownloadCleanSvg');
const svgExportModal = document.getElementById('svgExportModal');
const svgExportText = document.getElementById('svgExportText');
const svgExportStatus = document.getElementById('svgExportStatus');
const svgExportCopy = document.getElementById('svgExportCopy');
const svgExportDownload = document.getElementById('svgExportDownload');

let selectedRasterFile = null;
let rasterObjectUrl = null;
let svgObjectUrl = null;
let validatedSvg = '';

function openRasterAiDialog() {
  if (demoHelpPanel) demoHelpPanel.hidden = true;
  rasterAiModal.classList.add('visible');
  rasterAiModal.setAttribute('aria-hidden', 'false');
}

function closeRasterAiDialog() {
  closeSvgExportDialog();
  rasterAiModal.classList.remove('visible');
  rasterAiModal.setAttribute('aria-hidden', 'true');
}

function openSvgExportDialog() {
  if (!validatedSvg) return;
  svgExportText.value = validatedSvg;
  svgExportStatus.textContent = 'Pronto per la copia.';
  svgExportModal.classList.add('visible');
  svgExportModal.setAttribute('aria-hidden', 'false');
  requestAnimationFrame(() => {
    svgExportText.focus();
    svgExportText.setSelectionRange(0, 0);
  });
}

function closeSvgExportDialog() {
  if (!svgExportModal) return;
  svgExportModal.classList.remove('visible');
  svgExportModal.setAttribute('aria-hidden', 'true');
}

function downloadValidatedSvg() {
  if (!validatedSvg) return;
  const url = URL.createObjectURL(new Blob([validatedSvg], { type: 'image/svg+xml' }));
  const link = document.createElement('a');
  link.href = url;
  link.download = 'DisegnoInput.svg';
  document.body.appendChild(link);
  link.click();
  link.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}

async function copyValidatedSvg() {
  if (!validatedSvg) return;
  svgExportText.value = validatedSvg;

  try {
    if (!navigator.clipboard?.writeText)
      throw new Error('Clipboard API non disponibile.');
    await navigator.clipboard.writeText(validatedSvg);
    svgExportStatus.textContent = '✓ SVG copiato negli appunti. Ora puoi incollarlo in Termodel.';
    return;
  } catch (_) {
    svgExportText.focus();
    svgExportText.select();
    try {
      if (document.execCommand('copy')) {
        svgExportStatus.textContent = '✓ SVG copiato negli appunti.';
        return;
      }
    } catch (_) {
      // fallback manuale sotto
    }
    svgExportStatus.textContent = 'Copia automatica non consentita: testo selezionato, premi Ctrl+C.';
  }
}

const TERMODEL_SVG_TEXT_START = '[TERMODEL-SVG-TEXT-V1]';
const TERMODEL_SVG_TEXT_END = '[/TERMODEL-SVG-TEXT-V1]';

function decodeHtmlEntitiesOnce(text) {
  const textarea = document.createElement('textarea');
  textarea.innerHTML = text;
  return textarea.value;
}

function decodeTermodelSvgTransport(text) {
  const source = text ?? '';
  const upper = source.toUpperCase();
  const start = upper.indexOf(TERMODEL_SVG_TEXT_START);
  if (start < 0) return { text: source, transported: false };

  const payloadStart = start + TERMODEL_SVG_TEXT_START.length;
  const end = upper.indexOf(TERMODEL_SVG_TEXT_END, payloadStart);
  if (end < 0)
    throw new Error('Payload TERMODEL-SVG-TEXT-V1 incompleto: manca il marcatore finale.');

  const encoded = source.slice(payloadStart, end).trim();
  if (!encoded)
    throw new Error('Payload TERMODEL-SVG-TEXT-V1 vuoto.');

  return {
    text: decodeHtmlEntitiesOnce(encoded),
    transported: true
  };
}

function extractSvg(text) {
  if (!text || !text.trim()) throw new Error('Non è presente alcun testo SVG.');

  const decoded = decodeTermodelSvgTransport(text);
  const source = decoded.text;
  const start = source.toLowerCase().indexOf('<svg');
  const end = source.toLowerCase().lastIndexOf('</svg>');
  if (start < 0 || end < start)
    throw new Error('Blocco <svg>...</svg> non trovato, neppure dopo la decodifica TERMODEL-SVG-TEXT-V1.');

  return {
    svg: source.slice(start, end + '</svg>'.length).trim(),
    transported: decoded.transported
  };
}

function readNumberAttribute(line, name) {
  const raw = line.getAttribute(name);
  if (raw === null) throw new Error(`Una linea non contiene l'attributo ${name}.`);
  const value = Number(raw);
  if (!Number.isFinite(value))
    throw new Error(`Coordinata ${name}="${raw}" non valida: usa il punto come separatore decimale.`);
  return value;
}

function sanitizeSvgForPreview(svg) {
  const parser = new DOMParser();
  const doc = parser.parseFromString(svg, 'image/svg+xml');
  doc.querySelectorAll('script, foreignObject, iframe, object, embed').forEach(el => el.remove());
  doc.querySelectorAll('*').forEach(el => {
    Array.from(el.attributes).forEach(attr => {
      const name = attr.name.toLowerCase();
      const value = attr.value.toLowerCase();
      if (name.startsWith('on') || name === 'href' || name.endsWith(':href') || value.includes('javascript:'))
        el.removeAttribute(attr.name);
    });
  });
  return new XMLSerializer().serializeToString(doc);
}

function showSvgPreview(svg) {
  if (svgObjectUrl) URL.revokeObjectURL(svgObjectUrl);
  const safeSvg = sanitizeSvgForPreview(svg);
  svgObjectUrl = URL.createObjectURL(new Blob([safeSvg], { type: 'image/svg+xml' }));
  svgPreviewImage.src = svgObjectUrl;
  svgPreviewImage.hidden = false;
  svgPreviewPlaceholder.hidden = true;
}

const AI_PREVIEW_WALL_HEIGHT_M = 2.70;
const AI_PREVIEW_EXTERNAL_WALL_THICKNESS_M = 0.40;
const AI_PREVIEW_INTERNAL_WALL_THICKNESS_M = 0.15;
const AI_PREVIEW_FLOOR_THICKNESS_M = 0.20;
const AI_PREVIEW_CEILING_THICKNESS_M = 0.20;

function svgRingToThreePoints(ring) {
  return ring.map(([x, y]) => new THREE.Vector2(Number(x) / 100, -Number(y) / 100));
}

function createPrismMeshPrimitive({
  shell,
  holes = [],
  zBottom,
  zTop,
  id,
  numero,
  tipo,
  descrizione,
  parte,
  color,
  opacity = 1
}) {
  const contour = svgRingToThreePoints(shell || []);
  const holeRings = (holes || []).map(svgRingToThreePoints);

  if (contour.length < 3)
    throw new Error(`Contorno insufficiente per ${id || tipo}.`);

  const triangles = THREE.ShapeUtils.triangulateShape(contour, holeRings);
  const rings = [contour, ...holeRings];
  const points = rings.flat();

  const vertices = [
    ...points.map(p => [p.x, p.y, zBottom]),
    ...points.map(p => [p.x, p.y, zTop])
  ];
  const pointCount = points.length;
  const indices = [];

  triangles.forEach(([a, b, d]) => {
    indices.push(d, b, a);
    indices.push(pointCount + a, pointCount + b, pointCount + d);
  });

  let offset = 0;
  rings.forEach((ring) => {
    for (let i = 0; i < ring.length; i++) {
      const a = offset + i;
      const b = offset + ((i + 1) % ring.length);
      const at = pointCount + a;
      const bt = pointCount + b;
      indices.push(a, b, bt, a, bt, at);
    }
    offset += ring.length;
  });

  return {
    kind: 'mesh',
    source: 'GeneraPiantaJs',
    parte,
    numero,
    id,
    tipo,
    descrizione,
    filterMetadata: true,
    piano: 'Anteprima AI',
    confine: '',
    separatore: false,
    stessaZona: false,
    fittizia: false,
    falda: false,
    color,
    opacity,
    lineWidth: 1,
    text: '',
    vertices,
    indices
  };
}

function createWallMassPrimitive(plan) {
  if (!plan.edificio?.outerShell?.length)
    return null;

  const holes = (plan.locali || [])
    .map(locale => locale.architecturalShell)
    .filter(ring => Array.isArray(ring) && ring.length >= 3);

  return createPrismMeshPrimitive({
    shell: plan.edificio.outerShell,
    holes,
    zBottom: 0,
    zTop: AI_PREVIEW_WALL_HEIGHT_M,
    id: 'MASSA-MURARIA',
    numero: 1,
    tipo: 'Parete',
    descrizione: 'Massa muraria GeneraPianta — E 40 cm, W 15 cm',
    parte: 'massa-muraria-generapianta',
    color: '#A86F43',
    opacity: 0.92
  });
}

function createSlabMeshPrimitive(locale, index, tipo) {
  const isFloor = tipo === 'Pavimento';
  const zBottom = isFloor ? -AI_PREVIEW_FLOOR_THICKNESS_M : AI_PREVIEW_WALL_HEIGHT_M;
  const zTop = isFloor ? 0 : AI_PREVIEW_WALL_HEIGHT_M + AI_PREVIEW_CEILING_THICKNESS_M;

  return createPrismMeshPrimitive({
    shell: locale.architecturalShell || locale.shell,
    holes: [],
    zBottom,
    zTop,
    id: `${locale.id}-${isFloor ? 'PAV' : 'SOF'}`,
    numero: index + 1,
    tipo,
    descrizione: `${tipo} provvisorio — ${locale.id} ${locale.descrizione || ''}`.trim(),
    parte: isFloor ? 'pavimento-provvisorio' : 'soffitto-provvisorio',
    color: isFloor ? '#B9A58D' : '#D7D7D7',
    opacity: isFloor ? 0.96 : 0.62
  });
}

function createAiPreviewModelFromPlan(plan) {
  const walls = [];
  const wallMass = createWallMassPrimitive(plan);
  if (wallMass) walls.push(wallMass);

  const floors = plan.locali.map((locale, index) =>
    createSlabMeshPrimitive(locale, index, 'Pavimento'));
  const ceilings = plan.locali.map((locale, index) =>
    createSlabMeshPrimitive(locale, index, 'Soffitto'));

  const primitives = [...walls, ...floors, ...ceilings];

  return {
    format: 'TermodelWebModel',
    version: 3,
    coordinateSystem: 'Z-up',
    generatedAtUtc: new Date().toISOString(),
    source: 'DisegnoInput.svg → JSTS GeneraPianta.js',
    preview: true,
    previewAssumptions: {
      units: 'm',
      sourceSvgUnits: 'cm',
      wallHeightMeters: AI_PREVIEW_WALL_HEIGHT_M,
      externalWallThicknessMeters: AI_PREVIEW_EXTERNAL_WALL_THICKNESS_M,
      internalWallThicknessMeters: AI_PREVIEW_INTERNAL_WALL_THICKNESS_M,
      floorThicknessMeters: AI_PREVIEW_FLOOR_THICKNESS_M,
      ceilingThicknessMeters: AI_PREVIEW_CEILING_THICKNESS_M,
      note: 'GeneraPianta v0.5: i lati esterni dei locali restano sul filo E; i lati interni sono spostati di 7.5 cm verso il locale; il perimetro edificio è spostato di 40 cm verso l’esterno.'
    },
    previewCounts: {
      walls: walls.length,
      wallMassBodies: wallMass ? 1 : 0,
      floors: floors.length,
      ceilings: ceilings.length,
      rooms: plan.locali.length
    },
    primitiveCount: primitives.length,
    primitives
  };
}

function setCadLayoutMode(active) {
  appRoot?.classList.toggle('cad-layout-mode', active);
  if (appTitleText)
    appTitleText.textContent = active ? APP_CAD_TITLE : APP_MAIN_TITLE;
}

function activateModelPage() {
  setCadLayoutMode(false);
  document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));

  const modelTab = document.querySelector('.tab[data-page="modelPage"]');
  if (modelTab) modelTab.classList.add('active');
  modelPage.classList.add('active');
  requestAnimationFrame(resize);
}

function showAiPreviewModel(plan) {
  lastAiPreviewData = createAiPreviewModelFromPlan(plan);
  renderModelData(lastAiPreviewData, {
    mode: 'ai',
    label: 'ANTEPRIMA AI — GENERAPIANTA.JS'
  });
  activateModelPage();
}

function downloadAiPreviewJson() {
  if (!lastAiPreviewData) return;
  const json = JSON.stringify(lastAiPreviewData, null, 2);
  const url = URL.createObjectURL(new Blob([json], { type: 'application/json' }));
  const link = document.createElement('a');
  link.href = url;
  link.download = 'TermodelWebModel-AI.json';
  document.body.appendChild(link);
  link.click();
  link.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}

function downloadCleanPlanSvg() {
  if (!lastCleanPlanSvg) return;
  const url = URL.createObjectURL(new Blob([lastCleanPlanSvg], { type: 'image/svg+xml' }));
  const link = document.createElement('a');
  link.href = url;
  link.download = 'PiantaPulita-AI.svg';
  document.body.appendChild(link);
  link.click();
  link.remove();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}


function downloadArchitecturalDxf() {
  if (!lastGeneratedPlan) return;

  try {
    const dxf = generaDxfDaPianta(lastGeneratedPlan);
    const url = URL.createObjectURL(
      new Blob([dxf], { type: 'application/dxf;charset=utf-8' })
    );
    const link = document.createElement('a');
    link.href = url;
    link.download = 'PiantaArchitettonica-Termodel.dxf';
    document.body.appendChild(link);
    link.click();
    link.remove();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
  } catch (error) {
    window.alert('Esportazione DXF non riuscita: ' + error.message);
  }
}


const SVG_NS = 'http://www.w3.org/2000/svg';
const NORTH_SYMBOL_ID = 'termodel-north';
const NORTH_ORIENTATION_ATTR = 'data-termodel-orientamento';

function normalizeNorthAngle(value) {
  if (value === null || value === undefined || value === '' || value === '?')
    return null;
  const number = Number(value);
  if (!Number.isFinite(number)) return null;
  return ((number % 360) + 360) % 360;
}

function northSvgViewBox(doc) {
  const root = doc?.documentElement;
  const raw = String(root?.getAttribute('viewBox') || '').trim();
  const values = raw.split(/[ ,]+/).map(Number);
  if (values.length === 4 && values.every(Number.isFinite))
    return values;

  const width = Number(root?.getAttribute('width')) || 1200;
  const height = Number(root?.getAttribute('height')) || 800;
  return [0, 0, width, height];
}

function northSvgElement(doc, name, attributes = {}) {
  const node = doc.createElementNS(SVG_NS, name);
  Object.entries(attributes).forEach(([key, value]) => {
    if (value !== null && value !== undefined)
      node.setAttribute(key, String(value));
  });
  return node;
}

function readNorthOrientationFromSvg(doc) {
  const group = doc?.getElementById?.(NORTH_SYMBOL_ID);
  if (!group) return null;
  return normalizeNorthAngle(group.getAttribute(NORTH_ORIENTATION_ATTR));
}

function ensureNorthSymbolInSvg(doc, angle = readNorthOrientationFromSvg(doc)) {
  const root = doc?.documentElement;
  if (!root) return null;

  let group = doc.getElementById(NORTH_SYMBOL_ID);
  if (!group) {
    group = northSvgElement(doc, 'g', { id: NORTH_SYMBOL_ID });
    root.appendChild(group);
  } else if (group.parentElement !== root) {
    root.appendChild(group);
  }

  const normalized = normalizeNorthAngle(angle);
  group.setAttribute('data-termodel-accessorio', 'NORD');
  group.setAttribute(
    NORTH_ORIENTATION_ATTR,
    normalized === null ? '?' : String(Math.round(normalized * 100) / 100)
  );
  group.setAttribute('pointer-events', 'none');

  while (group.firstChild) group.removeChild(group.firstChild);

  const [minX, minY, width, height] = northSvgViewBox(doc);
  // Simbolo volutamente più discreto e con maggiore rispetto dal bordo:
  // deve orientare la pianta senza coprire la geometria edilizia.
  const radius = Math.min(Math.max(Math.min(width, height) * 0.032, 22), 48);
  const x = minX + width - radius * 1.15;
  const y = minY + radius * 1.15;
  group.setAttribute('transform', `translate(${x} ${y})`);

  group.appendChild(northSvgElement(doc, 'circle', {
    cx: 0, cy: 0, r: radius,
    fill: '#ffffff', 'fill-opacity': 0.88,
    stroke: '#333333', 'stroke-width': Math.max(1.5, radius * 0.035)
  }));

  if (normalized === null) {
    const text = northSvgElement(doc, 'text', {
      x: 0, y: radius * 0.16,
      'text-anchor': 'middle',
      'font-family': 'Segoe UI, Arial, sans-serif',
      'font-size': radius * 0.55,
      'font-weight': 700,
      fill: '#a11616'
    });
    text.textContent = 'N ?';
    group.appendChild(text);
    return group;
  }

  const arrow = northSvgElement(doc, 'g', {
    transform: `rotate(${normalized})`
  });
  arrow.appendChild(northSvgElement(doc, 'line', {
    x1: 0, y1: radius * 0.25,
    x2: 0, y2: -radius * 0.70,
    stroke: '#c62828',
    'stroke-width': Math.max(2, radius * 0.06),
    'stroke-linecap': 'round'
  }));
  arrow.appendChild(northSvgElement(doc, 'polygon', {
    points: `0,${-radius * 0.82} ${-radius * 0.13},${-radius * 0.55} ${radius * 0.13},${-radius * 0.55}`,
    fill: '#c62828'
  }));
  group.appendChild(arrow);

  const n = northSvgElement(doc, 'text', {
    x: 0, y: radius * 0.48,
    'text-anchor': 'middle',
    'font-family': 'Segoe UI, Arial, sans-serif',
    'font-size': radius * 0.34,
    'font-weight': 700,
    fill: '#111111'
  });
  n.textContent = 'N';
  group.appendChild(n);
  return group;
}

function ensureNorthSymbolInSvgText(svgText) {
  const parser = new DOMParser();
  const doc = parser.parseFromString(String(svgText ?? ''), 'image/svg+xml');
  if (doc.querySelector('parsererror'))
    throw new Error('SVG non valido durante la normalizzazione del simbolo Nord.');
  ensureNorthSymbolInSvg(doc);
  return new XMLSerializer().serializeToString(doc.documentElement);
}

function cadNorthPanelIsOpen() {
  return Boolean(cadNorthPropertiesSection && !cadNorthPropertiesSection.hidden);
}

function cadOpenNorthPanel() {
  if (!cadNorthPropertiesSection) return;
  cadNorthPropertiesSection.hidden = false;
  cadUpdateNorthControls();
}

function cadCloseNorthPanel(updatePanel = true) {
  if (!cadNorthPropertiesSection) return;
  cadNorthPropertiesSection.hidden = true;
  if (updatePanel) cadUpdatePropertiesPanel();
}

function cadUpdateNorthControls() {
  const defined = northOrientationDeg !== null;
  const value = defined ? Math.round(northOrientationDeg) : 0;

  if (cadNorthDefined) cadNorthDefined.checked = defined;
  if (cadNorthRange) {
    cadNorthRange.disabled = !defined;
    cadNorthRange.value = String(value);
  }
  if (cadNorthAngle) {
    cadNorthAngle.disabled = !defined;
    cadNorthAngle.value = defined ? String(value) : '';
  }
  if (cadNorthNeedle) {
    cadNorthNeedle.hidden = !defined;
    cadNorthNeedle.style.display = defined ? 'block' : 'none';
    cadNorthNeedle.style.transform = `rotate(${value}deg)`;
  }
  if (cadNorthUnknown) {
    cadNorthUnknown.hidden = defined;
    cadNorthUnknown.style.display = defined ? 'none' : 'flex';
  }
}

function cadSyncNorthFromWorkingDoc() {
  northOrientationDeg = readNorthOrientationFromSvg(cadWorkingDoc);
  ensureNorthSymbolInSvg(cadWorkingDoc, northOrientationDeg);
  cadUpdateNorthControls();
  updateNorth3DMarker();
}

function cadSetNorthOrientation(value) {
  northOrientationDeg = normalizeNorthAngle(value);

  if (cadWorkingDoc) {
    ensureNorthSymbolInSvg(cadWorkingDoc, northOrientationDeg);
    validatedSvg = cadSerializeWorkingSvg();
    if (rasterSvgText) rasterSvgText.value = validatedSvg;
  }

  cadUpdateNorthControls();
  updateNorth3DMarker();

  if (cadWorkingDoc && cadPage?.classList.contains('active'))
    renderCadComparison();

  cadUpdateControls();
  cadSetStatus(
    northOrientationDeg === null
      ? 'Nord non definito · nel 3D viene mostrato N ?'
      : `Nord ${Math.round(northOrientationDeg)}° · 0° alto pianta · positivo orario`,
    cadWorkingDoc && cadIsDirty() ? 'dirty' : ''
  );
}

function cadRenderNorthOverlay(svg, viewBoxValues) {
  if (!Array.isArray(viewBoxValues) || viewBoxValues.length !== 4) return;
  const [minX, minY, width, height] = viewBoxValues;
  if (![minX, minY, width, height].every(Number.isFinite)) return;

  // Simbolo volutamente più discreto e con maggiore rispetto dal bordo:
  // deve orientare la pianta senza coprire la geometria edilizia.
  const radius = Math.min(Math.max(Math.min(width, height) * 0.032, 22), 48);
  const x = minX + width - radius * 1.15;
  const y = minY + radius * 1.15;

  const group = svgNode('g', {
    id: 'cadNorthOverlay',
    transform: `translate(${x} ${y})`,
    'pointer-events': 'all',
    role: 'button',
    tabindex: '0',
    'aria-label': 'Apri proprietà orientamento Nord'
  });

  const openNorth = event => {
    if (cadToolMode !== 'select') return;
    event?.preventDefault?.();
    event?.stopPropagation?.();
    cadSelectedLineId = '';
    cadSelectedSymbolId = '';
    cadOpenNorthPanel();
    cadUpdatePropertiesPanel();
    cadSetStatus(
      northOrientationDeg === null
        ? 'Nord selezionato · orientamento non definito'
        : 'Nord selezionato · ' + Math.round(northOrientationDeg) + '°'
    );
  };

  group.addEventListener('pointerdown', openNorth);
  group.addEventListener('keydown', event => {
    if (event.key === 'Enter' || event.key === ' ') openNorth(event);
  });
  group.appendChild(svgNode('circle', {
    cx: 0, cy: 0, r: radius,
    fill: '#ffffff', 'fill-opacity': 0.94,
    stroke: '#333333', 'stroke-width': Math.max(1.5, radius * 0.035),
    'vector-effect': 'non-scaling-stroke'
  }));

  if (northOrientationDeg === null) {
    const text = svgNode('text', {
      x: 0, y: radius * 0.16,
      fill: '#a11616',
      'text-anchor': 'middle',
      'font-family': 'Segoe UI, Arial, sans-serif',
      'font-size': radius * 0.55,
      'font-weight': 700
    });
    text.textContent = 'N ?';
    group.appendChild(text);
  } else {
    const arrow = svgNode('g', {
      transform: `rotate(${northOrientationDeg})`
    });
    arrow.appendChild(svgNode('line', {
      x1: 0, y1: radius * 0.25,
      x2: 0, y2: -radius * 0.70,
      stroke: '#c62828',
      'stroke-width': Math.max(2, radius * 0.06),
      'stroke-linecap': 'round',
      'vector-effect': 'non-scaling-stroke'
    }));
    arrow.appendChild(svgNode('polygon', {
      points: `0,${-radius * 0.82} ${-radius * 0.13},${-radius * 0.55} ${radius * 0.13},${-radius * 0.55}`,
      fill: '#c62828'
    }));
    group.appendChild(arrow);

    const n = svgNode('text', {
      x: 0, y: radius * 0.48,
      fill: '#111111',
      'text-anchor': 'middle',
      'font-family': 'Segoe UI, Arial, sans-serif',
      'font-size': radius * 0.34,
      'font-weight': 700
    });
    n.textContent = 'N';
    group.appendChild(n);
  }

  svg.appendChild(group);
}



function svgNode(name, attributes = {}) {
  const node = document.createElementNS(SVG_NS, name);
  Object.entries(attributes).forEach(([key, value]) => {
    if (value !== null && value !== undefined)
      node.setAttribute(key, String(value));
  });
  return node;
}

function cadColorForId(id) {
  if (/^E/i.test(id)) return '#1565c0';
  if (/^W/i.test(id)) return '#d35400';
  if (/^P/i.test(id)) return '#7b1fa2';
  if (/^F/i.test(id)) return '#00897b';
  return '#c62828';
}

const CAD_ACI_COLORS = {
  1: { css: '#ff0000', aliases: ['red', '#f00', '#ff0000'] },
  2: { css: '#ffff00', aliases: ['yellow', '#ff0', '#ffff00'] },
  3: { css: '#00ff00', aliases: ['lime', 'green', '#0f0', '#00ff00', '#008000'] },
  4: { css: '#00ffff', aliases: ['cyan', 'aqua', '#0ff', '#00ffff'] },
  5: { css: '#0000ff', aliases: ['blue', '#00f', '#0000ff'] },
  6: { css: '#ff00ff', aliases: ['magenta', 'fuchsia', '#f0f', '#ff00ff'] },
  7: { css: '#000000', aliases: ['black', 'white', '#000', '#000000', '#fff', '#ffffff'] },
  8: { css: '#808080', aliases: ['gray', 'grey', '#808080'] },
  9: { css: '#404040', aliases: ['darkgray', 'darkgrey', '#404040', '#444', '#444444'] }
};

function cadArchiveRecords(name) {
  try {
    return getArchivioWebRecords(name) || [];
  } catch (_) {
    return [];
  }
}

function cadText(value) {
  return String(value ?? '').trim();
}

function cadFindRecord(records, field, value) {
  const wanted = cadText(value).toLowerCase();
  if (!wanted) return null;
  return records.find(record => cadText(record?.[field]).toLowerCase() === wanted) || null;
}

function cadArchiveColorIndex(value) {
  const match = /^\s*(\d+)\s*(?:-|$)/.exec(cadText(value));
  return match ? Number(match[1]) : 0;
}

function cadCssColorIndex(value) {
  const normalized = cadText(value).toLowerCase().replace(/\s+/g, '');
  if (!normalized) return 0;
  for (const [index, data] of Object.entries(CAD_ACI_COLORS)) {
    if (data.aliases.includes(normalized)) return Number(index);
  }
  return 0;
}

function cadCssForArchiveColor(value) {
  const index = cadArchiveColorIndex(value);
  return CAD_ACI_COLORS[index]?.css || '';
}

function cadLineRawStroke(line) {
  if (!line) return '';
  const direct = cadText(line.getAttribute('stroke'));
  if (direct) return direct;
  const style = cadText(line.getAttribute('style'));
  const match = /(?:^|;)\s*stroke\s*:\s*([^;]+)/i.exec(style);
  return cadText(match?.[1]);
}

function cadDashArrayForLineType(value) {
  switch (cadText(value).toUpperCase()) {
    case 'FITTIZIA': return '2 6';
    case 'TRATTEGGIATA': return '10 6';
    case 'TRATTOPUNTO': return '10 4 2 4';
    case 'DIVIDI': return '14 4 2 4 2 4';
    default: return '';
  }
}

function cadDefaultToolbarState() {
  const datiCad = cadArchiveRecords('DatiCad')[0] || {};
  const piani = cadArchiveRecords('Piani');
  const pareti = cadArchiveRecords('Pareti');
  const confini = cadArchiveRecords('Confini');

  const valid = value => {
    const text = cadText(value);
    return text && text !== '-Seleziona-' ? text : '';
  };

  const piano = valid(datiCad.Piano) || cadText(piani[0]?.Nome);
  const tipoParete = valid(datiCad.TipoParete) || cadText(pareti[0]?.DescBreve);

  let confineParete = valid(datiCad.ConfineParete);
  if (!confineParete) {
    confineParete = cadFindRecord(confini, 'Codice', 'Automatico')
      ? 'Automatico'
      : cadText(confini[0]?.Codice);
  }

  return { piano, tipoParete, confineParete };
}

function cadEnsureToolbarState() {
  const defaults = cadDefaultToolbarState();
  if (!cadText(cadToolbarState.piano)) cadToolbarState.piano = defaults.piano;
  if (!cadText(cadToolbarState.tipoParete)) cadToolbarState.tipoParete = defaults.tipoParete;
  if (!cadText(cadToolbarState.confineParete)) cadToolbarState.confineParete = defaults.confineParete;
  return cadToolbarState;
}

function cadDerivedToolbarValues(state = cadToolbarState) {
  const piano = cadFindRecord(cadArchiveRecords('Piani'), 'Nome', state.piano);
  const parete = cadFindRecord(cadArchiveRecords('Pareti'), 'DescBreve', state.tipoParete);
  const confine = cadFindRecord(cadArchiveRecords('Confini'), 'Codice', state.confineParete);

  return {
    layer: cadText(piano?.LayerCad),
    colore: cadText(parete?.Colore),
    tipoLinea: cadText(confine?.Tipolinea),
    colorCss: cadCssForArchiveColor(parete?.Colore)
  };
}

function cadLayerForPlane(planeName) {
  const piano = cadFindRecord(cadArchiveRecords('Piani'), 'Nome', planeName);
  return cadText(piano?.LayerCad);
}

function cadCurrentLayer() {
  return cadLayerForPlane(cadCurrentPlane());
}

function cadDatiCadRecord() {
  return cadArchiveRecords('DatiCad')[0] || {};
}

function cadMetersToSvgCm(value) {
  const raw = cadText(value).replace(',', '.');
  const number = Number(raw);
  if (!Number.isFinite(number)) return raw || '0';
  return String(Math.round(number * 10000) / 100);
}
function cadFillSelect(select, values, preferred) {
  if (!select) return '';
  const clean = [];
  values.forEach(value => {
    const text = cadText(value);
    if (text && !clean.includes(text)) clean.push(text);
  });

  const current = cadText(preferred);
  select.replaceChildren();

  clean.forEach(value => {
    const option = document.createElement('option');
    option.value = value;
    option.textContent = value;
    select.appendChild(option);
  });

  if (current && !clean.includes(current)) {
    const option = document.createElement('option');
    option.value = current;
    option.textContent = current + ' · non presente in archivio';
    option.dataset.outOfArchive = 'true';
    select.appendChild(option);
  }

  const value = current || clean[0] || '';
  select.value = value;
  return value;
}

function cadRefreshToolbarControls() {
  cadEnsureToolbarState();

  cadToolbarState.piano = cadFillSelect(
    cadPropPiano,
    cadArchiveRecords('Piani').map(r => r?.Nome),
    cadToolbarState.piano
  );
  cadToolbarState.tipoParete = cadFillSelect(
    cadPropTipoParete,
    cadArchiveRecords('Pareti').map(r => r?.DescBreve),
    cadToolbarState.tipoParete
  );
  cadToolbarState.confineParete = cadFillSelect(
    cadPropConfineParete,
    cadArchiveRecords('Confini').map(r => r?.Codice),
    cadToolbarState.confineParete
  );

  const derived = cadDerivedToolbarValues();
  if (cadPropColore) cadPropColore.value = derived.colore;
  if (cadPropTipoLinea) cadPropTipoLinea.value = derived.tipoLinea;
  if (cadPropColorSwatch)
    cadPropColorSwatch.style.background = derived.colorCss || '#ccc';

  return derived;
}

function cadWallRecordFromLine(line) {
  const pareti = cadArchiveRecords('Pareti');
  const explicit = cadText(line?.getAttribute('data-termodel-tipo-parete'));
  if (explicit) return cadFindRecord(pareti, 'DescBreve', explicit);

  const semanticColor = cadText(line?.getAttribute('data-termodel-colore'));
  let colorIndex = cadArchiveColorIndex(semanticColor);
  if (!colorIndex) colorIndex = cadCssColorIndex(cadLineRawStroke(line));
  if (!colorIndex) return null;

  return pareti.find(record => cadArchiveColorIndex(record?.Colore) === colorIndex) || null;
}

function cadBoundaryRecordFromLine(line) {
  const confini = cadArchiveRecords('Confini');
  const explicit = cadText(line?.getAttribute('data-termodel-confine-parete'));
  if (explicit) return cadFindRecord(confini, 'Codice', explicit);

  const tipoLinea = cadText(line?.getAttribute('data-termodel-tipo-linea'));
  if (!tipoLinea) return null;
  return cadFindRecord(confini, 'Tipolinea', tipoLinea);
}

function cadStateFromLine(line) {
  const defaults = cadDefaultToolbarState();
  const wall = cadWallRecordFromLine(line);
  const boundary = cadBoundaryRecordFromLine(line);
  return {
    piano: cadCurrentPlane() || defaults.piano,
    tipoParete: cadText(line?.getAttribute('data-termodel-tipo-parete')) ||
      cadText(wall?.DescBreve) || defaults.tipoParete,
    confineParete: cadText(line?.getAttribute('data-termodel-confine-parete')) ||
      cadText(boundary?.Codice) || defaults.confineParete
  };
}

function cadApplySemanticAttributes(line, state = cadToolbarState) {
  if (!line) return;

  cadSetOptionalAttribute(line, 'data-termodel-piano', state.piano);
  cadSetOptionalAttribute(line, 'data-termodel-layer', cadLayerForPlane(state.piano));
  cadSetOptionalAttribute(line, 'data-termodel-tipo-parete', state.tipoParete);
  cadSetOptionalAttribute(line, 'data-termodel-confine-parete', state.confineParete);

  const derived = cadDerivedToolbarValues(state);
  cadSetOptionalAttribute(line, 'data-termodel-colore', derived.colore);
  cadSetOptionalAttribute(line, 'data-termodel-tipo-linea', derived.tipoLinea);

  if (derived.colorCss) line.setAttribute('stroke', derived.colorCss);
  else line.removeAttribute('stroke');

  const dash = cadDashArrayForLineType(derived.tipoLinea);
  if (dash) line.setAttribute('stroke-dasharray', dash);
  else line.removeAttribute('stroke-dasharray');
}

function cadLineDisplayStyle(line) {
  const wall = cadWallRecordFromLine(line);
  const boundary = cadBoundaryRecordFromLine(line);

  const color =
    cadCssForArchiveColor(wall?.Colore) ||
    cadLineRawStroke(line) ||
    cadColorForId(line?.id || '');

  const tipoLinea =
    cadText(line?.getAttribute('data-termodel-tipo-linea')) ||
    cadText(boundary?.Tipolinea);

  return {
    color,
    tipoLinea,
    dash: cadDashArrayForLineType(tipoLinea)
  };
}

function addCadLabel(group, id, x, y, color, dataId = '') {
  if (!id || !Number.isFinite(x) || !Number.isFinite(y)) return;
  const text = svgNode('text', {
    x, y: y - 8,
    fill: color,
    stroke: '#ffffff',
    'stroke-width': 3,
    'paint-order': 'stroke',
    'text-anchor': 'middle',
    'font-family': 'Segoe UI, Arial, sans-serif',
    'font-size': 15,
    'font-weight': 700,
    'pointer-events': 'none',
    'data-cad-label': dataId || null
  });
  text.textContent = id;
  group.appendChild(text);
}

function cadParseSvg(svgText) {
  const doc = new DOMParser().parseFromString(svgText, 'image/svg+xml');
  if (doc.querySelector('parsererror'))
    throw new Error('Lo SVG di lavoro del CAD non è XML valido.');
  return doc;
}

function cadSerializeWorkingSvg() {
  if (!cadWorkingDoc) return '';
  return new XMLSerializer().serializeToString(cadWorkingDoc.documentElement);
}

function cadCalpestabile(doc = cadWorkingDoc) {
  if (!doc) return null;
  return Array.from(doc.documentElement.children)
    .find(el => el.localName === 'g' && el.id === 'calpestabile') || null;
}

function cadBackgroundContainer(doc = cadWorkingDoc, create = false) {
  if (!doc) return null;
  const root = doc.documentElement;
  let group = Array.from(root.children)
    .find(el => el.localName === 'g' && el.id === 'termodel-backgrounds') || null;

  if (!group && create) {
    group = doc.createElementNS(SVG_NS, 'g');
    group.setAttribute('id', 'termodel-backgrounds');
    group.setAttribute('data-termodel-accessorio', 'SFONDI');
    root.insertBefore(group, root.firstChild);
  }
  return group;
}

function cadPlaneBackground(doc = cadWorkingDoc, planeName = cadCurrentPlane()) {
  const group = cadBackgroundContainer(doc, false);
  if (!group || !planeName) return null;
  return Array.from(group.children).find(element =>
    element.localName === 'image' &&
    cadText(element.getAttribute('data-termodel-piano')) === planeName
  ) || null;
}

function cadReadFileAsDataUrl(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.addEventListener('load', () => resolve(String(reader.result || '')));
    reader.addEventListener('error', () => reject(reader.error || new Error('Impossibile leggere il file.')));
    reader.readAsDataURL(file);
  });
}

function cadBackgroundKind(file) {
  return file?.type === 'image/svg+xml' || /\.svg$/i.test(file?.name || '')
    ? 'vector'
    : 'raster';
}

async function cadImportBackgroundFile(file) {
  if (!cadWorkingDoc || !file) return;

  const isSvg = file.type === 'image/svg+xml' || /\.svg$/i.test(file.name || '');
  const isRaster = /^image\//i.test(file.type || '') && !isSvg;
  if (!isSvg && !isRaster) {
    cadSetStatus('Formato sfondo non supportato. Usa SVG o un file immagine.', 'error');
    return;
  }

  const root = cadWorkingDoc.documentElement;
  const viewBox = cadParseViewBox(root.getAttribute('viewBox'));
  const plane = cadCurrentPlane();
  if (!viewBox || !plane) {
    cadSetStatus('Impossibile aggiungere lo sfondo: viewBox o piano corrente non disponibile.', 'error');
    return;
  }

  const dataUrl = await cadReadFileAsDataUrl(file);
  if (!dataUrl) {
    cadSetStatus('Impossibile incorporare il file di sfondo.', 'error');
    return;
  }

  const before = cadSerializeWorkingSvg();
  const group = cadBackgroundContainer(cadWorkingDoc, true);
  cadPlaneBackground(cadWorkingDoc, plane)?.remove();

  const image = cadWorkingDoc.createElementNS(SVG_NS, 'image');
  image.setAttribute('data-termodel-sfondo', '1');
  image.setAttribute('data-termodel-piano', plane);
  image.setAttribute('data-termodel-layer', cadCurrentLayer());
  image.setAttribute('data-termodel-sfondo-tipo', cadBackgroundKind(file));
  image.setAttribute('data-termodel-nome-file', file.name || '');
  image.setAttribute('x', String(viewBox[0]));
  image.setAttribute('y', String(viewBox[1]));
  image.setAttribute('width', String(viewBox[2]));
  image.setAttribute('height', String(viewBox[3]));
  image.setAttribute('preserveAspectRatio', 'xMidYMid meet');
  image.setAttribute('opacity', '0.72');
  image.setAttribute('href', dataUrl);
  group.appendChild(image);

  cadUndoStack.push(before);
  cadRedoStack = [];
  renderCadComparison();
  cadUpdateControls();
  cadSetStatus(
    '✓ Sfondo ' + (isSvg ? 'vettoriale' : 'raster') +
    ' aggiunto · Piano ' + plane +
    ' · ' + (file.name || 'file'),
    'dirty'
  );
}

function cadCurrentPlane() {
  cadEnsureToolbarState();
  return cadText(cadToolbarState.piano);
}

function cadPlaneScopedEntities(doc = cadWorkingDoc) {
  const group = cadCalpestabile(doc);
  if (!group) return [];
  return Array.from(group.children);
}

function cadEntityPlane(element) {
  return cadText(element?.getAttribute?.('data-termodel-piano'));
}

function cadEntityBelongsToCurrentPlane(element) {
  const current = cadCurrentPlane();
  if (!current) return true;
  return cadEntityPlane(element) === current;
}

function cadNormalizePlaneAssignments() {
  const current = cadCurrentPlane();
  if (!current) return 0;

  let count = 0;
  cadPlaneScopedEntities().forEach(element => {
    let plane = cadEntityPlane(element);
    if (!plane) {
      plane = current;
      element.setAttribute('data-termodel-piano', plane);
      count++;
    }
    const layer = cadLayerForPlane(plane);
    if (layer && cadText(element.getAttribute('data-termodel-layer')) !== layer) {
      element.setAttribute('data-termodel-layer', layer);
      count++;
    }
  });
  return count;
}

function cadAllSourceLines() {
  const group = cadCalpestabile();
  if (!group) return [];
  return Array.from(group.children)
    .filter(el => el.localName === 'line' && /^[EW]/i.test(el.id || ''));
}

function cadEditableSourceLines() {
  return cadAllSourceLines().filter(cadEntityBelongsToCurrentPlane);
}

function cadSerializeCurrentPlaneSvg() {
  if (!cadWorkingDoc) return '';
  const clone = cadWorkingDoc.cloneNode(true);
  const group = cadCalpestabile(clone);
  const current = cadCurrentPlane();

  if (group && current) {
    Array.from(group.children).forEach(element => {
      const plane = cadText(element.getAttribute('data-termodel-piano'));
      if (plane && plane !== current) element.remove();
    });
  }

  const backgroundGroup = cadBackgroundContainer(clone, false);
  if (backgroundGroup && current) {
    Array.from(backgroundGroup.children).forEach(element => {
      const plane = cadText(element.getAttribute('data-termodel-piano'));
      if (plane && plane !== current) element.remove();
    });
  }

  return new XMLSerializer().serializeToString(clone.documentElement);
}

function cadRestorePlanePreview() {
  const current = cadCurrentPlane();
  lastCleanPlanSvg = cadCleanPlanByPlane.get(current) || '';
  lastGeneratedPlan = cadGeneratedPlanByPlane.get(current) || null;
}

function cadSymbolBlockType(element) {
  if (!element || element.localName !== 'text') return '';
  const first = Array.from(element.children).find(child => child.localName === 'tspan');
  const line = cadText(first?.textContent);
  const match = /^BLOCCO\s*,\s*([^,]+)$/i.exec(line);
  return match ? match[1].trim().toUpperCase() : '';
}

function cadSymbolAttribute(element, name) {
  const wanted = String(name || '').trim().toUpperCase();
  for (const child of Array.from(element?.children || [])) {
    if (child.localName !== 'tspan') continue;
    const line = cadText(child.textContent);
    const comma = line.indexOf(',');
    if (comma < 0) continue;
    const key = line.slice(0, comma).trim().toUpperCase();
    if (key === wanted) return line.slice(comma + 1).trim();
  }
  return '';
}

function cadSymbolColor(element) {
  const type = cadSymbolBlockType(element);
  if (type === 'FIN') return cadSymbolAttribute(element, 'PORTA') === 'Struttura trasparente' ? '#00897b' : '#7b1fa2';
  if (type === 'PON') return '#7b1fa2';
  if (type === 'LOC') return '#c62828';
  if (type === 'ALLINEA') return '#455a64';
  return '#6d4c41';
}

function cadNextSymbolId(prefix) {
  const p = String(prefix || 'S').toUpperCase();
  let max = 0;
  const used = new Set(Array.from(cadWorkingDoc?.querySelectorAll?.('[id]') || []).map(element => element.id).filter(Boolean));
  const re = new RegExp('^' + p + '(\\d+)$', 'i');
  used.forEach(id => {
    const match = re.exec(id);
    if (match) max = Math.max(max, Number(match[1]) || 0);
  });
  let n = max + 1;
  let id = p + String(n).padStart(3, '0');
  while (used.has(id)) { n++; id = p + String(n).padStart(3, '0'); }
  return id;
}

function cadCreateSymbolText(id, x, y, rows) {
  const text = cadWorkingDoc.createElementNS(SVG_NS, 'text');
  text.setAttribute('id', id);
  text.setAttribute('x', Number(x).toFixed(3).replace(/\.000$/, ''));
  text.setAttribute('y', Number(y).toFixed(3).replace(/\.000$/, ''));
  text.setAttribute('font-size', '1');
  cadSetOptionalAttribute(text, 'data-termodel-piano', cadCurrentPlane());
  cadSetOptionalAttribute(text, 'data-termodel-layer', cadCurrentLayer());
  rows.forEach((row, index) => {
    const tspan = cadWorkingDoc.createElementNS(SVG_NS, 'tspan');
    tspan.setAttribute('x', text.getAttribute('x'));
    tspan.setAttribute('dy', index === 0 ? '0' : '1.2em');
    tspan.textContent = row;
    text.appendChild(tspan);
  });
  return text;
}

function cadNearestWallPoint(point, maxDistance = CAD_SNAP_DISTANCE * 3) {
  let best = null;
  let bestDistance = Number.POSITIVE_INFINITY;
  cadEditableSourceLines().forEach(line => {
    const projected = cadNearestPointOnSegment(point, cadLinePoint(line, 1), cadLinePoint(line, 2));
    const distance = cadPointDistance(point, projected);
    if (distance < bestDistance) { best = projected; bestDistance = distance; }
  });
  return { point: best || point, snapped: Boolean(best) && bestDistance <= maxDistance, distance: bestDistance };
}

function cadSymbolInsertLabel(type) {
  if (type === 'ALLINEA') return 'Allinea';
  if (type === 'FIN') return 'Porta/Finestra';
  if (type === 'PON') return 'Ponte';
  if (type === 'LOC') return 'Locale';
  return 'Simbolo';
}

function cadCancelSymbolInsert() {
  if (cadToolMode === 'symbol') {
    cadToolMode = 'select';
    cadSymbolInsertType = '';
  }
  if (cadCanvas) cadCanvas.classList.remove('symbol-insert-mode');
  cadUpdateControls();
}

function cadToggleSymbolInsert(type) {
  if (!cadWorkingDoc) {
    cadSetStatus('Disegno CAD non disponibile.', 'error');
    return;
  }

  const normalized = String(type || '').toUpperCase();
  if (cadToolMode === 'symbol' && cadSymbolInsertType === normalized) {
    cadCancelSymbolInsert();
    return;
  }

  if (cadToolMode === 'line') cadCancelNewLine();

  cadCloseNorthPanel(false);
  cadLastRepeatableCommand = 'symbol:' + normalized;
  cadToolMode = 'symbol';
  cadSymbolInsertType = normalized;
  cadSelectedLineId = '';
  cadNewLineState = null;

  // Feedback immediato: l'attivazione del comando non deve dipendere
  // dall'aggiornamento del pannello laterale.
  cadUpdateControls();

  const needsWall = normalized === 'FIN' || normalized === 'PON';
  cadSetStatus(
    'Piano ' + cadCurrentPlane() +
    ' · Layer ' + cadCurrentLayer() +
    ' · ' + cadSymbolInsertLabel(normalized) +
    (needsWall ? ' · clicca vicino a una parete' : ' · clicca il punto di inserimento')
  );

  try {
    cadUpdatePropertiesPanel();
  } catch (error) {
    console.warn('Pannello CAD non aggiornato durante inserimento simbolo:', error);
  }
}

function cadInsertSymbolAtPoint(rawPoint) {
  if (!cadWorkingDoc || cadToolMode !== 'symbol' || !cadSymbolInsertType) return;
  const group = cadCalpestabile();
  if (!group) { cadSetStatus('Gruppo calpestabile non trovato nello SVG.', 'error'); return; }
  const plane = cadCurrentPlane();
  const layer = cadCurrentLayer();
  if (!plane || !layer) { cadSetStatus('Piano/LayerCad corrente non disponibile: impossibile inserire il simbolo.', 'error'); return; }
  let point = rawPoint.slice();
  let wallSnapped = false;
  if (cadSymbolInsertType === 'FIN' || cadSymbolInsertType === 'PON') {
    const snap = cadNearestWallPoint(rawPoint);
    if (!snap.snapped) { cadSetStatus(cadSymbolInsertLabel(cadSymbolInsertType) + ': clicca vicino a una parete del piano corrente.', 'error'); return; }
    point = snap.point;
    wallSnapped = true;
  }
  const before = cadSerializeWorkingSvg();
  const dati = cadDatiCadRecord();
  let id = '';
  let rows = [];
  if (cadSymbolInsertType === 'ALLINEA') {
    id = cadNextSymbolId('A');
    rows = ['BLOCCO,ALLINEA'];
  } else if (cadSymbolInsertType === 'FIN') {
    id = cadNextSymbolId('F');
    rows = [
      'BLOCCO,FIN',
      'PORTA,' + (cadText(dati.Porta) || 'Struttura trasparente'),
      'TIPO,' + (cadText(dati.TipoFinestra) || 'Da associare'),
      'LARGHEZZA,' + cadMetersToSvgCm(dati.LarghezzaFinestra),
      'ALTEZZA,' + cadMetersToSvgCm(dati.AltezzaFinestra),
      'NUMEROANTE,' + (cadText(dati.AnteFinestra) || '0'),
      'SOTTOFINESTRA,' + cadMetersToSvgCm(dati.SottoFinestra),
      'SOPRALUCE,' + cadMetersToSvgCm(dati.SopraLuce)
    ];
  } else if (cadSymbolInsertType === 'PON') {
    id = cadNextSymbolId('PON');
    const orientamento = cadText(dati.OrientamentoPonte) || 'Orizzontale';
    const lunghezza = cadText(dati.FonteLunghezzaPonte) === 'Valore imposto'
      ? cadText(dati.LungPonte)
      : (orientamento === 'Orizzontale' ? 'Lunghezza parete' : 'Altezza parete');
    rows = [
      'BLOCCO,PON',
      'TIPO,' + (cadText(dati.TipoPonte) || 'Da associare'),
      'ORIENTAMENTO,' + orientamento,
      'LUNGHEZZA,' + lunghezza
    ];
  } else if (cadSymbolInsertType === 'LOC') {
    id = cadNextSymbolId('R');
    const altezzaDaPiano = cadText(dati.FonteAltezza) === 'Da piano';
    const quotaDaPiano = cadText(dati.FonteQuotaPavimento) === 'Da piano';
    rows = [
      'BLOCCO,LOC',
      'DESCR.,' + (cadText(dati.DescrizioneLocale) || ('Locale ' + id)),
      'ZONA,' + cadText(dati.Zona),
      'CPAV,' + (cadText(dati.ConfinePavimento) || 'Automatico'),
      'CSOF,' + (cadText(dati.ConfineSoffitto) || 'Automatico'),
      'CCOPERTURA,' + (cadText(dati.ColoreCopertura) || 'Solaio piano'),
      'TPAV,' + cadText(dati.TipoPavimento),
      'TSOF,' + cadText(dati.TipoSoffitto),
      'ALTEZZALORDA,' + (altezzaDaPiano ? 'Da piano' : cadText(dati.AltezzaLorda)),
      'ALTEZZANETTA,' + (altezzaDaPiano ? 'Da piano' : cadText(dati.AltezzaNetta)),
      'QUOTAPAVIMENTO,' + (quotaDaPiano ? 'Da piano' : cadText(dati.QuotaPavimento))
    ];
  }
  if (!id || !rows.length) return;
  const symbol = cadCreateSymbolText(id, point[0], point[1], rows);
  group.appendChild(symbol);
  cadUndoStack.push(before);
  cadRedoStack = [];
  cadToolMode = 'select';
  cadSymbolInsertType = '';
  cadSelectedLineId = '';
  cadSelectedSymbolId = id;
  if (cadCanvas) cadCanvas.classList.remove('symbol-insert-mode');
  renderCadComparison();
  cadUpdatePropertiesPanel();
  cadUpdateControls();
  cadSetStatus('✓ ' + id + ' ' + cadSymbolBlockType(symbol) + ' inserito · Piano ' + plane + ' · Layer ' + layer + (wallSnapped ? ' · SNAP parete' : ''), 'dirty');
}
function cadFindSourceLine(id) {
  if (!id) return null;
  return cadEditableSourceLines().find(line => line.id === id) || null;
}

function cadFindSourceSymbol(id) {
  if (!id) return null;
  return cadPlaneScopedEntities().find(element =>
    element.localName === 'text' &&
    element.id === id &&
    cadSymbolBlockType(element) &&
    cadEntityBelongsToCurrentPlane(element)
  ) || null;
}

const CAD_SYMBOL_PANEL_CONFIG = {
  FIN: [
    { key: 'PORTA', field: 'Porta', label: 'Porta o sup. opaca', arc: true },
    { key: 'TIPO', field: 'TipoFinestra', label: 'Tipo finestra', arc: true },
    { key: 'LARGHEZZA', field: 'LarghezzaFinestra', label: 'Larghezza (m)', svgCm: true },
    { key: 'ALTEZZA', field: 'AltezzaFinestra', label: 'Altezza (m)', svgCm: true },
    { key: 'NUMEROANTE', field: 'AnteFinestra', label: 'Numero Ante' },
    { key: 'SOTTOFINESTRA', field: 'SottoFinestra', label: 'Sottofinestra (m)', svgCm: true },
    { key: 'SOPRALUCE', field: 'SopraLuce', label: 'Sopraluce (m)', svgCm: true }
  ],
  PON: [
    { key: 'TIPO', field: 'TipoPonte', label: 'Tipo ponte', arc: true },
    { key: 'ORIENTAMENTO', field: 'OrientamentoPonte', label: 'Orientamento ponte' },
    { key: '__FONTE_LUNGHEZZA', field: 'FonteLunghezzaPonte', label: 'Fonte lunghezza ponte', virtual: true },
    { key: 'LUNGHEZZA', field: 'LungPonte', label: 'Lunghezza ponte (m)' }
  ],
  LOC: [
    { key: 'DESCR.', field: 'DescrizioneLocale', label: 'Descrizione Locale' },
    { key: 'ZONA', field: 'Zona', label: 'Zona', arc: true },
    { key: '__FONTE_ALTEZZA', field: 'FonteAltezza', label: 'Fonte altezza', virtual: true },
    { key: 'ALTEZZALORDA', field: 'AltezzaLorda', label: 'Altezza lorda (m)' },
    { key: 'ALTEZZANETTA', field: 'AltezzaNetta', label: 'Altezza netta (m)' },
    { key: '__FONTE_QUOTA', field: 'FonteQuotaPavimento', label: 'Fonte quota pavimento', virtual: true },
    { key: 'QUOTAPAVIMENTO', field: 'QuotaPavimento', label: 'Quota pavimento (m)' },
    { key: 'TSOF', field: 'TipoSoffitto', label: 'Tipo Soffitto', arc: true },
    { key: 'CSOF', field: 'ConfineSoffitto', label: 'Confine Soffitto', arc: true },
    { key: 'CCOPERTURA', field: 'ColoreCopertura', label: 'Colore copertura' },
    { key: 'TPAV', field: 'TipoPavimento', label: 'Tipo Pavimento', arc: true },
    { key: 'CPAV', field: 'ConfinePavimento', label: 'Confine Pavimento', arc: true }
  ],
  ALLINEA: []
};

function cadSymbolPanelConfig(type) {
  return CAD_SYMBOL_PANEL_CONFIG[type] || [];
}

function cadDatiCadMeta(field) {
  return getArchivioWebSchema('DatiCad')?.[field] || {};
}

function cadUniqueValues(values) {
  const result = [];
  values.forEach(value => {
    const normalized = cadText(value);
    if (normalized && !result.includes(normalized)) result.push(normalized);
  });
  return result;
}

function cadComboInfo(field, currentValue = '') {
  const meta = cadDatiCadMeta(field);
  const combo = Array.isArray(meta.Combo) ? meta.Combo : [];
  if (!combo.length) return { values: [], archive: '' };

  if (combo[0] === 'auto_combo') {
    const archive = cadText(combo[1]);
    const archiveField = cadText(combo[2]);
    const extras = combo.slice(3);
    const values = cadArchiveRecords(archive).map(record => record?.[archiveField]);
    return {
      values: cadUniqueValues([currentValue, ...values, ...extras]),
      archive
    };
  }

  return {
    values: cadUniqueValues([currentValue, ...combo]),
    archive: ''
  };
}

function cadTrimNumber(value, decimals = 2) {
  const number = Number(String(value ?? '').replace(',', '.'));
  if (!Number.isFinite(number)) return cadText(value);
  return Number(number.toFixed(decimals)).toString();
}

function cadSymbolPanelValue(symbol, type, config) {
  if (type === 'PON' && config.key === '__FONTE_LUNGHEZZA') {
    const value = cadSymbolAttribute(symbol, 'LUNGHEZZA');
    return value === 'Lunghezza parete' || value === 'Altezza parete'
      ? 'Altezza parete o lunghezza parete'
      : 'Valore imposto';
  }

  if (type === 'LOC' && config.key === '__FONTE_ALTEZZA') {
    return cadSymbolAttribute(symbol, 'ALTEZZALORDA') === 'Da piano' &&
      cadSymbolAttribute(symbol, 'ALTEZZANETTA') === 'Da piano'
      ? 'Da piano'
      : 'Valore imposto';
  }

  if (type === 'LOC' && config.key === '__FONTE_QUOTA') {
    return cadSymbolAttribute(symbol, 'QUOTAPAVIMENTO') === 'Da piano'
      ? 'Da piano'
      : 'Valore imposto';
  }

  const raw = cadSymbolAttribute(symbol, config.key);
  if (config.svgCm) {
    const number = Number(String(raw).replace(',', '.'));
    return Number.isFinite(number) ? cadTrimNumber(number / 100, 2) : raw;
  }

  if (
    type === 'PON' &&
    config.key === 'LUNGHEZZA' &&
    (raw === 'Lunghezza parete' || raw === 'Altezza parete')
  ) return '';

  if (
    type === 'LOC' &&
    ['ALTEZZALORDA','ALTEZZANETTA','QUOTAPAVIMENTO'].includes(config.key) &&
    raw === 'Da piano'
  ) return '';

  return raw;
}

function cadCreateSymbolPanelControl(symbol, type, config) {
  const meta = cadDatiCadMeta(config.field);
  const currentValue = cadSymbolPanelValue(symbol, type, config);
  const comboInfo = cadComboInfo(config.field, currentValue);
  const hasCombo = comboInfo.values.length > 0;
  const control = document.createElement(hasCombo ? 'select' : 'input');

  control.dataset.cadSymbolConfigKey = config.key;
  control.dataset.cadDatiCadField = config.field;

  if (hasCombo) {
    comboInfo.values.forEach(value => {
      const option = document.createElement('option');
      option.value = value;
      option.textContent = value;
      control.appendChild(option);
    });
    control.value = currentValue;
  } else {
    control.type = (meta.NumeroCifre !== undefined || meta.NumeroDecimali !== undefined)
      ? 'number'
      : 'text';
    if (control.type === 'number') {
      const decimals = Number(meta.NumeroDecimali ?? 0);
      control.step = decimals > 0 ? String(1 / Math.pow(10, decimals)) : '1';
    }
    control.value = currentValue;
  }

  control.readOnly = Boolean(meta.ReadOnly);
  control.disabled = Boolean(meta.ReadOnly);
  return { control, comboInfo };
}

function cadUpdateSymbolPanelDependencies(type) {
  if (!cadSymbolFields) return;
  const get = key => cadSymbolFields.querySelector('[data-cad-symbol-config-key="' + key + '"]');

  if (type === 'PON') {
    const source = get('__FONTE_LUNGHEZZA');
    const length = get('LUNGHEZZA');
    if (length) length.disabled = source?.value !== 'Valore imposto';
  }

  if (type === 'LOC') {
    const sourceHeight = get('__FONTE_ALTEZZA');
    const sourceQuota = get('__FONTE_QUOTA');
    ['ALTEZZALORDA','ALTEZZANETTA'].forEach(key => {
      const control = get(key);
      if (control) control.disabled = sourceHeight?.value === 'Da piano';
    });
    const quota = get('QUOTAPAVIMENTO');
    if (quota) quota.disabled = sourceQuota?.value === 'Da piano';
  }
}

function cadRenderSelectedSymbolFields(symbol) {
  if (!cadSymbolFields) return;
  cadSymbolFields.innerHTML = '';

  const type = cadSymbolBlockType(symbol);
  const configs = cadSymbolPanelConfig(type);

  if (cadSymbolSectionTitle) {
    const title = type === 'FIN'
      ? 'Finestre / Porte'
      : type === 'PON'
        ? 'Ponti termici'
        : type === 'LOC'
          ? 'Locali'
          : 'Simbolo di allineamento';
    cadSymbolSectionTitle.textContent = title;
  }

  if (!configs.length) {
    const note = document.createElement('div');
    note.className = 'cad-properties-note';
    note.textContent = 'Questo simbolo non contiene attributi tecnici.';
    cadSymbolFields.appendChild(note);
    return;
  }

  configs.forEach(config => {
    const wrapper = document.createElement('div');
    wrapper.className = 'cad-prop-row';

    const label = document.createElement('label');
    label.textContent = config.label + ':';

    const { control, comboInfo } = cadCreateSymbolPanelControl(symbol, type, config);
    const meta = cadDatiCadMeta(config.field);

    if (config.arc && comboInfo.archive) {
      const controlWrap = document.createElement('div');
      controlWrap.className = 'cad-prop-with-arc';

      const arc = document.createElement('button');
      arc.type = 'button';
      arc.className = 'cad-prop-arc';
      arc.textContent = 'Arc';
      arc.title = 'Apri archivio ' + comboInfo.archive;
      arc.addEventListener('click', () => openArchivioWeb(comboInfo.archive));

      controlWrap.appendChild(control);
      controlWrap.appendChild(arc);
      wrapper.appendChild(label);
      wrapper.appendChild(controlWrap);
    } else {
      wrapper.appendChild(label);
      wrapper.appendChild(control);
    }

    if (config.virtual)
      control.addEventListener('change', () => cadUpdateSymbolPanelDependencies(type));

    if (meta.ReadOnly)
      control.title = 'Campo correlato readonly secondo definizionedati.json';

    cadSymbolFields.appendChild(wrapper);
  });

  cadUpdateSymbolPanelDependencies(type);
}

function cadSetSymbolAttribute(symbol, key, value) {
  const wanted = String(key || '').trim().toUpperCase();
  let target = null;
  for (const child of Array.from(symbol?.children || [])) {
    if (child.localName !== 'tspan') continue;
    const line = cadText(child.textContent);
    const comma = line.indexOf(',');
    if (comma < 0) continue;
    if (line.slice(0, comma).trim().toUpperCase() === wanted) {
      target = child;
      break;
    }
  }

  if (!target) {
    target = cadWorkingDoc.createElementNS(SVG_NS, 'tspan');
    target.setAttribute('x', symbol.getAttribute('x') || '0');
    target.setAttribute('dy', '1.2em');
    symbol.appendChild(target);
  }
  target.textContent = key + ',' + cadText(value);
}

function cadSymbolPanelControlValue(key) {
  return cadText(
    cadSymbolFields?.querySelector('[data-cad-symbol-config-key="' + key + '"]')?.value
  );
}

function cadApplySelectedSymbolProperties() {
  const symbol = cadFindSourceSymbol(cadSelectedSymbolId);
  if (!symbol || !cadSymbolFields) return;

  const type = cadSymbolBlockType(symbol);
  const before = cadSerializeWorkingSvg();

  if (type === 'FIN') {
    cadSetSymbolAttribute(symbol, 'PORTA', cadSymbolPanelControlValue('PORTA'));
    cadSetSymbolAttribute(symbol, 'TIPO', cadSymbolPanelControlValue('TIPO'));
    ['LARGHEZZA','ALTEZZA','SOTTOFINESTRA','SOPRALUCE'].forEach(key => {
      cadSetSymbolAttribute(symbol, key, cadMetersToSvgCm(cadSymbolPanelControlValue(key)));
    });
    cadSetSymbolAttribute(symbol, 'NUMEROANTE', cadSymbolPanelControlValue('NUMEROANTE'));
  }

  if (type === 'PON') {
    const orientamento = cadSymbolPanelControlValue('ORIENTAMENTO');
    const fonte = cadSymbolPanelControlValue('__FONTE_LUNGHEZZA');
    cadSetSymbolAttribute(symbol, 'TIPO', cadSymbolPanelControlValue('TIPO'));
    cadSetSymbolAttribute(symbol, 'ORIENTAMENTO', orientamento);
    cadSetSymbolAttribute(
      symbol,
      'LUNGHEZZA',
      fonte === 'Valore imposto'
        ? cadSymbolPanelControlValue('LUNGHEZZA')
        : (orientamento === 'Orizzontale' ? 'Lunghezza parete' : 'Altezza parete')
    );
  }

  if (type === 'LOC') {
    const fonteAltezza = cadSymbolPanelControlValue('__FONTE_ALTEZZA');
    const fonteQuota = cadSymbolPanelControlValue('__FONTE_QUOTA');

    cadSetSymbolAttribute(symbol, 'DESCR.', cadSymbolPanelControlValue('DESCR.'));
    cadSetSymbolAttribute(symbol, 'ZONA', cadSymbolPanelControlValue('ZONA'));
    cadSetSymbolAttribute(symbol, 'TSOF', cadSymbolPanelControlValue('TSOF'));
    cadSetSymbolAttribute(symbol, 'CSOF', cadSymbolPanelControlValue('CSOF'));
    cadSetSymbolAttribute(symbol, 'CCOPERTURA', cadSymbolPanelControlValue('CCOPERTURA'));
    cadSetSymbolAttribute(symbol, 'TPAV', cadSymbolPanelControlValue('TPAV'));
    cadSetSymbolAttribute(symbol, 'CPAV', cadSymbolPanelControlValue('CPAV'));

    cadSetSymbolAttribute(
      symbol,
      'ALTEZZALORDA',
      fonteAltezza === 'Da piano' ? 'Da piano' : cadSymbolPanelControlValue('ALTEZZALORDA')
    );
    cadSetSymbolAttribute(
      symbol,
      'ALTEZZANETTA',
      fonteAltezza === 'Da piano' ? 'Da piano' : cadSymbolPanelControlValue('ALTEZZANETTA')
    );
    cadSetSymbolAttribute(
      symbol,
      'QUOTAPAVIMENTO',
      fonteQuota === 'Da piano' ? 'Da piano' : cadSymbolPanelControlValue('QUOTAPAVIMENTO')
    );
  }

  const after = cadSerializeWorkingSvg();
  if (after !== before) {
    cadUndoStack.push(before);
    cadRedoStack = [];
    renderCadComparison();
    cadSetStatus(cadSelectedSymbolId + ' · attributi XAML aggiornati', 'dirty');
  } else {
    cadUpdatePropertiesPanel();
    cadSetStatus(cadSelectedSymbolId + ' · attributi invariati');
  }
  cadUpdateControls();
}

function cadLinePoint(line, endpoint) {
  const suffix = endpoint === 1 ? '1' : '2';
  return [
    Number(line.getAttribute(`x${suffix}`)),
    Number(line.getAttribute(`y${suffix}`))
  ];
}

function cadSetLinePoint(line, endpoint, x, y) {
  const suffix = endpoint === 1 ? '1' : '2';
  line.setAttribute(`x${suffix}`, Number(x).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute(`y${suffix}`, Number(y).toFixed(3).replace(/\.000$/, ''));
}

function cadLineCalibrationAxis(line) {
  if (!line) return '';
  const [x1, y1] = cadLinePoint(line, 1);
  const [x2, y2] = cadLinePoint(line, 2);
  if (![x1, y1, x2, y2].every(Number.isFinite)) return '';

  if (Math.abs(y2 - y1) <= CAD_CALIBRATION_ORTHO_EPSILON && Math.abs(x2 - x1) > CAD_CALIBRATION_ORTHO_EPSILON)
    return 'horizontal';
  if (Math.abs(x2 - x1) <= CAD_CALIBRATION_ORTHO_EPSILON && Math.abs(y2 - y1) > CAD_CALIBRATION_ORTHO_EPSILON)
    return 'vertical';
  return '';
}

function cadLineLengthCm(line) {
  if (!line) return 0;
  const [x1, y1] = cadLinePoint(line, 1);
  const [x2, y2] = cadLinePoint(line, 2);
  return Math.hypot(x2 - x1, y2 - y1);
}

function cadScaleCoordinate(value, pivot, factor) {
  const number = Number(value);
  return Number.isFinite(number) ? pivot + (number - pivot) * factor : number;
}

function cadSetSvgNumber(element, attribute, value) {
  if (!element || !Number.isFinite(value)) return;
  element.setAttribute(attribute, Number(value).toFixed(3).replace(/\.000$/, ''));
}

function cadScaleCurrentPlaneGeometry(factor, pivot) {
  const plane = cadCurrentPlane();
  if (!plane || !Number.isFinite(factor) || factor <= 0 || !Array.isArray(pivot)) return;

  cadPlaneScopedEntities().forEach(element => {
    if (cadEntityPlane(element) !== plane) return;

    if (element.localName === 'line') {
      [1, 2].forEach(endpoint => {
        const [x, y] = cadLinePoint(element, endpoint);
        cadSetLinePoint(
          element,
          endpoint,
          cadScaleCoordinate(x, pivot[0], factor),
          cadScaleCoordinate(y, pivot[1], factor)
        );
      });
      return;
    }

    // I simboli mantengono gli attributi tecnici ma seguono geometricamente
    // la nuova scala del piano.
    if (element.localName === 'text') {
      const x = Number(element.getAttribute('x'));
      const y = Number(element.getAttribute('y'));
      const nextX = cadScaleCoordinate(x, pivot[0], factor);
      const nextY = cadScaleCoordinate(y, pivot[1], factor);
      cadSetSvgNumber(element, 'x', nextX);
      cadSetSvgNumber(element, 'y', nextY);

      Array.from(element.children).forEach(child => {
        if (child.localName !== 'tspan') return;
        if (child.hasAttribute('x'))
          cadSetSvgNumber(child, 'x', cadScaleCoordinate(Number(child.getAttribute('x')), pivot[0], factor));
        if (child.hasAttribute('y'))
          cadSetSvgNumber(child, 'y', cadScaleCoordinate(Number(child.getAttribute('y')), pivot[1], factor));
      });
    }
  });

  const background = cadPlaneBackground(cadWorkingDoc, plane);
  if (background) {
    const x = Number(background.getAttribute('x'));
    const y = Number(background.getAttribute('y'));
    const width = Number(background.getAttribute('width'));
    const height = Number(background.getAttribute('height'));

    cadSetSvgNumber(background, 'x', cadScaleCoordinate(x, pivot[0], factor));
    cadSetSvgNumber(background, 'y', cadScaleCoordinate(y, pivot[1], factor));
    if (Number.isFinite(width)) cadSetSvgNumber(background, 'width', width * factor);
    if (Number.isFinite(height)) cadSetSvgNumber(background, 'height', height * factor);
  }
}

function cadGeometryViewBox(doc = cadWorkingDoc, planeName = '') {
  if (!doc) return null;
  let minX = Number.POSITIVE_INFINITY;
  let minY = Number.POSITIVE_INFINITY;
  let maxX = Number.NEGATIVE_INFINITY;
  let maxY = Number.NEGATIVE_INFINITY;

  const addPoint = (x, y) => {
    if (!Number.isFinite(x) || !Number.isFinite(y)) return;
    minX = Math.min(minX, x);
    minY = Math.min(minY, y);
    maxX = Math.max(maxX, x);
    maxY = Math.max(maxY, y);
  };

  cadPlaneScopedEntities(doc).forEach(element => {
    if (planeName && cadEntityPlane(element) !== planeName) return;

    if (element.localName === 'line') {
      addPoint(Number(element.getAttribute('x1')), Number(element.getAttribute('y1')));
      addPoint(Number(element.getAttribute('x2')), Number(element.getAttribute('y2')));
    } else if (element.localName === 'text') {
      addPoint(Number(element.getAttribute('x')), Number(element.getAttribute('y')));
    }
  });

  const backgroundGroup = cadBackgroundContainer(doc, false);
  Array.from(backgroundGroup?.children || []).forEach(image => {
    if (image.localName !== 'image') return;
    if (planeName && cadText(image.getAttribute('data-termodel-piano')) !== planeName) return;
    const x = Number(image.getAttribute('x'));
    const y = Number(image.getAttribute('y'));
    const width = Number(image.getAttribute('width'));
    const height = Number(image.getAttribute('height'));
    addPoint(x, y);
    addPoint(x + width, y + height);
  });

  if (![minX, minY, maxX, maxY].every(Number.isFinite)) return null;

  let width = maxX - minX;
  let height = maxY - minY;
  const fallback = cadParseViewBox(doc.documentElement.getAttribute('viewBox'));
  if (width < 1) width = Math.max(100, fallback?.[2] || 100);
  if (height < 1) height = Math.max(100, fallback?.[3] || 100);

  const margin = Math.max(10, Math.max(width, height) * 0.06);
  return [minX - margin, minY - margin, width + margin * 2, height + margin * 2];
}

function cadUpdateCalibrationPanel(line, northOpen = false) {
  if (!cadBackgroundCalibrationSection) return;

  const axis = line ? cadLineCalibrationAxis(line) : '';
  const show = Boolean(line && axis && !northOpen && !cadSelectedSymbolId);
  cadBackgroundCalibrationSection.hidden = !show;

  if (!show) {
    cadCalibrationLineId = '';
    return;
  }

  const lengthM = cadLineLengthCm(line) / 100;
  const changedReference = cadCalibrationLineId !== line.id;
  cadCalibrationLineId = line.id;

  if (cadCalibrationReference) {
    cadCalibrationReference.textContent =
      line.id + ' · ' +
      (axis === 'horizontal' ? 'orizzontale' : 'verticale') +
      ' · misura attuale ' + lengthM.toFixed(3) + ' m';
  }

  if (changedReference && cadCalibrationRealMeters)
    cadCalibrationRealMeters.value = Number(lengthM.toFixed(3)).toString();

  const hasBackground = Boolean(cadPlaneBackground(cadWorkingDoc, cadCurrentPlane()));
  if (cadCalibrateBackground) cadCalibrateBackground.disabled = !hasBackground;

  if (cadCalibrationNote) {
    cadCalibrationNote.textContent = hasBackground
      ? 'Calibra usa questa parete come riferimento e ridimensiona sfondo, linee e posizioni dei simboli del piano corrente.'
      : 'Aggiungi prima uno sfondo al piano corrente. Le pareti inclinate non sono ammesse come riferimento.';
  }
}

function cadApplyBackgroundCalibration() {
  const line = cadFindSourceLine(cadSelectedLineId);
  const axis = cadLineCalibrationAxis(line);
  if (!line || !axis) {
    cadSetStatus('Calibrazione rifiutata: seleziona una parete orizzontale o verticale.', 'error');
    return;
  }

  if (!cadPlaneBackground(cadWorkingDoc, cadCurrentPlane())) {
    cadSetStatus('Calibrazione impossibile: il piano corrente non ha uno sfondo.', 'error');
    return;
  }

  const realMeters = Number(String(cadCalibrationRealMeters?.value || '').replace(',', '.'));
  if (!Number.isFinite(realMeters) || realMeters <= 0) {
    cadSetStatus('Inserisci una misura reale valida in metri.', 'error');
    cadCalibrationRealMeters?.focus();
    return;
  }

  const currentCm = cadLineLengthCm(line);
  const targetCm = realMeters * 100;
  if (!Number.isFinite(currentCm) || currentCm <= CAD_CALIBRATION_ORTHO_EPSILON) {
    cadSetStatus('Calibrazione impossibile: lunghezza della parete non valida.', 'error');
    return;
  }

  const factor = targetCm / currentCm;
  if (!Number.isFinite(factor) || factor <= 0 || factor < 0.0001 || factor > 10000) {
    cadSetStatus('Fattore di calibrazione fuori intervallo.', 'error');
    return;
  }

  if (Math.abs(factor - 1) < 1e-9) {
    cadSetStatus('La parete è già calibrata alla misura indicata.');
    return;
  }

  const before = cadSerializeWorkingSvg();
  const pivot = cadLinePoint(line, 1);
  const plane = cadCurrentPlane();

  cadScaleCurrentPlaneGeometry(factor, pivot);

  const projectViewBox = cadGeometryViewBox(cadWorkingDoc, '');
  if (projectViewBox) {
    cadWorkingDoc.documentElement.setAttribute('viewBox', cadFormatViewBox(projectViewBox));
    ensureNorthSymbolInSvg(cadWorkingDoc, northOrientationDeg);
  }

  const planeViewBox = cadGeometryViewBox(cadWorkingDoc, plane);
  cadViewportBase = projectViewBox?.slice() || null;
  cadViewport = planeViewBox?.slice() || projectViewBox?.slice() || null;

  cadUndoStack.push(before);
  cadRedoStack = [];
  renderCadComparison();
  cadUpdatePropertiesPanel();
  cadUpdateControls();

  cadSetStatus(
    '✓ Calibrazione ' + plane +
    ' · ' + line.id +
    ' = ' + realMeters.toFixed(3) + ' m' +
    ' · fattore ' + factor.toFixed(6),
    'dirty'
  );
}

function cadUpdatePropertiesPanel() {
  const line = cadFindSourceLine(cadSelectedLineId);
  const symbol = cadFindSourceSymbol(cadSelectedSymbolId);
  const hasDoc = !!cadWorkingDoc;

  if (cadPropertiesEmpty) cadPropertiesEmpty.hidden = hasDoc;
  if (cadPropertiesBody) cadPropertiesBody.hidden = !hasDoc;
  if (!hasDoc) return;

  if (line) {
    const lineState = cadStateFromLine(line);
    cadToolbarState.tipoParete = lineState.tipoParete;
    cadToolbarState.confineParete = lineState.confineParete;
  } else {
    cadEnsureToolbarState();
  }

  const derived = cadRefreshToolbarControls();
  const symbolType = symbol ? cadSymbolBlockType(symbol) : '';
  const northOpen = cadNorthPanelIsOpen();

  if (cadWallPropertiesSection) cadWallPropertiesSection.hidden = Boolean(symbol) || northOpen;
  if (cadWallGeometrySection) cadWallGeometrySection.hidden = Boolean(symbol) || northOpen;
  if (cadSymbolPropertiesSection) cadSymbolPropertiesSection.hidden = !symbol || northOpen;
  cadUpdateCalibrationPanel(line, northOpen);

  if (cadPropertiesHead) {
    if (northOpen)
      cadPropertiesHead.textContent = 'Dati CAD · Nord';
    else if (symbol)
      cadPropertiesHead.textContent = 'Dati CAD · ' + cadSymbolInsertLabel(symbolType) + ' ' + symbol.id;
    else
      cadPropertiesHead.textContent = line ? `Dati CAD · Parete ${line.id}` : 'Dati CAD · Nuova parete';
  }

  if (symbol) {
    const x = Number(symbol.getAttribute('x'));
    const y = Number(symbol.getAttribute('y'));
    if (cadSymbolPosition)
      cadSymbolPosition.value = Number.isFinite(x) && Number.isFinite(y)
        ? `${x.toFixed(1)} / ${y.toFixed(1)} cm`
        : '';
    cadRenderSelectedSymbolFields(symbol);

    if (cadPropStart) cadPropStart.value = '';
    if (cadPropEnd) cadPropEnd.value = '';
    if (cadPropLength) cadPropLength.value = '';
  } else if (line) {
    const [x1, y1] = cadLinePoint(line, 1);
    const [x2, y2] = cadLinePoint(line, 2);
    const lengthCm = Math.hypot(x2 - x1, y2 - y1);

    if (cadPropStart)
      cadPropStart.value = `${x1.toFixed(1)} / ${y1.toFixed(1)} cm`;
    if (cadPropEnd)
      cadPropEnd.value = `${x2.toFixed(1)} / ${y2.toFixed(1)} cm`;
    if (cadPropLength)
      cadPropLength.value = `${lengthCm.toFixed(1)} cm · ${(lengthCm / 100).toFixed(3)} m`;
  } else {
    if (cadPropStart) cadPropStart.value = '';
    if (cadPropEnd) cadPropEnd.value = '';
    if (cadPropLength) cadPropLength.value = '';
    if (cadSymbolPosition) cadSymbolPosition.value = '';
    if (cadSymbolFields) cadSymbolFields.innerHTML = '';
  }

  if (cadPropConfirm)
    cadPropConfirm.disabled = !line;
  if (cadSymbolApply)
    cadSymbolApply.disabled = !symbol || !cadSymbolPanelConfig(symbolType).length;

  if (cadPropColorSwatch)
    cadPropColorSwatch.style.background = derived.colorCss || '#ccc';
}

function cadSetOptionalAttribute(element, name, value) {
  const normalized = String(value ?? '').trim();
  if (normalized) element.setAttribute(name, normalized);
  else element.removeAttribute(name);
}

function cadCommitToolbarToSelectedLine() {
  const line = cadFindSourceLine(cadSelectedLineId);
  if (!line) {
    cadRefreshToolbarControls();
    return;
  }

  const before = cadSerializeWorkingSvg();
  cadApplySemanticAttributes(line, cadToolbarState);
  const after = cadSerializeWorkingSvg();

  if (after !== before) {
    cadUndoStack.push(before);
    cadRedoStack = [];
    renderCadComparison();
    cadSetStatus(`${line.id} · proprietà archivio aggiornate · modifica non rigenerata`, 'dirty');
  } else {
    cadUpdatePropertiesPanel();
    cadSetStatus(`${line.id} · proprietà invariate`);
  }
  cadUpdateControls();
}

function cadWallPropertySelectionChanged() {
  cadToolbarState.tipoParete = cadText(cadPropTipoParete?.value);
  cadToolbarState.confineParete = cadText(cadPropConfineParete?.value);

  cadRefreshToolbarControls();

  if (cadFindSourceLine(cadSelectedLineId))
    cadCommitToolbarToSelectedLine();
  else
    cadSetStatus(`Piano ${cadCurrentPlane()} · valori correnti aggiornati per ＋ Nuova parete`);
}

function cadCurrentPlaneChanged() {
  const requested = cadText(cadPropPiano?.value);
  if (!requested || requested === cadCurrentPlane()) {
    cadRefreshToolbarControls();
    return;
  }

  if (cadToolMode === 'line')
    cadCancelNewLine();
  if (cadToolMode === 'symbol')
    cadCancelSymbolInsert();

  cadCloseNorthPanel(false);
  cadToolbarState.piano = requested;
  cadSelectedLineId = '';
  cadSelectedSymbolId = '';
  cadDragState = null;
  cadRestorePlanePreview();
  cadRefreshToolbarControls();
  renderCadComparison();

  const derived = cadDerivedToolbarValues();
  cadSetStatus(
    `Piano corrente: ${requested}${derived.layer ? ` · Layer ${derived.layer}` : ''}`
  );
}

function cadApplyProperties() {
  cadWallPropertySelectionChanged();
}

function cadSetStatus(message, kind = '') {
  if (!cadEditStatus) return;
  cadEditStatus.textContent = message;
  cadEditStatus.classList.remove('dirty', 'error');
  if (kind) cadEditStatus.classList.add(kind);
}

function cadIsDirty() {
  if (!cadWorkingDoc) return false;
  return cadSerializeWorkingSvg() !== cadCommittedSvg;
}

function cadUpdateControls() {
  const hasDoc = !!cadWorkingDoc;
  const selected = !!cadFindSourceLine(cadSelectedLineId);
  const selectedSymbol = cadFindSourceSymbol(cadSelectedSymbolId);
  const dirty = cadIsDirty();
  const drawingLine = cadToolMode === 'line';
  const insertingSymbol = cadToolMode === 'symbol';
  const busy = drawingLine || insertingSymbol;

  if (cadAddBackground) cadAddBackground.disabled = !hasDoc || busy;
  if (cadShowBackground)
    cadShowBackground.disabled = !hasDoc || !cadPlaneBackground(cadWorkingDoc, cadCurrentPlane());
  if (cadUndo) cadUndo.disabled = !cadUndoStack.length || busy;
  if (cadRedo) cadRedo.disabled = !cadRedoStack.length || busy;
  if (cadDelete) cadDelete.disabled = !selected || busy;
  if (cadRegenerate) cadRegenerate.disabled = !hasDoc || !dirty || busy;
  if (cadNewLine) {
    cadNewLine.disabled = !hasDoc;
    cadNewLine.classList.toggle('active', drawingLine);
    cadNewLine.textContent = drawingLine ? '× Interrompi sequenza' : '＋ Nuova parete';
  }
  [[cadInsertAlign,'ALLINEA'],[cadInsertOpening,'FIN'],[cadInsertBridge,'PON'],[cadInsertRoom,'LOC']].forEach(pair => {
    const button = pair[0];
    const type = pair[1];
    if (!button) return;
    const active = insertingSymbol && cadSymbolInsertType === type;
    button.disabled = !hasDoc;
    button.classList.toggle('active', active);
    button.textContent = active
      ? '× ' + cadSymbolInsertLabel(type)
      : '＋ ' + cadSymbolInsertLabel(type);
  });
  if (cadCanvas) {
    cadCanvas.classList.toggle('symbol-insert-mode', insertingSymbol);
    cadCanvas.classList.toggle('wall-insert-mode', drawingLine);
  }
  if (cadNewLineType) cadNewLineType.disabled = !hasDoc || busy;
  if (cadExportArchitectural) cadExportArchitectural.disabled = !lastGeneratedPlan || dirty || busy;

  if (!hasDoc) cadSetStatus('Genera prima una pianta');
  else if (drawingLine) {
    const tipo = (cadNewLineType?.value || 'W').toUpperCase();
    cadSetStatus(cadNewLineState ? ('Piano ' + cadCurrentPlane() + ' · Parete ' + tipo + ' · clicca il punto successivo · tasto destro per interrompere') : ('Piano ' + cadCurrentPlane() + ' · Parete ' + tipo + ' · clicca il punto iniziale'));
  } else if (insertingSymbol) {
    const needsWall = cadSymbolInsertType === 'FIN' || cadSymbolInsertType === 'PON';
    cadSetStatus(
      'Piano ' + cadCurrentPlane() +
      ' · Layer ' + cadCurrentLayer() +
      ' · ' + cadSymbolInsertLabel(cadSymbolInsertType) +
      (needsWall ? ' · clicca vicino a una parete' : ' · clicca il punto di inserimento')
    );
  } else if (dirty) {
    cadSetStatus(
      cadSelectedSymbolId
        ? (cadSelectedSymbolId + ' · simbolo selezionato · modifica non rigenerata')
        : (cadSelectedLineId ? (cadSelectedLineId + ' · modifica non rigenerata') : 'Modifica non rigenerata'),
      'dirty'
    );
  } else if (selectedSymbol) {
    cadSetStatus(cadSelectedSymbolId + ' · ' + cadSymbolInsertLabel(cadSymbolBlockType(selectedSymbol)) + ' selezionato');
  } else if (selected) {
    const line = cadFindSourceLine(cadSelectedLineId);
    const p1 = cadLinePoint(line, 1);
    const p2 = cadLinePoint(line, 2);
    cadSetStatus(cadSelectedLineId + ' · (' + p1[0].toFixed(1) + ', ' + p1[1].toFixed(1) + ') → (' + p2[0].toFixed(1) + ', ' + p2[1].toFixed(1) + ')');
  } else {
    cadSetStatus('Piano ' + cadCurrentPlane() + ' · Layer ' + cadCurrentLayer() + ' · seleziona una parete o inserisci una nuova entità');
  }
}
function cadSetWorkingSvg(svgText) {
  cadWorkingDoc = cadParseSvg(svgText);
  cadToolbarState = cadDefaultToolbarState();
  cadCleanPlanByPlane = new Map();
  cadGeneratedPlanByPlane = new Map();

  cadSyncNorthFromWorkingDoc();
  const normalized = cadNormalizePlaneAssignments();
  const current = cadCurrentPlane();
  if (lastCleanPlanSvg) cadCleanPlanByPlane.set(current, lastCleanPlanSvg);
  if (lastGeneratedPlan) cadGeneratedPlanByPlane.set(current, lastGeneratedPlan);

  cadCommittedSvg = cadSerializeWorkingSvg();
  cadSelectedLineId = '';
  cadSelectedSymbolId = '';
  cadUndoStack = [];
  cadRedoStack = [];
  cadDragState = null;
  cadViewportBase = null;
  cadViewport = null;
  cadPanState = null;
  cadCalibrationLineId = '';
  cadCanvas?.classList.remove('pan-mode');
  cadToolMode = 'select';
  cadNewLineState = null;
  cadSymbolInsertType = '';
  cadCloseNorthPanel(false);

  if (normalized)
    console.info(`CAD multipiano: assegnate ${normalized} entità legacy al piano "${current}".`);

  cadUpdatePropertiesPanel();
  cadUpdateControls();
}

function cadPointDistance(a, b) {
  return Math.hypot(a[0] - b[0], a[1] - b[1]);
}

function cadNearestPointOnSegment(point, a, b) {
  const vx = b[0] - a[0];
  const vy = b[1] - a[1];
  const len2 = vx * vx + vy * vy;
  if (len2 <= 1e-12) return a.slice();
  let t = ((point[0] - a[0]) * vx + (point[1] - a[1]) * vy) / len2;
  t = Math.max(0, Math.min(1, t));
  return [a[0] + t * vx, a[1] + t * vy];
}

function cadSnapPoint(point, movingLineId) {
  if (cadSnap?.checked === false)
    return { point, snapped: false, targetLineId: '' };

  let best = point;
  let bestDistance = CAD_SNAP_DISTANCE + 1;
  let bestLineId = '';

  cadEditableSourceLines().forEach(line => {
    if (line.id === movingLineId) return;
    const a = cadLinePoint(line, 1);
    const b = cadLinePoint(line, 2);

    for (const candidate of [a, b]) {
      const distance = cadPointDistance(point, candidate);
      if (distance < bestDistance) {
        best = candidate.slice();
        bestDistance = distance;
        bestLineId = line.id || '';
      }
    }

    const projected = cadNearestPointOnSegment(point, a, b);
    const segmentDistance = cadPointDistance(point, projected);
    if (segmentDistance < bestDistance) {
      best = projected;
      bestDistance = segmentDistance;
      bestLineId = line.id || '';
    }
  });

  const snapped = bestDistance <= CAD_SNAP_DISTANCE;
  return {
    point: snapped ? best : point,
    snapped,
    targetLineId: snapped ? bestLineId : ''
  };
}

function cadOrthoPoint(point, start) {
  const dx = point[0] - start[0];
  const dy = point[1] - start[1];

  // La direzione dominante decide automaticamente orizzontale/verticale.
  return Math.abs(dx) >= Math.abs(dy)
    ? [point[0], start[1]]
    : [start[0], point[1]];
}

function cadNewLineTargetPoint(rawPoint) {
  // Il primo punto continua a usare il normale Snap.
  if (!cadNewLineState || cadOrtho?.checked !== true) {
    const snapped = cadSnapPoint(rawPoint, '');
    return { ...snapped, ortho: false };
  }

  const start = cadNewLineState.start;
  const constrained = cadOrthoPoint(rawPoint, start);
  const snapped = cadSnapPoint(constrained, '');

  // Snap e Orto convivono solo se il punto agganciato rispetta davvero
  // lo stesso asse ortogonale. In caso contrario prevale Orto.
  if (snapped.snapped) {
    const snappedOrtho = cadOrthoPoint(snapped.point, start);
    if (cadPointDistance(snapped.point, snappedOrtho) <= CAD_JOIN_EPSILON) {
      return {
        point: snapped.point,
        snapped: true,
        ortho: true,
        targetLineId: snapped.targetLineId || ''
      };
    }
  }

  return { point: constrained, snapped: false, ortho: true, targetLineId: '' };
}

function cadConnectedEndpointRefs(point) {
  const refs = [];
  cadEditableSourceLines().forEach(line => {
    [1, 2].forEach(endpoint => {
      const current = cadLinePoint(line, endpoint);
      if (cadPointDistance(current, point) <= CAD_JOIN_EPSILON) {
        refs.push({
          line,
          endpoint,
          x: current[0],
          y: current[1]
        });
      }
    });
  });
  return refs;
}

function cadNextLineId(prefix) {
  const p = String(prefix || 'W').toUpperCase();
  let max = 0;
  const used = new Set();

  cadAllSourceLines().forEach(line => {
    used.add(line.id);
    const match = new RegExp('^' + p + '(\\d+)$', 'i').exec(line.id || '');
    if (match) max = Math.max(max, Number(match[1]) || 0);
  });

  let n = max + 1;
  let id = p + String(n).padStart(3, '0');
  while (used.has(id)) {
    n++;
    id = p + String(n).padStart(3, '0');
  }
  return id;
}

function cadHideContextMenu() {
  if (cadContextMenu) cadContextMenu.hidden = true;
}

function cadCanCloseWallSequence() {
  return cadToolMode === 'line' &&
    !!cadNewLineState?.sequenceStart &&
    !!cadNewLineState?.firstLineId &&
    Number(cadNewLineState?.segmentCount || 0) >= 3;
}

function cadPositionContextMenu(event, height) {
  if (!cadContextMenu) return;
  const width = 180;
  cadContextMenu.style.left = Math.max(0, Math.min(event.clientX, window.innerWidth - width - 4)) + 'px';
  cadContextMenu.style.top = Math.max(0, Math.min(event.clientY, window.innerHeight - height - 4)) + 'px';
  cadContextMenu.hidden = false;
}

function cadShowIdleContextMenu(event) {
  if (!cadContextMenu || cadToolMode !== 'select') return;
  if (cadRepeatLastCommand) {
    cadRepeatLastCommand.hidden = false;
    cadRepeatLastCommand.disabled = !cadLastRepeatableCommand;
  }
  if (cadCloseSequence) cadCloseSequence.hidden = true;
  if (cadCloseOrthogonalSequence) cadCloseOrthogonalSequence.hidden = true;
  if (cadStopSequence) cadStopSequence.hidden = true;
  cadPositionContextMenu(event, 36);
}

function cadShowLineContextMenu(event) {
  if (!cadContextMenu || cadToolMode !== 'line') return;
  const canClose = cadCanCloseWallSequence();
  if (cadRepeatLastCommand) cadRepeatLastCommand.hidden = true;
  if (cadCloseSequence) cadCloseSequence.hidden = !canClose;
  if (cadCloseOrthogonalSequence) cadCloseOrthogonalSequence.hidden = !canClose;
  if (cadStopSequence) cadStopSequence.hidden = false;
  cadPositionContextMenu(event, canClose ? 108 : 36);
}

function cadCancelNewLine(svg = cadCanvas?.querySelector('svg')) {
  cadHideContextMenu();
  cadToolMode = 'select';
  cadNewLineState = null;
  if (svg) {
    svg.querySelector('#cadNewLinePreviewLayer')?.remove();
    cadSyncOverlay(svg);
  }
  cadUpdateControls();
}

function cadToggleNewLine() {
  if (!cadWorkingDoc) return;

  if (cadToolMode === 'line') {
    cadCancelNewLine();
    return;
  }

  cadLastRepeatableCommand = 'line';
  cadCloseNorthPanel(false);
  cadSymbolInsertType = '';
  cadToolMode = 'line';
  cadNewLineState = null;
  cadSelectedLineId = '';
  cadEnsureToolbarState();
  const svg = cadCanvas?.querySelector('svg');
  if (svg) cadSyncOverlay(svg);
  cadUpdatePropertiesPanel();
  cadUpdateControls();
}

function cadRepeatLastCadCommand() {
  if (cadToolMode !== 'select' || !cadLastRepeatableCommand) return;

  cadHideContextMenu();

  if (cadLastRepeatableCommand === 'line') {
    cadToggleNewLine();
    return;
  }

  const match = /^symbol:(ALLINEA|FIN|PON|LOC)$/.exec(cadLastRepeatableCommand);
  if (match) cadToggleSymbolInsert(match[1]);
}

function cadRenderNewLineFirstPointPreview(svg, rawPoint) {
  svg.querySelector('#cadNewLinePreviewLayer')?.remove();
  if (cadToolMode !== 'line' || cadNewLineState) return { point: rawPoint, snapped: false };

  const snapped = cadSnapPoint(rawPoint, '');
  if (!snapped.snapped) return snapped;

  const layer = svgNode('g', {
    id: 'cadNewLinePreviewLayer',
    'pointer-events': 'none'
  });

  layer.appendChild(svgNode('circle', {
    cx: snapped.point[0],
    cy: snapped.point[1],
    r: 10,
    class: 'cad-snap-marker'
  }));

  svg.appendChild(layer);
  return snapped;
}

function cadRenderNewLinePreview(svg, currentPoint = null, snapped = false) {
  svg.querySelector('#cadNewLinePreviewLayer')?.remove();
  if (cadToolMode !== 'line' || !cadNewLineState) return;

  const layer = svgNode('g', {
    id: 'cadNewLinePreviewLayer',
    'pointer-events': 'none'
  });
  const [x1, y1] = cadNewLineState.start;

  layer.appendChild(svgNode('circle', {
    cx: x1, cy: y1, r: 7,
    class: 'cad-newline-start'
  }));

  if (currentPoint) {
    layer.appendChild(svgNode('line', {
      x1, y1,
      x2: currentPoint[0],
      y2: currentPoint[1],
      class: 'cad-newline-preview'
    }));

    if (snapped) {
      layer.appendChild(svgNode('circle', {
        cx: currentPoint[0],
        cy: currentPoint[1],
        r: 10,
        class: 'cad-snap-marker'
      }));
    }
  }

  svg.appendChild(layer);
}

function cadStartOrFinishNewLine(svg, rawPoint) {
  const snapped = cadNewLineTargetPoint(rawPoint);
  const point = snapped.point;

  if (!cadNewLineState) {
    cadNewLineState = {
      start: point.slice(),
      before: cadSerializeWorkingSvg(),
      sequenceStart: point.slice(),
      firstLineId: '',
      lastLineId: '',
      segmentCount: 0
    };
    cadRenderNewLinePreview(svg, point, snapped.snapped);
    cadSetStatus(
      `Parete ${(cadNewLineType?.value || 'W').toUpperCase()} · punto iniziale${snapped.snapped ? ' · SNAP' : ''}${cadOrtho?.checked ? ' · ORTO' : ''} · clicca il punto successivo`
    );
    return;
  }

  if (cadPointDistance(cadNewLineState.start, point) < 0.5) {
    cadSetStatus('La nuova parete deve avere una lunghezza maggiore di zero.', 'error');
    return;
  }

  const group = cadCalpestabile();
  if (!group) {
    cadSetStatus('Gruppo calpestabile non trovato nello SVG.', 'error');
    cadCancelNewLine(svg);
    return;
  }

  const previousLastLineId = cadNewLineState.lastLineId || '';
  const snapTargetLineId = snapped.targetLineId || '';
  const stopSequenceOnWallSnap =
    snapped.snapped &&
    !!snapTargetLineId &&
    snapTargetLineId !== previousLastLineId;

  const type = (cadNewLineType?.value || 'W').toUpperCase() === 'E' ? 'E' : 'W';
  const id = cadNextLineId(type);
  const [x1, y1] = cadNewLineState.start;

  const line = cadWorkingDoc.createElementNS(SVG_NS, 'line');
  line.setAttribute('id', id);
  line.setAttribute('x1', Number(x1).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('y1', Number(y1).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('x2', Number(point[0]).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('y2', Number(point[1]).toFixed(3).replace(/\.000$/, ''));
  cadEnsureToolbarState();
  cadApplySemanticAttributes(line, cadToolbarState);
  group.appendChild(line);

  cadUndoStack.push(cadNewLineState.before);
  cadRedoStack = [];
  cadSelectedLineId = id;

  const sequenceStart = cadNewLineState.sequenceStart?.slice() || [x1, y1];
  const firstLineId = cadNewLineState.firstLineId || id;
  const lastLineId = id;
  const segmentCount = Number(cadNewLineState.segmentCount || 0) + 1;

  // Se il nuovo segmento termina con Snap su una parete diversa
  // dall'ultima parete della sequenza, la connessione conclude la multilinea.
  if (stopSequenceOnWallSnap) {
    cadToolMode = 'select';
    cadNewLineState = null;
    renderCadComparison();
    cadUpdatePropertiesPanel();
    cadUpdateControls();
    cadSetStatus(
      `✓ ${id} creata${snapped.ortho ? ' · ORTO' : ''} · SNAP su ${snapTargetLineId} · sequenza terminata`,
      'dirty'
    );
    return;
  }

  // Modalità multilinea: il punto finale appena confermato diventa
  // automaticamente il punto iniziale del segmento successivo.
  // Manteniamo anche origine, prima parete e numero segmenti della sequenza.
  cadToolMode = 'line';
  cadNewLineState = {
    start: point.slice(),
    before: cadSerializeWorkingSvg(),
    sequenceStart,
    firstLineId,
    lastLineId,
    segmentCount
  };

  renderCadComparison();
  const nextSvg = cadCanvas?.querySelector('svg');
  if (nextSvg) cadRenderNewLinePreview(nextSvg, point, false);
  cadSetStatus(
    `✓ ${id} creata${snapped.ortho ? ' · ORTO' : ''}${snapped.snapped ? ' · SNAP' : ''} · continua dal punto finale · tasto destro per interrompere`,
    'dirty'
  );
}

function cadOrthogonalCloseCandidate(lastLine, start, sequenceStart) {
  if (!lastLine || !start || !sequenceStart) return null;

  const previousStart = cadLinePoint(lastLine, 1);
  const candidates = [
    {
      point: [sequenceStart[0], start[1]],
      axis: 'verticale',
      shift: Math.abs(start[0] - sequenceStart[0])
    },
    {
      point: [start[0], sequenceStart[1]],
      axis: 'orizzontale',
      shift: Math.abs(start[1] - sequenceStart[1])
    }
  ];

  return candidates
    .filter(candidate =>
      cadPointDistance(previousStart, candidate.point) >= 0.5 &&
      cadPointDistance(candidate.point, sequenceStart) >= 0.5
    )
    .sort((a, b) => a.shift - b.shift)[0] || null;
}

function cadCloseWallSequence(orthogonal = false) {
  if (!cadCanCloseWallSequence() || !cadWorkingDoc) return;

  const group = cadCalpestabile();
  const firstLine = cadFindSourceLine(cadNewLineState.firstLineId);
  const lastLine = orthogonal
    ? cadFindSourceLine(cadNewLineState.lastLineId || cadSelectedLineId)
    : null;
  let start = cadNewLineState.start?.slice();
  const sequenceStart = cadNewLineState.sequenceStart?.slice();

  if (!group || !firstLine || !start || !sequenceStart || (orthogonal && !lastLine)) {
    cadSetStatus('Impossibile chiudere la sequenza pareti.', 'error');
    return;
  }

  cadHideContextMenu();

  // Se l'ultimo punto coincide già con l'origine non generiamo una parete nulla:
  // terminiamo semplicemente la sequenza.
  if (cadPointDistance(start, sequenceStart) < 0.5) {
    cadToolMode = 'select';
    cadNewLineState = null;
    renderCadComparison();
    cadUpdateControls();
    cadSetStatus('Sequenza pareti già chiusa.', 'dirty');
    return;
  }

  const before = cadSerializeWorkingSvg();
  let orthogonalAxis = '';

  if (orthogonal) {
    const candidate = cadOrthogonalCloseCandidate(lastLine, start, sequenceStart);
    if (!candidate) {
      cadSetStatus('Chiusura ortogonale impossibile senza annullare una parete.', 'error');
      return;
    }

    // Il vertice finale è condiviso: spostiamo insieme l'arrivo della
    // parete precedente e la partenza della parete di chiusura.
    const lastEnd = cadLinePoint(lastLine, 2);
    const lastStart = cadLinePoint(lastLine, 1);
    let endpoint = 0;
    if (cadPointDistance(lastEnd, start) <= CAD_JOIN_EPSILON) endpoint = 2;
    else if (cadPointDistance(lastStart, start) <= CAD_JOIN_EPSILON) endpoint = 1;

    if (!endpoint) {
      cadSetStatus('Chiusura ortogonale impossibile: ultimo vertice non riconosciuto.', 'error');
      return;
    }

    cadSetLinePoint(lastLine, endpoint, candidate.point[0], candidate.point[1]);
    cadNewLineState.start = candidate.point.slice();
    start = candidate.point.slice();
    orthogonalAxis = candidate.axis;
  }

  const type = /^E/i.test(firstLine.id || '') ? 'E' : 'W';
  const id = cadNextLineId(type);
  const line = cadWorkingDoc.createElementNS(SVG_NS, 'line');
  line.setAttribute('id', id);
  line.setAttribute('x1', Number(start[0]).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('y1', Number(start[1]).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('x2', Number(sequenceStart[0]).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('y2', Number(sequenceStart[1]).toFixed(3).replace(/\.000$/, ''));

  // La parete di chiusura eredita i dati semantici dalla prima parete
  // memorizzata della sequenza.
  cadApplySemanticAttributes(line, cadStateFromLine(firstLine));
  group.appendChild(line);

  cadUndoStack.push(before);
  cadRedoStack = [];
  cadSelectedLineId = id;
  cadToolMode = 'select';
  cadNewLineState = null;

  renderCadComparison();
  cadUpdateControls();
  cadSetStatus(
    orthogonal
      ? `✓ Sequenza chiusa ortogonalmente con ${id} · chiusura ${orthogonalAxis}`
      : `✓ Sequenza chiusa con ${id} · ultimo punto collegato all'inizio`,
    'dirty'
  );
}

function cadParseViewBox(value) {
  const values = String(value || '').trim().split(/[ ,]+/).map(Number);
  return values.length === 4 && values.every(Number.isFinite) ? values : null;
}

function cadViewBoxEqual(a, b, epsilon = 1e-6) {
  return Array.isArray(a) && Array.isArray(b) && a.length === 4 && b.length === 4 &&
    a.every((value, index) => Math.abs(value - b[index]) <= epsilon);
}

function cadFormatViewBox(values) {
  return values.map(value => Number(value.toFixed(6))).join(' ');
}

function cadEnsureViewport(sourceViewBox) {
  const source = Array.isArray(sourceViewBox) ? sourceViewBox.slice() : null;
  if (!source || source.length !== 4) return null;

  if (!cadViewportBase || !cadViewport || !cadViewBoxEqual(cadViewportBase, source)) {
    cadViewportBase = source.slice();
    cadViewport = source.slice();
  }

  return cadViewport.slice();
}

function cadApplyViewport(svg, values) {
  if (!svg || !Array.isArray(values) || values.length !== 4) return;
  cadViewport = values.slice();
  svg.setAttribute('viewBox', cadFormatViewBox(cadViewport));
}

function cadZoomAtPointer(svg, event) {
  if (!svg) return;
  event.preventDefault();

  const current = cadViewport?.slice() || cadParseViewBox(svg.getAttribute('viewBox'));
  const base = cadViewportBase?.slice() || current?.slice();
  if (!current || !base || current[2] <= 0 || current[3] <= 0 || base[2] <= 0) return;

  const world = cadClientPoint(svg, event);
  const currentRatio = current[2] / base[2];
  const requestedFactor = Math.max(0.5, Math.min(2, Math.exp(event.deltaY * 0.0015)));
  const targetRatio = Math.max(0.02, Math.min(50, currentRatio * requestedFactor));
  const factor = targetRatio / currentRatio;

  if (Math.abs(factor - 1) < 1e-9) return;

  const nextWidth = current[2] * factor;
  const nextHeight = current[3] * factor;
  const relX = (world[0] - current[0]) / current[2];
  const relY = (world[1] - current[1]) / current[3];

  cadApplyViewport(svg, [
    world[0] - relX * nextWidth,
    world[1] - relY * nextHeight,
    nextWidth,
    nextHeight
  ]);
}

function cadStartPan(svg, event) {
  if (!svg || event.button !== 1 || cadDragState) return false;

  const current = cadViewport?.slice() || cadParseViewBox(svg.getAttribute('viewBox'));
  if (!current) return false;

  event.preventDefault();
  event.stopImmediatePropagation();

  cadPanState = {
    pointerId: event.pointerId,
    lastClientX: event.clientX,
    lastClientY: event.clientY
  };

  cadCanvas?.classList.add('pan-mode');
  if (svg.setPointerCapture) {
    try { svg.setPointerCapture(event.pointerId); } catch (_) {}
  }
  return true;
}

function cadMovePan(svg, event) {
  if (!cadPanState || cadPanState.pointerId !== event.pointerId) return false;

  event.preventDefault();

  const matrix = svg.getScreenCTM();
  if (!matrix) return true;
  const inverse = matrix.inverse();

  const dxClient = event.clientX - cadPanState.lastClientX;
  const dyClient = event.clientY - cadPanState.lastClientY;
  const dxWorld = inverse.a * dxClient + inverse.c * dyClient;
  const dyWorld = inverse.b * dxClient + inverse.d * dyClient;

  const current = cadViewport?.slice() || cadParseViewBox(svg.getAttribute('viewBox'));
  if (current) {
    current[0] -= dxWorld;
    current[1] -= dyWorld;
    cadApplyViewport(svg, current);
  }

  cadPanState.lastClientX = event.clientX;
  cadPanState.lastClientY = event.clientY;
  return true;
}

function cadFinishPan(svg, event) {
  if (!cadPanState || cadPanState.pointerId !== event.pointerId) return false;

  cadPanState = null;
  cadCanvas?.classList.remove('pan-mode');
  if (svg?.releasePointerCapture) {
    try { svg.releasePointerCapture(event.pointerId); } catch (_) {}
  }
  return true;
}

function cadClientPoint(svg, event) {
  const point = svg.createSVGPoint();
  point.x = event.clientX;
  point.y = event.clientY;
  const matrix = svg.getScreenCTM();
  if (!matrix) return [0, 0];
  const local = point.matrixTransform(matrix.inverse());
  return [local.x, local.y];
}

function cadSelectLine(id, svg = cadCanvas?.querySelector('svg')) {
  cadSelectedLineId = cadFindSourceLine(id) ? id : '';
  if (cadSelectedLineId) {
    cadSelectedSymbolId = '';
    cadCloseNorthPanel(false);
  }
  if (svg) cadSyncOverlay(svg);
  cadUpdatePropertiesPanel();
  cadUpdateControls();
}

function cadSelectSymbol(id, svg = cadCanvas?.querySelector('svg')) {
  cadSelectedSymbolId = cadFindSourceSymbol(id) ? id : '';
  if (cadSelectedSymbolId) {
    cadSelectedLineId = '';
    cadCloseNorthPanel(false);
  }
  if (svg) cadSyncOverlay(svg);
  cadUpdatePropertiesPanel();
  cadUpdateControls();
}

function cadRenderSelectionHandles(svg) {
  svg.querySelector('#cadHandlesLayer')?.remove();
  if (cadToolMode === 'line') return;
  const line = cadFindSourceLine(cadSelectedLineId);
  if (!line) return;

  const handles = svgNode('g', { id: 'cadHandlesLayer' });
  [1, 2].forEach(endpoint => {
    const [x, y] = cadLinePoint(line, endpoint);
    const handle = svgNode('circle', {
      cx: x,
      cy: y,
      r: 8,
      class: 'cad-handle',
      'data-cad-handle': endpoint
    });

    handle.addEventListener('pointerdown', event => {
      if (event.button !== 0) return;
      if (cadToolMode === 'line') return;
      event.preventDefault();
      event.stopPropagation();
      const selected = cadFindSourceLine(cadSelectedLineId);
      if (!selected) return;

      const anchor = cadLinePoint(selected, endpoint);
      cadDragState = {
        mode: 'endpoint',
        pointerId: event.pointerId,
        lineId: selected.id,
        endpoint,
        before: cadSerializeWorkingSvg(),
        refs: cadConnectedEndpointRefs(anchor),
        moved: false
      };
      if (svg.setPointerCapture) {
        try { svg.setPointerCapture(event.pointerId); } catch (_) {}
      }
    });
    handles.appendChild(handle);
  });

  svg.appendChild(handles);
}

function cadSyncOverlay(svg) {
  if (!svg || !cadWorkingDoc) return;

  svg.querySelectorAll('[data-cad-id]').forEach(displayLine => {
    const id = displayLine.getAttribute('data-cad-id');
    const source = cadFindSourceLine(id);
    if (!source) {
      displayLine.remove();
      return;
    }

    const [x1, y1] = cadLinePoint(source, 1);
    const [x2, y2] = cadLinePoint(source, 2);
    displayLine.setAttribute('x1', x1);
    displayLine.setAttribute('y1', y1);
    displayLine.setAttribute('x2', x2);
    displayLine.setAttribute('y2', y2);

    const style = cadLineDisplayStyle(source);
    displayLine.setAttribute('stroke', style.color);
    if (style.dash) displayLine.setAttribute('stroke-dasharray', style.dash);
    else displayLine.removeAttribute('stroke-dasharray');

    displayLine.classList.toggle('selected', id === cadSelectedLineId);

    const label = svg.querySelector(`[data-cad-label="${CSS.escape(id)}"]`);
    if (label) {
      label.setAttribute('x', (x1 + x2) / 2);
      label.setAttribute('y', (y1 + y2) / 2 - 8);
      label.setAttribute('fill', style.color);
    }
  });

  svg.querySelectorAll('[data-cad-symbol-id]').forEach(displaySymbol => {
    const id = displaySymbol.getAttribute('data-cad-symbol-id');
    displaySymbol.classList.toggle('selected', id === cadSelectedSymbolId);
  });

  cadRenderSelectionHandles(svg);
  cadUpdatePropertiesPanel();
  cadUpdateControls();
}

function cadInstallPointerEditing(svg) {
  // Navigazione CAD senza pulsanti UI:
  // rotella = zoom sul cursore, tasto centrale + drag = pan.
  svg.addEventListener('wheel', event => cadZoomAtPointer(svg, event), { passive: false });

  // Impedisce l'autoscroll del browser sul clic della rotella.
  svg.addEventListener('mousedown', event => {
    if (event.button === 1) event.preventDefault();
  });
  svg.addEventListener('auxclick', event => {
    if (event.button === 1) event.preventDefault();
  });

  // Il pan con tasto centrale ha priorità su selezione/inserimento/drag.
  svg.addEventListener('pointerdown', event => {
    if (event.button === 1) cadStartPan(svg, event);
  }, true);

  // Il tasto destro usa un menu CAD contestuale:
  // - in modalità parete: chiusura/interruzione sequenza;
  // - in stato neutro: ripetizione dell'ultimo comando ripetibile.
  svg.addEventListener('contextmenu', event => {
    if (cadToolMode === 'line') {
      event.preventDefault();
      event.stopPropagation();
      cadShowLineContextMenu(event);
      return;
    }

    if (cadToolMode === 'select') {
      event.preventDefault();
      event.stopPropagation();
      cadShowIdleContextMenu(event);
      return;
    }

    cadHideContextMenu();
  });

  // Le modalità di inserimento intercettano il click sinistro prima delle singole entità.
  svg.addEventListener('pointerdown', event => {
    if (event.button !== 0) return;
    cadHideContextMenu();
    if (cadToolMode === 'symbol') {
      event.preventDefault();
      event.stopPropagation();
      cadInsertSymbolAtPoint(cadClientPoint(svg, event));
      return;
    }
    if (cadToolMode !== 'line') return;
    event.preventDefault();
    event.stopPropagation();
    cadStartOrFinishNewLine(svg, cadClientPoint(svg, event));
  }, true);

  svg.addEventListener('pointermove', event => {
    if (cadMovePan(svg, event)) return;

    if (cadToolMode === 'line') {
      const rawPoint = cadClientPoint(svg, event);

      if (!cadNewLineState) {
        const snapped = cadRenderNewLineFirstPointPreview(svg, rawPoint);
        cadSetStatus(
          `Parete ${(cadNewLineType?.value || 'W').toUpperCase()} · clicca il punto iniziale${snapped.snapped ? ' · SNAP' : ''}`
        );
        return;
      }

      const snapped = cadNewLineTargetPoint(rawPoint);
      cadRenderNewLinePreview(svg, snapped.point, snapped.snapped);
      cadSetStatus(
        `Parete ${(cadNewLineType?.value || 'W').toUpperCase()} · clicca il punto successivo${snapped.ortho ? ' · ORTO' : ''}${snapped.snapped ? ' · SNAP' : ''}`
      );
      return;
    }

    if (!cadDragState || cadDragState.pointerId !== event.pointerId) return;

    const point = cadClientPoint(svg, event);

    if (cadDragState.mode === 'endpoint') {
      const snapped = cadSnapPoint(point, cadDragState.lineId);
      cadDragState.refs.forEach(ref => {
        cadSetLinePoint(ref.line, ref.endpoint, snapped.point[0], snapped.point[1]);
      });
      cadDragState.moved = true;
      cadSyncOverlay(svg);
      cadSetStatus(
        `${cadDragState.lineId} · estremo ${cadDragState.endpoint}${snapped.snapped ? ' · SNAP' : ''}`,
        'dirty'
      );
    } else if (cadDragState.mode === 'line') {
      const dx = point[0] - cadDragState.startPointer[0];
      const dy = point[1] - cadDragState.startPointer[1];

      cadDragState.refs.forEach(ref => {
        cadSetLinePoint(ref.line, ref.endpoint, ref.x + dx, ref.y + dy);
      });
      cadDragState.moved = true;
      cadSyncOverlay(svg);
      cadSetStatus(`${cadDragState.lineId} · spostamento parete`, 'dirty');
    }
  });

  const finishDrag = event => {
    if (cadFinishPan(svg, event)) return;
    if (!cadDragState || cadDragState.pointerId !== event.pointerId) return;

    if (cadDragState.moved) {
      cadUndoStack.push(cadDragState.before);
      cadRedoStack = [];
    }

    cadDragState = null;
    if (svg.releasePointerCapture) {
      try { svg.releasePointerCapture(event.pointerId); } catch (_) {}
    }
    cadUpdateControls();
  };

  svg.addEventListener('pointerup', finishDrag);
  svg.addEventListener('pointercancel', finishDrag);

  svg.addEventListener('pointerdown', event => {
    if (event.button !== 0) return;
    if (cadToolMode === 'line' || cadToolMode === 'symbol') return;
    if (event.target === svg || event.target.getAttribute('data-cad-background') === '1') {
      cadSelectedSymbolId = '';
      cadSelectLine('', svg);
    }
  });
}

function applyCadLayerVisibility() {
  if (!cadCanvas) return;
  const background = cadCanvas.querySelector('#cadImportedBackgroundLayer');
  const input = cadCanvas.querySelector('#cadInputLayer');

  if (background) background.style.display = cadShowBackground?.checked === false ? 'none' : '';
  if (input) input.style.display = cadShowInput?.checked === false ? 'none' : '';

  const handles = cadCanvas.querySelector('#cadHandlesLayer');
  if (handles) handles.style.display = cadShowInput?.checked === false ? 'none' : '';
}

function renderCadComparison() {
  if (!cadCanvas) return;

  cadCanvas.innerHTML = '';
  if (!cadWorkingDoc) {
    const empty = document.createElement('div');
    empty.className = 'cad-empty';
    empty.textContent = 'Nessun disegno CAD disponibile.';
    cadCanvas.appendChild(empty);
    cadUpdateControls();
    return;
  }

  const inputRoot = cadWorkingDoc.documentElement;

  // v0.40: la "Pianta pulita" resta disponibile al motore ma non viene
  // renderizzata nel CAD. Il fondo visibile è l'eventuale disegno importato.
  const viewBox = inputRoot.getAttribute('viewBox');
  if (!viewBox) {
    const empty = document.createElement('div');
    empty.className = 'cad-empty';
    empty.textContent = 'Impossibile visualizzare il CAD: manca il viewBox SVG.';
    cadCanvas.appendChild(empty);
    return;
  }

  const sourceViewBox = cadParseViewBox(viewBox);
  const displayViewBox = cadEnsureViewport(sourceViewBox) || sourceViewBox;

  const svg = svgNode('svg', {
    viewBox: displayViewBox ? cadFormatViewBox(displayViewBox) : viewBox,
    preserveAspectRatio: 'xMidYMid meet',
    role: 'img',
    'aria-label': 'Editor CAD della pianta Termodel'
  });

  const vb = sourceViewBox || viewBox.trim().split(/[ ,]+/).map(Number);
  if (vb.length === 4 && vb.every(Number.isFinite)) {
    svg.appendChild(svgNode('rect', {
      x: vb[0], y: vb[1], width: vb[2], height: vb[3],
      fill: '#f5f5f5',
      'data-cad-background': 1
    }));
  }

  // Sfondo importato del piano corrente: raster o SVG vettoriale incorporato.
  const backgroundLayer = svgNode('g', {
    id: 'cadImportedBackgroundLayer',
    'pointer-events': 'none'
  });
  const sourceBackground = cadPlaneBackground(cadWorkingDoc, cadCurrentPlane());
  if (sourceBackground) {
    backgroundLayer.appendChild(svgNode('image', {
      x: sourceBackground.getAttribute('x'),
      y: sourceBackground.getAttribute('y'),
      width: sourceBackground.getAttribute('width'),
      height: sourceBackground.getAttribute('height'),
      preserveAspectRatio: sourceBackground.getAttribute('preserveAspectRatio') || 'xMidYMid meet',
      opacity: sourceBackground.getAttribute('opacity') || '0.72',
      href: sourceBackground.getAttribute('href') || ''
    }));
  }
  svg.appendChild(backgroundLayer);

  // Overlay semantico editabile. In v0.7 sono editabili soltanto E/W.
  const inputLayer = svgNode('g', { id: 'cadInputLayer' });
  const calpestabile = cadCalpestabile();

  if (calpestabile) {
    Array.from(calpestabile.children)
      .filter(el => el.localName === 'line' && cadEntityBelongsToCurrentPlane(el))
      .forEach(line => {
        const id = line.id || '';
        const lineStyle = cadLineDisplayStyle(line);
        const color = lineStyle.color;
        const x1 = Number(line.getAttribute('x1'));
        const y1 = Number(line.getAttribute('y1'));
        const x2 = Number(line.getAttribute('x2'));
        const y2 = Number(line.getAttribute('y2'));
        const editable = /^[EW]/i.test(id);

        const displayLine = svgNode('line', {
          x1, y1, x2, y2,
          stroke: color,
          'stroke-dasharray': lineStyle.dash || null,
          'stroke-width': editable ? 3.4 : 2.8,
          'stroke-linecap': 'round',
          opacity: editable ? 0.92 : 0.72,
          'vector-effect': 'non-scaling-stroke',
          class: editable ? 'cad-edit-line' : '',
          'data-cad-id': editable ? id : null
        });

        if (editable) {
          displayLine.addEventListener('pointerdown', event => {
            if (event.button !== 0) return;
            if (cadToolMode === 'line') return;
            event.preventDefault();
            event.stopPropagation();

            cadSelectedSymbolId = '';
            cadSelectedLineId = id;
            cadSyncOverlay(svg);

            const source = cadFindSourceLine(id);
            if (!source) return;

            const start = cadLinePoint(source, 1);
            const end = cadLinePoint(source, 2);
            const refs = [
              ...cadConnectedEndpointRefs(start),
              ...cadConnectedEndpointRefs(end)
            ];

            // Evita di aggiornare due volte lo stesso endpoint.
            const unique = [];
            const seen = new Set();
            refs.forEach(ref => {
              const key = `${ref.line.id}:${ref.endpoint}`;
              if (seen.has(key)) return;
              seen.add(key);
              unique.push(ref);
            });

            cadDragState = {
              mode: 'line',
              pointerId: event.pointerId,
              lineId: id,
              before: cadSerializeWorkingSvg(),
              startPointer: cadClientPoint(svg, event),
              refs: unique,
              moved: false
            };

            if (svg.setPointerCapture) {
              try { svg.setPointerCapture(event.pointerId); } catch (_) {}
            }
          });
        }

        inputLayer.appendChild(displayLine);
        addCadLabel(
          inputLayer, id, (x1 + x2) / 2, (y1 + y2) / 2, color,
          editable ? id : ''
        );
      });

    Array.from(calpestabile.children)
      .filter(el => el.localName === 'text' && cadSymbolBlockType(el) && cadEntityBelongsToCurrentPlane(el))
      .forEach(labelSource => {
        const id = labelSource.id || '';
        const x = Number(labelSource.getAttribute('x'));
        const y = Number(labelSource.getAttribute('y'));
        const color = cadSymbolColor(labelSource);
        const marker = svgNode('circle', {
          cx: x, cy: y, r: 7, fill: '#ffffff', stroke: color, 'stroke-width': 2,
          'vector-effect': 'non-scaling-stroke',
          class: 'cad-edit-symbol',
          'data-cad-symbol-id': id
        });
        marker.classList.toggle('selected', id === cadSelectedSymbolId);
        marker.addEventListener('pointerdown', event => {
          if (event.button !== 0) return;
          if (cadToolMode !== 'select') return;
          event.preventDefault();
          event.stopPropagation();
          cadSelectSymbol(id, svg);
        });
        inputLayer.appendChild(marker);
        addCadLabel(inputLayer, id, x, y, color);
      });
  }

  svg.appendChild(inputLayer);
  cadRenderNorthOverlay(svg, vb);
  cadCanvas.appendChild(svg);

  cadInstallPointerEditing(svg);
  cadSyncOverlay(svg);
  applyCadLayerVisibility();
}

function cadDeleteSelected() {
  const line = cadFindSourceLine(cadSelectedLineId);
  if (!line) return;

  const before = cadSerializeWorkingSvg();
  line.remove();
  cadUndoStack.push(before);
  cadRedoStack = [];
  cadSelectedLineId = '';
  renderCadComparison();
  cadSetStatus('Parete eliminata · premi Rigenera pianta', 'dirty');
}

function cadUndoEdit() {
  if (!cadUndoStack.length || !cadWorkingDoc) return;
  cadRedoStack.push(cadSerializeWorkingSvg());
  cadWorkingDoc = cadParseSvg(cadUndoStack.pop());
  cadSyncNorthFromWorkingDoc();
  if (!cadFindSourceLine(cadSelectedLineId)) cadSelectedLineId = '';
  if (!cadFindSourceSymbol(cadSelectedSymbolId)) cadSelectedSymbolId = '';
  renderCadComparison();
}

function cadRedoEdit() {
  if (!cadRedoStack.length || !cadWorkingDoc) return;
  cadUndoStack.push(cadSerializeWorkingSvg());
  cadWorkingDoc = cadParseSvg(cadRedoStack.pop());
  cadSyncNorthFromWorkingDoc();
  if (!cadFindSourceLine(cadSelectedLineId)) cadSelectedLineId = '';
  if (!cadFindSourceSymbol(cadSelectedSymbolId)) cadSelectedSymbolId = '';
  renderCadComparison();
}

function cadRegeneratePlan() {
  if (!cadWorkingDoc) return false;
  if (!cadIsDirty()) return true;

  try {
    const svgText = cadSerializeWorkingSvg();
    const currentPlaneSvg = cadSerializeCurrentPlaneSvg();
    const plan = generaPiantaDaSvg(currentPlaneSvg);
    const current = cadCurrentPlane();

    validatedSvg = svgText;
    lastCleanPlanSvg = plan.svgPulito;
    lastGeneratedPlan = plan;
    cadCleanPlanByPlane.set(current, plan.svgPulito);
    cadGeneratedPlanByPlane.set(current, plan);
    cadCommittedSvg = svgText;
    rasterSvgText.value = svgText;
    showSvgPreview(plan.svgPulito);

    // Aggiorna anche il 3D senza abbandonare la pagina CAD.
    lastAiPreviewData = createAiPreviewModelFromPlan(plan);
    renderModelData(lastAiPreviewData, {
      mode: 'ai',
      label: 'ANTEPRIMA AI — GENERAPIANTA.JS'
    });

    rasterExportSvg.disabled = false;
    if (rasterDownloadAiJson) rasterDownloadAiJson.disabled = false;
    if (rasterDownloadCleanSvg) rasterDownloadCleanSvg.disabled = false;

    if (cadExportArchitectural) {
      cadExportArchitectural.disabled = false;
      cadExportArchitectural.title =
        `${DXF_EXPORT_INFO.version} · ${DXF_EXPORT_INFO.units}`;
    }

    renderCadComparison();
    cadSetStatus(
      `✓ Piano ${cadCurrentPlane()} rigenerato · ${plan.stats.locali} locali`
    );
    return true;
  } catch (error) {
    cadSetStatus('✗ ' + error.message, 'error');
    return false;
  }
}

function cadReturnToModel() {
  // Una linea iniziata ma non conclusa non fa ancora parte dello SVG:
  // la annulliamo prima del ritorno.
  if (cadToolMode === 'line')
    cadCancelNewLine();

  // Se il DisegnoInput è stato modificato, il modello deve sempre
  // corrispondere all'input corrente prima di lasciare il CAD.
  if (cadWorkingDoc && cadIsDirty()) {
    const regenerated = cadRegeneratePlan();
    if (!regenerated) return;
  }

  activateModelPage();
}

function activateCadPage() {
  if (!structuredProjectActive) {
    projectStartContext = { target: 'cad', archiveName: '' };
    void startBlankProjectFromCad();
    return;
  }

  setCadLayoutMode(true);
  document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
  document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
  if (cadPage) cadPage.classList.add('active');
  if (demoHelpPanel) demoHelpPanel.hidden = true;

  if (!cadWorkingDoc && validatedSvg) {
    try {
      cadSetWorkingSvg(validatedSvg);
    } catch (error) {
      cadSetStatus('✗ ' + error.message, 'error');
    }
  }

  cadEnsureToolbarState();
  cadRestorePlanePreview();
  renderCadComparison();
  cadUpdatePropertiesPanel();
}

function processSvgText(text) {
  validatedSvg = '';
  lastAiPreviewData = null;
  lastCleanPlanSvg = '';
  lastGeneratedPlan = null;
  if (cadExportArchitectural) cadExportArchitectural.disabled = true;
  rasterExportSvg.disabled = true;
  if (rasterDownloadAiJson) rasterDownloadAiJson.disabled = true;
  if (rasterDownloadCleanSvg) rasterDownloadCleanSvg.disabled = true;
  svgExportText.value = '';
  rasterValidation.className = 'raster-ai-validation';

  try {
    const extracted = extractSvg(text);
    const svg = extracted.svg;

    // GPT ha già validato la geometria. Il Web esegue soltanto il lavoro
    // necessario a GeneraPianta: noding + polygonizzazione con JSTS.
    const plan = generaPiantaDaSvg(svg);

    validatedSvg = svg;
    lastCleanPlanSvg = plan.svgPulito;
    lastGeneratedPlan = plan;
    cadSetWorkingSvg(svg);
    validatedSvg = cadSerializeWorkingSvg();
    rasterSvgText.value = validatedSvg;
    showSvgPreview(plan.svgPulito);
    showAiPreviewModel(plan);

    const counts = lastAiPreviewData.previewCounts;
    const warningText = plan.warnings?.length
      ? `\n⚠ ${plan.warnings.length} raccordi/associazioni hanno usato una protezione; dettagli in console.`
      : '';
    if (plan.warnings?.length) console.warn('GeneraPianta Web warnings:', plan.warnings);

    rasterValidation.textContent =
      `${extracted.transported ? '✓ Payload TERMODEL-SVG-TEXT-V1 decodificato\n' : ''}` +
      `✓ GeneraPianta.js: ${plan.stats.linee} linee lette · ${plan.stats.locali} locali\n` +
      `✓ Classificazione JSTS: ${plan.stats.geometricExternalEdges} lati esterni · ${plan.stats.geometricInternalEdges} lati interni\n` +
      `✓ Regola netta: E ferme · W spostate 7.5 cm verso il locale · esterno edificio +40 cm\n` +
      `✓ Incongruenze E/W GPT vs geometria: ${plan.stats.classificationMismatches}\n` +
      `✓ ${counts.floors} pavimenti · spessore default ${AI_PREVIEW_FLOOR_THICKNESS_M.toFixed(2)} m\n` +
      `✓ ${counts.ceilings} soffitti · spessore default ${AI_PREVIEW_CEILING_THICKNESS_M.toFixed(2)} m\n` +
      `✓ Pianta SVG pulita generata\n` +
      `✓ Anteprima 3D caricata nel viewer` + warningText;

    rasterValidation.classList.add('ok');
    rasterExportSvg.disabled = false;
    if (rasterDownloadAiJson) rasterDownloadAiJson.disabled = false;
    if (rasterDownloadCleanSvg) rasterDownloadCleanSvg.disabled = false;
    if (cadExportArchitectural) {
      cadExportArchitectural.disabled = false;
      cadExportArchitectural.title = `${DXF_EXPORT_INFO.version} · ${DXF_EXPORT_INFO.units}`;
    }

    // Il ritorno da GPT porta direttamente alla pianta estrusa.
    closeRasterAiDialog();
    return true;
  } catch (error) {
    rasterValidation.textContent = '✗ ' + error.message;
    rasterValidation.classList.add('error');
    return false;
  }
}

document.getElementById('rasterSelectButton').addEventListener('click', () => rasterFileInput.click());
rasterFileInput.addEventListener('change', () => {
  const file = rasterFileInput.files?.[0];
  if (!file) return;

  selectedRasterFile = file;
  if (rasterObjectUrl) URL.revokeObjectURL(rasterObjectUrl);
  rasterObjectUrl = URL.createObjectURL(file);
  rasterPreviewImage.src = rasterObjectUrl;
  rasterPreviewImage.hidden = false;
  rasterPreviewPlaceholder.hidden = true;
  rasterFileName.textContent = file.name;
  rasterCopyPrompt.disabled = false;
  rasterOpenChatGpt.disabled = false;
});

rasterCopyPrompt.addEventListener('click', async () => {
  if (!selectedRasterFile) return;
  try {
    const [generalResponse, rasterResponse] = await Promise.all([
      fetch(TERMODEL_GENERAL_PROMPT_URL, { cache: 'no-store' }),
      fetch(RASTER_PROMPT_URL, { cache: 'no-store' })
    ]);
    if (!generalResponse.ok) throw new Error(`Istruzioni generali: HTTP ${generalResponse.status}`);
    if (!rasterResponse.ok) throw new Error(`Istruzioni raster: HTTP ${rasterResponse.status}`);
    const generalInstructions = await generalResponse.text();
    const rasterInstructions = await rasterResponse.text();
    const instructions = generalInstructions + '\n\n---\n\n' + rasterInstructions;
    const session = `

---
IMMAGINE DI QUESTA SESSIONE: ${selectedRasterFile.name}
L'utente allegherà alla chat il file raster; non tentare di aprire percorsi locali di Termodel.`;
    await navigator.clipboard.writeText(instructions + session);
    rasterValidation.className = 'raster-ai-validation ok';
    rasterValidation.textContent = '✓ Istruzioni Termodel copiate. Ora apri ChatGPT e allega la stessa pianta.';
  } catch (error) {
    rasterValidation.className = 'raster-ai-validation error';
    rasterValidation.textContent = '✗ Impossibile copiare le istruzioni: ' + error.message;
  }
});

rasterOpenChatGpt.addEventListener('click', () => {
  if (!selectedRasterFile) return;
  window.open('https://chatgpt.com/', '_blank', 'noopener');
});

document.getElementById('rasterLoadSvg').addEventListener('click', () => rasterSvgFileInput.click());
rasterSvgFileInput.addEventListener('change', async () => {
  const file = rasterSvgFileInput.files?.[0];
  if (!file) return;
  const text = await file.text();
  rasterSvgText.value = text;
  processSvgText(text);
});

document.getElementById('rasterPasteSvg').addEventListener('click', async () => {
  try {
    const text = await navigator.clipboard.readText();
    rasterSvgText.value = text;
    processSvgText(text);
  } catch (error) {
    rasterValidation.className = 'raster-ai-validation error';
    rasterValidation.textContent = '✗ Il browser non ha consentito la lettura degli appunti. Incolla manualmente nel riquadro.';
  }
});

document.getElementById('rasterValidateSvg').addEventListener('click', () => {
  processSvgText(rasterSvgText.value);
});

rasterExportSvg.addEventListener('click', openSvgExportDialog);
if (rasterDownloadAiJson)
  rasterDownloadAiJson.addEventListener('click', downloadAiPreviewJson);
if (rasterDownloadCleanSvg)
  rasterDownloadCleanSvg.addEventListener('click', downloadCleanPlanSvg);
svgExportCopy.addEventListener('click', copyValidatedSvg);
svgExportDownload.addEventListener('click', downloadValidatedSvg);
document.getElementById('svgExportClose').addEventListener('click', closeSvgExportDialog);
document.getElementById('svgExportCloseBottom').addEventListener('click', closeSvgExportDialog);
svgExportModal.addEventListener('click', (event) => {
  if (event.target === svgExportModal) closeSvgExportDialog();
});

document.getElementById('rasterAiClose').addEventListener('click', closeRasterAiDialog);
document.getElementById('rasterAiCloseBottom').addEventListener('click', closeRasterAiDialog);
rasterAiModal.addEventListener('click', (event) => {
  if (event.target === rasterAiModal) closeRasterAiDialog();
});
document.addEventListener('keydown', (event) => {
  if (event.key !== 'Escape') return;
  if (aiInstructModal?.classList.contains('visible')) {
    closeAiInstructDialog();
    return;
  }
  if (svgExportModal.classList.contains('visible')) {
    closeSvgExportDialog();
    return;
  }
  if (rasterAiModal.classList.contains('visible'))
    closeRasterAiDialog();
});


cadAddBackground?.addEventListener('click', () => {
  if (!cadWorkingDoc || !cadBackgroundFile) return;
  cadBackgroundFile.click();
});
cadBackgroundFile?.addEventListener('change', async () => {
  const file = cadBackgroundFile.files?.[0];
  cadBackgroundFile.value = '';
  if (!file) return;
  try {
    await cadImportBackgroundFile(file);
  } catch (error) {
    console.error(error);
    cadSetStatus('Errore importazione sfondo: ' + (error?.message || error), 'error');
  }
});
if (cadShowBackground)
  cadShowBackground.addEventListener('change', applyCadLayerVisibility);
if (cadShowInput)
  cadShowInput.addEventListener('change', applyCadLayerVisibility);
cadCalibrateBackground?.addEventListener('click', cadApplyBackgroundCalibration);
cadCalibrationRealMeters?.addEventListener('keydown', event => {
  if (event.key === 'Enter' && !cadCalibrateBackground?.disabled)
    cadApplyBackgroundCalibration();
});
if (cadUndo)
  cadUndo.addEventListener('click', cadUndoEdit);
if (cadRedo)
  cadRedo.addEventListener('click', cadRedoEdit);
if (cadDelete)
  cadDelete.addEventListener('click', cadDeleteSelected);
if (cadNewLine)
  cadNewLine.addEventListener('click', cadToggleNewLine);
cadRepeatLastCommand?.addEventListener('click', cadRepeatLastCadCommand);
cadCloseSequence?.addEventListener('click', () => cadCloseWallSequence(false));
cadCloseOrthogonalSequence?.addEventListener('click', () => cadCloseWallSequence(true));
cadStopSequence?.addEventListener('click', () => {
  cadHideContextMenu();
  cadCancelNewLine();
});
document.addEventListener('pointerdown', event => {
  if (!cadContextMenu || cadContextMenu.hidden) return;
  if (!cadContextMenu.contains(event.target)) cadHideContextMenu();
});
cadInsertAlign?.addEventListener('click', () => cadToggleSymbolInsert('ALLINEA'));
cadInsertOpening?.addEventListener('click', () => cadToggleSymbolInsert('FIN'));
cadInsertBridge?.addEventListener('click', () => cadToggleSymbolInsert('PON'));
cadInsertRoom?.addEventListener('click', () => cadToggleSymbolInsert('LOC'));
if (cadPropConfirm)
  cadPropConfirm.addEventListener('click', cadApplyProperties);
cadSymbolApply?.addEventListener('click', cadApplySelectedSymbolProperties);
cadNorthClose?.addEventListener('click', () => cadCloseNorthPanel(true));
cadNorthDefined?.addEventListener('change', () => {
  cadSetNorthOrientation(cadNorthDefined.checked ? (cadNorthAngle?.value || 0) : null);
});
cadNorthRange?.addEventListener('input', () => {
  if (cadNorthDefined?.checked)
    cadSetNorthOrientation(cadNorthRange.value);
});
cadNorthAngle?.addEventListener('change', () => {
  if (cadNorthDefined?.checked)
    cadSetNorthOrientation(cadNorthAngle.value);
});
cadPropPiano?.addEventListener('change', cadCurrentPlaneChanged);
[cadPropTipoParete, cadPropConfineParete].forEach(control => {
  control?.addEventListener('change', cadWallPropertySelectionChanged);
});
cadOpenPianiArchive?.addEventListener('click', () => openArchivioWeb('Piani'));
cadOpenParetiArchive?.addEventListener('click', () => openArchivioWeb('Pareti'));
cadOpenConfiniArchive?.addEventListener('click', () => openArchivioWeb('Confini'));
window.addEventListener('termodel:archives-updated', () => {
  const piani = cadArchiveRecords('Piani').map(r => cadText(r?.Nome)).filter(Boolean);
  if (piani.length && !piani.includes(cadText(cadToolbarState.piano))) {
    cadToolbarState.piano = piani[0];
    cadSelectedLineId = '';
    cadRestorePlanePreview();
  }
  cadRefreshToolbarControls();
  if (cadPage?.classList.contains('active')) {
    renderCadComparison();
    cadUpdatePropertiesPanel();
  }
});
if (cadRegenerate)
  cadRegenerate.addEventListener('click', cadRegeneratePlan);
if (cadReturnModel)
  cadReturnModel.addEventListener('click', cadReturnToModel);
if (cadExportArchitectural)
  cadExportArchitectural.addEventListener('click', downloadArchitecturalDxf);

// Scorciatoie operative del mini-CAD.
document.addEventListener('keydown', event => {
  if (!cadPage?.classList.contains('active')) return;
  const tag = event.target?.tagName?.toLowerCase();

  if (event.key === 'Escape' && (cadToolMode === 'line' || cadToolMode === 'symbol')) {
    event.preventDefault();
    if (cadToolMode === 'line') cadCancelNewLine();
    else cadCancelSymbolInsert();
    return;
  }
  if (tag === 'input' || tag === 'textarea' || tag === 'select') return;

  if ((event.key === 'Delete' || event.key === 'Backspace') && cadSelectedLineId) {
    event.preventDefault();
    cadDeleteSelected();
    return;
  }

  if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'z') {
    event.preventDefault();
    if (event.shiftKey) cadRedoEdit();
    else cadUndoEdit();
    return;
  }

  if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'y') {
    event.preventDefault();
    cadRedoEdit();
  }
});
// v0.52: ArchivioWeb usa il file progetto completo + definizionedati.json.
initArchivioWeb({ schemaUrl: './definizionedati.json?v=0.52' })
  .catch(error => console.error('ArchivioWeb non inizializzato:', error));

document.querySelectorAll('[data-action]').forEach(button => {
  button.addEventListener('click', () => {
    if (button.dataset.action === 'Edita nel Cad') {
      activateCadPage();
      return;
    }
    showDemoHelp(button.dataset.action);
  });
});

const drawingSelect = document.querySelector('select[aria-label="Disegno input"]');
if (drawingSelect) {
  drawingSelect.addEventListener('click', () => showDemoHelp('DisegnoInput'));
  drawingSelect.addEventListener('change', () => showDemoHelp('DisegnoInput'));
}

projectStartClose?.addEventListener('click', closeProjectStartDialog);
projectStartCloseBottom?.addEventListener('click', closeProjectStartDialog);
projectStartModal?.addEventListener('click', event => {
  if (event.target === projectStartModal) closeProjectStartDialog();
});
projectStartBlank?.addEventListener('click', () => {
  projectStartContext = { target: 'cad', archiveName: '' };
  void startBlankProjectFromCad();
});
projectStartInstructAi?.addEventListener('click', async event => {
  closeProjectStartDialog();
  await instructAiFromMainForm(event);
});
projectStartImportAi?.addEventListener('click', async event => {
  const context = projectStartContext;
  closeProjectStartDialog();
  await importAiFromMainForm(event);
  if (structuredProjectActive) {
    projectStartContext = context;
    await continueAfterProjectStart();
  }
});
newProjectButton?.addEventListener('click', event => {
  event.preventDefault();
  event.stopPropagation();
  openProjectStartDialog({ target: 'cad' });
});

setStructuredProjectState(false);
refreshWebServiceCapabilities();

showDemoHelp('Benvenuto');

renderer.setAnimationLoop(() => {
  controls.update();
  renderer.render(scene, camera);
});

resize();
loadModel();
