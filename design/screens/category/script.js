// Category Details Screen
var categoryName = new URLSearchParams(window.location.search).get('name') || 'Electronics';
var categoryId = categoryName;
var selectedTabIndex = 0;
var categoryData = CATEGORY_DATA[categoryName];

// Status bar
document.getElementById('statusbar-main').innerHTML = getStatusHTML();

// Page caption
document.getElementById('page-caption').textContent = categoryName;

// Back button
document.getElementById('cat-back').addEventListener('click', function() {
  window.history.back();
});

// Search placeholder
document.getElementById('cat-search-input').placeholder = 'Search in ' + categoryName;

// Show loading, then content
function showLoading() {
  document.getElementById('cat-loading').style.display = 'block';
  document.getElementById('cat-content').style.display = 'none';
}

function showContent() {
  document.getElementById('cat-loading').style.display = 'none';
  document.getElementById('cat-content').style.display = 'flex';
  renderCategory();
}

function renderCategory() {
  if (!categoryData) {
    renderEmpty();
    return;
  }

  // App bar title
  document.getElementById('cat-title').textContent = categoryName;

  // Subcategory tabs
  renderTabs();

  // Products grid
  renderProducts();
}

function renderTabs() {
  var html = categoryData.subcategories.map(function(sc, i) {
    var isSelected = i === selectedTabIndex;
    return '<button class="sellio-chip ' + (isSelected ? 'sellio-chip--selected' : 'sellio-chip--unselected') + '" data-tab-index="' + i + '">' +
      '<span class="sellio-chip__label">' + sc.name + '</span>' +
    '</button>';
  }).join('');
  document.getElementById('cat-tabs').innerHTML = html;

  // Click handlers
  document.querySelectorAll('#cat-tabs .sellio-chip').forEach(function(chip) {
    chip.addEventListener('click', function() {
      selectedTabIndex = parseInt(this.dataset.tabIndex);
      renderTabs();
      renderProducts();
    });
  });
}

function renderProducts() {
  var selectedSub = categoryData.subcategories[selectedTabIndex];
  var filtered;

  if (selectedSub.id === 'all') {
    filtered = categoryData.products;
  } else {
    filtered = categoryData.products.filter(function(p) {
      return p.subcategories.indexOf(selectedSub.id) !== -1;
    });
  }

  if (filtered.length === 0) {
    document.getElementById('cat-products').innerHTML =
      '<div class="cat-empty">' +
        '<div class="cat-empty__icon">' +
          '<svg viewBox="0 0 24 24" fill="none"><path d="M20 7L12 3L4 7M20 7L12 11M20 7V17L12 21M12 11L4 7M12 11V21M4 7V17L12 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>' +
        '</div>' +
        '<div class="cat-empty__title">No products found</div>' +
        '<div class="cat-empty__desc">There are no products in this category yet.</div>' +
      '</div>';
    return;
  }

  var html = filtered.map(function(p) {
    var discountTag = p.discount ? '<div class="sellio-product-v-card__category">' + p.discount + ' OFF</div>' : '';
    var originalPrice = p.originalPrice ? '<span class="sellio-product-v-card__original-price">' + p.originalPrice + ' EGP</span>' : '';

    return '<div class="sellio-product-v-card cat-product-card" data-product-id="' + p.id + '">' +
      '<div class="sellio-product-v-card__image">' +
        '<img src="' + p.images[0] + '" alt="' + p.title + '" loading="lazy" style="width:100%;height:100%;object-fit:cover;" />' +
        '<button class="sellio-product-v-card__favorite" data-fav-id="' + p.id + '">' +
          (p.isFavorite ? SHARED_ICONS.heartFav : SHARED_ICONS.heart) +
        '</button>' +
      '</div>' +
      '<div class="sellio-product-v-card__content">' +
        discountTag +
        '<div class="sellio-product-v-card__title">' + p.title + '</div>' +
        '<div class="sellio-product-v-card__prices">' +
          '<span class="sellio-product-v-card__price">' + p.price + ' EGP</span>' +
          originalPrice +
        '</div>' +
        '<div class="sellio-product-v-card__actions" data-cart-row="' + p.id + '"></div>' +
      '</div>' +
    '</div>';
  }).join('');
  document.getElementById('cat-products').innerHTML = html;

  // Render product counters
  ProductCounter.renderAllCounters();

  // Favorite toggles
  initFavorites('.cat-product-card .sellio-product-v-card__favorite');

  // Product tap (navigate to product detail)
  document.querySelectorAll('.cat-product-card').forEach(function(card) {
    card.addEventListener('click', function(e) {
      if (e.target.closest('.sellio-product-v-card__favorite') || e.target.closest('.product-card__add-btn') || e.target.closest('.counter')) return;
      window.location.href = '../product/';
    });
  });
}

function renderEmpty() {
  document.getElementById('cat-title').textContent = categoryName;
  document.getElementById('cat-products').innerHTML =
    '<div class="cat-empty">' +
      '<div class="cat-empty__icon">' +
        '<svg viewBox="0 0 24 24" fill="none"><path d="M20 7L12 3L4 7M20 7L12 11M20 7V17L12 21M12 11L4 7M12 11V21M4 7V17L12 21" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>' +
      '</div>' +
      '<div class="cat-empty__title">No products found</div>' +
      '<div class="cat-empty__desc">There are no products in this category yet.</div>' +
    '</div>';
}

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
