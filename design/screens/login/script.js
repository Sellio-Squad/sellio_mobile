document.getElementById('statusbar-main').innerHTML = getStatusHTML();
    const COUNTRIES = [
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

    const FAVORITE_CODES = ['IQ', 'EG', 'PS', 'SY'];

    const flagImg = (code) => `<img class="flag-img" src="https://flagcdn.com/w40/${code.toLowerCase()}.png" alt="${code}" />`;

    let selectedCountry = COUNTRIES.find(c => c.code === 'EG');
    let phoneValid = false;
    let passwordValid = false;

    const phoneInput = document.getElementById('phone-input');
    const passwordInput = document.getElementById('password-input');
    const phoneContainer = document.getElementById('phone-container');
    const passwordContainer = document.getElementById('password-container');
    const loginBtn = document.getElementById('login-btn');
    const loadingDots = document.getElementById('loading-dots');
    const loginArrow = document.getElementById('login-arrow');
    const btnText = loginBtn.querySelector('.btn-text');
    const eyeToggle = document.getElementById('eye-toggle');
    const eyeOpen = document.getElementById('eye-open');
    const eyeClosed = document.getElementById('eye-closed');
    const phoneError = document.getElementById('phone-error');
    const passwordError = document.getElementById('password-error');
    const phoneCounter = document.getElementById('phone-counter');
    const countryFlagDisplay = document.getElementById('country-flag-display');
    const countryCodeDisplay = document.getElementById('country-code-display');
    const countrySelector = document.getElementById('country-selector');
    const sheetOverlay = document.getElementById('sheet-overlay');
    const countrySheet = document.getElementById('country-sheet');
    const countryList = document.getElementById('country-list');
    const countrySearch = document.getElementById('country-search');
    const toast = document.getElementById('toast');
    const toastText = document.getElementById('toast-text');
    const toastIcon = document.getElementById('toast-icon');
    const successOverlay = document.getElementById('success-overlay');

    function updateLoginBtn() {
      const phone = phoneInput.value.trim();
      const pass = passwordInput.value;
      phoneValid = phone.length > 0 && phone.length === selectedCountry.maxLength && /^[0-9]+$/.test(phone);
      passwordValid = pass.length >= 6;
      loginBtn.disabled = !(phoneValid && passwordValid);
    }

    function updatePhoneCounter() {
      const len = phoneInput.value.length;
      const max = selectedCountry.maxLength;
      if (len > 0) {
        phoneCounter.classList.add('visible');
        phoneCounter.textContent = `${len}/${max}`;
        phoneCounter.classList.toggle('error', len > max);
      } else {
        phoneCounter.classList.remove('visible');
      }
    }

    function renderCountryList(filter = '') {
      const favs = COUNTRIES.filter(c => FAVORITE_CODES.includes(c.code));
      const rest = COUNTRIES.filter(c => !FAVORITE_CODES.includes(c.code));
      const filteredFavs = filter ? favs.filter(c => c.name.toLowerCase().includes(filter) || c.dial.includes(filter) || c.code.toLowerCase().includes(filter)) : favs;
      const filteredRest = filter ? rest.filter(c => c.name.toLowerCase().includes(filter) || c.dial.includes(filter) || c.code.toLowerCase().includes(filter)) : rest;

      let html = '';
      const renderItems = (items) => {
        items.forEach(c => {
          html += `<div class="country-item" data-code="${c.code}">
            ${flagImg(c.code)}
            <span class="name">${c.name}</span>
            <span class="code">${c.dial}</span>
          </div>`;
        });
      };

      if (filteredFavs.length > 0) {
        renderItems(filteredFavs);
      }
      if (filteredRest.length > 0) {
        renderItems(filteredRest);
      }

      countryList.innerHTML = html;

      countryList.querySelectorAll('.country-item').forEach(item => {
        item.addEventListener('click', () => {
          const code = item.dataset.code;
          selectedCountry = COUNTRIES.find(c => c.code === code);
          countryFlagDisplay.innerHTML = flagImg(selectedCountry.code);
          countryCodeDisplay.textContent = selectedCountry.dial;
          phoneInput.maxLength = selectedCountry.maxLength;
          phoneInput.value = '';
          updatePhoneCounter();
          updateLoginBtn();
          closeSheet();
        });
      });
    }

    function openSheet() {
      sheetOverlay.classList.add('open');
      countrySearch.value = '';
      renderCountryList();
      setTimeout(() => countrySearch.focus(), 350);
    }

    function closeSheet() {
      sheetOverlay.classList.remove('open');
    }

    countrySelector.addEventListener('click', openSheet);

    sheetOverlay.addEventListener('click', (e) => {
      if (e.target === sheetOverlay) closeSheet();
    });

    countrySearch.addEventListener('input', (e) => {
      renderCountryList(e.target.value.toLowerCase());
    });

    phoneInput.addEventListener('focus', () => {
      phoneContainer.classList.add('focused');
      phoneContainer.classList.remove('error');
      phoneError.classList.remove('visible');
    });
    phoneInput.addEventListener('blur', () => {
      phoneContainer.classList.remove('focused');
      const phone = phoneInput.value.trim();
      if (phone.length > 0 && phone.length < selectedCountry.maxLength) {
        phoneError.textContent = `Phone number must be ${selectedCountry.maxLength} digits`;
        phoneError.classList.add('visible');
        phoneContainer.classList.add('error');
      } else if (phone.length === 0) {
        phoneError.textContent = 'Phone number is required';
        phoneError.classList.add('visible');
        phoneContainer.classList.add('error');
      }
    });
    phoneInput.addEventListener('input', () => {
      phoneInput.value = phoneInput.value.replace(/[^0-9]/g, '');
      updatePhoneCounter();
      updateLoginBtn();
      if (phoneInput.value.length === selectedCountry.maxLength) {
        phoneError.classList.remove('visible');
        phoneContainer.classList.remove('error');
      }
    });

    passwordInput.addEventListener('focus', () => {
      passwordContainer.classList.add('focused');
      passwordContainer.classList.remove('error');
      passwordError.classList.remove('visible');
    });
    passwordInput.addEventListener('blur', () => {
      passwordContainer.classList.remove('focused');
      if (passwordInput.value.length > 0 && passwordInput.value.length < 6) {
        passwordError.textContent = 'Password must be at least 6 characters';
        passwordError.classList.add('visible');
        passwordContainer.classList.add('error');
      } else if (passwordInput.value.length === 0) {
        passwordError.textContent = 'Password is required';
        passwordError.classList.add('visible');
        passwordContainer.classList.add('error');
      }
    });
    passwordInput.addEventListener('input', () => {
      updateLoginBtn();
      if (passwordInput.value.length >= 6) {
        passwordError.classList.remove('visible');
        passwordContainer.classList.remove('error');
      }
    });

    eyeToggle.addEventListener('click', () => {
      const isPassword = passwordInput.type === 'password';
      passwordInput.type = isPassword ? 'text' : 'password';
      eyeOpen.style.display = isPassword ? 'none' : 'block';
      eyeClosed.style.display = isPassword ? 'block' : 'none';
    });

    function showToast(type, message) {
      toast.className = 'toast ' + type;
      toastText.textContent = message;
      toastIcon.innerHTML = type === 'success'
        ? '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>'
        : '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>';
      requestAnimationFrame(() => toast.classList.add('show'));
      setTimeout(() => toast.classList.remove('show'), 3000);
    }

    function showSuccess() {
      successOverlay.classList.add('show');
      sessionStorage.setItem('isLoggedIn', 'true');
      setTimeout(() => {
        window.location.href = '../home/';
      }, 1500);
    }

    const MOCK_CREDENTIALS = {
      phone: '1012345678',
      password: 'password123'
    };

    loginBtn.addEventListener('click', () => {
      if (loginBtn.disabled) return;
      btnText.style.display = 'none';
      loginArrow.style.display = 'none';
      loadingDots.classList.add('active');
      loginBtn.disabled = true;

      setTimeout(() => {
        loadingDots.classList.remove('active');
        btnText.style.display = '';
        loginArrow.style.display = '';

        const phone = phoneInput.value.trim();
        const pass = passwordInput.value;

        if (phone === MOCK_CREDENTIALS.phone && pass === MOCK_CREDENTIALS.password) {
          showSuccess();
        } else {
          showToast('error', 'Invalid phone number or password');
          passwordInput.value = '';
          passwordContainer.classList.add('error');
          passwordError.textContent = 'Invalid credentials';
          passwordError.classList.add('visible');
        }
        updateLoginBtn();
      }, 2000);
    });

    // Close button â†’ enter as guest
    document.querySelector('.close-btn').addEventListener('click', () => {
      sessionStorage.setItem('isLoggedIn', 'true');
      window.location.href = '../home/';
    });

    document.querySelector('.forget-btn').addEventListener('click', () => {
      window.location.href = '../forgot-password/';
    });
    document.querySelector('.btn-create').addEventListener('click', () => {
      window.location.href = '../create-account/';
    });

    countryFlagDisplay.innerHTML = flagImg(selectedCountry.code);
    countryCodeDisplay.textContent = selectedCountry.dial;
    renderCountryList();
    document.getElementById('statusbar-main').innerHTML = getStatusHTML();