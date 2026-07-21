document.getElementById('statusbar-main').innerHTML = getStatusHTML();
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

    initCountryPicker(function() {
      updatePhoneCounter();
      updateLoginBtn();
    });