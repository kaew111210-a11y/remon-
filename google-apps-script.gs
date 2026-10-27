const SHEET_NAME = 'Tasks';

function setup() {
  const sheet = getSheet_();
  if (sheet.getLastRow() === 0) {
    sheet.appendRow(['id', 'name', 'description', 'type', 'owner', 'done', 'updatedAt']);
  }
}

function doGet() {
  setup();
  const sheet = getSheet_();
  const values = sheet.getDataRange().getValues();
  const rows = values.slice(1).filter(row => row[0] !== '');
  const tasks = rows.map(row => ({
    id: String(row[0]), name: row[1], desc: row[2], type: row[3],
    owner: row[4], done: row[5] === true || row[5] === 'true'
  }));
  return json_({ ok: true, tasks });
}

function doPost(e) {
  setup();
  const body = JSON.parse(e.postData.contents || '{}');
  const tasks = Array.isArray(body.tasks) ? body.tasks : [];
  const sheet = getSheet_();
  if (sheet.getLastRow() > 1) sheet.getRange(2, 1, sheet.getLastRow() - 1, 7).clearContent();
  if (tasks.length) {
    sheet.getRange(2, 1, tasks.length, 7).setValues(tasks.map(task => [
      String(task.id), task.name || '', task.desc || '', task.type || 'once',
      task.owner || '', Boolean(task.done), new Date()
    ]));
  }
  return json_({ ok: true, count: tasks.length });
}

function getSheet_() {
  const spreadsheet = SpreadsheetApp.getActiveSpreadsheet();
  return spreadsheet.getSheetByName(SHEET_NAME) || spreadsheet.insertSheet(SHEET_NAME);
}

function json_(data) {
  return ContentService.createTextOutput(JSON.stringify(data))
    .setMimeType(ContentService.MimeType.JSON);
}
