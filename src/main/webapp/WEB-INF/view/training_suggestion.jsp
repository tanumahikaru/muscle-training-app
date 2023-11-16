<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>あなたの今日のメニュー</title>
  <link rel="stylesheet" href="css/training-suggestion.jsp">
</head>
<body>
<header>
  <!-- ここにハンバーガーメニューが入ります -->
  <h1 id="header-title">筋トレ</h1>
  <div class="right">
    <div id="user-level">Lv.13</div>
    <div class="user-icon">
      <img src="user.png" alt="ユーザー画像">
    </div>
  </div>
</header>

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

</body>
</html>
//こんにちは