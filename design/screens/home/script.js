if (!sessionStorage.getItem('isLoggedIn')) {
  window.location.href = '../login/';
}

var isGuest = sessionStorage.getItem('isGuest') === 'true';

if (isGuest) {
  document.getElementById('welcome-name').textContent = 'Welcome, Guest';
  document.getElementById('welcome-location').style.display = 'none';
}

document.getElementById('guest-login-btn').addEventListener('click', function() {
  sessionStorage.removeItem('isGuest');
  sessionStorage.setItem('loginRedirect', 'true');
  window.location.href = '../login/';
});

var ICONS = {
  more: '<svg width="18" height="18" viewBox="0 0 18 18" fill="none"><circle cx="4" cy="9" r="2" fill="#1F1F1F" fill-opacity="0.66"/><circle cx="9" cy="9" r="2" fill="#1F1F1F" fill-opacity="0.66"/><circle cx="14" cy="9" r="2" fill="#1F1F1F" fill-opacity="0.66"/></svg>',
};

document.getElementById('statusbar-main').innerHTML = getStatusHTML();
document.getElementById('statusbar-guest').innerHTML = getStatusHTML();
document.getElementById('filter-btn').innerHTML = SHARED_ICONS.filter;
populateBottomNav('home');

document.getElementById('categories-grid').innerHTML = CATEGORIES.map(function(c) {
  return '<div class="category-item" data-od-id="category-' + c.name.toLowerCase() + '">' +
    '<div class="category-img' + (c.isMore ? ' more-circle' : '') + '" style="background:' + c.bg + '">' +
      (c.isMore ? ICONS.more : (c.img ? '<img src="' + c.img + '" alt="' + c.name + '" loading="lazy" />' : (ICONS[c.iconKey] || ''))) +
    '</div>' +
    '<span class="category-name">' + c.name + '</span>' +
  '</div>';
}).join('');

document.getElementById('trending-products').innerHTML = PRODUCTS.map(function(p) {
  var discountHtml = p.discount
    ? '<div class="discount-tag">' +
        '<span class="discount-frame">' + SHARED_ICONS.discountFrame + '</span>' +
        '<span class="discount-content">' + SHARED_ICONS.discountIcon + '<span>' + p.discount + '</span></span>' +
      '</div>'
    : '';

  return '<div class="h-product-card" data-od-id="product-' + p.id + '">' +
    '<div class="img-wrap">' +
      '<img src="' + p.img + '" alt="' + p.title + '" loading="lazy" />' +
      discountHtml +
      getHeartBtnHTML(p.favorited, p.id) +
    '</div>' +
    '<div class="card-content">' +
      '<div class="product-title">' + p.title + '</div>' +
      '<div class="price-row">' +
        '<span class="price">' + p.price + ' EGP</span>' +
        (p.originalPrice ? '<span class="original-price">' + p.originalPrice + '</span>' : '') +
      '</div>' +
      '<div class="product-card__cart-row" data-cart-row="' + p.id + '">' +
        '<button class="product-card__add-btn" data-product-id="' + p.id + '">' +
          SHARED_ICONS.smallCart +
        '</button>' +
      '</div>' +
    '</div>' +
  '</div>';
}).join('');

document.getElementById('stores-list').innerHTML = STORES.map(function(s) {
  return '<div class="store-card" data-od-id="store-' + s.id + '" data-store-id="' + s.id + '">' +
    '<div class="store-bg" style="background:' + s.bg + '"><img src="' + s.img + '" alt="' + s.name + '" loading="lazy" /></div>' +
    '<div class="store-overlay"></div>' +
    (s.discount
      ? '<div class="store-discount">' +
          '<span class="discount-frame">' + SHARED_ICONS.discountFrame + '</span>' +
          '<span class="discount-content">' + SHARED_ICONS.discountIcon + '<span>' + s.discount + '%</span></span>' +
        '</div>'
      : '') +
    getHeartBtnHTML(s.favorited, 'store-' + s.id) +
    '<div class="store-name">' + s.name + '</div>' +
  '</div>';
}).join('');

document.querySelectorAll('.store-card').forEach(function(card) {
  card.addEventListener('click', function(e) {
    if (e.target.closest('.fav-btn')) return;
    window.location.href = '../store/';
  });
});

document.querySelectorAll('.h-product-card').forEach(function(card) {
  card.addEventListener('click', function(e) {
    if (e.target.closest('.fav-btn') || e.target.closest('.product-card__add-btn') || e.target.closest('.counter')) return;
    window.location.href = '../product/';
  });
});

initFavorites('.fav-btn');

ProductCounter.init({
  onBadgeUpdate: function(total) {
    var badge = document.getElementById('cart-badge');
    if (badge) { badge.textContent = total; badge.style.display = total > 0 ? 'flex' : 'none'; }
  }
});
ProductCounter.renderAllCounters();

initNavClickHandlers({
  cart: function() { window.location.href = '../cart/'; },
  thrift: function() { window.location.href = '../thrift/'; },
  account: function() {
    if (isGuest) {
      document.getElementById('guest-overlay').classList.add('show');
    } else {
      sessionStorage.removeItem('isLoggedIn');
      window.location.href = '../login/';
    }
  },
});
