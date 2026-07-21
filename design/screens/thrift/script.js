document.getElementById('statusbar-main').innerHTML = getStatusHTML();
document.getElementById('filter-btn').innerHTML = SHARED_ICONS.filter;
populateBottomNav('thrift');

initNavClickHandlers({
  home: function() { window.location.href = '../home/'; },
  cart: function() { window.location.href = '../cart/'; },
  account: function() {
    var isLoggedIn = sessionStorage.getItem('isLoggedIn');
    if (isLoggedIn) {
      window.location.href = '../home/';
    } else {
      window.location.href = '../login/';
    }
  }
});

var CATEGORIES = [
  { id: 'all', name: 'All' },
  { id: 'electronics', name: 'Electronics' },
  { id: 'fashion', name: 'Fashion' },
  { id: 'home', name: 'Home & Living' },
  { id: 'beauty', name: 'Beauty' },
  { id: 'sports', name: 'Sports' },
  { id: 'books', name: 'Books' },
  { id: 'toys', name: 'Toys' }
];

var selectedCategory = 'all';
var PRODUCTS = THRIFT_PRODUCTS;

function renderCategoryTabs() {
  var container = document.getElementById('thrift-tabs');
  container.innerHTML = CATEGORIES.map(function(cat) {
    var isSelected = cat.id === selectedCategory;
    var cls = 'sellio-chip ' + (isSelected ? 'sellio-chip--selected' : 'sellio-chip--unselected');
    return '<button class="' + cls + '" data-id="' + cat.id + '">' +
      '<span class="sellio-chip__label">' + cat.name + '</span>' +
    '</button>';
  }).join('');

  container.querySelectorAll('.sellio-chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
      selectedCategory = this.dataset.id;
      renderCategoryTabs();
      renderProducts();
    });
  });
}

function renderProducts() {
  var container = document.getElementById('thrift-products');
  var emptyEl = document.getElementById('thrift-empty');

  var filtered = selectedCategory === 'all'
    ? PRODUCTS
    : PRODUCTS.filter(function(p) { return p.category === selectedCategory; });

  if (filtered.length === 0) {
    container.style.display = 'none';
    emptyEl.style.display = '';
    return;
  }

  container.style.display = '';
  emptyEl.style.display = 'none';

  container.innerHTML = filtered.map(function(p) {
    var discountHtml = p.discount
      ? '<div class="product-card__discount"><div class="discount-frame-wrap">' +
          '<div class="frame-bg">' + SHARED_ICONS.discountFrame + '</div>' +
          '<div class="frame-content">' + SHARED_ICONS.discountIcon + '<span>' + p.discount.replace(' OFF', '') + '</span></div>' +
        '</div></div>'
      : '';

    var favSvg = p.isFavorite ? SHARED_ICONS.heartFav : SHARED_ICONS.heart;

    return '<div class="product-card" data-id="' + p.id + '">' +
      '<div class="product-card__img-wrap">' +
        '<img src="' + p.image + '" alt="' + p.title + '" loading="lazy" />' +
        discountHtml +
        '<button class="product-card__fav" data-fav="' + p.id + '">' + favSvg + '</button>' +
      '</div>' +
      '<div class="product-card__content">' +
        '<div class="product-card__title">' + p.title + '</div>' +
        '<div class="product-card__price">' + p.price + '</div>' +
        '<div class="product-card__cart-row" data-cart-row="' + p.id + '">' +
          '<button class="product-card__add-btn" data-add="' + p.id + '">' + SHARED_ICONS.smallCart + '</button>' +
        '</div>' +
      '</div>' +
    '</div>';
  }).join('');

  container.querySelectorAll('.product-card__fav').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      var id = parseInt(this.dataset.fav);
      var product = PRODUCTS.find(function(p) { return p.id === id; });
      if (product) {
        product.isFavorite = !product.isFavorite;
        renderProducts();
      }
    });
  });

  ProductCounter.renderAllCounters();
}

function renderLoadingTabs() {
  var container = document.getElementById('loading-tabs');
  var html = '';
  for (var i = 0; i < 6; i++) {
    html += '<div class="shimmer-tab"></div>';
  }
  container.innerHTML = html;
}

function renderLoadingGrid() {
  var container = document.getElementById('loading-grid');
  var html = '';
  for (var i = 0; i < 8; i++) {
    html += '<div class="shimmer-card">' +
      '<div class="shimmer-card__img"></div>' +
      '<div class="shimmer-card__line"></div>' +
      '<div class="shimmer-card__line shimmer-card__line--short"></div>' +
    '</div>';
  }
  container.innerHTML = html;
}

function showLoading() {
  document.getElementById('thrift-loading').style.display = '';
  document.getElementById('thrift-products').style.display = 'none';
  document.getElementById('thrift-empty').style.display = 'none';
  document.getElementById('thrift-tabs-wrap').style.display = 'none';
}

function showContent() {
  document.getElementById('thrift-loading').style.display = 'none';
  document.getElementById('thrift-tabs-wrap').style.display = '';
  renderCategoryTabs();
  renderProducts();
}

ProductCounter.init({
  onBadgeUpdate: null
});

showLoading();
renderLoadingTabs();
renderLoadingGrid();

setTimeout(function() {
  showContent();
}, 800);

var contentEl = document.getElementById('thrift-content');
contentEl.addEventListener('scroll', function() {
  if (contentEl.scrollTop + contentEl.clientHeight >= contentEl.scrollHeight - 200) {
    // Infinite scroll placeholder — no more data to load in mock
  }
});
