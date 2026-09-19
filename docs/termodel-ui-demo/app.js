import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import { generaPiantaDaSvg } from './genera-pianta.js';
import { generaDxfDaPianta, DXF_EXPORT_INFO } from './export-dxf.js';
import {
  initArchivioWeb,
  isTermodelProjectText,
  loadTermodelProjectText,
  openArchivioWeb
} from './archivio-web.js?v=0.24';

const MODEL_URL = './TermodelWebModel.json';
const WEB_SERVICE_BASE_URL = 'http://localhost:5080';
const WEB_SERVICE_CAPABILITIES_URL = `${WEB_SERVICE_BASE_URL}/api/model/capabilities`;
const WEB_SERVICE_NEW_PROJECT_URL = `${WEB_SERVICE_BASE_URL}/api/projects/new`;

const viewer = document.getElementById('viewer');
const modelPage = document.getElementById('modelPage');
const cadPage = document.getElementById('cadPage');
const cadCanvas = document.getElementById('cadCanvas');
const cadShowClean = document.getElementById('cadShowClean');
const cadShowInput = document.getElementById('cadShowInput');
const cadReturnModel = document.getElementById('cadReturnModel');
const cadExportArchitectural = document.getElementById('cadExportArchitectural');
const cadSnap = document.getElementById('cadSnap');
const cadUndo = document.getElementById('cadUndo');
const cadRedo = document.getElementById('cadRedo');
const cadDelete = document.getElementById('cadDelete');
const cadRegenerate = document.getElementById('cadRegenerate');
const cadNewLine = document.getElementById('cadNewLine');
const cadNewLineType = document.getElementById('cadNewLineType');
const cadEditStatus = document.getElementById('cadEditStatus');
const cadPropertiesEmpty = document.getElementById('cadPropertiesEmpty');
const cadPropertiesBody = document.getElementById('cadPropertiesBody');
const cadPropEntity = document.getElementById('cadPropEntity');
const cadPropPiano = document.getElementById('cadPropPiano');
const cadPropLayer = document.getElementById('cadPropLayer');
const cadPropTipoParete = document.getElementById('cadPropTipoParete');
const cadPropConfineParete = document.getElementById('cadPropConfineParete');
const cadPropTipoLinea = document.getElementById('cadPropTipoLinea');
const cadPropColore = document.getElementById('cadPropColore');
const cadPropColorSwatch = document.getElementById('cadPropColorSwatch');
const cadPropStart = document.getElementById('cadPropStart');
const cadPropEnd = document.getElementById('cadPropEnd');
const cadPropLength = document.getElementById('cadPropLength');
const cadPropConfirm = document.getElementById('cadPropConfirm');
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
scene.add(modelGroup);
scene.add(edgeGroup);

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

