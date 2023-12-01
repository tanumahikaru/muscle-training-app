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