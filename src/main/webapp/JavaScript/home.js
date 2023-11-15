/**
 * 
 */
document.addEventListener('DOMContentLoaded', function () {
  const menuButton = document.querySelector('.menu-btn');
  const closeButton = document.querySelector('.close-btn');
  const menu = document.querySelector('.menu');
  const body = document.querySelector('body');

  // メニューボタンがクリックされたときの処理
  menuButton.addEventListener('click', function () {
    menu.classList.toggle('is-active');
    body.classList.toggle('menu-open');
  });

  // クローズボタンがクリックされたときの処理
  closeButton.addEventListener('click', function () {
    menu.classList.remove('is-active');
    body.classList.remove('menu-open');
  });

  // メニュー以外の領域をクリックしたときの処理
  document.addEventListener('click', function (event) {
    if (!menu.contains(event.target) && !menuButton.contains(event.target)) {
      menu.classList.remove('is-active');
      body.classList.remove('menu-open');
    }
  });

  // ウィンドウサイズが変更されたときにメニューを閉じる
  window.addEventListener('resize', function () {
    if (window.innerWidth > 768) {
      menu.classList.remove('is-active');
      body.classList.remove('menu-open');
    }
  });
});
