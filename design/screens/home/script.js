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

var homeCategories = CATEGORIES.filter(function(c) { return !c.isMore; }).slice(0, 7);
homeCategories.push({ name: 'More', isMore: true, bg: '#F5F5F5' });

document.getElementById('categories-grid').innerHTML = homeCategories.map(function(c) {
  var clickable = c.isMore ? ' id="categories-more-btn"' : ' data-category="' + c.name + '"';
  return '<div class="category-item" data-od-id="category-' + c.name.toLowerCase() + '"' + clickable + '>' +
    '<div class="category-img' + (c.isMore ? ' more-circle' : '') + '" style="background:' + c.bg + '">' +
      (c.isMore ? ICONS.more : (c.img ? '<img src="' + c.img + '" alt="' + c.name + '" loading="lazy" />' : (ICONS[c.iconKey] || ''))) +
    '</div>' +
    '<span class="category-name">' + c.name + '</span>' +
  '</div>';
}).join('');

document.getElementById('categories-more-btn').addEventListener('click', function() {
  window.location.href = '../all-categories/';
});

document.querySelectorAll('.category-item[data-category]').forEach(function(item) {
  item.addEventListener('click', function() {
    var name = this.dataset.category;
    window.location.href = '../category/?name=' + encodeURIComponent(name);
  });
});

document.getElementById('trending-products').innerHTML = PRODUCTS.map(function(p) {
  var discountHtml = p.discount
    ? '<div class="product-card__discount">' +
        '<span class="product-card__discount-frame">' + SHARED_ICONS.discountFrame + '</span>' +
        '<span class="product-card__discount-content">' + SHARED_ICONS.discountIcon + '<span>' + p.discount + '</span></span>' +
      '</div>'
    : '';

  return '<div class="product-card" data-od-id="product-' + p.id + '">' +
    '<div class="product-card__img-wrap">' +
      '<img src="' + p.img + '" alt="' + p.title + '" loading="lazy" />' +
      discountHtml +
      getHeartBtnHTML(p.favorited, p.id) +
    '</div>' +
    '<div class="product-card__content">' +
      '<div class="product-card__title">' + p.title + '</div>' +
      '<div class="product-card__price-row">' +
        '<span class="product-card__price">' + p.price + ' EGP</span>' +
        (p.originalPrice ? '<span class="product-card__original-price">' + p.originalPrice + '</span>' : '') +
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
    var storeId = card.getAttribute('data-store-id');
    window.location.href = '../store/?id=' + storeId;
  });
});

document.querySelectorAll('.product-card').forEach(function(card) {
  card.addEventListener('click', function(e) {
    if (e.target.closest('.fav-btn') || e.target.closest('.product-card__add-btn') || e.target.closest('.counter')) return;
    var productId = card.getAttribute('data-od-id').replace('product-', '');
    window.location.href = '../product/?id=' + productId;
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

var bellBtn = document.querySelector('.appbar-bell');
if (bellBtn) {
  bellBtn.style.cursor = 'pointer';
  bellBtn.addEventListener('click', function() {
    window.location.href = '../notification/';
  });
}

document.querySelector('.home-search .input-wrap').addEventListener('click', function() {
  window.location.href = '../search/';
});
