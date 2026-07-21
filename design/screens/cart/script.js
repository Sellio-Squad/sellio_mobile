if (!sessionStorage.getItem('isLoggedIn')) {
  window.location.href = '../login/';
}

var CART_ICONS = {
  remove: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M5 12H19" stroke="#1F1F1F" stroke-opacity="0.66" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  add: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M12 5V19" stroke="#520826" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M5 12H19" stroke="#520826" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>',
  cartEmpty: '<svg width="64" height="64" viewBox="0 0 64 64" fill="none"><path d="M21 19.0003C21 13.1093 25.7756 8.33363 31.6666 8.33363C37.5577 8.33363 42.3333 13.1093 42.3333 19.0003L42.3333 20.3336C42.3333 21.8064 43.5272 23.0003 45 23.0003C46.4727 23.0003 47.6666 21.8064 47.6666 20.3336L47.6666 19.0003C47.6666 10.1637 40.5032 3.00029 31.6666 3.0003C22.8301 3.0003 15.6666 10.1637 15.6666 19.0003L15.6666 20.3336C15.6666 21.8064 16.8605 23.0003 18.3333 23.0003C19.8061 23.0003 21 21.8064 21 20.3336L21 19.0003Z" fill="#520826"/><path d="M58.8856 41.5526C59.927 40.5112 59.927 38.8227 58.8856 37.7813C57.8442 36.7399 56.1558 36.7399 55.1144 37.7813L47.6666 45.2291L40.2189 37.7813C39.1775 36.7399 37.4891 36.7399 36.4477 37.7813C35.4063 38.8227 35.4063 40.5112 36.4477 41.5526L43.8954 49.0003L36.4477 56.448C35.4063 57.4894 35.4063 59.1779 36.4477 60.2193C37.4891 61.2606 39.1775 61.2606 40.2189 60.2193L47.6666 52.7715L55.1144 60.2193C56.1558 61.2606 57.8442 61.2606 58.8856 60.2193C59.927 59.1779 59.927 57.4894 58.8856 56.448L51.4379 49.0003L58.8856 41.5526Z" fill="#520826"/></svg>',
};

