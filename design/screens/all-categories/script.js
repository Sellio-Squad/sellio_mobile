document.getElementById('statusbar-main').innerHTML = getStatusHTML();

document.getElementById('back-btn').addEventListener('click', function() {
  window.history.back();
});

var allCategories = CATEGORIES.filter(function(c) { return !c.isMore; });

document.getElementById('categories-grid').innerHTML = allCategories.map(function(c) {
  return '<div class="category-cell" data-category="' + c.name + '">' +
    '<div class="category-circle" style="background:' + c.bg + '">' +
      (c.img ? '<img src="' + c.img + '" alt="' + c.name + '" loading="lazy" />' : '') +
    '</div>' +
    '<span class="category-label">' + c.name + '</span>' +
  '</div>';
}).join('');

document.querySelectorAll('.category-cell').forEach(function(cell) {
  cell.addEventListener('click', function() {
    var name = this.dataset.category;
    window.location.href = '../category/?name=' + encodeURIComponent(name);
  });
});
