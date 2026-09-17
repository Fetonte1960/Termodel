import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

const viewer = document.getElementById('viewer');
const scene = new THREE.Scene();
scene.background = new THREE.Color(0xd3d3d3);

const camera = new THREE.PerspectiveCamera(38, 1, 0.1, 100);
camera.position.set(5.4, 4.2, 5.4);

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
renderer.shadowMap.enabled = true;
viewer.appendChild(renderer.domElement);

const controls = new OrbitControls(camera, renderer.domElement);
controls.enableDamping = true;
controls.dampingFactor = 0.08;
controls.target.set(0, 0.8, 0);
controls.minDistance = 2.5;
controls.maxDistance = 18;
controls.maxPolarAngle = Math.PI * 0.495;

scene.add(new THREE.HemisphereLight(0xffffff, 0x777777, 1.8));
const sun = new THREE.DirectionalLight(0xffffff, 2.0);
sun.position.set(5, 8, 6);
sun.castShadow = true;
scene.add(sun);

const floor = new THREE.Mesh(
  new THREE.PlaneGeometry(18, 18),
  new THREE.MeshStandardMaterial({ color: 0xd3d3d3, roughness: 1 })
);
floor.rotation.x = -Math.PI / 2;
floor.position.y = -1.01;
floor.receiveShadow = true;
scene.add(floor);

const material = new THREE.MeshStandardMaterial({
  color: 0xa95b31,
  roughness: 0.82,
  metalness: 0
});

const cube = new THREE.Mesh(new THREE.BoxGeometry(2.4, 2.0, 2.4), material);
cube.position.y = 0;
cube.castShadow = true;
cube.receiveShadow = true;
scene.add(cube);

const edges = new THREE.LineSegments(
  new THREE.EdgesGeometry(cube.geometry),
  new THREE.LineBasicMaterial({ color: 0x00e58a })
);
edges.position.copy(cube.position);
scene.add(edges);

const wireFrame = new THREE.LineSegments(
  new THREE.EdgesGeometry(new THREE.BoxGeometry(2.42, 2.02, 2.42)),
  new THREE.LineBasicMaterial({ color: 0x00e58a, transparent: true, opacity: 0.35 })
);
wireFrame.position.copy(cube.position);
wireFrame.visible = false;
scene.add(wireFrame);

function resetView() {
  camera.position.set(5.4, 4.2, 5.4);
  controls.target.set(0, 0.8, 0);
  controls.update();
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

document.getElementById('resetView').addEventListener('click', resetView);
document.getElementById('filtersCheck').addEventListener('change', (event) => {
  wireFrame.visible = event.target.checked;
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
    const status = document.querySelector('.viewport-status');
    status.textContent = `${button.dataset.action} · comando dimostrativo non ancora collegato al C#`;
    setTimeout(() => {
      status.textContent = 'Three.js · prototipo Web della finestra grafica Termodel';
    }, 1800);
  });
});

renderer.setAnimationLoop(() => {
  controls.update();
  renderer.render(scene, camera);
});

resetView();
resize();
