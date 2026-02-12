const fs = require('fs');
const path = require('path');

// Target the public folder which users commit
const swPath = path.join(__dirname, '../public/flutter_service_worker.js');

const killerContent = `
// Self-destructing Service Worker to clear old caches
self.addEventListener('install', function(e) {
    self.skipWaiting();
});

self.addEventListener('activate', function(e) {
    self.registration.unregister()
        .then(function() {
            return self.clients.matchAll();
        })
        .then(function(clients) {
            clients.forEach(client => client.navigate(client.url));
        });
});
`;

if (fs.existsSync(swPath)) {
    fs.writeFileSync(swPath, killerContent);
    console.log('Replaced public/flutter_service_worker.js with self-destruct version.');
} else {
    // If it doesn't exist, create it so browser finds something instead of 404/old valid
    // But if it's 404, the browser usually unregisters anyway. 
    // Safest is to provide the file.
    fs.writeFileSync(swPath, killerContent);
    console.log('Created public/flutter_service_worker.js with self-destruct version (was missing).');
}
