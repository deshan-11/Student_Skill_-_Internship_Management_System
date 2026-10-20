
const $ = id => document.getElementById(id);

let DB = {};
let LABEL = {};

const SAMPLES = [
  [
    "Students in IT",
    "SELECT * FROM student WHERE Department_ID = 1"
  ],
  [
    "Student skills (JOIN)",
    `SELECT s.First_Name, k.Skill_Name, l.Level_Name
     FROM student s
     JOIN student_skill ss ON s.Student_ID = ss.Student_ID
     JOIN skill k ON ss.Skill_ID = k.Skill_ID
     JOIN skill_level l ON ss.Level_ID = l.Level_ID`
  ],
  [
    "Certificates",
    "SELECT Certificate_Name, Issuing_Organization FROM certificate LIMIT 2"
  ],
  [
    "Courses",
    "SELECT * FROM course"
  ]
];

async function api(url, options = {}) {
  const response = await fetch(url, {
    credentials: 'same-origin',
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {})
    }
  });

  const data = await response.json();

  if (!response.ok || data.success === false) {
    throw new Error(data.message || 'Request failed.');
  }

  return data;
}

async function login() {
  $('err').textContent = '';

  try {
    await api('api/login.php', {
      method: 'POST',
      body: JSON.stringify({
        username: $('u').value.trim(),
        password: $('p').value
      })
    });

    $('login').style.display = 'none';
    $('app').style.display = 'block';

    await init();
  } catch (e) {
    $('err').textContent = e.message;
  }
}

function logout() {
  // Demo navigation. Add a server-side logout endpoint
  // to destroy the PHP session before deploying.
  $('app').style.display = 'none';
  $('login').style.display = 'grid';
  $('err').textContent = '';
}

function grid(rows, tag = false) {
  if (!rows.length) return '<p>No records found.</p>';

  const [headers, ...body] = rows;

  const esc = value => String(value ?? '').replace(
    /[&<>"']/g,
    ch => ({
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      '"': '&quot;',
      "'": '&#39;'
    })[ch]
  );

  return `
    <table>
      <thead>
        <tr>
          ${headers.map((h, i) => `
            <th>${esc(h)}
              ${tag
                ? (i === 0
                    ? '<span class="k">PK</span>'
                    : /_id$/i.test(h)
                      ? '<span class="k f">ID</span>'
                      : '')
                : ''}
            </th>
          `).join('')}
        </tr>
      </thead>
      <tbody>
        ${body.map(row => `
          <tr>${row.map(v => `<td>${esc(v)}</td>`).join('')}</tr>
        `).join('')}
      </tbody>
    </table>
  `;
}

async function init() {
  try {
    const data = await api('api/tables.php');
    DB = data.tables;
    LABEL = {};

    Object.values(DB).forEach(table => {
      table.columns.forEach(column => {
        LABEL[column.toLowerCase()] = column;
      });
    });

    const names = Object.keys(DB);

    $('navs').innerHTML = names.map(n =>
      `<button class="nav" id="n-${n}"
        onclick="openT('${n}')">${n}</button>`
    ).join('');

    $('tiles').innerHTML = names.map(n =>
      `<button class="tile" onclick="openT('${n}')">
        <b>${n}</b>
        <small>${DB[n].rows.length} rows</small>
      </button>`
    ).join('');

    const count = name => DB[name].rows.length;

    $('stats').innerHTML = [
      ['Students', count('student')],
      ['Skills', count('skill')],
      ['Certificates', count('certificate')],
      ['Training programs', count('training_program')]
    ].map(([name, value]) => `
      <div class="stat">
        <b>${value}</b>
        <span>${name}</span>
      </div>
    `).join('');

    $('q').value = SAMPLES[1][1];

    $('chips').innerHTML = SAMPLES.map((s, i) =>
      `<button class="chip" onclick="useSample(${i})">
        ${s[0]}
      </button>`
    ).join('');

    show('dash');
  } catch (e) {
    $('title').textContent = 'Database connection error';
    $('v-dash').innerHTML =
      `<div class="panel">${e.message}</div>`;
  }
}

function useSample(index) {
  $('q').value = SAMPLES[index][1];
  run();
}

function mark(id) {
  document.querySelectorAll('.nav').forEach(n =>
    n.classList.remove('on')
  );

  if ($(id)) $(id).classList.add('on');
}

function show(view) {
  ['dash', 'table', 'query'].forEach(v => {
    $('v-' + v).style.display =
      v === view ? 'block' : 'none';
  });

  $('title').textContent =
    view === 'dash' ? 'Dashboard' :
    view === 'table' ? $('title').textContent :
    'Query console';

  mark(
    view === 'dash' ? 'n-dash' :
    view === 'query' ? 'n-q' : ''
  );
}

function openT(name) {
  if (!DB[name]) return;

  $('v-dash').style.display = 'none';
  $('v-query').style.display = 'none';
  $('v-table').style.display = 'block';

  $('title').textContent = name;
  $('tinfo').textContent =
    `${DB[name].rows.length} rows · ${DB[name].columns.length} columns`;

  $('tgrid').innerHTML = grid([
    DB[name].columns,
    ...DB[name].rows.map(row =>
      DB[name].columns.map(col => row[col])
    )
  ], true);

  mark('n-' + name);
}

async function run() {
  const sql = $('q').value.trim();
  $('qmeta').textContent = 'Running query...';
  $('qgrid').innerHTML = '';

  try {
    const result = await api('api/query.php', {
      method: 'POST',
      body: JSON.stringify({ sql })
    });

    $('qgrid').innerHTML = result.count
      ? grid([
          result.columns,
          ...result.rows.map(row =>
            result.columns.map(col => row[col])
          )
        ])
      : '<p>No rows returned.</p>';

    $('qmeta').textContent =
      `${result.count} row(s) returned`;
  } catch (e) {
    $('qmeta').textContent = e.message;
  }
}

$('p').addEventListener('keydown', e => {
  if (e.key === 'Enter') login();
});
