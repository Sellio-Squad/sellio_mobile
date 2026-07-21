// Shared Toast Component
function showToast(message, duration) {
  duration = duration || 1500;
  var toast = document.getElementById('toast');
  if (!toast) return;
  toast.textContent = message || 'Added to cart';
  toast.style.opacity = '1';
  toast.style.transform = 'translateX(-50%) translateY(0)';
  setTimeout(function() {
    toast.style.opacity = '0';
    toast.style.transform = 'translateX(-50%) translateY(20px)';
  }, duration);
}
