<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO"%>
<%@ page import="dto.MaterialDTO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/header.css">
<link rel="stylesheet" href="css/meal-menu-detail.css">
</head>
<body>
	<div class="header-banner">
		<button type="button" class="menu-btn">
			<i class="fa fa-bars" aria-hidden="true"></i>
		</button>
		<h1>筋トレ</h1>
	</div>

	<div class="menu">
		<div class="menu__item">
			<a href="TopServlet">ホーム</a>
		</div>
		<div class="menu__item">
			<a href="TrainingSuggestionServlet">今日のトレーニング</a>
		</div>
		<div class="menu__item">
			<a href="MealServlet">食事</a>
		</div>
		<div class="menu__item">
			<a href="FreeTrainingServlet">フリートレーニング</a>
		</div>
		<div class="menu__item">
			<a href="RecipeServlet">レシピ検索</a>
		</div>
		<div class="menu__item">
			<a href="UserLogServlet">記録</a>
		</div>
		<div class="menu__item">
			<a href="QuizServlet">クイズ</a>
		</div>
		<div class="menu__item">
			<a href="LogoutServlet">ログアウト</a>
		</div>
	</div>

	<%
		Meal_menuDTO menu = (Meal_menuDTO) request.getAttribute("menu");
	%>
	
	<%
		MaterialDTO material = (MaterialDTO) request.getAttribute("material");
	%>

	

	<div id="main-contents">
		<div id="left-contents">
			<img id="meal-img" src="images/meal.png" alt="食事メニュー画像">
			<h2 id="menu-title"><%=menu.getFood_name()%></h2>
		</div>

		<div id="right-contents">
			<button class="back-button" onclick="goBack()">戻る</button>
			<div class="title">
				<h3>栄養素</h3>
			</div>
			<span class="calorie"><%=menu.getCalorie() %></span>
			<hr>
			<div id="nutrients">
				<div class="protein">
					タンパク質<br><%=menu.getProtein() %>
				</div>
				<div class="fat">
					脂質<br><%=menu.getFat() %>
				</div>
				<div class="carbo">
					糖質<br><%=menu.getCarbo() %>
				</div>
			</div>

			<div class="card-container type2">
	

		<div class="card-body">
			<h2><%= material.getStep() %></h2>
       		<h1><%= material.getIngredients() %></h1>
       		<h1><%= material.getQuantity() %></h1>
		</div>
	
	</div>

			<div id="option">
				<br>
				<h3>食べた量</h3>
				<div class="button-group">
					<button>25%</button>
					<button>50%</button>
					<button>75%</button>
					<button>100%</button>
				</div>
				<h3>白米</h3>
				<div class="button-group">
					<button>大(200g)</button>
					<button>中(150g)</button>
					<button>小(100g)</button>
				</div>
				<h3>食パン</h3>
				<div class="button-group">
					<button>プレーン</button>
					<button>ジャム</button>
					<button>マーガリン</button>
					<button>バター</button>
				</div>
			</div>
			<button class="add-button" onclick="goBack()">戻る</button>
		</div>
	</div>
	<script src="./JavaScript/back.js"></script>
</body>
</html>