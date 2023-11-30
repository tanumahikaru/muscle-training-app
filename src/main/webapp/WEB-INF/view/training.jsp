<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/training.css">
<title>フリートレーニング</title>
</head>
<body>
	<div class="header-banner">
    <button type="button" class="menu-btn">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
     <h1>筋トレ</h1>
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
    <button class="breakBtn">中断</button>
	<h1 class="titile">種目名</h1>
	<!-- フォームタグを付けるとタイマーが動かなくなる -->
		<div class="set" id="set1">
			1セット目:
			<div id="timer">
	  			<div id="time-display">00:00:00</div>
				<button id="start-button">開始</button>
				<button id="stop-button">停止</button>
				<button id="reset-button">リセット</button>
				<button class="minus">ー</button>
				<input type="number" class="number" min="0">
				<button class="plus">＋</button>
			</div>
		</div>
		<!-- 2セット目以降はまだタイマーは動かない -->
		<div class="set" id="set2">
			2セット目:
			<div id="timer">
	  			<div id="time-display">00:00:00</div>
				<button id="start-button">開始</button>
				<button id="stop-button">停止</button>
				<button id="reset-button">リセット</button>
				<button class="minus">ー</button>
				<input type="number" class="number" min="0">
				<button class="plus">＋</button>
			</div>
		</div>
		
		<div class="set" id="set3">
			3セット目:
			<div id="timer">
	  			<div id="time-display">00:00:00</div>
				<button id="start-button">開始</button>
				<button id="stop-button">停止</button>
				<button id="reset-button">リセット</button>
				<button class="minus">ー</button>
				<input type="number" class="number" min="0">
				<button class="plus">＋</button>
			</div>
		</div>
	
			<button class="recordBtn">記録</button><br>
			<form action="FreeTrainingServlet" method="post">
				<button type="submit" class="backBtn">戻る</button>
			</form>
			
			<h3>やり方</h3>
			
			<hr>
			
			<h1>ここに説明が入ります</h1>
	
	<script src="./JavaScript/home.js"></script>
	<script src="./JavaScript/timer.js"></script>
</body>
</html>