// Edita nel CAD v0.10: editor SVG semantico E/W con costruzione, snap
// e pannello proprietà ispirato a Grid_DatiCad/Grid_pareti del desktop.
// La geometria architettonica continua ad essere rigenerata dal motore GeneraPianta.
let cadWorkingDoc = null;
let cadCommittedSvg = '';
let cadSelectedLineId = '';
let cadUndoStack = [];
let cadRedoStack = [];
let cadDragState = null;
let cadToolMode = 'select';
let cadNewLineState = null;
const CAD_SNAP_DISTANCE = 12;
const CAD_JOIN_EPSILON = 0.05;

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
  const disabled = !structuredProjectActive;
  const unavailableTitle = 'Disponibile solo con un progetto Termodel strutturato.';

  document.querySelectorAll('[data-archive]').forEach(button => {
    button.disabled = disabled;
    button.title = disabled ? unavailableTitle : '';
  });

  const cadButton = document.querySelector('[data-action="Edita nel Cad"]');
  if (cadButton) {
    cadButton.disabled = disabled;
    cadButton.title = disabled ? unavailableTitle : '';
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
  const structuredProjectText = replaceProjectTextSection(
    emptyProjectText,
    'geometry/project.svg',
    svgText
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
      window.alert('Gli archivi sono disponibili solo dopo aver caricato o creato un progetto Termodel strutturato.');
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
          setMainAiStatus(`✓ Progetto strutturato creato: ${project.projectName} · archivi e CAD attivi`);
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

function activateModelPage() {
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

function cadEditableSourceLines() {
  const group = cadCalpestabile();
  if (!group) return [];
  return Array.from(group.children)
    .filter(el => el.localName === 'line' && /^[EW]/i.test(el.id || ''));
}

function cadFindSourceLine(id) {
  if (!id) return null;
  return cadEditableSourceLines().find(line => line.id === id) || null;
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

function cadUpdatePropertiesPanel() {
  const line = cadFindSourceLine(cadSelectedLineId);
  const selected = !!line;

  if (cadPropertiesEmpty) cadPropertiesEmpty.hidden = selected;
  if (cadPropertiesBody) cadPropertiesBody.hidden = !selected;
  if (!selected) return;

  const [x1, y1] = cadLinePoint(line, 1);
  const [x2, y2] = cadLinePoint(line, 2);
  const lengthCm = Math.hypot(x2 - x1, y2 - y1);
  const type = (line.id || '').charAt(0).toUpperCase();
  const color = cadColorForId(line.id || '');

  if (cadPropEntity) cadPropEntity.value = line.id || '';
  if (cadPropPiano)
    cadPropPiano.value = line.getAttribute('data-termodel-piano') || '';
  if (cadPropLayer) cadPropLayer.value = 'calpestabile';
  if (cadPropTipoParete)
    cadPropTipoParete.value = line.getAttribute('data-termodel-tipo-parete') || '';
  if (cadPropConfineParete)
    cadPropConfineParete.value = line.getAttribute('data-termodel-confine-parete') || '';
  if (cadPropTipoLinea) cadPropTipoLinea.value = type;
  if (cadPropColore) cadPropColore.value = color;
  if (cadPropColorSwatch) cadPropColorSwatch.style.background = color;
  if (cadPropStart)
    cadPropStart.value = `${x1.toFixed(1)} / ${y1.toFixed(1)} cm`;
  if (cadPropEnd)
    cadPropEnd.value = `${x2.toFixed(1)} / ${y2.toFixed(1)} cm`;
  if (cadPropLength)
    cadPropLength.value = `${lengthCm.toFixed(1)} cm · ${(lengthCm / 100).toFixed(3)} m`;
}

function cadSetOptionalAttribute(element, name, value) {
  const normalized = String(value ?? '').trim();
  if (normalized) element.setAttribute(name, normalized);
  else element.removeAttribute(name);
}

function cadApplyProperties() {
  const line = cadFindSourceLine(cadSelectedLineId);
  if (!line) return;

  const before = cadSerializeWorkingSvg();

  cadSetOptionalAttribute(line, 'data-termodel-piano', cadPropPiano?.value);
  cadSetOptionalAttribute(line, 'data-termodel-tipo-parete', cadPropTipoParete?.value);
  cadSetOptionalAttribute(line, 'data-termodel-confine-parete', cadPropConfineParete?.value);

  const after = cadSerializeWorkingSvg();
  if (after !== before) {
    cadUndoStack.push(before);
    cadRedoStack = [];
    cadSetStatus(`${line.id} · proprietà aggiornate · modifica non rigenerata`, 'dirty');
  } else {
    cadSetStatus(`${line.id} · proprietà invariate`);
  }

  cadUpdatePropertiesPanel();
  cadUpdateControls();
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
  const dirty = cadIsDirty();
  const drawing = cadToolMode === 'line';

  if (cadUndo) cadUndo.disabled = !cadUndoStack.length || drawing;
  if (cadRedo) cadRedo.disabled = !cadRedoStack.length || drawing;
  if (cadDelete) cadDelete.disabled = !selected || drawing;
  if (cadRegenerate) cadRegenerate.disabled = !hasDoc || !dirty || drawing;
  if (cadNewLine) {
    cadNewLine.disabled = !hasDoc;
    cadNewLine.classList.toggle('active', drawing);
    cadNewLine.textContent = drawing ? '× Annulla linea' : '＋ Nuova linea';
  }
  if (cadNewLineType) cadNewLineType.disabled = !hasDoc || drawing;
  if (cadExportArchitectural)
    cadExportArchitectural.disabled = !lastGeneratedPlan || dirty || drawing;

  if (!hasDoc) {
    cadSetStatus('Genera prima una pianta');
  } else if (drawing) {
    const tipo = (cadNewLineType?.value || 'W').toUpperCase();
    cadSetStatus(
      cadNewLineState
        ? `Nuova ${tipo} · clicca il punto finale`
        : `Nuova ${tipo} · clicca il punto iniziale`
    );
  } else if (dirty) {
    cadSetStatus(
      cadSelectedLineId
        ? `${cadSelectedLineId} · modifica non rigenerata`
        : 'Modifica non rigenerata',
      'dirty'
    );
  } else if (selected) {
    const line = cadFindSourceLine(cadSelectedLineId);
    const [x1, y1] = cadLinePoint(line, 1);
    const [x2, y2] = cadLinePoint(line, 2);
    cadSetStatus(
      `${cadSelectedLineId} · (${x1.toFixed(1)}, ${y1.toFixed(1)}) → (${x2.toFixed(1)}, ${y2.toFixed(1)})`
    );
  } else {
    cadSetStatus('Seleziona una parete E/W');
  }
}

function cadSetWorkingSvg(svgText) {
  cadWorkingDoc = cadParseSvg(svgText);
  cadCommittedSvg = cadSerializeWorkingSvg();
  cadSelectedLineId = '';
  cadUndoStack = [];
  cadRedoStack = [];
  cadDragState = null;
  cadToolMode = 'select';
  cadNewLineState = null;
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
  if (cadSnap?.checked === false) return { point, snapped: false };

  let best = point;
  let bestDistance = CAD_SNAP_DISTANCE + 1;

  cadEditableSourceLines().forEach(line => {
    if (line.id === movingLineId) return;
    const a = cadLinePoint(line, 1);
    const b = cadLinePoint(line, 2);

    for (const candidate of [a, b]) {
      const distance = cadPointDistance(point, candidate);
      if (distance < bestDistance) {
        best = candidate.slice();
        bestDistance = distance;
      }
    }

    const projected = cadNearestPointOnSegment(point, a, b);
    const segmentDistance = cadPointDistance(point, projected);
    if (segmentDistance < bestDistance) {
      best = projected;
      bestDistance = segmentDistance;
    }
  });

  return {
    point: bestDistance <= CAD_SNAP_DISTANCE ? best : point,
    snapped: bestDistance <= CAD_SNAP_DISTANCE
  };
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

  cadEditableSourceLines().forEach(line => {
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

function cadCancelNewLine(svg = cadCanvas?.querySelector('svg')) {
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

  cadToolMode = 'line';
  cadNewLineState = null;
  cadSelectedLineId = '';
  const svg = cadCanvas?.querySelector('svg');
  if (svg) cadSyncOverlay(svg);
  cadUpdateControls();
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
  const snapped = cadSnapPoint(rawPoint, '');
  const point = snapped.point;

  if (!cadNewLineState) {
    cadNewLineState = {
      start: point.slice(),
      before: cadSerializeWorkingSvg()
    };
    cadRenderNewLinePreview(svg, point, snapped.snapped);
    cadSetStatus(
      `Nuova ${(cadNewLineType?.value || 'W').toUpperCase()} · punto iniziale${snapped.snapped ? ' · SNAP' : ''} · clicca il finale`
    );
    return;
  }

  if (cadPointDistance(cadNewLineState.start, point) < 0.5) {
    cadSetStatus('La nuova linea deve avere una lunghezza maggiore di zero.', 'error');
    return;
  }

  const group = cadCalpestabile();
  if (!group) {
    cadSetStatus('Gruppo calpestabile non trovato nello SVG.', 'error');
    cadCancelNewLine(svg);
    return;
  }

  const type = (cadNewLineType?.value || 'W').toUpperCase() === 'E' ? 'E' : 'W';
  const id = cadNextLineId(type);
  const [x1, y1] = cadNewLineState.start;

  const line = cadWorkingDoc.createElementNS(SVG_NS, 'line');
  line.setAttribute('id', id);
  line.setAttribute('x1', Number(x1).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('y1', Number(y1).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('x2', Number(point[0]).toFixed(3).replace(/\.000$/, ''));
  line.setAttribute('y2', Number(point[1]).toFixed(3).replace(/\.000$/, ''));
  group.appendChild(line);

  cadUndoStack.push(cadNewLineState.before);
  cadRedoStack = [];
  cadSelectedLineId = id;
  cadToolMode = 'select';
  cadNewLineState = null;

  renderCadComparison();
  cadSetStatus(
    `✓ ${id} creata${snapped.snapped ? ' · finale SNAP' : ''} · premi Rigenera pianta`,
    'dirty'
  );
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
    displayLine.classList.toggle('selected', id === cadSelectedLineId);

    const label = svg.querySelector(`[data-cad-label="${CSS.escape(id)}"]`);
    if (label) {
      label.setAttribute('x', (x1 + x2) / 2);
      label.setAttribute('y', (y1 + y2) / 2 - 8);
    }
  });

  cadRenderSelectionHandles(svg);
  cadUpdatePropertiesPanel();
  cadUpdateControls();
}

function cadInstallPointerEditing(svg) {
  // In modalità Nuova linea intercettiamo il click prima delle singole entità.
  svg.addEventListener('pointerdown', event => {
    if (cadToolMode !== 'line') return;
    event.preventDefault();
    event.stopPropagation();
    cadStartOrFinishNewLine(svg, cadClientPoint(svg, event));
  }, true);

  svg.addEventListener('pointermove', event => {
    if (cadToolMode === 'line' && cadNewLineState) {
      const snapped = cadSnapPoint(cadClientPoint(svg, event), '');
      cadRenderNewLinePreview(svg, snapped.point, snapped.snapped);
      cadSetStatus(
        `Nuova ${(cadNewLineType?.value || 'W').toUpperCase()} · clicca il punto finale${snapped.snapped ? ' · SNAP' : ''}`
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
    if (cadToolMode === 'line') return;
    if (event.target === svg || event.target.getAttribute('data-cad-background') === '1') {
      cadSelectLine('', svg);
    }
  });
}

function applyCadLayerVisibility() {
  if (!cadCanvas) return;
  const clean = cadCanvas.querySelector('#cadCleanLayer');
  const input = cadCanvas.querySelector('#cadInputLayer');
  if (clean) clean.style.display = cadShowClean?.checked === false ? 'none' : '';
  if (input) input.style.display = cadShowInput?.checked === false ? 'none' : '';

  const handles = cadCanvas.querySelector('#cadHandlesLayer');
  if (handles) handles.style.display = cadShowInput?.checked === false ? 'none' : '';
}

function renderCadComparison() {
  if (!cadCanvas) return;

  cadCanvas.innerHTML = '';
  if (!cadWorkingDoc || !lastCleanPlanSvg) {
    const empty = document.createElement('div');
    empty.className = 'cad-empty';
    empty.textContent = 'Genera prima una pianta da raster con AI. Qui potrai correggere direttamente le pareti E/W del DisegnoInput.svg.';
    cadCanvas.appendChild(empty);
    cadUpdateControls();
    return;
  }

  const parser = new DOMParser();
  const cleanDoc = parser.parseFromString(lastCleanPlanSvg, 'image/svg+xml');
  const inputRoot = cadWorkingDoc.documentElement;
  const cleanRoot = cleanDoc.documentElement;

  const viewBox = cleanRoot.getAttribute('viewBox') || inputRoot.getAttribute('viewBox');
  if (!viewBox) {
    const empty = document.createElement('div');
    empty.className = 'cad-empty';
    empty.textContent = 'Impossibile visualizzare il CAD: manca il viewBox SVG.';
    cadCanvas.appendChild(empty);
    return;
  }

  const svg = svgNode('svg', {
    viewBox,
    preserveAspectRatio: 'xMidYMid meet',
    role: 'img',
    'aria-label': 'Editor CAD della pianta Termodel'
  });

  const vb = viewBox.trim().split(/[ ,]+/).map(Number);
  if (vb.length === 4 && vb.every(Number.isFinite)) {
    svg.appendChild(svgNode('rect', {
      x: vb[0], y: vb[1], width: vb[2], height: vb[3],
      fill: '#f5f5f5',
      'data-cad-background': 1
    }));
  }

  // Fondo: ultima pianta architettonica rigenerata.
  const cleanLayer = svgNode('g', { id: 'cadCleanLayer', 'pointer-events': 'none' });
  cleanDoc.querySelectorAll('#locali-puliti path').forEach(source => {
    cleanLayer.appendChild(svgNode('path', {
      d: source.getAttribute('d') || '',
      fill: '#fafafa',
      stroke: 'none'
    }));
  });
  cleanDoc.querySelectorAll('#pareti-architettoniche path').forEach(source => {
    cleanLayer.appendChild(svgNode('path', {
      d: source.getAttribute('d') || '',
      fill: '#cfcfcf',
      'fill-rule': source.getAttribute('fill-rule') || 'nonzero',
      stroke: '#858585',
      'stroke-width': 0.9,
      'vector-effect': 'non-scaling-stroke'
    }));
  });
  cleanDoc.querySelectorAll('#contorni-architettonici path').forEach(source => {
    cleanLayer.appendChild(svgNode('path', {
      d: source.getAttribute('d') || '',
      fill: 'none',
      stroke: '#707070',
      'stroke-width': 1.25,
      'vector-effect': 'non-scaling-stroke'
    }));
  });
  cleanDoc.querySelectorAll('#etichette-locali text').forEach(source => {
    const label = svgNode('text', {
      x: source.getAttribute('x'), y: source.getAttribute('y'),
      fill: '#777777',
      'text-anchor': 'middle',
      'font-family': 'Segoe UI, Arial, sans-serif',
      'font-size': 14
    });
    label.textContent = source.textContent || '';
    cleanLayer.appendChild(label);
  });
  svg.appendChild(cleanLayer);

  // Overlay semantico editabile. In v0.7 sono editabili soltanto E/W.
  const inputLayer = svgNode('g', { id: 'cadInputLayer' });
  const calpestabile = cadCalpestabile();

  if (calpestabile) {
    Array.from(calpestabile.children)
      .filter(el => el.localName === 'line')
      .forEach(line => {
        const id = line.id || '';
        const color = cadColorForId(id);
        const x1 = Number(line.getAttribute('x1'));
        const y1 = Number(line.getAttribute('y1'));
        const x2 = Number(line.getAttribute('x2'));
        const y2 = Number(line.getAttribute('y2'));
        const editable = /^[EW]/i.test(id);

        const displayLine = svgNode('line', {
          x1, y1, x2, y2,
          stroke: color,
          'stroke-width': editable ? 3.4 : 2.8,
          'stroke-linecap': 'round',
          opacity: editable ? 0.92 : 0.72,
          'vector-effect': 'non-scaling-stroke',
          class: editable ? 'cad-edit-line' : '',
          'data-cad-id': editable ? id : null
        });

        if (editable) {
          displayLine.addEventListener('pointerdown', event => {
            if (cadToolMode === 'line') return;
            event.preventDefault();
            event.stopPropagation();

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
      .filter(el => el.localName === 'text' && /^[RPF]/i.test(el.id || ''))
      .forEach(labelSource => {
        const id = labelSource.id || '';
        const x = Number(labelSource.getAttribute('x'));
        const y = Number(labelSource.getAttribute('y'));
        addCadLabel(inputLayer, id, x, y, cadColorForId(id));
      });
  }

  svg.appendChild(inputLayer);
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
  if (!cadFindSourceLine(cadSelectedLineId)) cadSelectedLineId = '';
  renderCadComparison();
}

function cadRedoEdit() {
  if (!cadRedoStack.length || !cadWorkingDoc) return;
  cadUndoStack.push(cadSerializeWorkingSvg());
  cadWorkingDoc = cadParseSvg(cadRedoStack.pop());
  if (!cadFindSourceLine(cadSelectedLineId)) cadSelectedLineId = '';
  renderCadComparison();
}

function cadRegeneratePlan() {
  if (!cadWorkingDoc) return false;
  if (!cadIsDirty()) return true;

  try {
    const svgText = cadSerializeWorkingSvg();
    const plan = generaPiantaDaSvg(svgText);

    validatedSvg = svgText;
    lastCleanPlanSvg = plan.svgPulito;
    lastGeneratedPlan = plan;
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
      `✓ Pianta rigenerata · ${plan.stats.locali} locali`
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
    window.alert('Edita nel CAD è disponibile solo con un progetto Termodel strutturato.');
    return;
  }

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

  renderCadComparison();
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
    rasterSvgText.value = svg;
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


if (cadShowClean)
  cadShowClean.addEventListener('change', applyCadLayerVisibility);
if (cadShowInput)
  cadShowInput.addEventListener('change', applyCadLayerVisibility);
if (cadUndo)
  cadUndo.addEventListener('click', cadUndoEdit);
if (cadRedo)
  cadRedo.addEventListener('click', cadRedoEdit);
if (cadDelete)
  cadDelete.addEventListener('click', cadDeleteSelected);
if (cadNewLine)
  cadNewLine.addEventListener('click', cadToggleNewLine);
if (cadPropConfirm)
  cadPropConfirm.addEventListener('click', cadApplyProperties);
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

  if (event.key === 'Escape' && cadToolMode === 'line') {
    event.preventDefault();
    cadCancelNewLine();
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
// v0.24: ArchivioWeb usa il file progetto completo + definizionedati.json.
initArchivioWeb({ schemaUrl: './definizionedati.json?v=0.24' })
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

setStructuredProjectState(false);
refreshWebServiceCapabilities();

showDemoHelp('Benvenuto');

renderer.setAnimationLoop(() => {
  controls.update();
  renderer.render(scene, camera);
});

resize();
loadModel();
