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
  heart: '<svg viewBox="0 0 18 17" fill="none"><path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M2.41241 0.920962C4.89656-0.602813 7.12508 0.00447571 8.47136 1.01551C8.69284 1.18183 8.84485 1.29567 8.95801 1.37254C9.07117 1.29567 9.22317 1.18183 9.44465 1.01551C10.7909 0.00447571 13.0195-0.602813 15.5036 0.920962C17.2213 1.9746 18.1878 4.1755 17.8487 6.70426C17.5079 9.24522 15.8632 12.1191 12.3802 14.6971C11.0841 15.657 10.2831 16.2503 8.95801 16.2503C7.63296 16.2503 6.83197 15.657 5.62248 14.7613C5.59382 14.74 5.56492 14.7186 5.53579 14.6971C2.05278 12.1191 0.40813 9.24522 0.06734 6.70426C-0.271814 4.1755 0.694712 1.9746 2.41241 0.920962Z" fill="#520826"/><path fill-rule="evenodd" clip-rule="evenodd" d="M2.41241 0.920962C4.89656-0.602813 7.12508 0.00447571 8.47136 1.01551C8.719 1.20148 8.87978 1.32182 8.99652 1.39825C9.02758 1.41858 9.04987 1.432 9.06494 1.44056C9.35917 1.49129 9.58301 1.74773 9.58301 2.05645C9.58301 2.40163 9.30319 2.68145 8.95801 2.68145C8.79648 2.68145 8.66166 2.63184 8.57389 2.59218C8.48142 2.55039 8.39231 2.49674 8.31185 2.44406C8.15702 2.3427 7.96346 2.19733 7.73813 2.0281L7.72074 2.01504Z" fill="#520826"/></svg>',
  heartFav: '<svg viewBox="0 0 20 20" fill="none"><path d="M3.45416 2.79596C5.93831 1.27219 8.16683 1.87948 9.51311 2.89051C9.73459 3.05683 9.8866 3.17067 9.99975 3.24754C10.1129 3.17067 10.2649 3.05683 10.4864 2.89051C11.8327 1.87948 14.0612 1.27219 16.5454 2.79596C18.2631 3.8496 19.2296 6.0505 18.8904 8.57926C18.5496 11.1202 16.905 13.9941 13.422 16.5721C12.2125 17.4678 11.3248 18.1253 9.99976 18.1253C8.67471 18.1253 7.78702 17.4678 6.57754 16.5721C3.09453 13.9941 1.44988 11.1202 1.10909 8.57926C0.769934 6.0505 1.73646 3.8496 3.45416 2.79596Z" fill="#520826"/></svg>',
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
      '<button class="fav-btn ' + (p.favorited ? 'favorited' : '') + '" data-od-id="fav-' + p.id + '">' +
        (p.favorited ? ICONS.heartFav : ICONS.heart) +
      '</button>' +
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
  return '<div class="store-card" data-od-id="store-' + s.id + '">' +
    '<div class="store-bg" style="background:' + s.bg + '"><img src="' + s.img + '" alt="' + s.name + '" loading="lazy" /></div>' +
    '<div class="store-overlay"></div>' +
    (s.discount
      ? '<div class="store-discount">' +
          '<span class="discount-frame">' + SHARED_ICONS.discountFrame + '</span>' +
          '<span class="discount-content">' + SHARED_ICONS.discountIcon + '<span>' + s.discount + '%</span></span>' +
        '</div>'
      : '') +
    '<button class="fav-btn ' + (s.favorited ? 'favorited' : '') + '" data-od-id="store-fav-' + s.id + '">' +
      (s.favorited ? ICONS.heartFav : ICONS.heart) +
    '</button>' +
    '<div class="store-name">' + s.name + '</div>' +
  '</div>';
}).join('');

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
