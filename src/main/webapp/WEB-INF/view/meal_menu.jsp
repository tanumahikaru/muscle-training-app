<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>レシピ検索</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/user-log.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/training-suggestion.css">    
</head>
<body>
<header>
   <div class="header-banner">
    <button type="button" class="menu-btn">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
       <h1 id="header-title">筋トレ</h1>
  <div class="right">
    <div id="user-level">Lv.13
      <img src="user.png" alt="ユーザー画像">
      </div>
  </div>
  </div>
   <div class="menu">
    <div class="menu__item"><a href="homeServlet">ホーム</a></div>
    <div class="menu__item"><a href="TrainingSuggestionServlet">今日のトレーニング</a></div>
    <div class="menu__item"><a href="MealServlet">食事</a></div>
    <div class="menu__item"><a href="FreeServlet">フリートレーニング</a></div>
    <div class="menu__item"><a href="RecipeServlet">レシピ検索</a></div>
    <div class="menu__item"><a href="UserLogServlet">記録</a></div>
    <div class="menu__item"><a href="QuizServlet">クイズ</a></div>
    <div class="menu__item"><a href="LogoutServlet">ログアウト</a></div>
  </div>
</header>

    <!-- カテゴリー別に検索する JavaScript 部分 -->
    <script>
        function searchByCategory(category_Id) {
            // カテゴリーIDをパラメータとしてサーブレットに送信
            window.location.href = "SearchServlet?category=" + category_Id;
        }
    </script>
</head>
<body>

 	<%
    // ボタンがクリックされたときにpositionIdを取得するサーブレットのURL
    String servletURL = "RecipeServlet"; // サーブレットのURLに置き換えてください
%>

<form action="<%=servletURL%>" method="post">
    <!-- positionIdをサーバーに送信するフォーム -->
    <input type="hidden" name="category_Id" id="category_Id" value="" />

    <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
    <button type="button" onclick="setAndSubmitForm(1)">肉</button>
    <button type="button" onclick="setAndSubmitForm(2)">魚</button>
    <button type="button" onclick="setAndSubmitForm(3)">卵</button>
    <button type="button" onclick="setAndSubmitForm(4)">乳製品</button>
    <button type="button" onclick="setAndSubmitForm(5)">豆</button>
    <button type="button" onclick="setAndSubmitForm(6)">野菜</button>
    <button type="button" onclick="setAndSubmitForm(7)">果実</button>
    <button type="button" onclick="setAndSubmitForm(8)">その他</button>

    <!-- JavaScriptでpositionIdを設定し、フォームをサーバーに送信するスクリプト -->
    <script>
        function setAndSubmitForm(category_Id) {
            document.getElementById("category_Id").value = category_Id;
            document.forms[0].submit();
        }
    </script>
	</form>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>メニュー名</th>
				<th>カロリー</th>
		</tr>
	<%
		List<Meal_menuDTO> meal_menu = (ArrayList<Meal_menuDTO>)request.getAttribute("list");
		for(Meal_menuDTO m : meal_menu) {
	%>
		<tr>
			<td><%=m.getFood_id() %>
			<td><%=m.getFood_name() %></td>
			<td><%=m.getCalorie() %></td>
		</tr>
	<%} %>
	</table>
   	<a href="TopServlet">戻る</a>

          <script src="./JavaScript/home.js"></script>
    
</body>
</html>
