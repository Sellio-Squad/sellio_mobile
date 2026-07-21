document.getElementById('statusbar-main').innerHTML = getStatusHTML();
    const COUNTRIES = [
      { code: 'IQ', name: 'Iraq', flag: 'ðŸ‡®ðŸ‡¶', dial: '+964', maxLength: 10 },
      { code: 'EG', name: 'Egypt', flag: 'ðŸ‡ªðŸ‡¬', dial: '+20', maxLength: 10 },
      { code: 'PS', name: 'Palestine', flag: 'ðŸ‡µðŸ‡¸', dial: '+970', maxLength: 9 },
      { code: 'SY', name: 'Syria', flag: 'ðŸ‡¸ðŸ‡¾', dial: '+963', maxLength: 10 },
      { code: 'SA', name: 'Saudi Arabia', flag: 'ðŸ‡¸ðŸ‡¦', dial: '+966', maxLength: 9 },
      { code: 'AE', name: 'United Arab Emirates', flag: 'ðŸ‡¦ðŸ‡ª', dial: '+971', maxLength: 9 },
      { code: 'JO', name: 'Jordan', flag: 'ðŸ‡¯ðŸ‡´', dial: '+962', maxLength: 9 },
      { code: 'LB', name: 'Lebanon', flag: 'ðŸ‡±ðŸ‡§', dial: '+961', maxLength: 8 },
      { code: 'KW', name: 'Kuwait', flag: 'ðŸ‡°ðŸ‡¼', dial: '+965', maxLength: 8 },
      { code: 'QA', name: 'Qatar', flag: 'ðŸ‡¶ðŸ‡¦', dial: '+974', maxLength: 8 },
      { code: 'BH', name: 'Bahrain', flag: 'ðŸ‡§ðŸ‡­', dial: '+973', maxLength: 8 },
      { code: 'OM', name: 'Oman', flag: 'ðŸ‡´ðŸ‡²', dial: '+968', maxLength: 8 },
      { code: 'YE', name: 'Yemen', flag: 'ðŸ‡¾ðŸ‡ª', dial: '+967', maxLength: 9 },
      { code: 'LY', name: 'Libya', flag: 'ðŸ‡±ðŸ‡¾', dial: '+218', maxLength: 9 },
      { code: 'MA', name: 'Morocco', flag: 'ðŸ‡²ðŸ‡¦', dial: '+212', maxLength: 9 },
      { code: 'TN', name: 'Tunisia', flag: 'ðŸ‡¹ðŸ‡³', dial: '+216', maxLength: 8 },
      { code: 'DZ', name: 'Algeria', flag: 'ðŸ‡©ðŸ‡¿', dial: '+213', maxLength: 9 },
      { code: 'SD', name: 'Sudan', flag: 'ðŸ‡¸ðŸ‡©', dial: '+249', maxLength: 9 },
      { code: 'TR', name: 'Turkey', flag: 'ðŸ‡¹ðŸ‡·', dial: '+90', maxLength: 10 },
      { code: 'IR', name: 'Iran', flag: 'ðŸ‡®ðŸ‡·', dial: '+98', maxLength: 10 },
    ];

    const FAVORITE_CODES = ['IQ', 'EG', 'PS', 'SY'];
    const CITIES = ['Baghdad', 'Basra', 'Erbil', 'Mosul', 'Sulaymaniyah', 'Najaf', 'Karbala', 'Cairo', 'Alexandria', 'Giza', 'Riyadh', 'Jeddah', 'Dubai', 'Abu Dhabi', 'Amman', 'Beirut'];

    let selectedCountry = COUNTRIES.find(c => c.code === 'EG');
    let selectedCity = '';
    let otpCountdown = 55;

    const nameInput = document.getElementById('name-input');
    const phoneInput = document.getElementById('phone-input');
    const cityPicker = document.getElementById('city-picker');
    const cityDisplay = document.getElementById('city-display');
    const passwordInput = document.getElementById('password-input');
    const confirmInput = document.getElementById('confirm-input');
    const continueBtn = document.getElementById('continue-btn');

    function validateForm() {
      const name = nameInput.value.trim();
      const phone = phoneInput.value.trim();
      const pass = passwordInput.value;
      const confirm = confirmInput.value;
      const nameOk = name.length >= 2;
      const phoneOk = phone.length === selectedCountry.maxLength && /^[0-9]+$/.test(phone);
      const cityOk = selectedCity.length > 0;
      const passOk = pass.length >= 6;
      const confirmOk = confirm.length >= 6 && confirm === pass;
      continueBtn.disabled = !(nameOk && phoneOk && cityOk && passOk && confirmOk);
    }

    function renderCountryList(filter = '') {
      const favs = COUNTRIES.filter(c => FAVORITE_CODES.includes(c.code));
      const rest = COUNTRIES.filter(c => !FAVORITE_CODES.includes(c.code));
      const ff = filter ? favs.filter(c => c.name.toLowerCase().includes(filter) || c.dial.includes(filter)) : favs;
      const fr = filter ? rest.filter(c => c.name.toLowerCase().includes(filter) || c.dial.includes(filter)) : rest;
      let html = '';
      [...ff, ...fr].forEach(c => {
        html += `<div class="country-item" data-code="${c.code}"><div class="flag">${c.flag}</div><span class="name">${c.name}</span><span class="code">${c.dial}</span></div>`;
      });
      document.getElementById('country-list').innerHTML = html;
      document.querySelectorAll('#country-list .country-item').forEach(item => {
        item.addEventListener('click', () => {
          selectedCountry = COUNTRIES.find(c => c.code === item.dataset.code);
          document.getElementById('country-flag-display').textContent = selectedCountry.flag;
          document.getElementById('country-code-display').textContent = selectedCountry.dial;
          phoneInput.maxLength = selectedCountry.maxLength;
          phoneInput.value = '';
          closeSheet('sheet-overlay');
          validateForm();
        });
      });
    }

    function renderCityList(filter = '') {
      const cities = filter ? CITIES.filter(c => c.toLowerCase().includes(filter)) : CITIES;
      let html = '';
      cities.forEach(c => { html += `<div class="city-item" data-city="${c}">${c}</div>`; });
      document.getElementById('city-list').innerHTML = html;
      document.querySelectorAll('.city-item').forEach(item => {
        item.addEventListener('click', () => {
          selectedCity = item.dataset.city;
          cityDisplay.textContent = selectedCity;
          cityDisplay.classList.remove('placeholder');
          closeSheet('city-sheet-overlay');
          validateForm();
        });
      });
    }

    function openSheet(id) { document.getElementById(id).classList.add('open'); }
    function closeSheet(id) { document.getElementById(id).classList.remove('open'); }

    document.getElementById('country-selector').addEventListener('click', () => { openSheet('sheet-overlay'); renderCountryList(); setTimeout(() => document.getElementById('country-search').focus(), 350); });
    document.getElementById('sheet-overlay').addEventListener('click', (e) => { if (e.target.id === 'sheet-overlay') closeSheet('sheet-overlay'); });
    document.getElementById('country-search').addEventListener('input', (e) => renderCountryList(e.target.value.toLowerCase()));

    cityPicker.addEventListener('click', () => { openSheet('city-sheet-overlay'); renderCityList(); setTimeout(() => document.getElementById('city-search').focus(), 350); });
    document.getElementById('city-sheet-overlay').addEventListener('click', (e) => { if (e.target.id === 'city-sheet-overlay') closeSheet('city-sheet-overlay'); });
    document.getElementById('city-search').addEventListener('input', (e) => renderCityList(e.target.value.toLowerCase()));

    function setupFocus(inputId, containerId, errorId) {
      const input = document.getElementById(inputId);
      const container = document.getElementById(containerId);
      const error = document.getElementById(errorId);
      input.addEventListener('focus', () => { container.classList.add('focused'); container.classList.remove('error'); error.classList.remove('visible'); });
      input.addEventListener('blur', () => { container.classList.remove('focused'); });
      input.addEventListener('input', validateForm);
    }

    setupFocus('name-input', 'name-container', 'name-error');
    setupFocus('phone-input', 'phone-container', 'phone-error');
    setupFocus('password-input', 'password-container', 'password-error');
    setupFocus('confirm-input', 'confirm-container', 'confirm-error');

    phoneInput.addEventListener('input', () => {
      phoneInput.value = phoneInput.value.replace(/[^0-9]/g, '');
      const len = phoneInput.value.length;
      const max = selectedCountry.maxLength;
      const counter = document.getElementById('phone-counter');
      if (len > 0) { counter.classList.add('visible'); counter.textContent = `${len}/${max}`; counter.classList.toggle('error', len > max); }
      else { counter.classList.remove('visible'); }
      validateForm();
    });

    document.getElementById('eye-toggle').addEventListener('click', () => {
      const isP = passwordInput.type === 'password';
      passwordInput.type = isP ? 'text' : 'password';
      document.getElementById('eye-open').style.display = isP ? 'none' : 'block';
      document.getElementById('eye-closed').style.display = isP ? 'block' : 'none';
    });
    document.getElementById('eye-toggle-confirm').addEventListener('click', () => {
      const isP = confirmInput.type === 'password';
      confirmInput.type = isP ? 'text' : 'password';
      document.getElementById('eye-open-c').style.display = isP ? 'none' : 'block';
      document.getElementById('eye-closed-c').style.display = isP ? 'block' : 'none';
    });

    function showToast(type, message) {
      const toast = document.getElementById('toast');
      const icon = document.getElementById('toast-icon');
      toast.className = 'toast ' + type;
      document.getElementById('toast-text').textContent = message;
      icon.innerHTML = type === 'success' ? '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>' : '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>';
      requestAnimationFrame(() => toast.classList.add('show'));
      setTimeout(() => toast.classList.remove('show'), 3000);
    }

    // OTP flow
    function openOtp() {
      const phone = selectedCountry.dial + ' ' + phoneInput.value;
      document.getElementById('otp-phone-display').textContent = phone;
      document.getElementById('otp-overlay').classList.add('show');
      otpCountdown = 55;
      startOtpCountdown();
      document.getElementById('otp-1').focus();
    }

    function startOtpCountdown() {
      const link = document.getElementById('otp-resend-link');
      const text = document.getElementById('otp-countdown-text');
      link.classList.add('disabled');
      link.textContent = `Re-send in ${otpCountdown}s`;
      const interval = setInterval(() => {
        otpCountdown--;
        if (otpCountdown <= 0) {
          clearInterval(interval);
          text.innerHTML = 'Didn\'t receive code? <a id="otp-resend-link" class="re-send-link">Re-send</a>';
          document.getElementById('otp-resend-link').addEventListener('click', () => {
            otpCountdown = 55;
            startOtpCountdown();
            showToast('success', 'OTP re-sent!');
          });
        } else {
          link.textContent = `Re-send in ${otpCountdown}s`;
        }
      }, 1000);
    }

    const otpInputs = [document.getElementById('otp-1'), document.getElementById('otp-2'), document.getElementById('otp-3'), document.getElementById('otp-4')];
    otpInputs.forEach((input, i) => {
      input.addEventListener('input', () => {
        input.value = input.value.replace(/[^0-9]/g, '');
        if (input.value && i < 3) otpInputs[i + 1].focus();
        const otp = otpInputs.map(el => el.value).join('');
        document.getElementById('otp-confirm-btn').disabled = otp.length !== 4;
      });
      input.addEventListener('keydown', (e) => {
        if (e.key === 'Backspace' && !input.value && i > 0) otpInputs[i - 1].focus();
      });
    });

    document.getElementById('otp-confirm-btn').addEventListener('click', () => {
      const otp = otpInputs.map(el => el.value).join('');
      if (otp === '9999') {
        closeSheet('otp-overlay');
        showToast('success', 'Account created successfully!');
        setTimeout(() => { window.location.href = '../login/'; }, 1500);
      } else {
        showToast('error', 'Invalid OTP code');
        otpInputs.forEach(el => { el.value = ''; });
        otpInputs[0].focus();
        document.getElementById('otp-confirm-btn').disabled = true;
      }
    });

    continueBtn.addEventListener('click', () => {
      if (continueBtn.disabled) return;
      document.querySelector('.btn-text').style.display = 'none';
      document.getElementById('continue-arrow').style.display = 'none';
      document.getElementById('loading-dots').classList.add('active');
      continueBtn.disabled = true;
      setTimeout(() => {
        document.getElementById('loading-dots').classList.remove('active');
        document.querySelector('.btn-text').style.display = '';
        document.getElementById('continue-arrow').style.display = '';
        openOtp();
      }, 1500);
    });

    document.getElementById('back-btn').addEventListener('click', () => { window.location.href = '../login/'; });
    document.getElementById('close-btn').addEventListener('click', () => { window.location.href = '../login/'; });
    document.getElementById('login-link').addEventListener('click', () => { window.location.href = '../login/'; });

    renderCountryList();
    renderCityList();
    document.getElementById('statusbar-main').innerHTML = getStatusHTML();