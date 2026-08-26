#!/usr/bin/env node

import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';

const [outputRoot, contractPath] = process.argv.slice(2);
if (!outputRoot || !contractPath) {
  console.error('usage: audit-contracts.mjs <dashboard-root> <contracts.json>');
  process.exit(2);
}

function canonical(value) {
  if (Array.isArray(value)) {
    return value.map(canonical);
  }
  if (value !== null && typeof value === 'object') {
    return Object.fromEntries(
      Object.keys(value).sort().map((key) => [key, canonical(value[key])]),
    );
  }
  return value;
}

function canonicalHash(value) {
  return crypto
    .createHash('sha256')
    .update(JSON.stringify(canonical(value)))
    .digest('hex');
}

function visit(value, callback) {
  callback(value);
  if (Array.isArray(value)) {
    value.forEach((entry) => visit(entry, callback));
  } else if (value !== null && typeof value === 'object') {
    Object.values(value).forEach((entry) => visit(entry, callback));
  }
}

function dashboardContract(relativePath, dashboard, folder) {
  const datasourceUids = new Set();
  let targetCount = 0;
  visit(dashboard, (value) => {
    if (value !== null && typeof value === 'object' && !Array.isArray(value)) {
      if (value.datasource && typeof value.datasource === 'object' && value.datasource.uid) {
        datasourceUids.add(value.datasource.uid);
      }
      if (Array.isArray(value.targets)) {
        targetCount += value.targets.length;
      }
    }
  });

  return {
    canonicalSha256: canonicalHash(dashboard),
    datasourceUids: [...datasourceUids].sort(),
    folder,
    panelIds: (dashboard.panels || []).map((panel) => panel.id),
    panelTypes: (dashboard.panels || []).map((panel) => panel.type),
    relativePath,
    targetCount,
    title: dashboard.title,
    uid: dashboard.uid,
    variableNames: (dashboard.templating?.list || []).map((variable) => variable.name),
  };
}

function listJsonFiles(root, relative = '') {
  const directory = path.join(root, relative);
  return fs.readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
    const entryRelative = path.join(relative, entry.name);
    if (entry.isDirectory()) {
      return listJsonFiles(root, entryRelative);
    }
    return entry.name.endsWith('.json') ? [entryRelative] : [];
  });
}

function folderFor(relativePath) {
  if (relativePath.startsWith(`common${path.sep}`)) return 'Kubernetes';
  if (relativePath.startsWith(`gpu${path.sep}`)) return 'GPU Nodes';
  if (relativePath.startsWith(`oci${path.sep}`)) return 'OCI Metrics';
  throw new Error(`No folder mapping for ${relativePath}`);
}

const expected = JSON.parse(fs.readFileSync(contractPath, 'utf8'));
const actual = Object.fromEntries(
  listJsonFiles(outputRoot)
    .sort()
    .map((relativePath) => {
      const dashboard = JSON.parse(fs.readFileSync(path.join(outputRoot, relativePath), 'utf8'));
      const normalizedPath = relativePath.split(path.sep).join('/');
      return [normalizedPath, dashboardContract(normalizedPath, dashboard, folderFor(relativePath))];
    }),
);

const expectedPaths = Object.keys(expected).sort();
const actualPaths = Object.keys(actual).sort();
if (JSON.stringify(expectedPaths) !== JSON.stringify(actualPaths)) {
  console.error('Dashboard output set differs from the contract.');
  console.error(`expected: ${expectedPaths.join(', ')}`);
  console.error(`actual:   ${actualPaths.join(', ')}`);
  process.exit(1);
}

let failed = false;
for (const relativePath of expectedPaths) {
  if (JSON.stringify(expected[relativePath]) !== JSON.stringify(actual[relativePath])) {
    failed = true;
    console.error(`Contract mismatch: ${relativePath}`);
    for (const field of Object.keys(expected[relativePath])) {
      if (JSON.stringify(expected[relativePath][field]) !== JSON.stringify(actual[relativePath][field])) {
        console.error(`  ${field}`);
        console.error(`    expected: ${JSON.stringify(expected[relativePath][field])}`);
        console.error(`    actual:   ${JSON.stringify(actual[relativePath][field])}`);
      }
    }
  }
}

const logicalDashboards = Object.entries(actual).filter(([relativePath]) => !relativePath.includes('/variants/'));
const uids = new Map();
for (const [relativePath, contract] of logicalDashboards) {
  if (uids.has(contract.uid)) {
    failed = true;
    console.error(`Duplicate dashboard UID ${contract.uid}: ${uids.get(contract.uid)}, ${relativePath}`);
  }
  uids.set(contract.uid, relativePath);

  const panelIds = contract.panelIds;
  if (new Set(panelIds).size !== panelIds.length) {
    failed = true;
    console.error(`Duplicate panel IDs: ${relativePath}`);
  }
}

if (logicalDashboards.length !== 21) {
  failed = true;
  console.error(`Expected 21 logical dashboards, found ${logicalDashboards.length}`);
}

if (failed) process.exit(1);
console.log(`Verified ${logicalDashboards.length} logical dashboards and ${actualPaths.length - logicalDashboards.length} GPU-health variants.`);
