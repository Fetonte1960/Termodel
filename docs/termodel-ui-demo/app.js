import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

const MODEL_URL = './TermodelWebModel.json';

const viewer = document.getElementById('viewer');
const modelPage = document.getElementById('modelPage');
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
    body: '<p>Comando attivo nella demo: selezioni una pianta, copi le istruzioni Termodel, apri il tuo ChatGPT e alleghi la stessa immagine. Quando GPT restituisce <code>DisegnoInput.svg</code>, puoi caricarlo o incollarlo qui, validarlo e visualizzarlo graficamente prima dell\'importazione.</p>'
  },
  'DisegnoInput': {
    title: 'DisegnoInput',
    body: '<p>Seleziona il disegno di input associato al progetto. Il modello Termodel viene costruito interpretando i DXF e i layer configurati nei piani.</p>'
  },
  'Edita nel Cad': {
    title: 'Edita nel CAD',
    body: '<p>Apre il disegno corrente nel CAD per modificarlo. Dopo il salvataggio del DXF, <strong>Aggiorna Modello</strong> rilegge il disegno e ricostruisce il modello termico.</p>'
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
    status.textContent = `Termodel Web Model · ${count} primitive · visibili ${visible}/${total}`;
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

async function loadModel() {
  if (loading) return;
  loading = true;
  status.textContent = 'Caricamento TermodelWebModel.json...';

  try {
    const response = await fetch(`${MODEL_URL}?t=${Date.now()}`, { cache: 'no-store' });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);

    const data = await response.json();
    if (data.format !== 'TermodelWebModel' || !Array.isArray(data.primitives))
      throw new Error('Formato TermodelWebModel non valido');

    lastModelData = data;
    disposeObject(modelGroup);
    disposeObject(edgeGroup);
    rebuildPianoFilters(data.primitives);
    updateFilterNote(data);

    let meshCount = 0;
    let lineCount = 0;

    data.primitives.forEach((primitive) => {
      if (primitive.kind === 'mesh') {
        createMeshPrimitive(primitive);
        meshCount += 1;
      } else if (primitive.kind === 'lineSegments') {
        createLinePrimitive(primitive);
        lineCount += 1;
      }
    });

    fitView();
    edgeGroup.visible = true;
    applyFilters();

    const objectInfo = document.querySelector('#infoPage .classic-row:nth-child(3) strong');
    if (objectInfo)
      objectInfo.textContent = `${data.primitiveCount ?? data.primitives.length} primitive dal JSON Termodel`;
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
    showDemoHelp(helpKeyFromElement(button));
    button.closest('.menu')?.classList.remove('open');
  });
});

document.addEventListener('click', () => {
  document.querySelectorAll('.menu').forEach(m => m.classList.remove('open'));
});


const RASTER_PROMPT_URL = './CreaPianoTermodelDaRaster.md';

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

function pointSegmentDistance(px, py, x1, y1, x2, y2) {
  const dx = x2 - x1;
  const dy = y2 - y1;
  const len2 = dx * dx + dy * dy;
  if (len2 <= Number.EPSILON) return Math.hypot(px - x1, py - y1);
  let t = ((px - x1) * dx + (py - y1) * dy) / len2;
  t = Math.max(0, Math.min(1, t));
  return Math.hypot(px - (x1 + t * dx), py - (y1 + t * dy));
}

function validateTermodelSvg(svg) {
  const parser = new DOMParser();
  const doc = parser.parseFromString(svg, 'image/svg+xml');
  const parseError = doc.querySelector('parsererror');
  if (parseError) throw new Error('Lo SVG non è XML valido.');

  const root = doc.documentElement;
  if (!root || root.localName.toLowerCase() !== 'svg')
    throw new Error('L\'elemento radice deve essere <svg>.');

  const directChildren = Array.from(root.children);
  const calpestabile = directChildren.find(el => el.localName === 'g' && el.id === 'calpestabile');
  const copertura = directChildren.find(el => el.localName === 'g' && el.id === 'copertura');
  if (!calpestabile || !copertura)
    throw new Error('Servono i due gruppi diretti <g id="calpestabile"> e <g id="copertura">.');

  const children = Array.from(calpestabile.children);
  const forbidden = children.find(el => !['line', 'text'].includes(el.localName));
  if (forbidden)
    throw new Error(`Elemento <${forbidden.localName}> non ammesso in calpestabile: usa solo line e text diretti.`);

  const lines = children
    .filter(el => el.localName === 'line')
    .map(el => ({
      x1: readNumberAttribute(el, 'x1'),
      y1: readNumberAttribute(el, 'y1'),
      x2: readNumberAttribute(el, 'x2'),
      y2: readNumberAttribute(el, 'y2')
    }));

  if (!lines.length) throw new Error('Il gruppo calpestabile non contiene pareti <line>.');

  const texts = children.filter(el => el.localName === 'text');
  const locCount = texts.filter(el => el.textContent.toUpperCase().includes('BLOCCO,LOC')).length;
  const finCount = texts.filter(el => el.textContent.toUpperCase().includes('BLOCCO,FIN')).length;
  if (!locCount) throw new Error('Manca almeno un blocco testuale BLOCCO,LOC.');

  const tolerance = 0.5; // come il controllo C# desktop: 0,5 cm nelle unità SVG
  for (let i = 0; i < lines.length; i++) {
    const endpoints = [[lines[i].x1, lines[i].y1], [lines[i].x2, lines[i].y2]];
    for (const [x, y] of endpoints) {
      let connected = false;
      for (let j = 0; j < lines.length; j++) {
        if (i === j) continue;
        const b = lines[j];
        if (pointSegmentDistance(x, y, b.x1, b.y1, b.x2, b.y2) <= tolerance) {
          connected = true;
          break;
        }
      }
      if (!connected)
        throw new Error(`Estremità non collegata alle coordinate (${x.toFixed(3)}, ${y.toFixed(3)}).`);
    }
  }

  return { lineCount: lines.length, locCount, finCount };
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

function processSvgText(text) {
  validatedSvg = '';
  rasterExportSvg.disabled = true;
  svgExportText.value = '';
  rasterValidation.className = 'raster-ai-validation';

  try {
    const extracted = extractSvg(text);
    const svg = extracted.svg;
    const result = validateTermodelSvg(svg);
    validatedSvg = svg;
    rasterSvgText.value = svg;
    showSvgPreview(svg);
    rasterValidation.textContent =
      `${extracted.transported ? '✓ Payload TERMODEL-SVG-TEXT-V1 decodificato\\n' : ''}✓ XML/SVG valido\n✓ gruppi calpestabile e copertura presenti\n✓ ${result.lineCount} linee\n✓ ${result.locCount} blocchi LOC\n✓ ${result.finCount} blocchi FIN\n✓ 0 estremità non collegate`;
    rasterValidation.classList.add('ok');
    rasterExportSvg.disabled = false;
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
    const response = await fetch(RASTER_PROMPT_URL, { cache: 'no-store' });
    if (!response.ok) throw new Error(`HTTP ${response.status}`);
    const instructions = await response.text();
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
  if (svgExportModal.classList.contains('visible')) {
    closeSvgExportDialog();
    return;
  }
  if (rasterAiModal.classList.contains('visible'))
    closeRasterAiDialog();
});

document.querySelectorAll('[data-action]').forEach(button => {
  button.addEventListener('click', () => {
    if (button.dataset.action === 'Crea piano da raster con AI') {
      openRasterAiDialog();
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

showDemoHelp('Benvenuto');

renderer.setAnimationLoop(() => {
  controls.update();
  renderer.render(scene, camera);
});

resize();
loadModel();
