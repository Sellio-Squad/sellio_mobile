/* ═══════════════════════════════════════════════
   Favorites Toggle + Heart Button Factory
   ═══════════════════════════════════════════════
   Usage:
     getHeartBtnHTML(favorited, idAttr)
       Returns a <button class="fav-btn"> HTML string.
       favorited: Boolean — whether heart starts filled.
       idAttr: optional data attribute (e.g. product id).

     initFavorites(selector, options)
       selector: CSS selector for favorite buttons (default: '.fav-btn')
       options.onToggle: callback(favButton, isFavorited) for custom handling
*/

function getHeartBtnHTML(favorited, idAttr) {
  var icons = (typeof SHARED_ICONS !== 'undefined') ? SHARED_ICONS : {};
  var favClass = 'fav-btn' + (favorited ? ' favorited' : '');
  var dataAttr = idAttr !== undefined ? ' data-fav-id="' + idAttr + '"' : '';
  return '<button class="' + favClass + '"' + dataAttr + '>' +
    (favorited ? icons.heartFav : icons.heart) +
  '</button>';
}

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
