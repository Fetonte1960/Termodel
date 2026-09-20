// Termodel Web v0.58 — conversione bidirezionale TERMODEL-PROJECT-TEXT-V1.
// Il progetto unico resta il contenitore; questo modulo aggiorna soltanto le
// sezioni modificate dal frontend e conserva tutte le altre sezioni.

export const TERMODEL_PROJECT_START = '[TERMODEL-PROJECT-TEXT-V1]';
export const TERMODEL_PROJECT_END = '[END-TERMODEL-PROJECT-TEXT-V1]';

const ARCHIVE_ARRAY_KEYS = [
  'records', 'Records',
  'items', 'Items',
  'data', 'Data',
  'dataCollection', 'DataCollection',
  'rows', 'Rows'
];

function normalizeSource(source) {
  return String(source == null ? '' : source).replace(/\r\n?/g, '\n').trim();
}

export function isTermodelProjectText(text) {
  const source = String(text == null ? '' : text).toUpperCase();
  return source.includes(TERMODEL_PROJECT_START) && source.includes(TERMODEL_PROJECT_END);
}

export function parseTermodelProjectText(source) {
  const normalized = normalizeSource(source);
  if (!isTermodelProjectText(normalized))
    throw new Error('File progetto TERMODEL-PROJECT-TEXT-V1 non valido o incompleto.');

  const lines = normalized.split('\n');
  const sections = new Map();
  const sectionOrder = [];

  for (let i = 0; i < lines.length; i++) {
    const match = lines[i].match(/^---BEGIN:(.+)---\s*$/);
    if (!match) continue;

    const name = match[1].trim();
    const expectedEnd = '---END:' + name + '---';
    const body = [];
    let closed = false;

    for (i = i + 1; i < lines.length; i++) {
      if (lines[i].trim() === expectedEnd) {
        closed = true;
        break;
      }
      body.push(lines[i]);
    }

    if (!closed)
      throw new Error('Sezione progetto non chiusa: ' + name + '.');

    sections.set(name, body.join('\n').replace(/\n+$/, ''));
    sectionOrder.push(name);
  }

  if (!sections.size)
    throw new Error('Il progetto TERMODEL-PROJECT-TEXT-V1 non contiene sezioni.');

  return { source: normalized, sections, sectionOrder };
}

export function getTermodelProjectSection(source, sectionName) {
  return parseTermodelProjectText(source).sections.get(sectionName) || '';
}

export function replaceTermodelProjectSection(source, sectionName, sectionText) {
  const normalized = normalizeSource(source);
  const begin = '---BEGIN:' + sectionName + '---';
  const end = '---END:' + sectionName + '---';
  const beginIndex = normalized.indexOf(begin);
  if (beginIndex < 0)
    throw new Error('Il progetto non contiene la sezione ' + sectionName + '.');

  const bodyStart = beginIndex + begin.length;
  const endIndex = normalized.indexOf(end, bodyStart);
  if (endIndex < 0)
    throw new Error('La sezione ' + sectionName + ' del progetto non è chiusa.');

  return normalized.slice(0, bodyStart) +
    '\n' + String(sectionText == null ? '' : sectionText).trim() + '\n' +
    normalized.slice(endIndex);
}

function parseArchiveJsonShape(sectionText) {
  let parsed;
  try {
    parsed = JSON.parse(sectionText);
  } catch (error) {
    throw new Error('Archivio JSON non valido: ' + error.message);
  }

  if (Array.isArray(parsed))
    return { root: parsed, key: '', records: parsed };

  if (!parsed || typeof parsed !== 'object')
    throw new Error('Archivio JSON non valido.');

  for (const key of ARCHIVE_ARRAY_KEYS) {
    if (Array.isArray(parsed[key]))
      return { root: parsed, key, records: parsed[key] };
  }

  return { root: parsed, key: '', records: [parsed], singleObject: true };
}

function buildJsonTypeMap(templateRecords) {
  const types = new Map();
  for (const record of templateRecords || []) {
    if (!record || typeof record !== 'object' || Array.isArray(record)) continue;
    for (const [key, value] of Object.entries(record)) {
      if (value === null || value === undefined || types.has(key)) continue;
      types.set(key, typeof value);
    }
  }
  return types;
}

function coerceJsonValue(value, type) {
  if (value === null || value === undefined) return value;
  if (type === 'number') {
    const numeric = Number(String(value).replace(',', '.'));
    return Number.isFinite(numeric) ? numeric : value;
  }
  if (type === 'boolean') {
    if (value === true || value === false) return value;
    const text = String(value).trim().toLowerCase();
    if (text === 'true') return true;
    if (text === 'false') return false;
  }
  return value;
}

