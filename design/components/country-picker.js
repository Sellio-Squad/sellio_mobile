// Shared Country Picker Component
var COUNTRIES = [
  { code: 'IQ', name: 'Iraq', dial: '+964', maxLength: 10 },
  { code: 'EG', name: 'Egypt', dial: '+20', maxLength: 10 },
  { code: 'PS', name: 'Palestine', dial: '+970', maxLength: 9 },
  { code: 'SY', name: 'Syria', dial: '+963', maxLength: 10 },
  { code: 'SA', name: 'Saudi Arabia', dial: '+966', maxLength: 9 },
  { code: 'AE', name: 'United Arab Emirates', dial: '+971', maxLength: 9 },
  { code: 'JO', name: 'Jordan', dial: '+962', maxLength: 9 },
  { code: 'LB', name: 'Lebanon', dial: '+961', maxLength: 8 },
  { code: 'KW', name: 'Kuwait', dial: '+965', maxLength: 8 },
  { code: 'QA', name: 'Qatar', dial: '+974', maxLength: 8 },
  { code: 'BH', name: 'Bahrain', dial: '+973', maxLength: 8 },
  { code: 'OM', name: 'Oman', dial: '+968', maxLength: 8 },
  { code: 'YE', name: 'Yemen', dial: '+967', maxLength: 9 },
  { code: 'LY', name: 'Libya', dial: '+218', maxLength: 9 },
  { code: 'MA', name: 'Morocco', dial: '+212', maxLength: 9 },
  { code: 'TN', name: 'Tunisia', dial: '+216', maxLength: 8 },
  { code: 'DZ', name: 'Algeria', dial: '+213', maxLength: 9 },
  { code: 'SD', name: 'Sudan', dial: '+249', maxLength: 9 },
  { code: 'TR', name: 'Turkey', dial: '+90', maxLength: 10 },
  { code: 'IR', name: 'Iran', dial: '+98', maxLength: 10 },
];
var FAVORITE_CODES = ['IQ', 'EG', 'PS', 'SY'];
var selectedCountry = COUNTRIES.find(function(c) { return c.code === 'EG'; });

function flagImg(code) {
  return '<img class="flag-img" src="https://flagcdn.com/w40/' + code.toLowerCase() + '.png" alt="' + code + '" />';
}

function initCountryPicker(onSelect) {
  var overlay = document.getElementById('sheet-overlay');
  var search = document.getElementById('country-search');
  var list = document.getElementById('country-list');
  var selector = document.getElementById('country-selector');

  function renderCountryList(filter) {
    filter = filter || '';
    var favs = COUNTRIES.filter(function(c) { return FAVORITE_CODES.indexOf(c.code) >= 0; });
    var rest = COUNTRIES.filter(function(c) { return FAVORITE_CODES.indexOf(c.code) < 0; });
    var ff = filter ? favs.filter(function(c) { return c.name.toLowerCase().indexOf(filter) >= 0 || c.dial.indexOf(filter) >= 0 || c.code.toLowerCase().indexOf(filter) >= 0; }) : favs;
    var fr = filter ? rest.filter(function(c) { return c.name.toLowerCase().indexOf(filter) >= 0 || c.dial.indexOf(filter) >= 0 || c.code.toLowerCase().indexOf(filter) >= 0; }) : rest;

    var html = '';
    function renderItems(items) {
      for (var i = 0; i < items.length; i++) {
        html += '<div class="country-item" data-code="' + items[i].code + '">' + flagImg(items[i].code) + '<span class="name">' + items[i].name + '</span><span class="code">' + items[i].dial + '</span></div>';
      }
    }
    if (ff.length > 0) renderItems(ff);
    if (fr.length > 0) renderItems(fr);

    list.innerHTML = html;

    var items = list.querySelectorAll('.country-item');
    for (var i = 0; i < items.length; i++) {
      items[i].addEventListener('click', function() {
        var code = this.getAttribute('data-code');
        for (var j = 0; j < COUNTRIES.length; j++) {
          if (COUNTRIES[j].code === code) {
            selectedCountry = COUNTRIES[j];
            break;
          }
        }
        document.getElementById('country-flag-display').innerHTML = flagImg(selectedCountry.code);
        document.getElementById('country-code-display').textContent = selectedCountry.dial;
        var phoneInput = document.getElementById('phone-input');
        if (phoneInput) {
          phoneInput.maxLength = selectedCountry.maxLength;
          phoneInput.value = '';
        }
        overlay.classList.remove('open');
        if (onSelect) onSelect(selectedCountry);
      });
    }
  }

  selector.addEventListener('click', function() {
    overlay.classList.add('open');
    search.value = '';
    renderCountryList();
    setTimeout(function() { search.focus(); }, 350);
  });

  overlay.addEventListener('click', function(e) {
    if (e.target === overlay) overlay.classList.remove('open');
  });

  search.addEventListener('input', function(e) {
    renderCountryList(e.target.value.toLowerCase());
  });

  document.getElementById('country-flag-display').innerHTML = flagImg(selectedCountry.code);
  document.getElementById('country-code-display').textContent = selectedCountry.dial;
  renderCountryList();
}
