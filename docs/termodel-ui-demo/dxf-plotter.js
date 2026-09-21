// Termodel Web v0.60 — DXF background "pen plotter".
// Parser ASCII DXF deliberately limited to 2D background rendering.
// It does not create Termodel entities: it converts selected DXF content to SVG.

const UNIT_NAMES = new Map([
  [0, 'senza unità'],
  [1, 'pollici'],
  [2, 'piedi'],
  [4, 'mm'],
  [5, 'cm'],
  [6, 'm'],
  [10, 'yard']
]);

function dxfPairs(text) {
  const lines = String(text || '').replace(/\r/g, '').split('\n');
  const pairs = [];
  for (let i = 0; i + 1 < lines.length; i += 2) {
    const rawCode = lines[i].replace(/^\uFEFF/, '').trim();
    if (!rawCode) continue;
    const code = Number(rawCode);
    if (!Number.isFinite(code)) continue;
    pairs.push({ code, value: String(lines[i + 1] ?? '').trimEnd() });
  }
  return pairs;
}

function findSection(pairs, name) {
  for (let i = 0; i < pairs.length - 1; i++) {
    if (pairs[i].code === 0 && pairs[i].value === 'SECTION' &&
        pairs[i + 1].code === 2 && pairs[i + 1].value === name) {
      const start = i + 2;
      for (let j = start; j < pairs.length; j++) {
        if (pairs[j].code === 0 && pairs[j].value === 'ENDSEC')
          return pairs.slice(start, j);
      }
    }
  }
  return [];
}

function num(value, fallback = 0) {
  const n = Number(value);
  return Number.isFinite(n) ? n : fallback;
}

function first(fields, code, fallback = '') {
  const pair = fields.find(item => item.code === code);
  return pair ? pair.value : fallback;
}

function all(fields, code) {
  return fields.filter(item => item.code === code).map(item => item.value);
}

function pointFrom(fields, xCode, yCode) {
  return {
    x: num(first(fields, xCode, 0)),
    y: num(first(fields, yCode, 0))
  };
}

function parseHeader(section) {
  const header = {};
  for (let i = 0; i < section.length; i++) {
    if (section[i].code !== 9) continue;
    const key = section[i].value;
    const values = [];
    for (i = i + 1; i < section.length && section[i].code !== 9; i++)
      values.push(section[i]);
    i--;
    header[key] = values;
  }
  const insUnitsPair = (header.$INSUNITS || []).find(pair => pair.code === 70);
  const insUnits = insUnitsPair ? num(insUnitsPair.value, 0) : 0;
  return {
    variables: header,
    insUnits,
    unitsLabel: UNIT_NAMES.get(insUnits) || ('codice ' + insUnits)
  };
}

function parseLayerTable(section) {
  const layers = new Set();
  for (let i = 0; i < section.length; i++) {
    if (section[i].code !== 0 || section[i].value !== 'LAYER') continue;
    const fields = [];
    for (i = i + 1; i < section.length && section[i].code !== 0; i++)
      fields.push(section[i]);
    i--;
    const name = String(first(fields, 2, '0')).trim() || '0';
    layers.add(name);
  }
  return layers;
}

function parsePolylineVertices(fields) {
  const vertices = [];
  let current = null;
  for (const pair of fields) {
    if (pair.code === 10) {
      current = { x: num(pair.value), y: 0, bulge: 0 };
      vertices.push(current);
    } else if (pair.code === 20 && current) {
      current.y = num(pair.value);
    } else if (pair.code === 42 && current) {
      current.bulge = num(pair.value);
    }
  }
  return vertices;
}

