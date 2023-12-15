<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>記録</title>
    
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
<main>
<div class="button-group">
            <!-- ボタングループはそのまま使用 -->
        </div>
        <div class="button-group center-button">
            <!-- ボタングループはそのまま使用 -->
        </div>
        <!-- 棒グラフを表示するコンテナ -->
        <div class="graph-container" id="calorieGraph">
        </div>
 <div class="button-group">
    <form action="TrainingLogServlet" method="post">
        <button type="submit">トレーニング記録</button>
    </form>

    <div class="space"></div> <!-- ここにスペースを追加 -->

    <form action="RecipeServlet" method="post">
        <button>食事記録</button>
    </form>
</div>
<div class="button-group center-button">
    <form action="TopServlet" method="post">
        <button class="start-button">TOP</button>
    </form>
</div>	
</main>
<script src="./JavaScript/home.js"></script>
<script src="js/script.js"></script>
</body>
</html>
