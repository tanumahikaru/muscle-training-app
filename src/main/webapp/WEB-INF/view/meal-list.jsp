<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

    <div id="container">
        <div id="title">今日の食事</div>

        <!-- レシピ検索で追加ボタン -->
        <button class="recipe-button" id="recipeAddButton">レシピ検索で追加</button><br>

        <!-- 登録フォーム -->
        <form action="MealServlet" method="post">
            <div class="underline-input-container">
                <span style="border-bottom: solid 1px">
                    <input type="text" id="mealName" name="mealName" class="small-rounded-input" placeholder="食べたものを入力">
                </span>
                <input type="text" id="mealDescription" name="mealDescription" class="rounded-textarea" required>kcal
                <button type="submit" class="margin-button" id="addButton">追加</button>
            </div>
        </form>
    </div>
    <!-- 作るボタン -->
    <button class="action-button" id="createButton">作る</button>
    
    <!-- TOPボタン -->
    <button class="action-button" id="topButton">TOP</button>

    <!-- ここに食事に関する情報やコンテンツを追加 -->
    <script src="./JavaScript/home.js"></script>
</body>
</html>