function parseSimpleEntity(type, fields) {
  const layer = String(first(fields, 8, '0')).trim() || '0';
  const common = { type, layer };

  if (type === 'LINE') {
    return {
      ...common,
      start: pointFrom(fields, 10, 20),
      end: pointFrom(fields, 11, 21)
    };
  }

  if (type === 'LWPOLYLINE') {
    return {
      ...common,
      vertices: parsePolylineVertices(fields),
      closed: (num(first(fields, 70, 0)) & 1) !== 0
    };
  }

  if (type === 'ARC') {
    return {
      ...common,
      center: pointFrom(fields, 10, 20),
      radius: Math.abs(num(first(fields, 40, 0))),
      startAngle: num(first(fields, 50, 0)),
      endAngle: num(first(fields, 51, 0))
    };
  }

  if (type === 'CIRCLE') {
    return {
      ...common,
      center: pointFrom(fields, 10, 20),
      radius: Math.abs(num(first(fields, 40, 0)))
    };
  }

  if (type === 'ELLIPSE') {
    return {
      ...common,
      center: pointFrom(fields, 10, 20),
      major: pointFrom(fields, 11, 21),
      ratio: Math.abs(num(first(fields, 40, 1), 1)),
      startParam: num(first(fields, 41, 0)),
      endParam: num(first(fields, 42, Math.PI * 2), Math.PI * 2)
    };
  }

  if (type === 'SPLINE') {
    const control = [];
    let p = null;
    for (const pair of fields) {
      if (pair.code === 10) {
        p = { x: num(pair.value), y: 0 };
        control.push(p);
      } else if (pair.code === 20 && p) {
        p.y = num(pair.value);
      }
    }
    return { ...common, controlPoints: control };
  }

  if (type === 'TEXT') {
    return {
      ...common,
      point: pointFrom(fields, 10, 20),
      height: Math.abs(num(first(fields, 40, 2.5), 2.5)),
      rotation: num(first(fields, 50, 0)),
      text: String(first(fields, 1, ''))
    };
  }

  if (type === 'MTEXT') {
    const chunks = [...all(fields, 3), ...all(fields, 1)];
    return {
      ...common,
      point: pointFrom(fields, 10, 20),
      height: Math.abs(num(first(fields, 40, 2.5), 2.5)),
      rotation: num(first(fields, 50, 0)),
      text: chunks.join('')
    };
  }

  if (type === 'INSERT') {
    return {
      ...common,
      block: String(first(fields, 2, '')).trim(),
      point: pointFrom(fields, 10, 20),
      scaleX: num(first(fields, 41, 1), 1),
      scaleY: num(first(fields, 42, 1), 1),
      rotation: num(first(fields, 50, 0))
    };
  }

  return { ...common, raw: fields };
}

function parseEntityAt(section, startIndex) {
  const type = section[startIndex]?.value || '';
  if (section[startIndex]?.code !== 0)
    return { entity: null, nextIndex: startIndex + 1 };

  const headerFields = [];
  let i = startIndex + 1;
  while (i < section.length && section[i].code !== 0) {
    headerFields.push(section[i]);
    i++;
  }

  if (type !== 'POLYLINE') {
    return {
      entity: parseSimpleEntity(type, headerFields),
      nextIndex: i
    };
  }

  const layer = String(first(headerFields, 8, '0')).trim() || '0';
  const entity = {
    type: 'POLYLINE',
    layer,
    closed: (num(first(headerFields, 70, 0)) & 1) !== 0,
    vertices: []
  };

  while (i < section.length) {
    if (section[i].code !== 0) {
      i++;
      continue;
    }
    const childType = section[i].value;
    if (childType === 'SEQEND') {
      i++;
      break;
    }
    if (childType !== 'VERTEX')
      break;

    const vertexFields = [];
    i++;
    while (i < section.length && section[i].code !== 0) {
      vertexFields.push(section[i]);
      i++;
    }
    entity.vertices.push({
      x: num(first(vertexFields, 10, 0)),
      y: num(first(vertexFields, 20, 0)),
      bulge: num(first(vertexFields, 42, 0))
    });
  }

  return { entity, nextIndex: i };
}