var cartItems = [
  { id: 1, name: 'Wireless Bluetooth Headphones', price: 299, originalPrice: 450, currency: 'EGP', quantity: 2, img: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=320&h=320&fit=crop' },
  { id: 2, name: 'Classic Denim Jacket', price: 189, originalPrice: 250, currency: 'EGP', quantity: 1, img: 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=320&h=320&fit=crop' },
  { id: 3, name: 'Running Sneakers Pro', price: 450, originalPrice: 600, currency: 'EGP', quantity: 1, img: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=320&h=320&fit=crop' },
  { id: 4, name: 'Organic Face Cream', price: 125, originalPrice: null, currency: 'EGP', quantity: 1, img: 'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?w=320&h=320&fit=crop' },
  { id: 5, name: 'Smart Watch Series 5', price: 899, originalPrice: 1200, currency: 'EGP', quantity: 3, img: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=320&h=320&fit=crop' },
  { id: 6, name: 'Canvas Backpack', price: 350, originalPrice: null, currency: 'EGP', quantity: 1, img: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=320&h=320&fit=crop' },
];

function formatPrice(price) {
  return 'EGP ' + price.toLocaleString();
}

function getTotalPrice() {
  return cartItems.reduce(function(sum, item) { return sum + item.price * item.quantity; }, 0);
}

function getItemCount() {
  return cartItems.length;
}

function renderCart() {
  var content = document.getElementById('cart-content');
  var bottomBar = document.getElementById('cart-bottom-bar');

  if (cartItems.length === 0) {
    content.innerHTML =
      '<div class="cart-empty">' +
        '<div class="cart-empty__icon-wrap">' + CART_ICONS.cartEmpty + '</div>' +
        '<div class="cart-empty__title">Your cart is empty</div>' +
        '<div class="cart-empty__desc">Looks like you haven\'t added anything to your cart yet.</div>' +
        '<button class="sellio-button sellio-button--primary sellio-button--small" id="start-shopping-btn">Start Shopping</button>' +
      '</div>';
    bottomBar.style.display = 'none';

    document.getElementById('start-shopping-btn').addEventListener('click', function() {
      window.location.href = '../home/';
    });
    return;
  }

  bottomBar.style.display = 'block';

  var html = '<div class="cart-items-count">' + cartItems.length + ' items</div>';
  html += '<div class="cart-items-list">';

  cartItems.forEach(function(item, index) {
    html +=
      '<div class="cart-item" data-id="' + item.id + '">' +
        '<div class="cart-item__image"><img src="' + item.img + '" alt="' + item.name + '" loading="lazy" /></div>' +
        '<div class="cart-item__content">' +
          '<div class="cart-item__top-row">' +
            '<div class="cart-item__title">' + item.name + '</div>' +
          '</div>' +
          '<div class="cart-item__bottom-row">' +
            '<div class="cart-counter">' +
              '<button class="cart-counter__btn cart-counter__btn--dec" data-action="dec" data-id="' + item.id + '">' + CART_ICONS.remove + '</button>' +
              '<div class="cart-counter__value">' + String(item.quantity).padStart(2, '0') + '</div>' +
              '<button class="cart-counter__btn cart-counter__btn--inc" data-action="inc" data-id="' + item.id + '">' + CART_ICONS.add + '</button>' +
            '</div>' +
            '<div class="cart-item__price-area">' +
              '<span class="cart-item__current-price">' + item.currency + ' ' + item.price + '</span>' +
              (item.originalPrice ? '<span class="cart-item__original-price">' + item.originalPrice + '</span>' : '') +
            '</div>' +
          '</div>' +
        '</div>' +
      '</div>';

    if (index < cartItems.length - 1) {
      html += '<div class="cart-dashed-divider"><div class="cart-dashed-divider__line"></div></div>';
    }
  });

  html += '</div>';
  html += '<div class="cart-solid-divider"><div class="cart-solid-divider__line"></div></div>';
  html +=
    '<div class="cart-note-section">' +
      '<div class="cart-note-section__title">Note about order</div>' +
      '<textarea placeholder="Write here" maxlength="500" rows="5" id="note-input"></textarea>' +
    '</div>';

  content.innerHTML = html;

  document.getElementById('total-price').textContent = formatPrice(getTotalPrice());
  document.getElementById('confirm-btn-text').textContent = 'Confirm order (' + getItemCount() + ')';

  content.querySelectorAll('[data-action]').forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      var action = btn.dataset.action;
      var id = parseInt(btn.dataset.id);

      if (action === 'inc') {
        var item = cartItems.find(function(i) { return i.id === id; });
        if (item) item.quantity++;
      } else if (action === 'dec') {
        var item = cartItems.find(function(i) { return i.id === id; });
        if (item) {
          if (item.quantity <= 1) {
            cartItems = cartItems.filter(function(i) { return i.id !== id; });
          } else {
            item.quantity--;
          }
        }
      }

      renderCart();
    });
  });
}

document.getElementById('confirm-btn').addEventListener('click', function() {
  if (cartItems.length === 0) return;
  document.getElementById('order-overlay').classList.add('visible');
});

document.getElementById('back-to-shopping-btn').addEventListener('click', function() {
  document.getElementById('order-overlay').classList.remove('visible');
  cartItems = [];
  renderCart();
  window.location.href = '../home/';
});

document.getElementById('cart-total-icon').innerHTML = SHARED_ICONS.discountIcon;
document.getElementById('confirm-icon').innerHTML = SHARED_ICONS.packageAdd;

document.getElementById('statusbar-main').innerHTML = getStatusHTML();
populateBottomNav('cart');

initNavClickHandlers({
  home: function() { window.location.href = '../home/'; },
  thrift: function() { window.location.href = '../thrift/'; },
  account: function() {
    var isLoggedIn = sessionStorage.getItem('isLoggedIn');
    if (isLoggedIn) {
      window.location.href = '../home/';
    } else {
      window.location.href = '../login/';
    }
  }
});

renderCart();
