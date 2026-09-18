// GeneraPianta Web Lite
// Input: SVG Termodel già interpretato da GPT.
// Topologia: JSTS (port JavaScript di JTS, famiglia di NetTopologySuite).
// Output: locali poligonali + SVG 2D pulito.
// Nessuna logica termica, mansardati, falde o validazione geometrica avanzata.

function getJsts() {
  const api = globalThis.jsts;
  if (!api)
    throw new Error('JSTS non disponibile: impossibile costruire la pianta.');
  return api;
}

function collectionToArray(collection) {
  if (!collection) return [];
  if (Array.isArray(collection)) return collection.filter(Boolean);
  if (Array.isArray(collection.array)) return collection.array.filter(Boolean);
  if (typeof collection.toArray === 'function')
    return Array.from(collection.toArray()).filter(Boolean);

  if (typeof collection.iterator === 'function') {
    const result = [];
    const iterator = collection.iterator();
    while (iterator.hasNext()) result.push(iterator.next());
    return result.filter(Boolean);
  }

  return [];
}

function numberAttr(element, name) {
  const value = Number.parseFloat(element.getAttribute(name) || '');
  if (!Number.isFinite(value))
    throw new Error(`Coordinata SVG non valida: ${name}.`);
  return value;
}

function readLinee(calpestabile) {
  return Array.from(calpestabile.children)
    .filter(el => el.localName === 'line')
    .map((el, index) => ({
      id: el.id || `L${String(index + 1).padStart(3, '0')}`,
      x1: numberAttr(el, 'x1'),
      y1: numberAttr(el, 'y1'),
      x2: numberAttr(el, 'x2'),
      y2: numberAttr(el, 'y2')
    }));
}

function readLocali(calpestabile) {
  return Array.from(calpestabile.children)
    .filter(el => el.localName === 'text' && /^R\d+/i.test(el.id || ''))
    .map((el, index) => {
      const righe = Array.from(el.querySelectorAll('tspan'))
        .map(t => (t.textContent || '').trim())
        .filter(Boolean);
      const descrizione = righe
        .find(r => r.toUpperCase().startsWith('DESCR.,'))
        ?.slice('DESCR.,'.length)
        .trim();

      return {
        id: el.id || `R${String(index + 1).padStart(3, '0')}`,
        x: numberAttr(el, 'x'),
        y: numberAttr(el, 'y'),
        descrizione: descrizione || el.id || `Locale ${index + 1}`
      };
    });
}

function polygonContainsPoint(jsts, polygon, point) {
  if (typeof polygon.contains === 'function')
    return polygon.contains(point);

  const RelateOp = jsts.operation?.relate?.RelateOp;
  if (RelateOp && typeof RelateOp.contains === 'function')
    return RelateOp.contains(polygon, point);

  throw new Error('JSTS non espone l’operazione contains richiesta da GeneraPianta.');
}

function ringCoordinates(ring) {
  const coords = Array.from(ring.getCoordinates() || [])
    .map(c => [Number(c.x), Number(c.y)])
    .filter(([x, y]) => Number.isFinite(x) && Number.isFinite(y));

  if (coords.length > 1) {
    const first = coords[0];
    const last = coords[coords.length - 1];
    if (Math.abs(first[0] - last[0]) < 1e-9 &&
        Math.abs(first[1] - last[1]) < 1e-9)
      coords.pop();
  }

  return coords;
}

function polygonToPlain(polygon) {
  const holes = [];
  for (let i = 0; i < polygon.getNumInteriorRing(); i++)
    holes.push(ringCoordinates(polygon.getInteriorRingN(i)));

  return {
    shell: ringCoordinates(polygon.getExteriorRing()),
    holes,
    area: Math.abs(Number(polygon.getArea?.() || 0))
  };
}

function matchLocaliToPolygons(jsts, geometryFactory, locali, polygons) {
  const matchedIndexes = new Set();
  const result = [];

  locali.forEach((locale) => {
    const point = geometryFactory.createPoint(
      new jsts.geom.Coordinate(locale.x, locale.y)
    );

    const candidates = polygons
      .map((polygon, index) => ({ polygon, index, area: Math.abs(polygon.getArea()) }))
      .filter(candidate => polygonContainsPoint(jsts, candidate.polygon, point))
      .sort((a, b) => a.area - b.area);

    if (!candidates.length)
      throw new Error(`JSTS non trova un poligono per il locale ${locale.id}.`);

    const selected = candidates.find(candidate => !matchedIndexes.has(candidate.index)) || candidates[0];
    matchedIndexes.add(selected.index);

    result.push({
      ...locale,
      ...polygonToPlain(selected.polygon)
    });
  });

  // Se lo SVG non contiene LOC, restituiamo comunque i poligoni costruiti.
  if (!locali.length) {
    polygons.forEach((polygon, index) => {
      const plain = polygonToPlain(polygon);
      result.push({
        id: `R-AI-${String(index + 1).padStart(3, '0')}`,
        descrizione: `Locale ${index + 1}`,
        x: plain.shell[0]?.[0] ?? 0,
        y: plain.shell[0]?.[1] ?? 0,
        ...plain
      });
    });
  }

  return result;
}