function parseEntities(section) {
  const entities = [];
  let i = 0;
  while (i < section.length) {
    if (section[i].code !== 0) {
      i++;
      continue;
    }
    const parsed = parseEntityAt(section, i);
    if (parsed.entity && parsed.entity.type && !['ENDSEC', 'SEQEND'].includes(parsed.entity.type))
      entities.push(parsed.entity);
    i = Math.max(parsed.nextIndex, i + 1);
  }
  return entities;
}

function parseBlocks(section) {
  const blocks = new Map();
  let i = 0;

  while (i < section.length) {
    if (section[i].code !== 0 || section[i].value !== 'BLOCK') {
      i++;
      continue;
    }

    const header = [];
    i++;
    while (i < section.length && section[i].code !== 0) {
      header.push(section[i]);
      i++;
    }

    const name = String(first(header, 2, first(header, 3, ''))).trim();
    const base = pointFrom(header, 10, 20);
    const entities = [];

    while (i < section.length) {
      if (section[i].code === 0 && section[i].value === 'ENDBLK') {
        i++;
        break;
      }
      if (section[i].code !== 0) {
        i++;
        continue;
      }
      const parsed = parseEntityAt(section, i);
      if (parsed.entity) entities.push(parsed.entity);
      i = Math.max(parsed.nextIndex, i + 1);
    }

    if (name)
      blocks.set(name, { name, base, entities });
  }

  return blocks;
}

function collectLayers(model) {
  const counts = new Map();
  const add = layer => {
    const key = String(layer || '0').trim() || '0';
    counts.set(key, (counts.get(key) || 0) + 1);
  };

  model.tableLayers.forEach(layer => {
    if (!counts.has(layer)) counts.set(layer, 0);
  });
  model.entities.forEach(entity => add(entity.layer));
  model.blocks.forEach(block => block.entities.forEach(entity => add(entity.layer)));

  return Array.from(counts.entries())
    .map(([name, count]) => ({ name, count }))
    .sort((a, b) => a.name.localeCompare(b.name, undefined, { numeric: true }));
}

export function parseDxfPlotSource(text) {
  const pairs = dxfPairs(text);
  if (!pairs.length)
    throw new Error('Il file DXF non contiene coppie group-code leggibili.');

  const header = parseHeader(findSection(pairs, 'HEADER'));
  const tableLayers = parseLayerTable(findSection(pairs, 'TABLES'));
  const blocks = parseBlocks(findSection(pairs, 'BLOCKS'));
  const entities = parseEntities(findSection(pairs, 'ENTITIES'));

  if (!entities.length && !blocks.size)
    throw new Error('Il DXF non contiene entità 2D convertibili.');

  const model = { header, tableLayers, blocks, entities };
  model.layers = collectLayers(model);
  return model;
}

export function getDxfLayerSummary(model) {
  return Array.isArray(model?.layers) ? model.layers.map(item => ({ ...item })) : [];
}

const IDENTITY = [1, 0, 0, 1, 0, 0];

function multiply(a, b) {
  return [
    a[0] * b[0] + a[2] * b[1],
    a[1] * b[0] + a[3] * b[1],
    a[0] * b[2] + a[2] * b[3],
    a[1] * b[2] + a[3] * b[3],
    a[0] * b[4] + a[2] * b[5] + a[4],
    a[1] * b[4] + a[3] * b[5] + a[5]
  ];
}

function translation(x, y) {
  return [1, 0, 0, 1, x, y];
}

function scaling(x, y) {
  return [x, 0, 0, y, 0, 0];
}

function rotation(degrees) {
  const radians = degrees * Math.PI / 180;
  const c = Math.cos(radians);
  const s = Math.sin(radians);
  return [c, s, -s, c, 0, 0];
}

function transformPoint(matrix, point) {
  return {
    x: matrix[0] * point.x + matrix[2] * point.y + matrix[4],
    y: matrix[1] * point.x + matrix[3] * point.y + matrix[5]
  };
}

