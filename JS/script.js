const $ = id => document.getElementById(id);
let DB = {};
let USER = null;

const SAMPLES = [
  ["Students in IT", "SELECT * FROM Student WHERE department_id = 'D002'"],
  ["Student skills (JOIN)", `SELECT s.First_Name, k.Skill_Name, l.Level_Name
FROM Student s
JOIN Student_Skill ss ON s.Student_ID = ss.Student_ID
JOIN Skill k ON ss.Skill_ID = k.Skill_ID
JOIN Skill_Level l ON ss.Level_ID = l.Level_ID`],
  ["Certificates", "SELECT Certificate_Name, Issued_Organization FROM Certificate LIMIT 2"],
  ["Courses", "SELECT * FROM Course"]
];

async function api(url, options = {}) {
  const response = await fetch(url, {
    credentials: 'same-origin',
    ...options,
    headers: { ...(options.headers || {}) }
  });
  const text = await response.text();
  let data;
  try { data = JSON.parse(text); }
  catch {
    console.error('Non-JSON response from', url, text);
    throw new Error(`Server returned a non-JSON response (${response.status}). Check ${url} and PHP errors.`);
  }
  if (!response.ok || data.success === false) throw new Error(data.message || `Request failed (${response.status}).`);
  return data;
}

async function enter(user) {
  USER = user;
  $('login').style.display = 'none';
  $('app').style.display = 'block';
  $('who').textContent = `${user.name} (${user.role})`;
  await init();
}

async function login() {
  $('err').textContent = '';
  try {
    const r = await api('api/login.php', {
      method: 'POST',
      headers: {'Content-Type':'application/json'},
      body: JSON.stringify({ email: $('u').value.trim() })
    });
    await enter(r.user);
  } catch (e) {
    $('err').textContent = e.message;
  }
}

async function logout() {
  try { await api('api/logout.php', { method: 'POST' }); }
  catch (e) { console.warn(e); }
  USER = null;
  $('app').style.display = 'none';
  $('login').style.display = 'grid';
  $('err').textContent = '';
}

function esc(v) {
  return String(v ?? '').replace(/[&<>"']/g, ch => ({
    '&':'&amp;', '<':'&lt;', '>':'&gt;', '"':'&quot;', "'":'&#39;'
  })[ch]);
}

function grid(rows, tag = false) {
  if (!rows.length) return '<p class="empty">No records found.</p>';
  const [headers, ...body] = rows;
  return `<table><thead><tr>${headers.map((h, i) =>
    `<th>${esc(h)}${tag ? (i === 0 ? '<span class="k">PK</span>' : /_id$/i.test(h) ? '<span class="k f">ID</span>' : '') : ''}</th>`
  ).join('')}</tr></thead><tbody>${body.map(r =>
    `<tr>${r.map(v => `<td>${esc(v)}</td>`).join('')}</tr>`
  ).join('')}</tbody></table>`;
}

async function init() {
  try {
    const data = await api('api/tables.php');
    DB = data.tables || {};
    const names = Object.keys(DB);
    $('n-q').style.display = USER.role === 'instructor' ? '' : 'none';
    $('navs').innerHTML = names.map(n =>
      `<button class="nav" id="n-${esc(n)}" onclick="openT('${esc(n)}')">${esc(n)}</button>`
    ).join('');
    $('tiles').innerHTML = names.map(n =>
      `<button class="tile" onclick="openT('${esc(n)}')"><b>${esc(n)}</b><small>${DB[n].rows.length} rows</small></button>`
    ).join('');
    const count = n => DB[n]?.rows?.length ?? 0;
    $('stats').innerHTML = [
      ['Students', count('student')],
      ['Skills', count('skill')],
      ['Certificates', count('certificate')],
      ['Training programs', count('training_program')]
    ].map(([name, value]) => `<div class="stat"><b>${value}</b><span>${name}</span></div>`).join('');
    $('q').value = SAMPLES[1][1];
    $('chips').innerHTML = SAMPLES.map((s, i) => `<button class="chip" onclick="useSample(${i})">${esc(s[0])}</button>`).join('');
    show('dash');
  } catch (e) {
    $('title').textContent = 'Database connection error';
    $('v-dash').innerHTML = `<div class="panel"><b>Could not load tables</b><p>${esc(e.message)}</p></div>`;
  }
}

function useSample(i) { $('q').value = SAMPLES[i][1]; run(); }
function mark(id) {
  document.querySelectorAll('.nav').forEach(n => n.classList.remove('on'));
  if ($(id)) $(id).classList.add('on');
}
function show(view) {
  if (view === 'query' && USER?.role !== 'instructor') return;
  ['dash', 'table', 'query'].forEach(v => $('v-' + v).style.display = v === view ? 'block' : 'none');
  $('title').textContent = view === 'dash' ? 'Dashboard' : view === 'query' ? 'Query console' : $('title').textContent;
  mark(view === 'dash' ? 'n-dash' : view === 'query' ? 'n-q' : '');
}
function openT(name) {
  if (!DB[name]) return;
  $('v-dash').style.display = 'none';
  $('v-query').style.display = 'none';
  $('v-table').style.display = 'block';
  $('title').textContent = name;
  $('tinfo').textContent = `${DB[name].rows.length} rows · ${DB[name].columns.length} columns`;
  $('tgrid').innerHTML = grid([DB[name].columns, ...DB[name].rows.map(r => DB[name].columns.map(c => r[c]))], true);
  mark('n-' + name);
}
async function run() {
  if (USER?.role !== 'instructor') return;
  const sql = $('q').value.trim();
  $('qmeta').textContent = 'Running query...';
  $('qgrid').innerHTML = '';
  try {
    const res = await api('api/query.php', {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify({sql})});
    $('qgrid').innerHTML = res.count ? grid([res.columns, ...res.rows.map(r => res.columns.map(c => r[c]))]) : '<p>No rows returned.</p>';
    $('qmeta').textContent = `${res.count} row(s) returned`;
  } catch (e) {
    $('qmeta').textContent = e.message;
  }
}
$('u').addEventListener('keydown', e => { if (e.key === 'Enter') login(); });
window.addEventListener('load', async () => {
  try { const r = await api('api/me.php'); await enter(r.user); }
  catch { /* not signed in yet */ }
});
