/* ═══════════════════════════════════════════════
   Favorites Toggle — shared favorite button behavior
   ═══════════════════════════════════════════════
   Usage:
     initFavorites(selector, options)
       selector: CSS selector for favorite buttons (default: '.fav-btn')
       options.onToggle: callback(favButton, isFavorited) for custom handling
*/
function initFavorites(selector, options) {
  var sel = selector || '.fav-btn';
  var opts = options || {};
  var icons = (typeof SHARED_ICONS !== 'undefined') ? SHARED_ICONS : (typeof ICONS !== 'undefined') ? ICONS : {};

  document.querySelectorAll(sel).forEach(function(btn) {
    btn.addEventListener('click', function(e) {
      e.stopPropagation();
      this.classList.toggle('favorited');
      var isFav = this.classList.contains('favorited');
      this.innerHTML = isFav ? icons.heartFav : icons.heart;
      if (opts.onToggle) opts.onToggle(this, isFav);
    });
  });
}
