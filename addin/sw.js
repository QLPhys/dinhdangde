// QL_Format: nhớ tạm các file của add-in trên máy để Word mở lệnh nhanh (dùng bản đã nhớ ngay, cập nhật ngầm từ mạng)
const CACHE = 'qlf-v2026.11.02.2';
const FILES = ['taskpane.html', 'commands.html', 'dlg.html', 'jszip.min.js'];
self.addEventListener('install', (e) => { e.waitUntil(caches.open(CACHE).then((c) => Promise.all(FILES.map((f) => fetch(f, { cache: 'no-cache' }).then((r) => (r.ok ? c.put(new URL(f, self.location).href, r) : null)).catch(() => null)))).then(() => self.skipWaiting())); });
self.addEventListener('activate', (e) => { e.waitUntil(caches.keys().then((ks) => Promise.all(ks.filter((k) => k.startsWith('qlf-') && k !== CACHE).map((k) => caches.delete(k)))).then(() => self.clients.claim())); });
self.addEventListener('fetch', (e) => {
  const u = new URL(e.request.url);
  if (e.request.method !== 'GET' || u.origin !== location.origin || !/\/addin\/(taskpane\.html|commands\.html|dlg\.html|jszip\.min\.js|ic\/)/.test(u.pathname)) return;
  const key = u.origin + u.pathname;   // bỏ tham số (?v=, ?m=…): mỗi file một bản nhớ
  e.respondWith(caches.open(CACHE).then(async (c) => {
    const hit = await c.match(key);
    const net = fetch(e.request).then((r) => { if (r && r.ok) c.put(key, r.clone()); return r; }).catch(() => null);
    if (hit) { e.waitUntil(net); return hit; }
    return (await net) || fetch(e.request);
  }));
});
