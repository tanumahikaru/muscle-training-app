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
  <div class="right">
    <div id="user-level">Lv.13
      <img src="user.png" alt="ユーザー画像">
      </div>
  </div>
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

 	<form action="SearchRecipeServlet" method="post">
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

    <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
    <button type="button" class="button-outline" onclick="setAndSubmitForm(1)">肉</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(2)">魚</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(3)">卵</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(4)">乳製品</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(5)">豆</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(6)">野菜</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(7)">果実</button>
	<button type="button" class="button-outline" onclick="setAndSubmitForm(8)">その他</button>
    

   	<%-- カテゴリー名を表示 --%>
	<h2><%= request.getAttribute("categoryName") %>のレシピ一覧</h2>
    
	<div class="card-container type2">
		<%
		int category_Id = 1;
		List<Meal_menuDTO> meal_menu = (ArrayList<Meal_menuDTO>)request.getAttribute("list");
		for(Meal_menuDTO m : meal_menu) {
		%>
		
		<div class="card-header">	
			<figure class="image"><img src="images/image (1).png"alt=""></figure>
		</div>
		<div class="card-body">
				<h2><%= m.getFood_name() %></h2>
       			<h1><%= m.getCalorie() %></h1>
				<button class = "card-button"><span>プロフィールを見る</span></button>
		</div>
		<%} %>
	</div>
</form>

   		<a href="TopServlet">戻る</a>

    <script src="./JavaScript/home.js"></script>
    <script src="./JavaScript/meal_menu.js"></script>
</body>
</html>