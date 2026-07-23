// Store Details Screen
var selectedCategoryIndex = 0;
var store = STORE_DETAIL;

// Status bar
document.getElementById('statusbar-main').innerHTML = getStatusHTML();

// Back button
document.getElementById('store-back').addEventListener('click', function() {
  window.history.back();
});

// Show loading, then content
function showLoading() {
  document.getElementById('store-loading').style.display = 'block';
  document.getElementById('store-content').style.display = 'none';
}

function showContent() {
  document.getElementById('store-loading').style.display = 'none';
  document.getElementById('store-content').style.display = 'flex';
  renderStore();
}

function renderStore() {
  // App bar title
  document.getElementById('store-title').textContent = store.name;

  // Cover image
  document.getElementById('store-cover').style.backgroundImage = 'url(' + store.coverImage + ')';

  // Profile image
  document.getElementById('store-profile').style.backgroundImage = 'url(' + store.profileImage + ')';

  // Discount tag
  if (store.sale) {
    document.getElementById('store-discount-tag').style.display = 'flex';
    document.getElementById('store-discount-text').textContent = store.sale + '%';
  }

  // Store name
  document.getElementById('store-name').textContent = store.name;

  // Address
  document.getElementById('store-address-text').textContent = store.address.country + ', ' + store.address.city;

  // Rating
  document.getElementById('store-rating-num').textContent = store.rating;

  // Categories text
  var catNames = store.categories.filter(function(c) { return c.id !== 'all'; }).map(function(c) { return c.name; });
  document.getElementById('store-categories-text').textContent = catNames.join(' • ');

  // Description
  document.getElementById('store-description').textContent = store.description;

  // Featured products
  if (store.featuredProducts && store.featuredProducts.length > 0) {
    document.getElementById('featured-section').style.display = 'block';
    renderFeaturedProducts();
  }

  // Category tabs
  renderCategoryTabs();

  // Products
  renderProducts();
}

function renderFeaturedProducts() {
  var html = store.featuredProducts.map(function(p) {
    return '<div class="featured-card" data-od-id="featured-' + p.id + '" data-product-id="' + p.id + '">' +
      '<div class="img-wrap">' +
        '<img src="' + p.images[0] + '" alt="' + p.title + '" loading="lazy" />' +
        getHeartBtnHTML(false, p.id) +
      '</div>' +
      '<div class="card-content">' +
        '<div class="product-title">' + p.title + '</div>' +
        '<div class="price">' + p.price.toLocaleString() + ' EGP</div>' +
        '<div class="card-cart-row">' +
          '<button class="card-add-btn" data-add-id="' + p.id + '">' +
            SHARED_ICONS.smallCart +
          '</button>' +
        '</div>' +
      '</div>' +
    '</div>';
  }).join('');
  document.getElementById('featured-scroll').innerHTML = html;

  // Initialize favorite toggles on featured cards
  initFavorites('.featured-card .fav-btn');

  // Add-to-cart on featured cards
  document.querySelectorAll('.featured-card .card-add-btn').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      var id = parseInt(this.dataset.addId);
      ProductCounter.addToCart(id);
      showToast('Added to cart');
    });
  });

  // Product tap on featured cards
  document.querySelectorAll('.featured-card').forEach(function(card) {
    card.addEventListener('click', function(e) {
      if (e.target.closest('.fav-btn') || e.target.closest('.card-add-btn')) return;
      window.location.href = '../product/';
    });
  });
}

function renderCategoryTabs() {
  var html = store.categories.map(function(c, i) {
    var isSelected = i === selectedCategoryIndex;
    return '<button class="sellio-chip ' + (isSelected ? 'sellio-chip--selected' : 'sellio-chip--unselected') + '" data-cat-index="' + i + '">' +
      '<span class="sellio-chip__label">' + c.name + '</span>' +
    '</button>';
  }).join('');
  document.getElementById('store-tabs').innerHTML = html;

  // Add click handlers
  document.querySelectorAll('#store-tabs .sellio-chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
      selectedCategoryIndex = parseInt(this.dataset.catIndex);
      renderCategoryTabs();
      renderProducts();
    });
  });
}

function renderProducts() {
  var selectedCat = store.categories[selectedCategoryIndex];
  var filtered;

  if (selectedCat.id === 'all') {
    filtered = store.products;
  } else {
    filtered = store.products.filter(function(p) {
      return p.subCategoriesIds.indexOf(selectedCat.id) !== -1;
    });
  }

  if (filtered.length === 0) {
    document.getElementById('store-products').innerHTML =
      '<div class="store-empty">' +
        '<div class="store-empty__icon">' +
          '<svg viewBox="0 0 24 24" fill="none"><path d="M20 7L12 3L4 7M20 7L12 11M20 7V17L12 21M12 11L4 7M12 11V21M4 7V17L12 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>' +
        '</div>' +
        '<div class="store-empty__title">No products available</div>' +
        '<div class="store-empty__desc">There are no products in this category yet.</div>' +
      '</div>';
    return;
  }

  var html = filtered.map(function(p) {
    return '<div class="sellio-product-h-card store-product-card" data-od-id="product-' + p.id + '" data-product-id="' + p.id + '">' +
      '<div class="sellio-product-h-card__image">' +
        '<img src="' + p.images[0] + '" alt="' + p.title + '" loading="lazy" />' +
      '</div>' +
      '<div class="sellio-product-h-card__content">' +
        '<div class="sellio-product-h-card__title">' + p.title + '</div>' +
        '<div class="sellio-product-h-card__description">' + p.description + '</div>' +
        '<div class="sellio-product-h-card__prices">' +
          '<span class="sellio-product-h-card__price">' + p.price.toLocaleString() + ' EGP</span>' +
        '</div>' +
      '</div>' +
      '<div class="sellio-product-h-card__actions" data-cart-row="' + p.id + '">' +
      '</div>' +
    '</div>';
  }).join('');
  document.getElementById('store-products').innerHTML = html;

  // Render product counters (add-to-cart / increment/decrement)
  ProductCounter.renderAllCounters();

  // Product tap
  document.querySelectorAll('.store-product-card').forEach(function(card) {
    card.addEventListener('click', function(e) {
      if (e.target.closest('.product-card__add-btn') || e.target.closest('.counter')) return;
      window.location.href = '../product/';
    });
  });
}

// Favorite button in app bar
document.getElementById('store-fav-btn').innerHTML = SHARED_ICONS.heart;
document.getElementById('store-fav-btn').addEventListener('click', function() {
  var isFav = this.classList.toggle('favorited');
  this.innerHTML = isFav ? SHARED_ICONS.heartFav : SHARED_ICONS.heart;
});

// Bottom nav
populateBottomNav('');
initNavClickHandlers({
  home: function() { window.location.href = '../home/'; },
  cart: function() { window.location.href = '../cart/'; },
  thrift: function() { window.location.href = '../thrift/'; },
  account: function() {
    var isLoggedIn = sessionStorage.getItem('isLoggedIn');
    if (isLoggedIn) {
      window.location.href = '../home/';
    } else {
      window.location.href = '../login/';
    }
  },
});

// Info button → About Store
document.getElementById('store-info-btn').addEventListener('click', function() {
  window.location.href = '../about-store/';
});

// Simulate loading
showLoading();
setTimeout(function() {
  showContent();
}, 800);
