(function() {
  'use strict';

  // ── Status Bar ──
  document.getElementById('statusbar-main').innerHTML = getStatusHTML();
  document.getElementById('filter-icon').innerHTML = SHARED_ICONS.filter;

  // ── State ──
  var searchInput = document.getElementById('search-input');
  var filterBtn = document.getElementById('search-filter-btn');
  var searchBar = document.getElementById('search-bar');
  var initialSection = document.getElementById('search-initial');
  var recentSection = document.getElementById('recent-section');
  var resultsSection = document.getElementById('results-section');
  var emptySection = document.getElementById('search-empty');
  var resultsGrid = document.getElementById('results-grid');
  var resultsStores = document.getElementById('results-stores');
  var categoryTabsContainer = document.getElementById('category-tabs');
  var emptyCategoryTabsContainer = document.getElementById('empty-category-tabs');
  var recentChips = document.getElementById('recent-chips');
  var debounceTimer = null;

  // Search type: 'products' or 'stores' (matches Flutter SearchType enum)
  var currentSearchType = 'products';
  var lastQuery = '';

  // Recent searches stored in session
  var RECENT_SEARCHES = [];
  try {
    var stored = sessionStorage.getItem('sellio_recent_searches');
    if (stored) RECENT_SEARCHES = JSON.parse(stored);
  } catch(e) {}

  // ── Back Button ──
  document.getElementById('search-back').addEventListener('click', function() {
    window.history.back();
  });

  // ── Filter Button ──
  filterBtn.addEventListener('click', function() {
    openFilterSheet();
  });

  // ── Filter Bottom Sheet ──
  var filterOverlay = document.getElementById('filter-overlay');
  var filterSheet = document.getElementById('filter-sheet');
  var filterChips = document.getElementById('filter-chips');
  var selectedFilter = 'all';

  function openFilterSheet() {
    filterOverlay.style.display = 'flex';
    requestAnimationFrame(function() {
      filterOverlay.classList.add('show');
    });
  }

  function closeFilterSheet() {
    filterOverlay.classList.remove('show');
    setTimeout(function() {
      filterOverlay.style.display = 'none';
    }, 300);
  }

  // Chip selection
  filterChips.addEventListener('click', function(e) {
    var chip = e.target.closest('.filter-chip');
    if (!chip) return;
    var filter = chip.dataset.filter;
    selectedFilter = filter;
    filterChips.querySelectorAll('.filter-chip').forEach(function(c) {
      c.classList.remove('filter-chip--selected');
      c.classList.add('filter-chip--unselected');
    });
    chip.classList.remove('filter-chip--unselected');
    chip.classList.add('filter-chip--selected');
  });

  // Save button
  document.getElementById('filter-save-btn').addEventListener('click', function() {
    closeFilterSheet();
    if (lastQuery.length > 0) {
      performSearch(lastQuery);
    }
    showToast('Filter applied');
  });

  // Backdrop click to close
  filterOverlay.addEventListener('click', function(e) {
    if (e.target === filterOverlay) {
      closeFilterSheet();
    }
  });

  // ── Input Handler ──
  searchInput.addEventListener('input', function() {
    var query = searchInput.value.trim();
    clearTimeout(debounceTimer);
    if (query.length === 0) {
      showRecent();
      return;
    }
    debounceTimer = setTimeout(function() {
      performSearch(query);
    }, 300);
  });

  // ── Keyboard Enter ──
  searchInput.addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
      var query = searchInput.value.trim();
      if (query.length > 0) {
        clearTimeout(debounceTimer);
        performSearch(query);
      }
    }
  });

  // ── Show Initial State ──
  function showInitial() {
    initialSection.style.display = '';
    recentSection.style.display = 'none';
    resultsSection.style.display = 'none';
    emptySection.style.display = 'none';
    filterBtn.style.display = 'none';
    searchBar.classList.remove('has-filter');
  }

  // ── Show Recent Searches ──
  function showRecent() {
    initialSection.style.display = 'none';
    recentSection.style.display = '';
    resultsSection.style.display = 'none';
    emptySection.style.display = 'none';
    filterBtn.style.display = 'none';
    searchBar.classList.remove('has-filter');
    renderRecentChips();
  }

  function renderRecentChips() {
    if (RECENT_SEARCHES.length === 0) {
      recentSection.style.display = 'none';
      return;
    }
    var clockIcon = '<svg viewBox="0 0 24 24" fill="none"><path d="M12 22C6.477 22 2 17.523 2 12S6.477 2 12 2s10 4.477 10 10-4.477 10-10 10z" stroke="currentColor" stroke-width="1.5" fill="none"/><path d="M12 6v6l4 2" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    recentChips.innerHTML = RECENT_SEARCHES.map(function(term) {
      return '<div class="recent-chip" data-term="' + term + '">' +
        '<span class="recent-chip__icon">' + clockIcon + '</span>' +
        '<span class="recent-chip__label">' + term + '</span>' +
      '</div>';
    }).join('');

    recentChips.querySelectorAll('.recent-chip').forEach(function(chip) {
      chip.addEventListener('click', function() {
        var term = this.dataset.term;
        searchInput.value = term;
        performSearch(term);
      });
    });
  }

  // ── Clear Recent ──
  document.getElementById('recent-clear-btn').addEventListener('click', function() {
    RECENT_SEARCHES = [];
    sessionStorage.removeItem('sellio_recent_searches');
    renderRecentChips();
  });

  // ── Render Category Tabs ──
  function renderCategoryTabs(container) {
    var productIcon = '<svg viewBox="0 0 24 24" fill="none"><path d="M20 7H4a1 1 0 0 0-1 1v10a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V8a1 1 0 0 0-1-1Z" stroke="currentColor" stroke-width="1.5"/><path d="M16 7V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v2" stroke="currentColor" stroke-width="1.5"/></svg>';
    var storeIcon = '<svg viewBox="0 0 24 24" fill="none"><path d="M3 9.5L12 4l9 5.5V20a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5Z" stroke="currentColor" stroke-width="1.5"/><path d="M9 21V12h6v9" stroke="currentColor" stroke-width="1.5"/></svg>';

    container.innerHTML =
      '<button class="category-tab' + (currentSearchType === 'products' ? ' category-tab--selected' : '') + '" data-type="products">' +
        '<span class="category-tab__icon">' + productIcon + '</span>' +
        '<span class="category-tab__label">Products</span>' +
      '</button>' +
      '<button class="category-tab' + (currentSearchType === 'stores' ? ' category-tab--selected' : '') + '" data-type="stores">' +
        '<span class="category-tab__icon">' + storeIcon + '</span>' +
        '<span class="category-tab__label">Stores</span>' +
      '</button>';

    container.querySelectorAll('.category-tab').forEach(function(tab) {
      tab.addEventListener('click', function() {
        var type = this.dataset.type;
        selectTab(type);
      });
    });
  }

  // ── Select Tab (matches Flutter cubit.selectTab) ──
  function selectTab(type) {
    if (currentSearchType === type) return;
    currentSearchType = type;
    if (lastQuery.length > 0) {
      performSearch(lastQuery);
    }
  }

  // ── Search ──
  function performSearch(query) {
    // Save to recent
    var idx = RECENT_SEARCHES.indexOf(query);
    if (idx !== -1) RECENT_SEARCHES.splice(idx, 1);
    RECENT_SEARCHES.unshift(query);
    if (RECENT_SEARCHES.length > 10) RECENT_SEARCHES = RECENT_SEARCHES.slice(0, 10);
    try { sessionStorage.setItem('sellio_recent_searches', JSON.stringify(RECENT_SEARCHES)); } catch(e) {}

    lastQuery = query;

    if (query.length === 0) {
      showRecent();
      return;
    }

    if (currentSearchType === 'products') {
      searchProducts(query);
    } else {
      searchStores(query);
    }
  }

  // ── Search Products ──
  function searchProducts(query) {
    var q = query.toLowerCase();
    var results = PRODUCTS.filter(function(p) {
      return p.title.toLowerCase().indexOf(q) !== -1 ||
             p.category.toLowerCase().indexOf(q) !== -1;
    });

    if (selectedFilter === 'high_rating') {
      results.sort(function(a, b) { return (b.rating || 0) - (a.rating || 0); });
    } else if (selectedFilter === 'near_by_you') {
      results.sort(function() { return 0.5 - Math.random(); });
    }

    initialSection.style.display = 'none';
    recentSection.style.display = 'none';
    emptySection.style.display = 'none';
    resultsSection.style.display = '';
    resultsStores.style.display = 'none';
    resultsGrid.style.display = '';
    filterBtn.style.display = '';
    searchBar.classList.add('has-filter');

    renderCategoryTabs(categoryTabsContainer);

    if (results.length === 0) {
      resultsGrid.innerHTML = '';
      emptySection.style.display = '';
      resultsSection.style.display = 'none';
      searchBar.classList.remove('has-filter');
      renderCategoryTabs(emptyCategoryTabsContainer);
      return;
    }

    resultsGrid.innerHTML = results.map(function(p) {
      var discountHtml = p.discount
        ? '<div class="product-card__discount">' +
            '<span class="product-card__discount-frame">' + SHARED_ICONS.discountFrame + '</span>' +
            '<span class="product-card__discount-content">' + SHARED_ICONS.discountIcon + '<span>' + p.discount + '</span></span>' +
          '</div>'
        : '';

      return '<div class="product-card" data-product-id="' + p.id + '">' +
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

    initFavorites('#results-grid .fav-btn');
    ProductCounter.renderAllCounters();

    resultsGrid.querySelectorAll('.product-card').forEach(function(card) {
      card.addEventListener('click', function(e) {
        if (e.target.closest('.fav-btn') || e.target.closest('.product-card__add-btn') || e.target.closest('.counter')) return;
        var productId = card.getAttribute('data-product-id');
        window.location.href = '../product/?id=' + productId;
      });
    });
  }

  // ── Search Stores ──
  function searchStores(query) {
    var q = query.toLowerCase();
    var results = STORES.filter(function(s) {
      return s.name.toLowerCase().indexOf(q) !== -1;
    });

    if (selectedFilter === 'high_rating') {
      results.sort(function(a, b) { return (b.rating || 0) - (a.rating || 0); });
    } else if (selectedFilter === 'near_by_you') {
      results.sort(function() { return 0.5 - Math.random(); });
    }

    initialSection.style.display = 'none';
    recentSection.style.display = 'none';
    emptySection.style.display = 'none';
    resultsSection.style.display = '';
    resultsGrid.style.display = 'none';
    resultsStores.style.display = '';
    filterBtn.style.display = '';
    searchBar.classList.add('has-filter');

    renderCategoryTabs(categoryTabsContainer);

    if (results.length === 0) {
      resultsStores.innerHTML = '';
      emptySection.style.display = '';
      resultsSection.style.display = 'none';
      searchBar.classList.remove('has-filter');
      renderCategoryTabs(emptyCategoryTabsContainer);
      return;
    }

    resultsStores.innerHTML = results.map(function(store) {
      var heartSvg = store.favorited ? SHARED_ICONS.heartFav : SHARED_ICONS.heart;
      return '<div class="search-store-card" data-store-id="' + store.id + '">' +
        '<img class="search-store-card__bg" src="' + store.img + '" alt="' + store.name + '" loading="lazy" />' +
        '<div class="search-store-card__title">' + store.name + '</div>' +
        '<button class="search-store-card__fav" data-store-id="' + store.id + '">' + heartSvg + '</button>' +
      '</div>';
    }).join('');

    resultsStores.querySelectorAll('.search-store-card').forEach(function(card) {
      card.addEventListener('click', function(e) {
        if (e.target.closest('.search-store-card__fav')) return;
        var storeId = card.getAttribute('data-store-id');
        window.location.href = '../store/?id=' + storeId;
      });
    });

    resultsStores.querySelectorAll('.search-store-card__fav').forEach(function(btn) {
      btn.addEventListener('click', function(e) {
        e.stopPropagation();
        var storeId = btn.getAttribute('data-store-id');
        showToast('Added to favorites');
      });
    });
  }

  // ── Product Counter ──
  ProductCounter.init({
    onBadgeUpdate: function(total) {
      var badge = document.getElementById('cart-badge');
      if (badge) { badge.textContent = total; badge.style.display = total > 0 ? 'flex' : 'none'; }
    }
  });

  // ── Toast ──
  function showToast(msg) {
    var toast = document.getElementById('toast');
    toast.textContent = msg;
    toast.classList.add('show');
    setTimeout(function() { toast.classList.remove('show'); }, 2000);
  }

  // ── Bottom Nav ──
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

  // ── Check URL for initial query ──
  var urlQuery = new URLSearchParams(window.location.search).get('q');
  if (urlQuery) {
    searchInput.value = urlQuery;
    performSearch(urlQuery);
  } else {
    showInitial();
  }

})();