function bboxFromLinee(linee) {
  const xs = [];
  const ys = [];
  linee.forEach(l => {
    xs.push(l.x1, l.x2);
    ys.push(l.y1, l.y2);
  });

  const minX = Math.min(...xs);
  const maxX = Math.max(...xs);
  const minY = Math.min(...ys);
  const maxY = Math.max(...ys);
  const pad = Math.max((maxX - minX) * 0.025, (maxY - minY) * 0.025, 10);

  return {
    x: minX - pad,
    y: minY - pad,
    width: (maxX - minX) + pad * 2,
    height: (maxY - minY) + pad * 2
  };
}

function pathFromRing(ring) {
  if (!ring.length) return '';
  return `M ${ring.map(([x, y]) => `${x} ${y}`).join(' L ')} Z`;
}

function escapeXml(value) {
  return String(value)
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;')
    .replaceAll("'", '&apos;');
}

function generaSvgPulito(linee, locali) {
  const box = bboxFromLinee(linee);
  const roomPaths = locali.map(locale => {
    const d = [pathFromRing(locale.shell), ...locale.holes.map(pathFromRing)]
      .filter(Boolean)
      .join(' ');
    return `    <path id="${escapeXml(locale.id)}" d="${d}" fill="#f7f7f7" fill-rule="evenodd" stroke="#777" stroke-width="1" />`;
  }).join('\n');

  const wallLines = linee.map(line =>
    `    <line id="${escapeXml(line.id)}" x1="${line.x1}" y1="${line.y1}" x2="${line.x2}" y2="${line.y2}" />`
  ).join('\n');

  const labels = locali.map(locale =>
    `    <text x="${locale.x}" y="${locale.y}" text-anchor="middle" font-family="Arial, sans-serif" font-size="16">${escapeXml(locale.id)} — ${escapeXml(locale.descrizione)}</text>`
  ).join('\n');

  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="${box.x} ${box.y} ${box.width} ${box.height}">
  <rect x="${box.x}" y="${box.y}" width="${box.width}" height="${box.height}" fill="white" />
  <g id="locali-puliti">
${roomPaths}
  </g>
  <g id="pareti-pulite" fill="none" stroke="#111" stroke-width="4" stroke-linecap="square">
${wallLines}
  </g>
  <g id="etichette-locali" fill="#222">
${labels}
  </g>
</svg>`;
}

export function generaPiantaDaSvg(svgText) {
  const jsts = getJsts();
  const parser = new DOMParser();
  const doc = parser.parseFromString(svgText, 'image/svg+xml');

  const parseError = doc.querySelector('parsererror');
  if (parseError)
    throw new Error('Lo SVG ricevuto non è XML leggibile.');

  const root = doc.documentElement;
  const calpestabile = Array.from(root.children)
    .find(el => el.localName === 'g' && el.id === 'calpestabile');

  if (!calpestabile)
    throw new Error('Manca il gruppo calpestabile richiesto da GeneraPianta Web.');

  const linee = readLinee(calpestabile);
  if (!linee.length)
    throw new Error('Nessuna parete disponibile per GeneraPianta Web.');

  const localiInput = readLocali(calpestabile);

  const geometryFactory = new jsts.geom.GeometryFactory();
  const lineStrings = linee.map(line =>
    geometryFactory.createLineString([
      new jsts.geom.Coordinate(line.x1, line.y1),
      new jsts.geom.Coordinate(line.x2, line.y2)
    ])
  );

  // UnaryUnionOp esegue il noding del linework: le giunzioni a T diventano
  // nodi reali prima della polygonizzazione.
  const multiLine = geometryFactory.createMultiLineString(lineStrings);
  const noded = jsts.operation.union.UnaryUnionOp.union(multiLine);

  const polygonizer = new jsts.operation.polygonize.Polygonizer();
  polygonizer.add(noded);

  const polygons = collectionToArray(polygonizer.getPolygons());
  if (!polygons.length)
    throw new Error('JSTS Polygonizer non ha prodotto alcun locale.');

  const locali = matchLocaliToPolygons(jsts, geometryFactory, localiInput, polygons);
  const svgPulito = generaSvgPulito(linee, locali);

  return {
    linee,
    locali,
    svgPulito,
    stats: {
      linee: linee.length,
      loc: localiInput.length,
      poligoniJsts: polygons.length,
      locali: locali.length
    }
  };
}
