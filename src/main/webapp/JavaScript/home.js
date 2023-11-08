/**
 * 
 */
// メニューボタンをクリックしたときの処理
document.querySelector('.menu-btn').addEventListener('click', function() {
  // メニューの表示・非表示を切り替える
  document.querySelector('.menu').classList.toggle('active');
});
