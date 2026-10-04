// Test double for a CRM + sales-notification API. Records what n8n sends.
const http=require('http');
http.createServer((req,res)=>{let b='';req.on('data',c=>b+=c);req.on('end',()=>{
 let parsed=null, ok=true; const forceFail=b.includes('CRMFAIL'); if(req.method==='POST'){try{parsed=JSON.parse(b)}catch(e){ok=false}}
 const entry={at:new Date().toISOString(),method:req.method,path:req.url.split('?')[0],query:req.url.includes('?')?decodeURIComponent(req.url.split('?')[1]):'',validJson:req.method==='POST'?ok:null,body:ok?parsed:b.slice(0,200)};
 console.log(JSON.stringify(entry));
 if(forceFail){res.writeHead(500,{'Content-Type':'application/json'});return res.end('{"error":"mock crm down"}');} res.writeHead(ok?200:400,{'Content-Type':'application/json'});res.end(JSON.stringify(ok?{id:'crm-test-1',status:'upserted'}:{error:'invalid JSON body'}));});}).listen(9200,()=>console.log('mock crm on 9200'));
