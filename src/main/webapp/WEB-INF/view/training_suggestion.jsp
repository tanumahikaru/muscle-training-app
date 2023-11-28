<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>あなたの今日のメニュー</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/header.css">
  <link rel="stylesheet" href="css/training-suggestion.css">
</head>
<body>

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
    <div class="menu__item"><a href="FreeServlet">フリートレーニング</a></div>
    <div class="menu__item"><a href="RecipeServlet">レシピ検索</a></div>
    <div class="menu__item"><a href="UserLogServlet">記録</a></div>
    <div class="menu__item"><a href="QuizServlet">クイズ</a></div>
    <div class="menu__item"><a href="LogoutServlet">ログアウト</a></div>
  </div>

<main>
  <h1>あなたの今日のメニュー</h1>
  <div class="menu-list">
    
    <div class="menu-item">
      <div class="icon">&#9742;</div>
      <div class="menu-info">
        <span class="menu-name">メニュー名</span>
        <span class="menu-details">回数 セット数</span>
      </div>
      <button class="start-button">詳細</button>
    </div>

  </div>
  <div class="button-group">
    <button>TOP</button>
    <button>START</button>
  </div>
</main>

<script src="./JavaScript/home.js"></script>
</body>
</html>
