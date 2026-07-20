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

function renderCategoryTabs() {
  var container = document.getElementById('category-tabs');
  container.innerHTML = CATEGORIES.map(function(cat) {
    var isSelected = cat.id === selectedCategory;
    return '<button class="cat-chip ' + (isSelected ? 'selected' : 'unselected') + '" data-id="' + cat.id + '">' +
      '<span class="cat-chip__label">' + cat.name + '</span>' +
    '</button>';
  }).join('');

  container.querySelectorAll('.cat-chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
      selectedCategory = this.dataset.id;
      renderCategoryTabs();
      renderProducts();
    });
  });
}

var PRODUCTS = THRIFT_PRODUCTS;

function renderProducts() {
  var container = document.getElementById('products-grid');
  var filtered = selectedCategory === 'all'
    ? PRODUCTS
    : PRODUCTS.filter(function(p) { return p.category === selectedCategory; });

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

ProductCounter.init({
  onBadgeUpdate: null
});

renderCategoryTabs();
renderProducts();
