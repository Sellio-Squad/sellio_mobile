document.getElementById('statusbar-main').innerHTML = getStatusHTML();
    let currentStep = 'phone'; // phone -> otp -> reset
    let otpCountdown = 55;

    const phoneInput = document.getElementById('phone-input');
    const sendBtn = document.getElementById('send-btn');
    const passwordInput = document.getElementById('password-input');
    const confirmInput = document.getElementById('confirm-input');

    function validatePhone() {
      const phone = phoneInput.value.trim();
      return phone.length === selectedCountry.maxLength && /^[0-9]+$/.test(phone);
    }

    function validateResetForm() {
      const pass = passwordInput.value;
      const confirm = confirmInput.value;
      return pass.length >= 6 && confirm.length >= 6 && pass === confirm;
    }

    function updateSendBtn() {
      if (currentStep === 'phone') {
        sendBtn.disabled = !validatePhone();
      } else if (currentStep === 'reset') {
        sendBtn.disabled = !validateResetForm();
      }
    }



    phoneInput.addEventListener('focus', () => { document.getElementById('phone-container').classList.add('focused'); document.getElementById('phone-container').classList.remove('error'); document.getElementById('phone-error').classList.remove('visible'); });
    phoneInput.addEventListener('blur', () => {
      document.getElementById('phone-container').classList.remove('focused');
      const phone = phoneInput.value.trim();
      if (phone.length > 0 && phone.length < selectedCountry.maxLength) {
        document.getElementById('phone-error').textContent = `Phone number must be ${selectedCountry.maxLength} digits`;
        document.getElementById('phone-error').classList.add('visible');
        document.getElementById('phone-container').classList.add('error');
      } else if (phone.length === 0) {
        document.getElementById('phone-error').textContent = 'Phone number is required';
        document.getElementById('phone-error').classList.add('visible');
        document.getElementById('phone-container').classList.add('error');
      }
    });
    phoneInput.addEventListener('input', () => {
      phoneInput.value = phoneInput.value.replace(/[^0-9]/g, '');
      const len = phoneInput.value.length;
      const max = selectedCountry.maxLength;
      const counter = document.getElementById('phone-counter');
      if (len > 0) { counter.classList.add('visible'); counter.textContent = `${len}/${max}`; counter.classList.toggle('error', len > max); }
      else { counter.classList.remove('visible'); }
      updateSendBtn();
    });

    // Password validation
    ['password-input', 'confirm-input'].forEach(id => {
      const el = document.getElementById(id);
      el.addEventListener('focus', () => { document.getElementById(id.replace('password-input', 'password-container').replace('confirm-input', 'confirm-container')).classList.add('focused'); });
      el.addEventListener('blur', () => { document.getElementById(id.replace('password-input', 'password-container').replace('confirm-input', 'confirm-container')).classList.remove('focused'); });
      el.addEventListener('input', updateSendBtn);
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
      toast.className = 'toast ' + type;
      document.getElementById('toast-text').textContent = message;
      document.getElementById('toast-icon').innerHTML = type === 'success' ? '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>' : '<path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/>';
      requestAnimationFrame(() => toast.classList.add('show'));
      setTimeout(() => toast.classList.remove('show'), 3000);
    }

    // OTP
    function openOtp() {
      const phone = selectedCountry.dial + ' ' + phoneInput.value;
      document.getElementById('otp-phone-display').textContent = phone;
      document.getElementById('otp-overlay').classList.add('show');
      otpCountdown = 55;
      startOtpCountdown();
      document.getElementById('otp-1').focus();
    }

    function startOtpCountdown() {
      const text = document.getElementById('otp-countdown-text');
      text.innerHTML = `Didn't receive code? <a id="otp-resend-link" class="disabled">Re-send in ${otpCountdown}s</a>`;
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
          document.getElementById('otp-resend-link').textContent = `Re-send in ${otpCountdown}s`;
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
        document.getElementById('otp-overlay').classList.remove('show');
        showResetSection();
      } else {
        showToast('error', 'Invalid OTP code');
        otpInputs.forEach(el => { el.value = ''; });
        otpInputs[0].focus();
        document.getElementById('otp-confirm-btn').disabled = true;
      }
    });

    function showResetSection() {
      currentStep = 'reset';
      document.getElementById('phone-section').classList.add('hidden');
      document.getElementById('reset-section').classList.add('active');
      document.querySelector('.btn-text').textContent = 'Send';
      document.querySelector('.appbar-title').textContent = 'Reset Password';
      document.getElementById('send-btn').disabled = true;
    }

    sendBtn.addEventListener('click', () => {
      if (sendBtn.disabled) return;
      document.querySelector('.btn-text').style.display = 'none';
      document.getElementById('loading-dots').classList.add('active');
      sendBtn.disabled = true;

      setTimeout(() => {
        document.getElementById('loading-dots').classList.remove('active');
        document.querySelector('.btn-text').style.display = '';

        if (currentStep === 'phone') {
          openOtp();
        } else if (currentStep === 'reset') {
          showToast('success', 'Password reset successfully!');
          setTimeout(() => { window.location.href = '../login/'; }, 1500);
        }
      }, 1500);
    });

    document.getElementById('back-btn').addEventListener('click', () => {
      if (currentStep === 'reset') {
        currentStep = 'phone';
        document.getElementById('phone-section').classList.remove('hidden');
        document.getElementById('reset-section').classList.remove('active');
        document.querySelector('.btn-text').textContent = 'Send';
        document.querySelector('.appbar-title').textContent = 'Forget Password';
        updateSendBtn();
      } else {
        window.location.href = '../login/';
      }
    });

    initCountryPicker(function() {
      updateSendBtn();
    });