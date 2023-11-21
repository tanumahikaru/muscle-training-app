/**
 * 
 */
document.addEventListener('DOMContentLoaded', function () {
  const menuButton = document.querySelector('.menu-btn');
  const menu = document.querySelector('.menu');
  const body = document.querySelector('body');

  // メニューボタンがクリックされたときの処理
  menuButton.addEventListener('click', function () {
    menu.classList.toggle('is-active');
  });

  // メニュー以外の領域をクリックしたときの処理
  document.addEventListener('click', function (event) {
    if (!menu.contains(event.target) && !menuButton.contains(event.target)) {
      menu.classList.remove('is-active');
    }
  });

  // ウィンドウサイズが変更されたときにメニューを閉じる
  window.addEventListener('resize', function () {
    if (window.innerWidth > 768) {
      menu.classList.remove('is-active');
    }
  });
});

