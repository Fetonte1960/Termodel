import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

const MODEL_URL = 'https://raw.githubusercontent.com/Fetonte1960/Termodel/main/SorgentiTermodel/Work/Web/TermodelWebModel.json';

const viewer = document.getElementById('viewer');
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
  // x resta x, z Termodel diventa y, y Termodel diventa -z.
  return [vertex[0], vertex[2], -vertex[1]];
}

function createMeshPrimitive(primitive) {
  if (!Array.isArray(primitive.vertices) || primitive.vertices.length === 0) return;

  const positions = [];
  primitive.vertices.forEach((vertex) => {
    positions.push(...fromTermodelPoint(vertex));
  });

  const geometry = new THREE.BufferGeometry();
  geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));

  if (Array.isArray(primitive.indices) && primitive.indices.length >= 3) {
    geometry.setIndex(primitive.indices);
  }

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

  const mesh = new THREE.Mesh(geometry, material);
  mesh.userData = {
    numero: primitive.numero,
    id: primitive.id || '',
    tipo: primitive.tipo || '',
    descrizione: primitive.descrizione || '',
    parte: primitive.parte || ''
  };
  modelGroup.add(mesh);

  // Contorno verde analogo al modello desktop mostrato da DrawBim.
  const edgeGeometry = new THREE.EdgesGeometry(geometry, 20);
  const edges = new THREE.LineSegments(
    edgeGeometry,
    new THREE.LineBasicMaterial({ color: 0x00e58a })
  );
  edgeGroup.add(edges);
}

function createLinePrimitive(primitive) {
  if (!Array.isArray(primitive.vertices) || primitive.vertices.length < 2) return;

  const positions = [];
  primitive.vertices.forEach((vertex) => {
    positions.push(...fromTermodelPoint(vertex));
  });

  const geometry = new THREE.BufferGeometry();
  geometry.setAttribute('position', new THREE.Float32BufferAttribute(positions, 3));

  if (Array.isArray(primitive.indices) && primitive.indices.length >= 2) {
    geometry.setIndex(primitive.indices);
  }

  const line = new THREE.LineSegments(
    geometry,
    new THREE.LineBasicMaterial({ color: primitive.color || '#00e58a' })
  );
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

  homeView = {
    position: position.clone(),
    target: center.clone()
  };

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
    if (data.format !== 'TermodelWebModel' || !Array.isArray(data.primitives)) {
      throw new Error('Formato TermodelWebModel non valido');
    }

    disposeObject(modelGroup);
    disposeObject(edgeGroup);

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

    status.textContent = `Termodel Web Model · ${data.primitiveCount ?? data.primitives.length} primitive · ${meshCount} mesh${lineCount ? ` · ${lineCount} linee` : ''}`;

    const objectInfo = document.querySelector('#infoPage .classic-row:nth-child(3) strong');
    if (objectInfo) objectInfo.textContent = `${data.primitiveCount ?? data.primitives.length} primitive dal JSON Termodel`;
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
  await loadModel();
  resetView();
});

document.getElementById('filtersCheck').addEventListener('change', (event) => {
  edgeGroup.visible = !event.target.checked;
});

document.querySelectorAll('.tab').forEach(tab => {
  tab.addEventListener('click', () => {
    document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
    tab.classList.add('active');
    document.getElementById(tab.dataset.page).classList.add('active');
    if (tab.dataset.page === 'modelPage') requestAnimationFrame(resize);
  });
});

document.querySelectorAll('.menu > button').forEach(button => {
  button.addEventListener('click', (event) => {
    event.stopPropagation();
    const menu = button.parentElement;
    document.querySelectorAll('.menu').forEach(m => { if (m !== menu) m.classList.remove('open'); });
    menu.classList.toggle('open');
  });
});

document.addEventListener('click', () => {
  document.querySelectorAll('.menu').forEach(m => m.classList.remove('open'));
});

document.querySelectorAll('[data-action]').forEach(button => {
  button.addEventListener('click', () => {
    status.textContent = `${button.dataset.action} · comando dimostrativo non ancora collegato al C#`;
    setTimeout(() => {
      if (!loading) status.textContent = 'Termodel Web Model · modello JSON generato dal desktop';
    }, 1800);
  });
});

renderer.setAnimationLoop(() => {
  controls.update();
  renderer.render(scene, camera);
});

resize();
loadModel();
