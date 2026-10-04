"""Independent pre-publication scan of the exported workflow JSON files."""
import json, re, sys
import os
SECRET = os.environ.get('WEBHOOK_SECRET', '')
patterns = {
  'email': re.compile(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'),
  'phone': re.compile(r'\+?\d[\d\s-]{8,}\d'),
  'url': re.compile(r'https?://[^\s"\\]+'),
  'google_api_key': re.compile(r'AIza[0-9A-Za-z_-]{20,}'),
  'bearer/token': re.compile(r'(?i)(bearer\s+[a-z0-9._-]{10,}|sk-[a-z0-9]{10,}|ghp_[a-z0-9]{10,}|xox[abp]-)'),
  'long_hex': re.compile(r'\b[0-9a-f]{32,}\b'),
  'query_key': re.compile(r'[?&](key|token|apikey|api_key)='),
}
ALLOWED_URLS = {'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent',
                'https://crm.example.invalid/api/contacts', 'https://notify.example.invalid/api/notify-sales'}
bad = 0
for f in sys.argv[1:]:
    raw = open(f).read(); w = json.loads(raw)
    print(f'== {f}')
    if SECRET and SECRET in raw: print('  FAIL test secret present'); bad += 1
    for n in w['nodes']:
        for k, v in (n.get('credentials') or {}).items():
            st = 'ok' if v.get('id') == 'REPLACE_WITH_YOUR_CREDENTIAL' else 'FAIL'
            if st == 'FAIL': bad += 1
            print(f'  credential ref [{n["name"]}] {k} id={v.get("id")} -> {st}')
        if 'webhookId' in n:
            st = 'ok' if n['webhookId'].startswith('00000000-0000-4000-8000-') else 'FAIL'
            if st == 'FAIL': bad += 1
            print(f'  webhookId [{n["name"]}] {n["webhookId"]} -> {st}')
    uuid_free = re.sub(r'[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}', '<uuid>', raw)
    print('  UUIDs present (node ids / placeholder webhook ids):', len(re.findall(r'<uuid>', uuid_free)))
    for name, p in patterns.items():
        for m in sorted(set(p.findall(uuid_free))):
            m = m if isinstance(m, str) else m[0]
            if name == 'url' and m in ALLOWED_URLS: print(f'  url ok: {m}'); continue
            if name == 'email' and m.endswith('@example.com'): print(f'  email ok (reserved example domain): {m}'); continue
            print(f'  REVIEW {name}: {m}'); bad += 1
    for key in ('pinData', 'staticData', 'meta', 'versionId', 'id', 'shared', 'owner'):
        if w.get(key): print(f'  REVIEW top-level {key}: {str(w[key])[:80]}'); bad += 1
print('SCAN RESULT:', 'CLEAN' if bad == 0 else f'{bad} item(s) need review')