function insertMatrix(entity, block) {
  return multiply(
    translation(entity.point.x, entity.point.y),
    multiply(
      rotation(entity.rotation || 0),
      multiply(
        scaling(entity.scaleX || 1, entity.scaleY || 1),
        translation(-block.base.x, -block.base.y)
      )
    )
  );
}

function escapeXml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

function cleanMText(value) {
  return String(value || '')
    .replace(/\\P/gi, ' ')
    .replace(/\{\\[^;]+;/g, '')
    .replace(/[{}]/g, '')
    .replace(/\\[A-Za-z][^;]*;/g, '')
    .trim();
}

function bulgeSegment(a, b, bulge) {
  if (!bulge || Math.abs(bulge) < 1e-9) return [a, b];
  const dx = b.x - a.x;
  const dy = b.y - a.y;
  const chord = Math.hypot(dx, dy);
  if (chord < 1e-9) return [a, b];

  const theta = 4 * Math.atan(bulge);
  const offset = chord / (2 * Math.tan(theta / 2));
  const mx = (a.x + b.x) / 2;
  const my = (a.y + b.y) / 2;
  const nx = -dy / chord;
  const ny = dx / chord;
  const center = { x: mx + nx * offset, y: my + ny * offset };
  const radius = Math.hypot(a.x - center.x, a.y - center.y);
  const start = Math.atan2(a.y - center.y, a.x - center.x);
  const segments = Math.max(4, Math.ceil(Math.abs(theta) / (Math.PI / 18)));
  const points = [];
  for (let i = 0; i <= segments; i++) {
    const t = start + theta * (i / segments);
    points.push({
      x: center.x + radius * Math.cos(t),
      y: center.y + radius * Math.sin(t)
    });
  }
  return points;
}

function arcPoints(entity, fullCircle = false) {
  if (!entity.radius) return [];
  let start = fullCircle ? 0 : entity.startAngle * Math.PI / 180;
  let end = fullCircle ? Math.PI * 2 : entity.endAngle * Math.PI / 180;
  if (!fullCircle) {
    while (end <= start) end += Math.PI * 2;
  }
  const sweep = end - start;
  const segments = Math.max(12, Math.ceil(Math.abs(sweep) / (Math.PI / 36)));
  const points = [];
  for (let i = 0; i <= segments; i++) {
    const t = start + sweep * (i / segments);
    points.push({
      x: entity.center.x + entity.radius * Math.cos(t),
      y: entity.center.y + entity.radius * Math.sin(t)
    });
  }
  return points;
}

function ellipsePoints(entity) {
  const majorLength = Math.hypot(entity.major.x, entity.major.y);
  if (!majorLength) return [];
  const majorAngle = Math.atan2(entity.major.y, entity.major.x);
  const minorLength = majorLength * (entity.ratio || 1);
  let start = entity.startParam || 0;
  let end = Number.isFinite(entity.endParam) ? entity.endParam : Math.PI * 2;
  while (end <= start) end += Math.PI * 2;
  const sweep = end - start;
  const segments = Math.max(18, Math.ceil(Math.abs(sweep) / (Math.PI / 36)));
  const c = Math.cos(majorAngle);
  const s = Math.sin(majorAngle);
  const points = [];
  for (let i = 0; i <= segments; i++) {
    const t = start + sweep * (i / segments);
    const lx = majorLength * Math.cos(t);
    const ly = minorLength * Math.sin(t);
    points.push({
      x: entity.center.x + lx * c - ly * s,
      y: entity.center.y + lx * s + ly * c
    });
  }
  return points;
}

function polylinePoints(entity, includeCurves) {
  const vertices = entity.vertices || [];
  if (vertices.length < 2) return [];

  const result = [vertices[0]];
  const count = entity.closed ? vertices.length : vertices.length - 1;
  for (let i = 0; i < count; i++) {
    const a = vertices[i];
    const b = vertices[(i + 1) % vertices.length];
    const segment = includeCurves && a.bulge
      ? bulgeSegment(a, b, a.bulge)
      : [a, b];
    result.push(...segment.slice(1));
  }
  return result;
}

function normalizeOptions(model, options = {}) {
  const available = getDxfLayerSummary(model).map(item => item.name);
  const layers = options.layers instanceof Set
    ? options.layers
    : new Set(Array.isArray(options.layers) ? options.layers : available);
  return {
    layers,
    curves: Boolean(options.curves),
    convertText: Boolean(options.convertText),
    explodeBlocks: Boolean(options.explodeBlocks)
  };
}

function entityAllowedByMode(entity, options) {
  if (['LINE', 'LWPOLYLINE', 'POLYLINE'].includes(entity.type)) return true;
  if (options.curves && ['ARC', 'CIRCLE', 'ELLIPSE', 'SPLINE'].includes(entity.type)) return true;
  if (options.convertText && ['TEXT', 'MTEXT'].includes(entity.type)) return true;
  if (entity.type === 'INSERT') return options.explodeBlocks;
  return false;
}

export function estimateDxfConversion(model, options = {}) {
  const normalized = normalizeOptions(model, options);
  let selected = 0;
  let ignored = 0;
  let blocks = 0;

  const visit = (entities, inheritedLayer = '', depth = 0) => {
    if (depth > 8) return;
    for (const entity of entities || []) {
      const layer = entity.layer === '0' && inheritedLayer ? inheritedLayer : entity.layer;
      if (!normalized.layers.has(layer)) {
        ignored++;
        continue;
      }
      if (entity.type === 'INSERT' && normalized.explodeBlocks) {
        const block = model.blocks.get(entity.block);
        if (!block) {
          ignored++;
          continue;
        }
        blocks++;
        visit(block.entities, layer, depth + 1);
        continue;
      }
      if (entityAllowedByMode(entity, normalized)) selected++;
      else ignored++;
    }
  };

  visit(model.entities);
  return { selected, ignored, blocks };
}

export function convertDxfToSvg(model, options = {}) {
  const normalized = normalizeOptions(model, options);
  const layerPaths = new Map();
  const textItems = [];
  const stats = {
    converted: 0,
    ignored: 0,
    unsupported: 0,
    explodedBlocks: 0
  };

  let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;

  const updateBounds = p => {
    if (!Number.isFinite(p.x) || !Number.isFinite(p.y)) return;
    const sy = -p.y;
    minX = Math.min(minX, p.x);
    maxX = Math.max(maxX, p.x);
    minY = Math.min(minY, sy);
    maxY = Math.max(maxY, sy);
  };

  const pathForLayer = layer => {
    const key = String(layer || '0');
    if (!layerPaths.has(key)) layerPaths.set(key, []);
    return layerPaths.get(key);
  };

  const emitPolyline = (points, matrix, layer) => {
    if (!points || points.length < 2) return false;
    const transformed = points.map(p => transformPoint(matrix, p));
    transformed.forEach(updateBounds);
    const commands = transformed.map((p, index) =>
      (index ? 'L ' : 'M ') + p.x.toFixed(5) + ' ' + (-p.y).toFixed(5)
    ).join(' ');
    pathForLayer(layer).push(commands);
    return true;
  };

  const renderEntity = (entity, matrix = IDENTITY, inheritedLayer = '', depth = 0) => {
    if (!entity || depth > 8) {
      stats.ignored++;
      return;
    }

    const layer = entity.layer === '0' && inheritedLayer ? inheritedLayer : (entity.layer || '0');
    if (!normalized.layers.has(layer)) {
      stats.ignored++;
      return;
    }

    if (entity.type === 'INSERT') {
      if (!normalized.explodeBlocks) {
        stats.ignored++;
        return;
      }
      const block = model.blocks.get(entity.block);
      if (!block) {
        stats.unsupported++;
        return;
      }
      const local = insertMatrix(entity, block);
      const combined = multiply(matrix, local);
      stats.explodedBlocks++;
      for (const child of block.entities)
        renderEntity(child, combined, layer, depth + 1);
      return;
    }

    let emitted = false;

    if (entity.type === 'LINE') {
      emitted = emitPolyline([entity.start, entity.end], matrix, layer);
    } else if (entity.type === 'LWPOLYLINE' || entity.type === 'POLYLINE') {
      emitted = emitPolyline(polylinePoints(entity, normalized.curves), matrix, layer);
    } else if (normalized.curves && entity.type === 'ARC') {
      emitted = emitPolyline(arcPoints(entity, false), matrix, layer);
    } else if (normalized.curves && entity.type === 'CIRCLE') {
      emitted = emitPolyline(arcPoints(entity, true), matrix, layer);
    } else if (normalized.curves && entity.type === 'ELLIPSE') {
      emitted = emitPolyline(ellipsePoints(entity), matrix, layer);
    } else if (normalized.curves && entity.type === 'SPLINE') {
      emitted = emitPolyline(entity.controlPoints || [], matrix, layer);
    } else if (normalized.convertText && (entity.type === 'TEXT' || entity.type === 'MTEXT')) {
      const p = transformPoint(matrix, entity.point);
      updateBounds(p);
      const content = cleanMText(entity.text);
      if (content) {
        textItems.push({
          layer,
          x: p.x,
          y: -p.y,
          height: Math.max(0.1, entity.height || 2.5),
          rotation: -(entity.rotation || 0),
          text: content
        });
        emitted = true;
      }
    } else {
      stats.ignored++;
      return;
    }

    if (emitted) stats.converted++;
    else stats.unsupported++;
  };

  for (const entity of model.entities)
    renderEntity(entity);

  if (!Number.isFinite(minX) || !Number.isFinite(minY) ||
      !Number.isFinite(maxX) || !Number.isFinite(maxY)) {
    throw new Error('Le opzioni selezionate non producono geometria DXF visibile.');
  }

  const width = Math.max(1e-6, maxX - minX);
  const height = Math.max(1e-6, maxY - minY);
  const margin = Math.max(width, height) * 0.02 || 1;
  const vb = [
    minX - margin,
    minY - margin,
    width + margin * 2,
    height + margin * 2
  ];

  const groups = [];
  for (const [layer, paths] of layerPaths.entries()) {
    if (!paths.length) continue;
    groups.push(
      '<g data-dxf-layer="' + escapeXml(layer) + '">' +
      '<path d="' + paths.join(' ') + '" />' +
      '</g>'
    );
  }

  for (const item of textItems) {
    const transform = item.rotation
      ? ' transform="rotate(' + item.rotation.toFixed(3) + ' ' + item.x.toFixed(5) + ' ' + item.y.toFixed(5) + ')"'
      : '';
    groups.push(
      '<text data-dxf-layer="' + escapeXml(item.layer) + '"' +
      ' x="' + item.x.toFixed(5) + '"' +
      ' y="' + item.y.toFixed(5) + '"' +
      ' font-family="Arial, sans-serif"' +
      ' font-size="' + item.height.toFixed(5) + '"' +
      ' fill="#222" stroke="none"' +
      transform + '>' +
      escapeXml(item.text) +
      '</text>'
    );
  }

  const svgText =
    '<?xml version="1.0" encoding="UTF-8"?>' +
    '<svg xmlns="http://www.w3.org/2000/svg"' +
    ' viewBox="' + vb.map(value => value.toFixed(5)).join(' ') + '"' +
    ' fill="none" stroke="#222" stroke-width="' + Math.max(width, height) / 1800 + '"' +
    ' stroke-linecap="round" stroke-linejoin="round"' +
    ' data-termodel-dxf-plotter="1">' +
    groups.join('') +
    '</svg>';

  return {
    svgText,
    stats,
    bounds: { minX, minY, maxX, maxY, width, height },
    unitsCode: model.header.insUnits,
    unitsLabel: model.header.unitsLabel
  };
}
