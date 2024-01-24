<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="dto.Meal_RecordDTO" %>
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
    <link rel="stylesheet" href="css/meal_record.css">
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

<body>

    <div class="content-container">
        <!-- レシピ検索で追加ボタン -->
        <div class="centered-link-container-strike">
      	  <a href="RecipeServlet" class="recipe-button" id="recipeAddButton">レシピ検索で追加</a><br>
        </div>
	
	     <!-- 日付選択フォーム -->
    <form action="RecipeLogServlet" method="GET">
        <label for="selectedDate">日付選択：</label>
        <input type="date" id="selectedDate" name="selectedDate" value="<%= request.getAttribute("selectedDate") %>">
        <input type="submit" value="表示">
    </form>

    <!-- 食事データ表示部分 -->
    <% if (request.getAttribute("mealsAddedOnSameDay") != null) { 
        List<Meal_RecordDTO> mealsAddedOnSameDay = (List<Meal_RecordDTO>) request.getAttribute("mealsAddedOnSameDay");
        String selectedDate = (String) request.getAttribute("selectedDate");
        for (Meal_RecordDTO meal : mealsAddedOnSameDay) { %>
            <div class="meal-entry">
                <p><%= meal.getFood_name() %></p>
                <p><%= meal.getCalorie() %>kcal</p>
                <p>Date: <%= selectedDate %></p>
              
            </div>
        <% }
    } else { %>
        <p>選択された日にはまだ何も食べていません。</p>
    <% } %>
    
    <!-- 登録フォーム -->
        <form action="RegistrationServlet2" method="post">
            <div class="underline-input-container">
                <span style="border-bottom: solid 1px">
                    <input type="text" id="foodName" name="foodName" class="small-rounded-input" placeholder="食べたものを入力">
                </span>
                <input type="text" id="calorie" name="calorie" class="rounded-textarea" required>kcal
                <button type="submit" class="margin-button" id="addButton">追加</button>
            </div>
        </form>
    </div>
    
   	<button type="button" class= backbutton onclick="goBack()">戻る</button>
   	
    <script src="./JavaScript/home.js"></script>
    <script src="./JavaScript/meal_menu.js"></script>
    <script src="./JavaScript/back.js"></script>
</body>
</html>