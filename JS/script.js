const $ = id => document.getElementById(id);

let DB = {};
let USER = null;

const SAMPLES = [
  ["Students in IT", "SELECT * FROM Student WHERE department_id = 'D002'"],
  ["Student skills (JOIN)",
   `SELECT s.First_Name, k.Skill_Name, l.Level_Name
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
    headers: { 'Content-Type': 'application/json', ...(options.headers || {}) }
  });
  let data;
  try { data = await response.json(); }
  catch { throw new Error('Server did not return JSON. Open the site via http://localhost/ and check PHP/MySQL are running.'); }
  if (!response.ok || data.success === false) throw new Error(data.message || 'Request failed.');
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
      body: JSON.stringify({ email: $('u').value.trim() })
    });
    await enter(r.user);
  } catch (e) {
    $('err').textContent = e.message;
  }
}

async function logout() {
  try { await api('api/logout.php', { method: 'POST', body: '{}' }); }
  finally {
    USER = null;
    $('app').style.display = 'none';
    $('login').style.display = 'grid';
    $('err').textContent = '';
  }
}

function grid(rows, tag = false) {
  if (!rows.length) return '<p>No records found.</p>';
  const [headers, ...body] = rows;
  const esc = v => String(v ?? '').replace(/[&<>"']/g,
    ch => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[ch]);

  return `<table><thead><tr>
    ${headers.map((h, i) => `<th>${esc(h)}${
      tag ? (i === 0 ? '<span class="k">PK</span>'
            : /_id$/i.test(h) ? '<span class="k f">ID</span>' : '') : ''}</th>`).join('')}
  </tr></thead><tbody>
    ${body.map(r => `<tr>${r.map(v => `<td>${esc(v)}</td>`).join('')}</tr>`).join('')}
  </tbody></table>`;
}

async function init() {
  try {
    const data = await api('api/tables.php');
    DB = data.tables;
    const names = Object.keys(DB);

    $('n-q').style.display = USER.role === 'instructor' ? '' : 'none';

    $('navs').innerHTML = names.map(n =>
      `<button class="nav" id="n-${n}" onclick="openT('${n}')">${n}</button>`).join('');

    $('tiles').innerHTML = names.map(n =>
      `<button class="tile" onclick="openT('${n}')"><b>${n}</b>
       <small>${DB[n].rows.length} rows</small></button>`).join('');

    const count = n => DB[n].rows.length;
    $('stats').innerHTML = [
      ['Students', count('student')],
      ['Skills', count('skill')],
      ['Certificates', count('certificate')],
      ['Training programs', count('training_program')]
    ].map(([name, value]) =>
      `<div class="stat"><b>${value}</b><span>${name}</span></div>`).join('');

    $('q').value = SAMPLES[1][1];
    $('chips').innerHTML = SAMPLES.map((s, i) =>
      `<button class="chip" onclick="useSample(${i})">${s[0]}</button>`).join('');

    show('dash');
  } catch (e) {
    $('title').textContent = 'Database connection error';
    $('v-dash').innerHTML = `<div class="panel">${e.message}</div>`;
  }
}

function useSample(i) { $('q').value = SAMPLES[i][1]; run(); }

function mark(id) {
  document.querySelectorAll('.nav').forEach(n => n.classList.remove('on'));
  if ($(id)) $(id).classList.add('on');
}

function show(view) {
  if (view === 'query' && USER?.role !== 'instructor') return;
  ['dash', 'table', 'query'].forEach(v => {
    $('v-' + v).style.display = v === view ? 'block' : 'none';
  });
  $('title').textContent = view === 'dash' ? 'Dashboard' : 'Query console';
  mark(view === 'dash' ? 'n-dash' : 'n-q');
}

function openT(name) {
  if (!DB[name]) return;
  $('v-dash').style.display = 'none';
  $('v-query').style.display = 'none';
  $('v-table').style.display = 'block';
  $('title').textContent = name;
  $('tinfo').textContent = `${DB[name].rows.length} rows · ${DB[name].columns.length} columns`;
  $('tgrid').innerHTML = grid([
    DB[name].columns,
    ...DB[name].rows.map(r => DB[name].columns.map(c => r[c]))
  ], true);
  mark('n-' + name);
}

async function run() {
  const sql = $('q').value.trim();
  $('qmeta').textContent = 'Running query...';
  $('qgrid').innerHTML = '';
  try {
    const res = await api('api/query.php', { method: 'POST', body: JSON.stringify({ sql }) });
    $('qgrid').innerHTML = res.count
      ? grid([res.columns, ...res.rows.map(r => res.columns.map(c => r[c]))])
      : '<p>No rows returned.</p>';
    $('qmeta').textContent = `${res.count} row(s) returned`;
  } catch (e) {
    $('qmeta').textContent = e.message;
  }
}

$('u').addEventListener('keydown', e => { if (e.key === 'Enter') login(); });

// keep the user signed in after a page refresh
window.addEventListener('load', async () => {
  try { const r = await api('api/me.php'); await enter(r.user); } catch { /* not signed in */ }
});