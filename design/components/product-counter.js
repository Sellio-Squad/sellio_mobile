/* ═══════════════════════════════════════════════
   Product Counter — shared add-to-cart + counter
   ═══════════════════════════════════════════════
   Usage:
     initProductCounter({ cartIcon, onBadgeUpdate })
       cartIcon: HTML string for the cart button icon
       onBadgeUpdate: optional callback(totalCount) after cart changes
*/
var ProductCounter = (function() {
  var cartCounts = {};

  function getDeleteIcon() {
    return '<svg width="16" height="16" viewBox="0 0 24 24" fill="none"><path d="M3 6h18M8 6V4a2 2 0 012-2h4a2 2 0 012 2v2m3 0v14a2 2 0 01-2 2H7a2 2 0 01-2-2V6h14zM10 11v6M14 11v6" stroke="#9E9E9E" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/></svg>';
  }
  function getMinusIcon() {
    return '<svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M4 8h8" stroke="#9E9E9E" stroke-width="1.5" stroke-linecap="round"/></svg>';
  }
  function getPlusIcon() {
    return '<svg width="16" height="16" viewBox="0 0 16 16" fill="none"><path d="M8 4v8M4 8h8" stroke="#520826" stroke-width="1.5" stroke-linecap="round"/></svg>';
  }

  var config = { cartIcon: '', onBadgeUpdate: null };

  function getCount(productId) { return cartCounts[productId] || 0; }

  function getTotalCount() {
    return Object.values(cartCounts).reduce(function(a, b) { return a + b; }, 0);
  }

  function renderCounter(container, productId) {
    var count = cartCounts[productId] || 0;
    var icons = (typeof SHARED_ICONS !== 'undefined') ? SHARED_ICONS : (typeof ICONS !== 'undefined') ? ICONS : {};
    var cartIcon = config.cartIcon || icons.smallCart || '';

    if (count === 0) {
      container.innerHTML = '<button class="product-card__add-btn" data-add="' + productId + '">' + cartIcon + '</button>';
      container.querySelector('.product-card__add-btn').addEventListener('click', function(e) {
        e.stopPropagation();
        addToCart(productId);
      });
    } else {
      container.innerHTML = '<div class="counter">' +
        '<button class="counter-btn minus">' + (count === 1 ? getDeleteIcon() : getMinusIcon()) + '</button>' +
        '<span class="counter-val">' + String(count).padStart(2, '0') + '</span>' +
        '<button class="counter-btn plus">' + getPlusIcon() + '</button>' +
      '</div>';
      container.querySelector('.counter-btn.minus').addEventListener('click', function(e) {
        e.stopPropagation();
        decrementProduct(productId);
      });
      container.querySelector('.counter-btn.plus').addEventListener('click', function(e) {
        e.stopPropagation();
        incrementProduct(productId);
      });
    }
  }

  function renderAllCounters() {
    document.querySelectorAll('.product-card__cart-row[data-cart-row]').forEach(function(row) {
      renderCounter(row, parseInt(row.dataset.cartRow));
    });
  }

  function notifyBadge() {
    if (config.onBadgeUpdate) config.onBadgeUpdate(getTotalCount());
  }

  function addToCart(productId) {
    cartCounts[productId] = 1;
    notifyBadge();
    document.querySelectorAll('.product-card__cart-row[data-cart-row="' + productId + '"]').forEach(function(el) {
      renderCounter(el, productId);
    });
  }

  function incrementProduct(productId) {
    cartCounts[productId] = (cartCounts[productId] || 0) + 1;
    notifyBadge();
    document.querySelectorAll('.product-card__cart-row[data-cart-row="' + productId + '"]').forEach(function(el) {
      renderCounter(el, productId);
    });
  }

  function decrementProduct(productId) {
    cartCounts[productId] = (cartCounts[productId] || 1) - 1;
    notifyBadge();
    document.querySelectorAll('.product-card__cart-row[data-cart-row="' + productId + '"]').forEach(function(el) {
      renderCounter(el, productId);
    });
  }

  function reset() { cartCounts = {}; notifyBadge(); }

  function init(opts) {
    config.cartIcon = (opts && opts.cartIcon) || '';
    config.onBadgeUpdate = (opts && opts.onBadgeUpdate) || null;
  }

  return {
    init: init,
    addToCart: addToCart,
    increment: incrementProduct,
    decrement: decrementProduct,
    getCount: getCount,
    getTotalCount: getTotalCount,
    renderAllCounters: renderAllCounters,
    renderCounter: renderCounter,
    reset: reset
  };
})();
