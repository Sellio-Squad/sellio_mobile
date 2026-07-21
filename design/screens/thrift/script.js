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
var isLoading = true;
var isRefreshing = false;
var isLoadingMore = false;
var allProducts = THRIFT_PRODUCTS;

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

function renderShimmerCards(containerId, count) {
  var container = document.getElementById(containerId);
  var html = '';
  for (var i = 0; i < count; i++) {
    html += '<div class="shimmer-card">' +
      '<div class="shimmer-card__image"></div>' +
      '<div class="shimmer-card__lines">' +
        '<div class="shimmer-card__line"></div>' +
        '<div class="shimmer-card__line shimmer-card__line--short"></div>' +
      '</div>' +
    '</div>';
  }
  container.innerHTML = html;
}

function showLoading() {
  isLoading = true;
  document.getElementById('thrift-loading').classList.add('active');
  document.getElementById('thrift-empty').classList.remove('active');
  document.getElementById('products-grid-wrap').style.display = 'none';
  renderShimmerCards('products-grid-loading', 6);
}

function showContent() {
  isLoading = false;
  document.getElementById('thrift-loading').classList.remove('active');
  document.getElementById('thrift-empty').classList.remove('active');
  document.getElementById('thrift-load-more').classList.remove('active');
  document.getElementById('products-grid-wrap').style.display = '';
  renderProducts();
}

function showEmpty() {
  isLoading = false;
  document.getElementById('thrift-loading').classList.remove('active');
  document.getElementById('thrift-empty').classList.add('active');
  document.getElementById('products-grid-wrap').style.display = 'none';
  document.getElementById('thrift-load-more').classList.remove('active');
}

function renderProducts() {
  var container = document.getElementById('products-grid');
  var filtered = selectedCategory === 'all'
    ? allProducts
    : allProducts.filter(function(p) { return p.category === selectedCategory; });

  if (filtered.length === 0) {
    showEmpty();
    return;
  }

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
      var product = allProducts.find(function(p) { return p.id === id; });
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

function refreshProducts() {
  if (isRefreshing) return;
  isRefreshing = true;
  showLoading();
  setTimeout(function() {
    isRefreshing = false;
    showContent();
  }, 800);
}

function loadMoreProducts() {
  if (isLoadingMore) return;
  isLoadingMore = true;
  document.getElementById('thrift-load-more').classList.add('active');
  renderShimmerCards('products-grid-load-more', 2);
  setTimeout(function() {
    isLoadingMore = false;
    document.getElementById('thrift-load-more').classList.remove('active');
  }, 800);
}

function initPullToRefresh() {
  var scrollContainer = document.getElementById('thrift-content');
  var startY = 0;
  var isPulling = false;

  scrollContainer.addEventListener('touchstart', function(e) {
    if (scrollContainer.scrollTop === 0) {
      startY = e.touches[0].clientY;
      isPulling = true;
    }
  });

  scrollContainer.addEventListener('touchmove', function(e) {
    if (!isPulling) return;
    var currentY = e.touches[0].clientY;
    var pullDistance = currentY - startY;
    if (pullDistance > 50 && !isRefreshing) {
      refreshProducts();
      isPulling = false;
    }
  });

  scrollContainer.addEventListener('touchend', function() {
    isPulling = false;
  });
}

function initInfiniteScroll() {
  var scrollContainer = document.getElementById('thrift-content');
  scrollContainer.addEventListener('scroll', function() {
    if (isLoadingMore || isRefreshing) return;
    var scrollTop = scrollContainer.scrollTop;
    var scrollHeight = scrollContainer.scrollHeight;
    var clientHeight = scrollContainer.clientHeight;
    if (scrollTop + clientHeight >= scrollHeight - 200) {
      loadMoreProducts();
    }
  });
}

document.getElementById('empty-cta').addEventListener('click', function() {
  selectedCategory = 'all';
  renderCategoryTabs();
  showContent();
});

renderCategoryTabs();
initPullToRefresh();
initInfiniteScroll();

showLoading();
setTimeout(function() {
  showContent();
}, 800);
