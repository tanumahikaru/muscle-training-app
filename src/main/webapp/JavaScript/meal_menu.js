/**
 * 
 */

function setAndSubmitForm(category_Id) {
    document.getElementById("category_Id").value = category_Id;
    document.forms["categoryForm"].submit();
}

function searchByCategory(category_Id) {
    // カテゴリーIDをパラメータとしてサーブレットに送信
    window.location.href = "SearchServlet?category=" + category_Id;
}

    function redirectToDetail(foodId) {
        window.location.href = "MealMenuDetailServlet?id=" + foodId;
    }
    
    
document.addEventListener('DOMContentLoaded', function () {
  // カードの数を取得
  var cardCount = document.querySelectorAll('.card-body').length;

  // カードが1枚の場合、左寄せのクラスを追加
  if (cardCount === 1) {
    document.querySelector('.card-container').classList.add('left-align');
  }

  // カードが2枚以上の場合、中央寄せのクラスを追加
  if (cardCount > 1) {
    document.querySelector('.card-container').classList.add('center-cards');
  }
});