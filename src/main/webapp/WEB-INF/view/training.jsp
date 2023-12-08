<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
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
	<%
		MuscleDTO training = (MuscleDTO) request.getAttribute("training");
	%>
    <form action="FreeTrainingResultServlet" method="post">
	<button class="breakBtn">中断</button>
	</form>
	<h1 class="titile"><%=training.getEvent_name()%></h1>
	<!-- フォームタグを付けるとタイマーが動かなくなる -->
	<form action="FreeTrainingResultServlet" method="post" id="form">
        <button class="breakBtn">中断</button>
        <div class="set" id="set1">
            1セット目:
            <div id="timer1">
                <div class="time-display">00:00:00</div>
                <button type="button" class="start-button">開始</button>
                <button type="button" class="stop-button">停止</button>
                <button type="button" class="reset-button">リセット</button>
                <button type="button" class="minus">ー</button>
                <input type="number" name="numberSet1" class="number" min="0">
                <button type="button" class="plus">＋</button>
            </div>
        </div>
        <!-- 2セット目以降はまだタイマーは動かない -->
        <div class="set" id="set2">
            2セット目:
            <div id="timer2">
                <div class="time-display">00:00:00</div>
                <button type="button" class="start-button">開始</button>
                <button type="button" class="stop-button">停止</button>
                <button type="button" class="reset-button">リセット</button>
                <button type="button" class="minus">ー</button>
                <input type="number" name="numberSet2" class="number" min="0">
                <button type="button" class="plus">＋</button>
            </div>
        </div>
        
        <div class="set" id="set3">
            3セット目:
            <div id="timer3">
                <div class="time-display">00:00:00</div>
                <button type="button" class="start-button">開始</button>
                <button type="button" class="stop-button">停止</button>
                <button type="button" class="reset-button">リセット</button>
                <button type="button" class="minus">ー</button>
                <input type="number" name="numberSet3" class="number" min="0">
                <button type="button" class="plus">＋</button>
            </div>
        </div>
    
        <button type="button" class="recordBtn" onclick="recordTraining()">記録</button><br>
    </form>
    <form action="FreeTrainingServlet" method="post">
        <button type="submit" class="backBtn">戻る</button>
    </form>
    
    <h3>やり方</h3>
    
    <hr>
    
    <h1>ここに説明が入ります</h1>

    <script src="./JavaScript/home.js"></script>
    <script src="./JavaScript/timer.js"></script>
    <script>
        function recordTraining() {
            // 各セットのタイマーの値を取得
            var numberSet1 = document.getElementById("timer1").querySelector("input").value;
            var numberSet2 = document.getElementById("timer2").querySelector("input").value;
            var numberSet3 = document.getElementById("timer3").querySelector("input").value;

            // フォームに値を設定
            document.getElementById("form").querySelector("input[name='numberSet1']").value = numberSet1;
            document.getElementById("form").querySelector("input[name='numberSet2']").value = numberSet2;
            document.getElementById("form").querySelector("input[name='numberSet3']").value = numberSet3;

            // フォームを送信
            document.getElementById("form").submit();
        }
    </script>
</body>
</html>