function typedArchiveRecords(originalJson, records) {
  const shape = parseArchiveJsonShape(originalJson);
  const typeMap = buildJsonTypeMap(shape.records);
  return (records || []).map((record) => {
    const output = {};
    for (const [key, value] of Object.entries(record || {}))
      output[key] = coerceJsonValue(value, typeMap.get(key));
    return output;
  });
}

function serializeArchiveJson(originalJson, records) {
  const shape = parseArchiveJsonShape(originalJson);
  const typed = typedArchiveRecords(originalJson, records);

  if (Array.isArray(shape.root))
    return JSON.stringify(typed, null, 2);

  if (shape.key) {
    const root = { ...shape.root, [shape.key]: typed };
    return JSON.stringify(root, null, 2);
  }

  if (shape.singleObject)
    return JSON.stringify(typed[0] || {}, null, 2);

  return JSON.stringify(typed, null, 2);
}

function decodeXml(text) {
  return String(text == null ? '' : text)
    .replace(/&#x([0-9a-f]+);/gi, (_, value) => String.fromCodePoint(parseInt(value, 16)))
    .replace(/&#([0-9]+);/g, (_, value) => String.fromCodePoint(parseInt(value, 10)))
    .replace(/&quot;/g, '"')
    .replace(/&apos;/g, "'")
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&amp;/g, '&');
}

function encodeXml(text) {
  return String(text == null ? '' : text)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&apos;');
}

function parseArchiveXmlTemplate(xmlText) {
  const rows = [];
  const globalTypes = new Map();
  const rowRegex = /<ArrayOfKeyValueOfstringanyType>([\s\S]*?)<\/ArrayOfKeyValueOfstringanyType>/g;
  let rowMatch;

  while ((rowMatch = rowRegex.exec(String(xmlText || ''))) !== null) {
    const row = { order: [], values: {}, types: {} };
    const kvRegex = /<KeyValueOfstringanyType>([\s\S]*?)<\/KeyValueOfstringanyType>/g;
    let kvMatch;

    while ((kvMatch = kvRegex.exec(rowMatch[1])) !== null) {
      const block = kvMatch[1];
      const keyMatch = block.match(/<Key>([\s\S]*?)<\/Key>/);
      if (!keyMatch) continue;
      const key = decodeXml(keyMatch[1]);
      row.order.push(key);

      const selfClosing = block.match(/<Value\b([^>]*)\/>/);
      const full = block.match(/<Value\b([^>]*)>([\s\S]*?)<\/Value>/);
      const attrs = selfClosing ? selfClosing[1] : (full ? full[1] : '');
      const typeMatch = attrs.match(/i:type="d4p1:([^"]+)"/);
      const type = typeMatch ? typeMatch[1] : '';
      if (type) {
        row.types[key] = type;
        if (!globalTypes.has(key)) globalTypes.set(key, type);
      }

      if (/i:nil="true"/.test(attrs))
        row.values[key] = null;
      else if (full)
        row.values[key] = decodeXml(full[2]);
      else
        row.values[key] = '';
    }

    rows.push(row);
  }

  return { rows, globalTypes };
}

function inferXmlType(value, key, templateRow, globalTypes) {
  const fromRow = templateRow && templateRow.types ? templateRow.types[key] : '';
  if (fromRow) return fromRow;
  const global = globalTypes.get(key);
  if (global) return global;
  if (typeof value === 'number') return Number.isInteger(value) ? 'int' : 'double';
  if (typeof value === 'boolean') return 'boolean';
  return 'string';
}

function formatXmlScalar(value, type) {
  if (type === 'boolean')
    return value === true || String(value).toLowerCase() === 'true' ? 'true' : 'false';
  if (type === 'int') {
    const numeric = Number(String(value).replace(',', '.'));
    return Number.isFinite(numeric) ? String(Math.trunc(numeric)) : String(value);
  }
  if (type === 'double' || type === 'float' || type === 'decimal') {
    const numeric = Number(String(value).replace(',', '.'));
    return Number.isFinite(numeric) ? String(numeric) : String(value);
  }
  return String(value);
}

function serializeArchiveXml(originalXml, records) {
  const template = parseArchiveXmlTemplate(originalXml);
  const output = [
    '<?xml version="1.0" encoding="utf-8"?>',
    '<ArrayOfArrayOfKeyValueOfstringanyType xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays">'
  ];

  (records || []).forEach((record, index) => {
    const templateRow = template.rows[index] || { order: [], values: {}, types: {} };
    const keys = [];
    for (const key of templateRow.order || []) {
      if (!keys.includes(key)) keys.push(key);
    }
    for (const key of Object.keys(record || {})) {
      if (!keys.includes(key)) keys.push(key);
    }

    output.push('  <ArrayOfKeyValueOfstringanyType>');

    for (const key of keys) {
      const hasCurrent = Object.prototype.hasOwnProperty.call(record || {}, key);
      const value = hasCurrent ? record[key] : templateRow.values[key];
      const type = inferXmlType(value, key, templateRow, template.globalTypes);

      output.push('    <KeyValueOfstringanyType>');
      output.push('      <Key>' + encodeXml(key) + '</Key>');

      if (value === null || value === undefined) {
        output.push('      <Value i:nil="true" />');
      } else {
        output.push(
          '      <Value xmlns:d4p1="http://www.w3.org/2001/XMLSchema" i:type="d4p1:' +
          encodeXml(type) + '">' +
          encodeXml(formatXmlScalar(value, type)) +
          '</Value>'
        );
      }

      output.push('    </KeyValueOfstringanyType>');
    }

    output.push('  </ArrayOfKeyValueOfstringanyType>');
  });

  output.push('</ArrayOfArrayOfKeyValueOfstringanyType>');
  return output.join('\n');
}

