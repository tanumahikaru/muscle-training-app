<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz</title>
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/quiz-top.css">
</head>
<body>
    <header>
  <div id="header-title">筋トレ</div>
  <div id="header-contents">
    <!--  ヘッダーの右側に入るモノを入れる  -->
    <img id="user-icon" src="images/user_icon.png" alt="">
  </div>
</header>

<div id="main-contents">
  <h1 id="page-title">筋トレクイズ</h1>
  <div id="quiz-chart">
    <div id="quiz-records">
      <span class="records" style="color: #B01B3C">正解:30</span>
      <span class="records" style="color: #2941BC">不正解:10</span>
      <span class="records" style="color: #aac">未回答:60</span>
    </div>
    <div id="chart">
      <div class="bad" data-good="30">
        <div class="good" data-bad="10"></div>
      </div>
    </div>
  </div>
  <div id="quiz-list">
    <!--  このクイズ一つ一つをfor文で繰り返す  -->
    <a href="">
      <div class="quiz">
        <div class="quiz-num">問題1</div>
        <div class="quiz-title">プロテインを摂取するタイミング</div>
        <div class="quiz-status">◯</div>
      </div>
    </a>
  </div>
  <button>TOP</button>
</div>
<div class="right-upper-contents">
  <div id="correct-answers">正当数 <span class="correct-count">100</span>/100</div>
  <button>ランダム出題</button>
</div>

<script>
  let bad = document.querySelector(".bad")
  bad.style.width = ((100 - 60) * 6) + 'px'

  let good = document.querySelector(".good")
  good.style.width = (30 * 6) + 'px'

</script>
</body>
</html>