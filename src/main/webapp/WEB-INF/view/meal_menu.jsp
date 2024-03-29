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
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/meal_menu.css">
    <link rel="stylesheet" href="css/user-log.css">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body>
<header>
   <div class="header-banner">
    <button type="button" class="menu-btn">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
       <h1 id="header-title">筋トレ</h1>

  </div>
   <div class="menu">
    <div class="menu__item"><a href="TopServlet">ホーム</a></div>
    <div class="menu__item"><a href="TrainingSuggestionServlet">今日のトレーニング</a></div>
    <div class="menu__item"><a href="MealServlet">食事</a></div>
    <div class="menu__item"><a href="FreeTrainingServlet">フリートレーニング</a></div>
    <div class="menu__item"><a href="RecipeServlet">レシピ検索</a></div>
    <div class="menu__item"><a href="UserLogServlet">記録</a></div>
    <div class="menu__item"><a href="QuizServlet">クイズ</a></div>
    <div class="menu__item"><a href="LogoutServlet">ログアウト</a></div>
  </div>
</header>

 	<form action="SearchRecipeServlet" method="post" class= "search-menu">
        <input type="text" name="searchKeyword" placeholder="検索したいメニューを入力してください">
        <input type="submit" value="検索">
    </form>


</head>
<body>

 	<%
    // ボタンがクリックされたときにpositionIdを取得するサーブレットのURL
    String servletURL = "RecipeServlet"; // サーブレットのURLに置き換えてください
%>

<form action="<%=servletURL%>" method="post" id="categoryForm">
    <!-- positionIdをサーバーに送信するフォーム -->
    <input type="hidden" name="category_Id" id="category_Id" value="" />
	<div class = "form-buttons">
    <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
    <button type="button" class="button-outline" onclick="setAndSubmitForm(1)">肉</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(2)">魚</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(3)">卵</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(4)">乳製品</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(5)">豆</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(6)">野菜</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(7)">果実</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(8)">その他</button>
    </div>

   	<%-- カテゴリー名を表示 --%>
	<h2><%= request.getAttribute("categoryName") %>のレシピ一覧</h2>
    
	<div class="card-container type2">
		<%
		int category_Id = 1;
		List<Meal_menuDTO> meal_menu = (ArrayList<Meal_menuDTO>)request.getAttribute("list");
		for(Meal_menuDTO m : meal_menu) {
		%>

		<div class="card-body">
			<figure class="image"><img src="images/<%= m.getFood_id() %>.jpg" alt="" style="width:150px; height:150px;"></figure>
			<h2><%= m.getFood_name() %></h2>
       		<h1><%= m.getCalorie() %>kcal</h1>
       		<div class="centered-link-container-strike">
			<a href="MealMenuDetailServlet?id=<%=m.getFood_id() %>">料理を作る</a>
			</div>
		</div>
		<%} %>
	</div>	
</form>
   		<div class="centered-link-container">
    	<a href="TopServlet" class="back">戻る</a>
		</div>

    <script src="./JavaScript/home.js"></script>
    <script src="./JavaScript/meal_menu.js"></script>
    <script src="./JavaScript/back.js"></script>
</body>
</html>