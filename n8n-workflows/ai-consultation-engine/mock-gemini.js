// Test double for the Gemini generateContent endpoint. Used ONLY to exercise
// the workflow's success and failure paths in a disposable n8n instance.
// The behaviour is selected by a marker inside the request's problem text.
const http = require('http');
const PORT = 9100;
const log = [];

const goodResult = {
  summary: 'Leads arrive by WhatsApp and web form and are copied into a spreadsheet by hand, so follow-up is late and untracked.',
  automation_opportunities: [
    { process: 'Lead capture', suggested_automation: 'Webhook intake from form and WhatsApp into one CRM table with de-duplication on phone/email', tools: ['n8n', 'CRM API'], complexity: 'low' },
    { process: 'Follow-up', suggested_automation: 'Assign an owner and send an alert when a lead has no reply after 2 hours', tools: ['n8n', 'Slack or email'], complexity: 'medium' }
  ],
  risks: ['Duplicate leads if phone formats are not normalised'],
  next_step: 'Map the current intake fields and agree the follow-up time limit.'
};

function geminiEnvelope(text, finishReason = 'STOP') {
  return { candidates: [{ content: { role: 'model', parts: [{ text }] }, finishReason }], modelVersion: 'mock-gemini' };
}

http.createServer((req, res) => {
  let body = '';
  req.on('data', c => (body += c));
  req.on('end', () => {
    let prompt = '';
    try { prompt = JSON.parse(body).contents[0].parts[0].text; } catch (e) {}
    const entry = { at: new Date().toISOString(), path: req.url, apiKeyHeaderPresent: Boolean(req.headers['x-goog-api-key']), keyInQuery: /[?&]key=/.test(req.url) };
    let status = 200, payload;
    if (prompt.includes('MOCK_UPSTREAM_500')) { status = 500; payload = { error: { code: 500, message: 'mock internal error' } }; }
    else if (prompt.includes('MOCK_EMPTY')) { payload = { candidates: [], promptFeedback: { blockReason: 'SAFETY' } }; }
    else if (prompt.includes('MOCK_BAD_JSON')) { payload = geminiEnvelope('Sure! Here is your analysis: {not valid json'); }
    else if (prompt.includes('MOCK_WRONG_SHAPE')) { payload = geminiEnvelope(JSON.stringify({ summary: 42 })); }
    else { payload = geminiEnvelope(JSON.stringify(goodResult)); }
    entry.status = status;
    log.push(entry);
    console.log(JSON.stringify(entry));
    res.writeHead(status, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(payload));
  });
}).listen(PORT, () => console.log('mock gemini on ' + PORT));
