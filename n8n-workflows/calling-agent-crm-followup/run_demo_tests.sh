#!/usr/bin/env bash
S="${WEBHOOK_SECRET:?set WEBHOOK_SECRET}"; B="${N8N_BASE:-http://localhost:5678}"
t(){ n="$1"; shift; printf -- '--- %s\n' "$n"; curl -s -w '\nHTTP %{http_code}\n' -X POST "$@" | python3 -c "
import sys,json
t=sys.stdin.read().strip(); b,_,s=t.rpartition('\n')
try:
  j=json.loads(b); keys=['qualification','lead_score','service','preferred_date','preferred_time','crm_stage','status','error','detail','details','follow_up_task']
  print(s,'|',{k:j[k] for k in keys if k in j})
except Exception: print(s,'|',b[:160])"; }
W=$B/webhook/lz-whatsapp-lead-demo
echo "### WhatsApp lead qualification v2"
t hot     $W -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Lead A","phone":"+910000000001","message":"I need a dermatologist appointment tomorrow at 6 PM"}'
t warm    $W -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Lead B","phone":"+910000000002","message":"Can I book a dentist visit? Please call back"}'
t cold    $W -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Lead C","phone":"+910000000003","message":"what are your opening hours"}'
t empty   $W -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{}'
t noauth  $W -H 'Content-Type: application/json' -d '{"name":"X","phone":"+910000000004","message":"book appointment"}'
C=$B/webhook/lz-call-completed-demo
echo; echo "### AI calling agent -> CRM v2 (CRM/notify URLs pointed at a local mock CRM)"
t qualified   $C -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Caller","phone":"+910000000005","email":"caller@example.com","call_summary":"Interested in pricing, wants to book a demo","intent":"demo_request"}'
t quote       $C -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Caller 2","phone":"+910000000006","call_summary":"Said the \"starter\" plan looks good, wants a demo","intent":"demo_request"}'
t unqualified $C -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Caller 3","phone":"+910000000007","call_summary":"Wrong number","intent":"other"}'
t missing     $C -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"Test Caller 4"}'
t crm_down    $C -H "x-webhook-secret: $S" -H 'Content-Type: application/json' -d '{"name":"CRMFAIL Caller","phone":"+910000000008","call_summary":"wants pricing","intent":"pricing"}'
t noauth      $C -H 'Content-Type: application/json' -d '{"name":"X","phone":"1","call_summary":"demo"}'
