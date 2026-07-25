/* ═══════════════════════════════════════════════
   Notification Screen — script
   ═══════════════════════════════════════════════ */

(function () {
  var loading = document.getElementById('notif-loading');
  var empty = document.getElementById('notif-empty');
  var error = document.getElementById('notif-error');
  var content = document.getElementById('notif-content');
  var backBtn = document.getElementById('back-btn');
  var retryBtn = document.getElementById('notif-retry-btn');

  var NOTIF_ICONS = {
    placed: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M6.33546 11.3293C5.96498 11.1441 5.51447 11.2942 5.32923 11.6647C5.14399 12.0352 5.29415 12.4857 5.66464 12.6709L7.66464 13.6709C8.03512 13.8562 8.48563 13.706 8.67087 13.3355C8.85611 12.965 8.70594 12.5145 8.33546 12.3293L6.33546 11.3293Z" fill="currentColor" fill-opacity="0.87"/><path fill-rule="evenodd" clip-rule="evenodd" d="M2.24989 6.49995C2.24989 6.60244 2.26022 6.69948 2.27926 6.79141C2.26013 6.85762 2.24988 6.92759 2.24988 6.99995L2.24989 17.1612C2.24989 18.2817 3.06723 19.0268 4.07321 19.6304C5.0916 20.2415 6.58974 20.8744 8.48284 21.6741L8.69401 21.7633C10.1131 22.3632 11.0278 22.75 11.9999 22.75C12.1988 22.75 12.3896 22.6709 12.5302 22.5303C12.6709 22.3896 12.7499 22.1989 12.7499 22L12.7499 11.6782C13.635 11.512 14.5548 11.0666 15.8347 10.4468L18.976 8.92671C19.4529 8.69597 19.8844 8.4872 20.2499 8.28887L20.2499 12C20.2499 12.4142 20.5857 12.75 20.9999 12.75C21.4141 12.75 21.7499 12.4142 21.7499 12L21.7499 6.99995C21.7499 6.92759 21.7396 6.85762 21.7205 6.79141C21.7396 6.69948 21.7499 6.60244 21.7499 6.49995C21.7499 5.7979 21.265 5.35166 20.8185 5.05009C20.3726 4.74891 19.7314 4.43865 18.976 4.07321L15.8347 2.55309C14.1929 1.75806 13.1436 1.24995 11.9999 1.24995C10.8561 1.24995 9.80688 1.75806 8.16511 2.5531L5.02377 4.07319C4.26843 4.43865 3.62716 4.74891 3.18126 5.05009C2.73481 5.35166 2.24989 5.7979 2.24989 6.49995ZM5.02378 8.92672C4.54685 8.69597 4.11539 8.48722 3.74989 8.28887L3.74989 17.1612C3.74989 17.4233 3.90536 17.7804 4.84502 18.3442C5.76116 18.894 7.15984 19.4868 9.12866 20.3185C10.1479 20.7491 10.771 21.0064 11.2499 21.1381L11.2499 11.6782C10.3647 11.512 9.44495 11.0666 8.16511 10.4468L5.02378 8.92672ZM11.9999 2.74995C11.2423 2.74995 10.5203 3.07985 8.65248 3.98368L5.73128 5.39722C4.90698 5.79609 4.36592 6.06003 4.02086 6.2931C3.87247 6.39334 3.80078 6.46125 3.7676 6.49995C3.80078 6.53865 3.87247 6.60657 4.02086 6.7068C4.36592 6.93987 4.90698 7.20381 5.73128 7.60268L8.65248 9.01622C10.5203 9.92005 11.2423 10.25 11.9999 10.25C12.7575 10.25 13.4794 9.92005 15.3473 9.01622L18.2685 7.60269C19.0928 7.20381 19.6338 6.93988 19.9789 6.70681C20.1273 6.60657 20.199 6.53865 20.2322 6.49995C20.199 6.46125 20.1273 6.39333 19.9789 6.2931C19.6338 6.06003 19.0928 5.79609 18.2685 5.39722L15.3473 3.98368C13.4794 3.07986 12.7575 2.74995 11.9999 2.74995Z" fill="currentColor" fill-opacity="0.87"/><g opacity="0.4"><path d="M22.2813 15.6953C22.6653 15.5399 22.8506 15.1027 22.6952 14.7187C22.5397 14.3348 22.1025 14.1495 21.7186 14.3049C20.9632 14.6107 20.2416 15.1932 19.6064 15.8298C18.9617 16.476 18.3575 17.2277 17.8427 17.9329C17.4282 18.5008 17.0658 19.0467 16.7805 19.4964C16.5151 19.1141 16.251 18.8437 16.0014 18.6535C15.7721 18.4789 15.5607 18.3764 15.3831 18.3184C15.295 18.2896 15.2173 18.2725 15.1522 18.2626C15.1198 18.2576 15.0906 18.2545 15.0651 18.2526C15.0524 18.2517 15.0406 18.2511 15.0297 18.2507L15.0141 18.2503L15.0068 18.2502L15.0033 18.2501L15.0016 18.2501L14.9999 18.2501C14.5857 18.2501 14.2499 18.5859 14.2499 19.0001C14.2499 19.3884 14.545 19.7077 14.923 19.7462C14.944 19.7538 15.0032 19.7788 15.0923 19.8467C15.2914 19.9984 15.6605 20.3811 16.0628 21.3007C16.1771 21.5619 16.4296 21.7357 16.7144 21.7493C16.9991 21.7628 17.267 21.6135 17.4056 21.3644L17.4067 21.3624L17.4118 21.3532L17.4338 21.3144C17.4535 21.2798 17.4832 21.2279 17.5222 21.161C17.6002 21.0272 17.7151 20.8335 17.8609 20.5974C18.1531 20.1243 18.5669 19.485 19.0543 18.8173C19.5431 18.1475 20.097 17.4618 20.6683 16.8892C21.2491 16.3071 21.8014 15.8896 22.2813 15.6953Z" fill="currentColor"/><path d="M17.3355 4.67091C17.706 4.48567 17.8562 4.03516 17.6709 3.66468C17.4857 3.29419 17.0352 3.14403 16.6647 3.32927L6.6647 8.32927C6.29422 8.51451 6.14405 8.96502 6.32929 9.3355C6.51453 9.70598 6.96504 9.85615 7.33552 9.67091L17.3355 4.67091Z" fill="currentColor"/></g></svg>',
    delivered: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path opacity="0.4" fill-rule="evenodd" clip-rule="evenodd" d="M13.546 4.79823C13.1991 4.7516 12.7283 4.75 12 4.75L2 4.75C1.58579 4.75 1.25 4.41422 1.25 4C1.25 3.58579 1.58579 3.25 2 3.25L12.0494 3.25C12.7142 3.24996 13.2871 3.24993 13.7458 3.31161C14.2375 3.37771 14.7087 3.52677 15.091 3.90901C15.4732 4.29126 15.6223 4.76252 15.6884 5.25416C15.7091 5.40809 15.7228 5.57486 15.732 5.75365C19.6287 5.87613 22.75 9.07355 22.75 13V15.7632C22.75 15.7765 22.75 15.7898 22.75 15.8029C22.7501 15.9832 22.7502 16.1382 22.7327 16.2783C22.6053 17.3003 21.8003 18.1053 20.7783 18.2327C20.6382 18.2502 20.4832 18.2501 20.3029 18.25C20.2898 18.25 20.2765 18.25 20.2632 18.25H19.5C19.0858 18.25 18.75 17.9142 18.75 17.5C18.75 17.0858 19.0858 16.75 19.5 16.75H20.2632C20.5057 16.75 20.5582 16.7486 20.5928 16.7442C20.9334 16.7018 21.2018 16.4334 21.2442 16.0928C21.2486 16.0582 21.25 16.0057 21.25 15.7632V13C21.25 9.90813 18.8097 7.38623 15.75 7.25534L15.75 15.5C15.75 15.9142 15.4142 16.25 15 16.25C14.5858 16.25 14.25 15.9142 14.25 15.5L14.25 7C14.25 6.27169 14.2484 5.80091 14.2018 5.45403C14.158 5.12873 14.0874 5.02677 14.0303 4.96967C13.9732 4.91258 13.8713 4.84197 13.546 4.79823ZM2 12C2.41422 12 2.75 12.3358 2.75 12.75L2.75 15C2.75 15.4811 2.75072 15.7918 2.77206 16.0273C2.79247 16.2524 2.82689 16.3341 2.85048 16.375C2.91631 16.489 3.01099 16.5837 3.125 16.6495C3.16587 16.6731 3.2476 16.7075 3.47275 16.7279C3.7082 16.7493 4.01889 16.75 4.5 16.75C4.91422 16.75 5.25 17.0858 5.25 17.5C5.25 17.9142 4.91422 18.25 4.5 18.25H4.4678C4.028 18.25 3.64865 18.25 3.33735 18.2218C3.00817 18.192 2.68221 18.1259 2.375 17.9486C2.03296 17.7511 1.74892 17.467 1.55144 17.125C1.37407 16.8178 1.30802 16.4918 1.27818 16.1627C1.24997 15.8514 1.24998 15.472 1.25 15.0322L1.25 12.75C1.25 12.3358 1.58579 12 2 12ZM8.75 17.5C8.75 17.0858 9.08579 16.75 9.5 16.75L14.5 16.75C14.9142 16.75 15.25 17.0858 15.25 17.5C15.25 17.9142 14.9142 18.25 14.5 18.25L9.5 18.25C9.08579 18.25 8.75 17.9142 8.75 17.5Z" fill="currentColor" fill-opacity="0.87"/><path d="M1.99994 6.24996C1.58572 6.24996 1.24994 6.58574 1.24994 6.99996C1.24994 7.41417 1.58573 7.74996 1.99994 7.74996L7.99994 7.74996C8.41415 7.74996 8.74994 7.41417 8.74994 6.99996C8.74994 6.58575 8.41415 6.24996 7.99994 6.24996L1.99994 6.24996Z" fill="currentColor" fill-opacity="0.87"/><path d="M1.99994 9.24996C1.58573 9.24996 1.24994 9.58574 1.24994 9.99996C1.24994 10.4142 1.58572 10.75 1.99994 10.75L5.99994 10.75C6.41415 10.75 6.74994 10.4142 6.74994 9.99996C6.74994 9.58574 6.41415 9.24996 5.99994 9.24996L1.99994 9.24996Z" fill="currentColor" fill-opacity="0.87"/><path fill-rule="evenodd" clip-rule="evenodd" d="M3.74994 17.5C3.74994 15.705 5.20501 14.25 6.99994 14.25C8.79487 14.25 10.2499 15.705 10.2499 17.5C10.2499 19.2949 8.79487 20.75 6.99994 20.75C5.20501 20.75 3.74994 19.2949 3.74994 17.5ZM6.99994 15.75C6.03344 15.75 5.24994 16.5335 5.24994 17.5C5.24994 18.4665 6.03344 19.25 6.99994 19.25C7.96644 19.25 8.74994 18.4665 8.74994 17.5C8.74994 16.5335 7.96644 15.75 6.99994 15.75Z" fill="currentColor" fill-opacity="0.87"/><path fill-rule="evenodd" clip-rule="evenodd" d="M13.7499 17.5C13.7499 15.705 15.205 14.25 16.9999 14.25C18.7949 14.25 20.2499 15.705 20.2499 17.5C20.2499 19.2949 18.7949 20.75 16.9999 20.75C15.205 20.75 13.7499 19.2949 13.7499 17.5ZM16.9999 15.75C16.0334 15.75 15.2499 16.5335 15.2499 17.5C15.2499 18.4665 16.0334 19.25 16.9999 19.25C17.9664 19.25 18.7499 18.4665 18.7499 17.5C18.7499 16.5335 17.9664 15.75 16.9999 15.75Z" fill="currentColor" fill-opacity="0.87"/></svg>',
    cancelled: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M5.33556 11.3291C4.96507 11.1439 4.51457 11.294 4.32933 11.6645C4.14408 12.035 4.29425 12.4855 4.66474 12.6708L6.66474 13.6708C7.03522 13.856 7.48573 13.7058 7.67097 13.3353C7.85621 12.9649 7.70604 12.5144 7.33556 12.3291L5.33556 11.3291Z" fill="currentColor" fill-opacity="0.87"/><path fill-rule="evenodd" clip-rule="evenodd" d="M1.24998 6.49977C1.24998 6.60225 1.26032 6.69929 1.27936 6.79122C1.26023 6.85743 1.24998 6.9274 1.24998 6.99977L1.24998 17.1611C1.24998 18.2815 2.06733 19.0266 3.07331 19.6303C4.0917 20.2414 5.58984 20.8742 7.48293 21.6739L7.69411 21.7631C9.11315 22.363 10.0279 22.7498 11 22.7498C11.7892 22.7498 12.4238 22.498 13.2941 22.1269C13.6752 21.9644 13.8523 21.5238 13.6899 21.1428C13.5274 20.7618 13.0868 20.5846 12.7058 20.7471C12.297 20.9214 11.9974 21.0417 11.75 21.1207L11.75 11.6781C12.6351 11.5118 13.5549 11.0664 14.8348 10.4466L17.9761 8.92652C18.453 8.69579 18.8845 8.48702 19.25 8.28868L19.25 11.9998C19.25 12.414 19.5858 12.7498 20 12.7498C20.4142 12.7498 20.75 12.414 20.75 11.9998L20.75 6.99977C20.75 6.9274 20.7397 6.85743 20.7206 6.79122C20.7396 6.69929 20.75 6.60225 20.75 6.49977C20.75 5.79772 20.2651 5.35147 19.8186 5.04991C19.3727 4.74872 18.7315 4.43847 17.9761 4.07302L14.8348 2.55291C13.193 1.75788 12.1437 1.24976 11 1.24977C9.85624 1.24977 8.80698 1.75787 7.16521 2.55291L4.02386 4.07301C3.26852 4.43846 2.62726 4.74872 2.18136 5.04991C1.73491 5.35147 1.24998 5.79771 1.24998 6.49977ZM4.02387 8.92653C3.54694 8.69578 3.11549 8.48703 2.74998 8.28868L2.74998 17.1611C2.74998 17.4231 2.90546 17.7802 3.84512 18.3441C4.76126 18.8938 6.15994 19.4867 8.12876 20.3183C9.14799 20.7489 9.77109 21.0062 10.25 21.1379L10.25 11.6781C9.36482 11.5118 8.44505 11.0664 7.16521 10.4466L4.02387 8.92653ZM11 2.74977C10.2424 2.74977 9.52042 3.07967 7.65258 3.9835L4.73138 5.39704C3.90708 5.79591 3.36602 6.05984 3.02096 6.29292C2.87257 6.39315 2.80088 6.46107 2.7677 6.49977C2.80088 6.53847 2.87257 6.60638 3.02096 6.70662C3.36602 6.93969 3.90708 7.20363 4.73138 7.6025L7.65258 9.01603C9.52042 9.91986 10.2424 10.2498 11 10.2498C11.7576 10.2498 12.4795 9.91986 14.3474 9.01603L17.2686 7.6025C18.0929 7.20363 18.6339 6.93969 18.979 6.70662C19.1274 6.60639 19.1991 6.53846 19.2323 6.49976C19.1991 6.46106 19.1274 6.39315 18.979 6.29291C18.6339 6.05984 18.0929 5.79591 17.2686 5.39704L14.3474 3.9835C12.4795 3.07967 11.7576 2.74977 11 2.74977Z" fill="currentColor" fill-opacity="0.87"/><g opacity="0.4"><path d="M22.5302 15.5302C22.8231 15.2373 22.8231 14.7624 22.5302 14.4696C22.2374 14.1767 21.7625 14.1767 21.4696 14.4696L18.9999 16.9392L16.5302 14.4696C16.2374 14.1767 15.7625 14.1767 15.4696 14.4696C15.1767 14.7624 15.1767 15.2373 15.4696 15.5302L17.9393 17.9999L15.4696 20.4696C15.1767 20.7624 15.1767 21.2373 15.4696 21.5302C15.7625 21.8231 16.2374 21.8231 16.5302 21.5302L18.9999 19.0605L21.4696 21.5302C21.7625 21.8231 22.2374 21.8231 22.5302 21.5302C22.8231 21.2373 22.8231 20.7624 22.5302 20.4696L20.0606 17.9999L22.5302 15.5302Z" fill="currentColor"/><path d="M16.3355 4.67087C16.706 4.48563 16.8561 4.03512 16.6709 3.66464C16.4857 3.29415 16.0352 3.14399 15.6647 3.32923L5.66467 8.32923C5.29419 8.51447 5.14402 8.96498 5.32926 9.33546C5.51451 9.70594 5.96501 9.85611 6.33549 9.67087L16.3355 4.67087Z" fill="currentColor"/></g></svg>'
  };

  var notifications = [];

  function showLoading() {
    loading.style.display = 'flex';
    empty.style.display = 'none';
    error.style.display = 'none';
    content.style.display = 'none';
  }

  function showEmpty() {
    loading.style.display = 'none';
    empty.style.display = 'flex';
    error.style.display = 'none';
    content.style.display = 'none';
  }

  function showError() {
    loading.style.display = 'none';
    empty.style.display = 'none';
    error.style.display = 'flex';
    content.style.display = 'none';
  }

  function showContent() {
    loading.style.display = 'none';
    empty.style.display = 'none';
    error.style.display = 'none';
    content.style.display = 'block';
  }

  function formatDateHeader(dateStr) {
    var d = new Date(dateStr + 'T00:00:00');
    var now = new Date();
    var today = new Date(now.getFullYear(), now.getMonth(), now.getDate());
    var yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    var dateOnly = new Date(d.getFullYear(), d.getMonth(), d.getDate());

    if (dateOnly.getTime() === today.getTime()) return 'Today';
    if (dateOnly.getTime() === yesterday.getTime()) return 'Yesterday';

    var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[d.getMonth()] + ' ' + d.getDate() + ', ' + d.getFullYear();
  }

  function groupByDate(items) {
    var groups = {};
    items.forEach(function (n) {
      if (!groups[n.date]) groups[n.date] = [];
      groups[n.date].push(n);
    });
    return groups;
  }

  function renderNotifications() {
    content.innerHTML = '';

    if (notifications.length === 0) {
      showEmpty();
      return;
    }

    var sorted = notifications.slice().sort(function (a, b) {
      return b.date.localeCompare(a.date) || b.time.localeCompare(a.time);
    });

    var groups = groupByDate(sorted);

    Object.keys(groups).sort().reverse().forEach(function (date) {
      var header = document.createElement('div');
      header.className = 'notif-date-header';
      header.innerHTML = '<span class="notif-date-header__text">' + formatDateHeader(date) + '</span><span class="notif-date-header__line"></span>';
      content.appendChild(header);

      groups[date].forEach(function (notif) {
        var stateInfo = NOTIFICATION_STATES[notif.state] || NOTIFICATION_STATES[2];
        var iconKey = stateInfo.icon;

        var item = document.createElement('div');
        item.className = 'notif-item';
        item.setAttribute('data-id', notif.id);

        item.innerHTML =
          '<div class="notif-item__bg"><svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z" fill="white"/></svg></div>' +
          '<div class="notif-item__inner">' +
            '<div class="notif-item__icon">' + NOTIF_ICONS[iconKey] + '</div>' +
            '<div class="notif-item__body">' +
              '<div class="notif-item__text">Your order from <strong>' + notif.storeName + '</strong> ' + stateInfo.label + '.</div>' +
              '<div class="notif-item__time">' + notif.time + '</div>' +
            '</div>' +
          '</div>' +
          '<div class="notif-item__divider"></div>';

        var inner = null;
        var startX = 0;
        var currentX = 0;
        var isDragging = false;

        item.addEventListener('touchstart', function (e) {
          inner = item.querySelector('.notif-item__inner');
          startX = e.touches[0].clientX;
          isDragging = true;
        }, { passive: true });

        item.addEventListener('touchmove', function (e) {
          if (!isDragging || !inner) return;
          currentX = e.touches[0].clientX - startX;
          if (currentX < 0) {
            var offset = Math.max(currentX, -80);
            inner.style.transition = 'none';
            inner.style.transform = 'translateX(' + offset + 'px)';
          }
        }, { passive: true });

        item.addEventListener('touchend', function () {
          if (!inner) return;
          isDragging = false;
          inner.style.transition = 'transform 0.2s ease';
          if (currentX < -40) {
            inner.style.transform = 'translateX(-80px)';
            setTimeout(function () {
              deleteNotification(notif.id);
            }, 300);
          } else {
            inner.style.transform = 'translateX(0)';
          }
          currentX = 0;
        });

        content.appendChild(item);
      });
    });

    showContent();
  }

  function deleteNotification(id) {
    notifications = notifications.filter(function (n) { return n.id !== id; });
    var el = document.querySelector('.notif-item[data-id="' + id + '"]');
    if (el) {
      el.style.height = el.offsetHeight + 'px';
      el.style.transition = 'height 0.2s ease, opacity 0.2s ease';
      requestAnimationFrame(function () {
        el.style.height = '0';
        el.style.opacity = '0';
        el.style.overflow = 'hidden';
      });
      setTimeout(function () {
        el.remove();
        if (notifications.length === 0) showEmpty();
      }, 200);
    }
    if (typeof Toast !== 'undefined') Toast.show('Notification dismissed', 2000);
  }

  function loadNotifications() {
    showLoading();
    setTimeout(function () {
      notifications = (typeof NOTIFICATIONS !== 'undefined') ? NOTIFICATIONS.slice() : [];
      renderNotifications();
    }, 800);
  }

  backBtn.addEventListener('click', function () { window.history.back(); });
  retryBtn.addEventListener('click', function () { loadNotifications(); });

  loadNotifications();
})();