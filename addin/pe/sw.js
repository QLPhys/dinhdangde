// PhongEm.Phys: nhớ tạm các file của add-in trên máy.
// Trang .html (lệnh, hộp thoại): lấy bản MỚI qua mạng trước (chờ tối đa 3 giây), mạng chậm/mất mới dùng bản đã nhớ
// -> vừa phát hành bản mới là Word dùng ngay, không còn chạy mã cũ suốt một phiên. Ảnh, jszip: dùng bản đã nhớ, cập nhật ngầm.
const CACHE = 'pef-2026.11.13.2';
const FILES = ['taskpane.html', 'commands.html', 'dlg.html', 'jszip.min.js'];
self.addEventListener('install', (e) => { e.waitUntil(caches.open(CACHE).then((c) => Promise.all(FILES.map((f) => fetch(f, { cache: 'no-cache' }).then((r) => (r.ok ? c.put(new URL(f, self.location).href, r) : null)).catch(() => null)))).then(() => self.skipWaiting())); });
self.addEventListener('activate', (e) => { e.waitUntil(caches.keys().then((ks) => Promise.all(ks.filter((k) => k.startsWith('pef-') && k !== CACHE).map((k) => caches.delete(k)))).then(() => self.clients.claim())); });
self.addEventListener('fetch', (e) => {
  const u = new URL(e.request.url);
  if (e.request.method !== 'GET' || u.origin !== location.origin || !/\/addin\/pe\/(taskpane\.html|commands\.html|dlg\.html|jszip\.min\.js|ic\/)/.test(u.pathname)) return;
  const key = u.origin + u.pathname;   // bỏ tham số (?v=, ?m=…): mỗi file một bản nhớ
  const html = /\.html$/.test(u.pathname);
  e.respondWith(caches.open(CACHE).then(async (c) => {
    const net = (html ? fetch(u.href, { cache: 'no-cache', credentials: 'same-origin' }) : fetch(e.request)).then((r) => { if (r && r.ok) { c.put(key, r.clone()); return r; } return null; }).catch(() => null);
    if (html) {
      const r = await Promise.race([net, new Promise((res) => setTimeout(() => res(null), 3000))]);
      if (r) return r;
    }
    const hit = await c.match(key);
    if (hit) { e.waitUntil(net); return hit; }
    return (await net) || fetch(e.request);
  }));
});
