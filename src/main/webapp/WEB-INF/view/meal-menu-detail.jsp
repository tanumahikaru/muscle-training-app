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
<title>食事詳細</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/home.css">
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

                <!-- 材料のリストを表示 -->
                <%
                    List<MaterialDTO> materials = (List<MaterialDTO>) request.getAttribute("materials");
                    if (materials != null) {
                        for (MaterialDTO material : materials) {
                %>
                            <div class="card-body">
                            <div class="materials">
                                <h1><%= material.getIngredients() %></h1>
                                <h1><%= material.getQuantity() %></h1>
                                </div>
                            </div>
                <%
                        }
                    }
                %>
            </div>

			<div id="option">
				<br>
				<form action="RegistrationServlet" method="post">
				
				<h3>白米</h3>
				<div class="button-group">
					<p><input type="radio" name="kome" value="1">大(200g)</p>
					<p><input type="radio" name="kome" value="2">中(150g)</p>
					<p><input type="radio" name="kome" value="3">小(100g)</p>
				</div>
				<h3>食パン</h3>
				<div class="button-group">
					<p><input type="radio" name="pan" value="4">プレーン</p>
					<p><input type="radio" name="pan" value="5">ジャム</p>
					<p><input type="radio" name="pan" value="6">マーガリン</p>
					<p><input type="radio" name="pan" value="7">バター</p>
				</div>
				
   				 <!-- フォームの内容 -->
   					 <button type="submit" class="margin-button" id="addButton">追加</button>
				</form>
				
			</div>
			<button class="add-button" onclick="goBack()">戻る</button>
		</div>
	</div>
	<script src="./JavaScript/home.js"></script>
	<script src="./JavaScript/back.js"></script>
</body>
</html>