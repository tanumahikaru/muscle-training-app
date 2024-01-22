<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_RecordDTO" %>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>食事画面</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/meal.css"> <!-- 追加したCSSファイルの読み込み -->
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

  <div id="container">
    <div class="content">
        <% 
            Meal_menuDTO meal_menu = (Meal_menuDTO) request.getAttribute("meal");
        %>
        <!-- 今日のおすすめメニューを表示 -->
        <h2>今日のおすすめメニュー:</h2>
        <% if (!meal_menu.getFood_name().isEmpty()) { %>
           <img id="meal-img" src="images/<%= meal_menu.getFood_id() %>.jpg" alt="食事メニュー画像">
            <h1 style="text-align: center;"><%= meal_menu.getFood_name() %></h1>
             <div class="centered-link-container">
            <a href="MealMenuDetailServlet?id=<%= meal_menu.getFood_id() %>">料理を作る</a>
            </div>
        <% } else { %>    
            <p>提案されたメニューはありません。</p>
        <% } %>
    </div>
    
    <div class="content-container">
        <!-- レシピ検索で追加ボタン -->
        <div class="centered-link-container">
      	  <a href="RecipeServlet" class="recipe-button" id="recipeAddButton">レシピ検索で追加</a><br>
        </div>
        <!-- 新しく作りたいメニューと登録フォームを一つの箱に表示 -->
    
        <h2>今日の食べたメニュー:</h2>
        <!-- 表示コードを追加 -->
        <% if (request.getAttribute("mealsAddedOnSameDay") != null) { 
            List<Meal_RecordDTO> mealsAddedOnSameDay = (List<Meal_RecordDTO>) request.getAttribute("mealsAddedOnSameDay");
            for (Meal_RecordDTO meal : mealsAddedOnSameDay) { %>
                <div class="meal-entry">
                    <p><%= meal.getFood_name() %></p>
                    <p><%= meal.getCalorie() %>kcal</p>
                    <!-- アイコンを追加して削除機能を実装 -->
                    <a href="DeleteMealServlet?id=<%= meal.getId() %>" class="delete-button">
                        <i class="fa fa-trash" aria-hidden="true"></i> 削除
                    </a>
                </div>
            <% }
        } else { %>
            <p>今日はまだ何も食べていません。</p>
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
</div>
    <!-- ここに食事に関する情報やコンテンツを追加 -->
    <script src="./JavaScript/home.js"></script>
</body>
</html>