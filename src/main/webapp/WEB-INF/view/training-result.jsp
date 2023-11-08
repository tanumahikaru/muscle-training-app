<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>あなたの今日のメニュー</title>
  <link rel="stylesheet" href="training_result.css">
</head>
<body>
<header>
  <!-- ここにハンバーガーメニューが入ります -->
  <h1 id="header-title">筋トレ</h1>
  <div class="right">
    <div id="user-level">Lv.13</div>
    <div class="user-icon">
      <img src="../training_result/user.png" alt="ユーザー画像">
    </div>
  </div>
</header>

<main>
  <h1>今日の消費カロリー</h1>
  <div id="total_cal">300kcal</div>

  <div id="training-list">
    <div class="training">
      <div>種目名</div>
      <div>カロリー</div>
    </div>
  </div>

</main>

</body>
</html>
