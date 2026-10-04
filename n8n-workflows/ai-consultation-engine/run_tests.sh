#!/usr/bin/env bash
# Black-box tests against the running n8n production webhook.
# The shared secret is read from a local file and never printed.
set -u
URL="${N8N_BASE:-http://localhost:5678}/webhook/lz-consultation"
SECRET="${WEBHOOK_SECRET:?set WEBHOOK_SECRET to the value stored in your n8n Header Auth credential}"
OUT="${OUT:-./results}"
mkdir -p "$OUT"
PASS=0; FAIL=0
GOOD='Our clinic receives appointment requests by WhatsApp and a web form; staff copy them into a spreadsheet and follow-up is often a day late.'

run() { # name expected_status curl-args...
  local name="$1" expected="$2"; shift 2
  local body hdr status
  body=$(curl -s -D "$OUT/$name.headers" -o "$OUT/$name.body" -w '%{http_code}' -X POST "$URL" -H 'Content-Type: application/json' -H "x-request-id: test-$name" "$@")
  status="$body"
  local rid=$(grep -i '^x-request-id:' "$OUT/$name.headers" | tr -d '\r' | cut -d' ' -f2)
  if [ "$status" = "$expected" ]; then PASS=$((PASS+1)); r=PASS; else FAIL=$((FAIL+1)); r=FAIL; fi
  printf '%-22s expected=%s got=%s %s  x-request-id=%s\n  body: %s\n' "$name" "$expected" "$status" "$r" "${rid:-none}" "$(head -c 400 "$OUT/$name.body")"
}

run 01_valid_request        200 -H "x-webhook-secret: $SECRET" -d "{\"problem\":\"$GOOD\",\"industry\":\"Healthcare clinic\"}"
run 02_missing_secret       403 -d "{\"problem\":\"$GOOD\"}"
run 03_wrong_secret         403 -H 'x-webhook-secret: wrong-value' -d "{\"problem\":\"$GOOD\"}"
run 04_empty_body           400 -H "x-webhook-secret: $SECRET" -d '{}'
run 05_problem_too_short    400 -H "x-webhook-secret: $SECRET" -d '{"problem":"help"}'
run 06_wrong_types          400 -H "x-webhook-secret: $SECRET" -d '{"problem":12345,"industry":["x"]}'
run 07_upstream_500         502 -H "x-webhook-secret: $SECRET" -d '{"problem":"MOCK_UPSTREAM_500 - leads are copied by hand into a sheet"}'
run 08_empty_model_reply    502 -H "x-webhook-secret: $SECRET" -d '{"problem":"MOCK_EMPTY - leads are copied by hand into a sheet"}'
run 09_non_json_model_reply 502 -H "x-webhook-secret: $SECRET" -d '{"problem":"MOCK_BAD_JSON - leads are copied by hand into a sheet"}'
run 10_wrong_shape_reply    502 -H "x-webhook-secret: $SECRET" -d '{"problem":"MOCK_WRONG_SHAPE - leads are copied by hand into a sheet"}'

echo "RESULT: $PASS passed, $FAIL failed"
