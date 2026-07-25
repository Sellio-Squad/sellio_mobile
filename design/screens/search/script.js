(function() {
  'use strict';

  // ── Status Bar ──
  document.getElementById('statusbar-main').innerHTML = getStatusHTML();

  // ── State ──
  var searchInput = document.getElementById('search-input');
  var clearBtn = document.getElementById('search-clear-btn');
  var recentSection = document.getElementById('recent-section');
  var resultsSection = document.getElementById('results-section');
  var emptySection = document.getElementById('search-empty');
  var resultsGrid = document.getElementById('results-grid');
  var resultsCount = document.getElementById('results-count');
  var recentChips = document.getElementById('recent-chips');
  var debounceTimer = null;

  // Recent searches stored in memory (session)
  var RECENT_SEARCHES = [];
  try {
    var stored = sessionStorage.getItem('sellio_recent_searches');
    if (stored) RECENT_SEARCHES = JSON.parse(stored);
  } catch(e) {}

  // ── Back Button ──
  document.getElementById('search-back').addEventListener('click', function() {
    window.history.back();
  });

  // ── Clear Input ──
  clearBtn.addEventListener('click', function() {
    searchInput.value = '';
    clearBtn.style.display = 'none';
    showRecent();
    searchInput.focus();
  });

  // ── Input Handler ──
  searchInput.addEventListener('input', function() {
    var query = searchInput.value.trim();
    clearBtn.style.display = query.length > 0 ? '' : 'none';

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

  // ── Show Recent Searches ──
  function showRecent() {
    recentSection.style.display = '';
    resultsSection.style.display = 'none';
    emptySection.style.display = 'none';
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
        clearBtn.style.display = '';
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

  // ── Search ──
  function performSearch(query) {
    // Save to recent
    var idx = RECENT_SEARCHES.indexOf(query);
    if (idx !== -1) RECENT_SEARCHES.splice(idx, 1);
    RECENT_SEARCHES.unshift(query);
    if (RECENT_SEARCHES.length > 10) RECENT_SEARCHES = RECENT_SEARCHES.slice(0, 10);
    try { sessionStorage.setItem('sellio_recent_searches', JSON.stringify(RECENT_SEARCHES)); } catch(e) {}

    // Search across all products
    var q = query.toLowerCase();
    var results = PRODUCTS.filter(function(p) {
      return p.title.toLowerCase().indexOf(q) !== -1 ||
             p.category.toLowerCase().indexOf(q) !== -1;
    });

    if (results.length === 0) {
      recentSection.style.display = 'none';
      resultsSection.style.display = 'none';
      emptySection.style.display = '';
      return;
    }

    recentSection.style.display = 'none';
    emptySection.style.display = 'none';
    resultsSection.style.display = '';

    resultsCount.textContent = results.length + ' result' + (results.length !== 1 ? 's' : '');

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

    // Favorite toggles
    initFavorites('#results-grid .fav-btn');

    // Product counter
    ProductCounter.renderAllCounters();

    // Product tap
    resultsGrid.querySelectorAll('.product-card').forEach(function(card) {
      card.addEventListener('click', function(e) {
        if (e.target.closest('.fav-btn') || e.target.closest('.product-card__add-btn') || e.target.closest('.counter')) return;
        var productId = card.getAttribute('data-product-id');
        window.location.href = '../product/?id=' + productId;
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
    clearBtn.style.display = '';
    performSearch(urlQuery);
  } else {
    showRecent();
  }

})();
