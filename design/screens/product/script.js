/* ═══════════════════════════════════════════════
   Product Detail Screen — script.js
   Matches Flutter ProductDetailsScreen behavior
   ═══════════════════════════════════════════════ */

(function() {
  'use strict';

  var productId = parseInt(new URLSearchParams(window.location.search).get('id')) || 1;
  var product = getProductDetail(productId);
  var isFav = product.isFavorite;
  var count = 0;

  // ── Status Bar ──
  document.getElementById('statusbar-main').innerHTML = getStatusHTML();

  // ── Back Button ──
  document.getElementById('back-btn').addEventListener('click', function() {
    window.history.back();
  });

  // ── Shimmer → Content ──
  showLoading();
  setTimeout(function() {
    showContent();
    renderAll();
  }, 800);

  function showLoading() {
    document.getElementById('product-loading').style.display = 'flex';
    document.getElementById('product-content').style.display = 'none';
  }

  function showContent() {
    document.getElementById('product-loading').style.display = 'none';
    document.getElementById('product-content').style.display = 'flex';
  }

  // ── Render Everything ──
  function renderAll() {
    renderTitle();
    renderFavorite();
    renderImages();
    renderPrice();
    renderCounter();
    renderDescription();
  }

  // ── Title (in AppBar) ──
  function renderTitle() {
    document.getElementById('product-title').textContent = product.title;
  }

  // ── Favorite Button ──
  function renderFavorite() {
    var btn = document.getElementById('product-fav-btn');
    btn.innerHTML = isFav ? SHARED_ICONS.heartFav : SHARED_ICONS.heart;
    btn.onclick = function() {
      isFav = !isFav;
      renderFavorite();
    };
  }

  // ── Image Grid (Flutter productImagesSection) ──
  // Layout: left column (2x 110×110) + gap 4 + right expanded (224h)
  function renderImages() {
    var imgs = product.images;
    // Pad to 3 images
    while (imgs.length < 3) imgs.push('');

    var container = document.getElementById('product-images');
    container.innerHTML =
      '<div class="img-col-left">' +
        '<div class="img-thumb"><img src="' + imgs[0] + '" alt="" /></div>' +
        '<div class="img-thumb"><img src="' + imgs[1] + '" alt="" /></div>' +
      '</div>' +
      '<div class="img-main"><img src="' + imgs[2] + '" alt="" /></div>';
  }

  // ── Price Section (Flutter productPriceSection) ──
  function renderPrice() {
    var container = document.getElementById('product-price-row');
    var html = '';
    var hasDiscount = product.discount && product.originalPrice;

    if (hasDiscount) {
      html += '<span class="price-original">' + product.originalPrice + ' EGP</span>';
    }
    html += '<span class="price-current">' + product.price.toLocaleString() + ' EGP</span>';

    container.innerHTML = html;
  }

  // ── Counter Section (Flutter productCounterSection) ──
  function renderCounter() {
    var container = document.getElementById('product-counter-section');
    var minusSvg = '<svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M4 8h8" stroke="#9E9E9E" stroke-width="1.5" stroke-linecap="round"/></svg>';
    var deleteSvg = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none"><path d="M3 6h18M8 6V4a2 2 0 012-2h4a2 2 0 012 2v2m3 0v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6h14zM10 11v6M14 11v6" stroke="#9E9E9E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    var plusSvg = '<svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M8 4v8M4 8h8" stroke="#520826" stroke-width="1.5" stroke-linecap="round"/></svg>';

    var countLabel = count < 10 ? '0' + count : '' + count;

    container.innerHTML =
      '<button class="counter-btn counter-btn--minus" id="counter-minus">' +
        (count <= 1 ? deleteSvg : minusSvg) +
      '</button>' +
      '<span class="counter-count">' + countLabel + '</span>' +
      '<button class="counter-btn counter-btn--plus" id="counter-plus">' +
        plusSvg +
      '</button>';

    document.getElementById('counter-minus').addEventListener('click', function() {
      if (count > 0) {
        count--;
        renderCounter();
      }
    });

    document.getElementById('counter-plus').addEventListener('click', function() {
      count++;
      renderCounter();
      if (count === 1) {
        showToast('Added to cart');
      }
    });
  }

  // ── Description ──
  function renderDescription() {
    document.getElementById('product-description').textContent = product.description;
  }

})();
