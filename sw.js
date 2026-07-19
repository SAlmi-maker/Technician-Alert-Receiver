// sw.js - Service Worker for push notifications
self.addEventListener('push', function(e) {
  var data = { title: 'Maintenance Alert', body: 'New alert', url: '/notifications.html' };
  if (e.data) {
    try { data = e.data.json(); } catch(err) { data.body = e.data.text(); }
  }
  e.waitUntil(
    self.registration.showNotification(data.title, {
      body: data.body,
      icon: 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"%3E%3Ccircle cx="50" cy="50" r="46" fill="%23003D7C"/%3E%3Ctext x="50" y="64" text-anchor="middle" fill="white" font-size="36" font-family="Arial" font-weight="bold"%3EF%3C/text%3E%3C/svg%3E',
      badge: 'data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"%3E%3Ccircle cx="50" cy="50" r="46" fill="%23DC2626"/%3E%3Ctext x="50" y="64" text-anchor="middle" fill="white" font-size="30" font-family="Arial" font-weight="bold"%3E!%3C/text%3E%3C/svg%3E',
      tag: data.tag || 'mms-alert',
      data: { url: data.url || '/notifications.html' }
    })
  );
});

self.addEventListener('notificationclick', function(e) {
  e.notification.close();
  var url = e.notification.data && e.notification.data.url ? e.notification.data.url : '/notifications.html';
  e.waitUntil(
    self.clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function(clients) {
      for (var i = 0; i < clients.length; i++) {
        if (clients[i].url.indexOf('notifications') !== -1 && 'focus' in clients[i]) return clients[i].focus();
      }
      return self.clients.openWindow(url);
    })
  );
});
