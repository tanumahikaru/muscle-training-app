<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フリートレーニング一覧</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
</head>
<body>
<header>
   <div class="header-banner">
    <button type="button" class="menu-btn">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
  <div class="right">
   <h1 id="header-title">筋トレ</h1>
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
<form action="SearchServlet" method="get">
  <input type="text" name="search" placeholder="Search...">
  <button type="submit">Search</button>
</form>
<div class="search">
	<table border="1">
		<tr>
			<th>ID</th>
			<th>レシピ名</th>
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
</div>
	<script src="./JavaScript/home.js"></script>
	
</body>
</html>