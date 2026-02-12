const fs = require('fs');
const path = require('path');

const swPath = path.join(__dirname, '../public/flutter_service_worker.js');

if (fs.existsSync(swPath)) {
  let content = fs.readFileSync(swPath, 'utf8');
  
  // 1. Fix chrome-extension error by checking origin
  // We insert a check at the beginning of the fetch event listener
  const fetchStart = 'self.addEventListener("fetch", (event) => {';
  const fetchFix = `
self.addEventListener("fetch", (event) => {
  if (!event.request.url.startsWith(self.location.origin)) {
    return;
  }
`;

  if (!content.includes('event.request.url.startsWith(self.location.origin)')) {
    content = content.replace(fetchStart, fetchFix);
    console.log('Patched flutter_service_worker.js to ignore cross-origin requests (fixes chrome-extension error).');
  } else {
    console.log('flutter_service_worker.js already patched for cross-origin requests.');
  }

  fs.writeFileSync(swPath, content);
} else {
  console.log('public/flutter_service_worker.js not found. Skipping patch.');
}
