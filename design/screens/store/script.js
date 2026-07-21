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
        '<button class="fav-btn" data-fav-id="' + p.id + '">' +
          SHARED_ICONS.heart +
        '</button>' +
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

  // Favorite toggle on featured cards
  document.querySelectorAll('.featured-card .fav-btn').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      this.classList.toggle('favorited');
      var isFav = this.classList.contains('favorited');
      this.innerHTML = isFav ? SHARED_ICONS.heartFav : SHARED_ICONS.heart;
    });
  });

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
    card.addEventListener('click', function() {
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
    return '<div class="store-product-card" data-od-id="product-' + p.id + '" data-product-id="' + p.id + '">' +
      '<div class="store-product-card__img">' +
        '<img src="' + p.images[0] + '" alt="' + p.title + '" loading="lazy" />' +
      '</div>' +
      '<div class="store-product-card__content">' +
        '<div class="store-product-card__title">' + p.title + '</div>' +
        '<div class="store-product-card__desc">' + p.description + '</div>' +
        '<div class="store-product-card__price">' + p.price.toLocaleString() + ' EGP</div>' +
      '</div>' +
      '<div class="store-product-card__actions" data-cart-row="' + p.id + '">' +
      '</div>' +
    '</div>';
  }).join('');
  document.getElementById('store-products').innerHTML = html;

  // Render product counters (add-to-cart / increment/decrement)
  ProductCounter.renderAllCounters();

  // Product tap
  document.querySelectorAll('.store-product-card').forEach(function(card) {
    card.addEventListener('click', function() {
    });
  });
}

// Favorite button in app bar
document.getElementById('store-fav-btn').addEventListener('click', function() {
  var isFav = this.classList.toggle('favorited');
  if (isFav) {
    this.innerHTML = SHARED_ICONS.heartFav;
  } else {
    this.innerHTML = '<svg viewBox="0 0 18 17" fill="none"><path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M2.41241 0.920962C4.89656-0.602813 7.12508 0.00447571 8.47136 1.01551C8.69284 1.18183 8.84485 1.29567 8.95801 1.37254C9.07117 1.29567 9.22317 1.18183 9.44465 1.01551C10.7909 0.00447571 13.0195-0.602813 15.5036 0.920962C17.2213 1.9746 18.1878 4.1755 17.8487 6.70426C17.5079 9.24522 15.8632 12.1191 12.3802 14.6971C11.0841 15.657 10.2831 16.2503 8.95801 16.2503C7.63296 16.2503 6.83197 15.657 5.62248 14.7613C5.59382 14.74 5.56492 14.7186 5.53579 14.6971C2.05278 12.1191 0.40813 9.24522 0.06734 6.70426C-0.271814 4.1755 0.694712 1.9746 2.41241 0.920962Z" fill="#520826"/><path fill-rule="evenodd" clip-rule="evenodd" d="M2.41241 0.920962C4.89656-0.602813 7.12508 0.00447571 8.47136 1.01551C8.719 1.20148 8.87978 1.32182 8.99652 1.39825C9.02758 1.41858 9.04987 1.432 9.06494 1.44056C9.35917 1.49129 9.58301 1.74773 9.58301 2.05645C9.58301 2.40163 9.30319 2.68145 8.95801 2.68145C8.79648 2.68145 8.66166 2.63184 8.57389 2.59218C8.48142 2.55039 8.39231 2.49674 8.31185 2.44406C8.15702 2.3427 7.96346 2.19733 7.73813 2.0281L7.72074 2.01504Z" fill="#520826"/></svg>';
  }
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

// Simulate loading
showLoading();
setTimeout(function() {
  showContent();
}, 800);