async function sha256Lower(text) {
  if (!globalThis.crypto || !globalThis.crypto.subtle)
    throw new Error('Web Crypto non disponibile: impossibile aggiornare le impronte del progetto.');

  const bytes = new TextEncoder().encode(String(text == null ? '' : text));
  const digest = await globalThis.crypto.subtle.digest('SHA-256', bytes);
  return Array.from(new Uint8Array(digest))
    .map(value => value.toString(16).padStart(2, '0'))
    .join('');
}

function numberOrOriginal(value, original) {
  const numeric = Number(String(value == null ? '' : value).replace(',', '.'));
  return Number.isFinite(numeric) ? numeric : original;
}

function updateManifestFloors(manifest, pianiRecords) {
  if (!Array.isArray(pianiRecords) || !pianiRecords.length) return;

  if (manifest.geometry && typeof manifest.geometry === 'object')
    manifest.geometry.floorCount = pianiRecords.length;

  const oldFloors = Array.isArray(manifest.floors) ? manifest.floors : [];
  manifest.floors = pianiRecords.map((piano, index) => {
    const old = oldFloors[index] && typeof oldFloors[index] === 'object'
      ? oldFloors[index]
      : {};

    return {
      ...old,
      order: index,
      id: old.id || ('F' + String(index + 1).padStart(3, '0')),
      name: piano.Nome == null ? (old.name || '') : String(piano.Nome),
      type: piano.Tipo == null ? (old.type || '') : String(piano.Tipo),
      fileName: piano.NomeFile == null ? (old.fileName || '') : String(piano.NomeFile),
      cadLayer: piano.LayerCad == null ? (old.cadLayer || '') : String(piano.LayerCad),
      netHeightMeters: numberOrOriginal(piano.AltezzaNetta, old.netHeightMeters),
      grossHeightMeters: numberOrOriginal(piano.AltezzaLorda, old.grossHeightMeters),
      repetitions: numberOrOriginal(piano.PianiUguali, old.repetitions)
    };
  });
}

async function refreshManifest(source, pianiRecords) {
  const parsed = parseTermodelProjectText(source);
  const rawManifest = parsed.sections.get('manifest.json');
  if (!rawManifest) return source;

  let manifest;
  try {
    manifest = JSON.parse(rawManifest);
  } catch (error) {
    throw new Error('manifest.json non valido: ' + error.message);
  }

  manifest.generatedAtUtc = new Date().toISOString();
  updateManifestFloors(manifest, pianiRecords);

  if (Array.isArray(manifest.sections)) {
    await Promise.all(manifest.sections.map(async (entry) => {
      if (!entry || typeof entry.name !== 'string') return;
      const sectionText = parsed.sections.get(entry.name);
      if (sectionText === undefined) return;
      entry.sha256 = await sha256Lower(sectionText);
    }));
  }

  return replaceTermodelProjectSection(source, 'manifest.json', JSON.stringify(manifest, null, 2));
}

export async function buildTermodelProjectText(source, options = {}) {
  let result = normalizeSource(source);
  parseTermodelProjectText(result);

  if (options.geometrySvg !== undefined)
    result = replaceTermodelProjectSection(result, 'geometry/project.svg', options.geometrySvg);

  const archives = options.archives || {};
  for (const [archiveName, records] of Object.entries(archives)) {
    const parsed = parseTermodelProjectText(result);
    const jsonName = 'archives/json/' + archiveName + '.json';
    const xmlName = 'archives/xml/' + archiveName + '.xml';
    const oldJson = parsed.sections.get(jsonName);
    const oldXml = parsed.sections.get(xmlName);

    if (oldJson !== undefined) {
      const jsonText = serializeArchiveJson(oldJson, records);
      result = replaceTermodelProjectSection(result, jsonName, jsonText);
    }

    if (oldXml !== undefined) {
      const xmlText = serializeArchiveXml(oldXml, records);
      result = replaceTermodelProjectSection(result, xmlName, xmlText);
    }
  }

  result = await refreshManifest(result, archives.Piani);
  return result;
}
