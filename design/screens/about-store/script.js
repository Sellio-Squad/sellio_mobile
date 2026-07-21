// About Store Screen
var aboutData = ABOUT_STORE_DATA;

// Status bar
document.getElementById('statusbar-main').innerHTML = getStatusHTML();

// Back button
document.getElementById('about-back').addEventListener('click', function() {
  window.history.back();
});

// Show loading, then content
function showLoading() {
  document.getElementById('about-loading').style.display = 'flex';
  document.getElementById('about-content').style.display = 'none';
}

function showContent() {
  document.getElementById('about-loading').style.display = 'none';
  document.getElementById('about-content').style.display = 'flex';
  renderContent();
}

function renderContent() {
  renderRating();
  renderContactInfo();
  renderAddress();
}

// ── Rating Section ──
function renderRating() {
  var r = aboutData.rating;

  // Average rating
  document.getElementById('rating-avg').textContent = r.averageRating.toFixed(1);

  // Stars
  var starsHtml = '';
  for (var i = 1; i <= 5; i++) {
    var filled = i <= Math.round(r.averageRating);
    if (filled) {
      starsHtml += '<svg viewBox="0 0 12 12" fill="none"><path d="M6 1L7.5 4.5L11 5L8.5 7.5L9 11L6 9.5L3 11L3.5 7.5L1 5L4.5 4.5L6 1Z" fill="#F5A623"/></svg>';
    } else {
      starsHtml += '<svg viewBox="0 0 12 12" fill="none"><path d="M6 1L7.5 4.5L11 5L8.5 7.5L9 11L6 9.5L3 11L3.5 7.5L1 5L4.5 4.5L6 1Z" stroke="#F5A623" stroke-width="0.8" fill="none"/></svg>';
    }
  }
  document.getElementById('rating-stars').innerHTML = starsHtml;

  // Total reviews
  document.getElementById('rating-total').textContent = 'Total ' + r.totalReviews + ' reviews';

  // Rating bars (5→1)
  var maxCount = Math.max.apply(null, Object.values(r.ratingDistribution));
  var barsHtml = '';
  for (var star = 5; star >= 1; star--) {
    var count = r.ratingDistribution[star] || 0;
    var pct = maxCount > 0 ? (count / maxCount) * 100 : 0;
    barsHtml +=
      '<div class="rating-bar-item">' +
        '<span class="rating-bar-label">' + star + '</span>' +
        '<div class="rating-bar-track">' +
          '<div class="rating-bar-fill" style="width:' + pct + '%"></div>' +
        '</div>' +
      '</div>';
  }
  document.getElementById('rating-bars').innerHTML = barsHtml;
}

// ── Contact Info ──
function getContactIcon(type) {
  switch (type) {
    case 'email':
    case 'website':
      return '<svg viewBox="0 0 24 24" fill="none"><path d="M4 4H20C21.1 4 22 4.9 22 6V18C22 19.1 21.1 20 20 20H4C2.9 20 2 19.1 2 18V6C2 4.9 2.9 4 4 4Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M22 6L12 13L2 6" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    case 'phone':
    case 'whatsapp':
      return '<svg viewBox="0 0 24 24" fill="none"><path d="M22 16.92V19.92C22 20.48 21.56 20.93 21 20.97C20.68 20.99 20.36 21 20 21C10.61 21 3 13.39 3 4C3 3.64 3.01 3.32 3.03 3C3.07 2.44 3.52 2 4.08 2H7.08C7.56 2 7.97 2.34 8.05 2.82C8.14 3.43 8.3 4.03 8.53 4.59L7.01 6.11C6.93 6.19 6.88 6.3 6.88 6.41C6.88 6.52 6.93 6.63 7.01 6.71L9.29 9C9.37 9.08 9.48 9.13 9.59 9.13C9.7 9.13 9.81 9.08 9.89 9L11.41 7.47C11.97 7.7 12.57 7.86 13.18 7.95C13.66 8.03 14 8.44 14 8.92V11.92" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    case 'facebook':
      return '<svg viewBox="0 0 24 24" fill="none"><path d="M18 2H15C13.6739 2 12.4021 2.52678 11.4645 3.46447C10.5268 4.40215 10 5.67392 10 7V10H7V14H10V22H14V14H17L18 10H14V7C14 6.73478 14.1054 6.48043 14.2929 6.29289C14.4804 6.10536 14.7348 6 15 6H18V2Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
    default:
      return '<svg viewBox="0 0 24 24" fill="none"><circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5"/><path d="M12 16V12M12 8H12.01" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>';
  }
}

function renderContactInfo() {
  var list = aboutData.contactInfoList;
  var html = list.map(function(c) {
    return '<div class="contact-item" data-type="' + c.type + '">' +
      '<div class="contact-icon">' + getContactIcon(c.type) + '</div>' +
      '<div class="contact-text">' +
        '<span class="contact-label">' + c.title + '</span>' +
        '<span class="contact-value">' + c.provider + '</span>' +
      '</div>' +
    '</div>';
  }).join('');
  document.getElementById('contact-list').innerHTML = html;

  // Tap handlers
  document.querySelectorAll('.contact-item').forEach(function(item) {
    item.addEventListener('click', function() {
      var type = this.dataset.type;
      var contact = list.find(function(c) { return c.type === type; });
      if (!contact) return;

      if (type === 'phone' || type === 'whatsapp') {
        window.location.href = 'tel:' + contact.provider.replace(/\s/g, '');
      } else if (type === 'email') {
        window.location.href = 'mailto:' + contact.provider;
      } else if (type === 'facebook') {
        // Open Facebook page (mock)
      } else if (type === 'website') {
        window.open('https://' + contact.provider, '_blank');
      }
    });
  });
}

// ── Address ──
function renderAddress() {
  var addr = aboutData.address;
  document.getElementById('address-text').textContent = addr.fullAddress;

  // Map tap → open Google Maps
  document.getElementById('map-view').addEventListener('click', function() {
    var url = 'https://www.google.com/maps/search/?api=1&query=' + addr.latitude + ',' + addr.longitude;
    window.open(url, '_blank');
  });
}

// Simulate loading
showLoading();
setTimeout(function() {
  showContent();
}, 800);
