<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.Quiz"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Quiz</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/quiz-result.css">
<link rel="stylesheet" href="css/home.css">
</head>
<body>
	<header>
	<button type="button" class="menu-btn">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
		<div id="header-title">筋トレ</div>
		<div id="header-contents">
			<!--  ヘッダーの右側に入るモノを入れる  -->
			<img id="user-icon" src="images/user_icon.png" alt="">
		</div>
	</header>

	<div class="menu">
		<div class="menu__item">
			<a href="TopServlet">ホーム</a>
		</div>
		<div class="menu__item">
			<a href="TrainingSuggestionServlet">今日のトレーニング</a>
		</div>
		<div class="menu__item">
			<a href="MealServlet">食事</a>
		</div>
		<div class="menu__item">
			<a href="FreeTrainingServlet">フリートレーニング</a>
		</div>
		<div class="menu__item">
			<a href="RecipeServlet">レシピ検索</a>
		</div>
		<div class="menu__item">
			<a href="UserLogServlet">記録</a>
		</div>
		<div class="menu__item">
			<a href="QuizServlet">クイズ</a>
		</div>
		<div class="menu__item">
			<a href="LogoutServlet">ログアウト</a>
		</div>
	</div>

	<div id="main-contents">
		<%
		int result = (int) request.getAttribute("result");
		Quiz q = (Quiz) request.getAttribute("quiz");
		String correct = (String) request.getAttribute("correct");
		%>
		<div id="result">
			<%
			if (result == 1) {
			%>
			<span class="res">正解です!</span> <span class="res" style="color: #B01B3C;">◯</span>
			<%
			} else {
			%>
			<span class="res">不正解です...</span> <span class="res" style="color: #2941BC;">✕</span>
			<%
			}
			%>
		</div>
		<br>
		<div>
			正解は<%=q.getCorrect()%>.
			<%=correct%></div>
		<div id="button-group">
			<button onclick="location.href='QuizServlet'">クイズ一覧</button>
			<button
				onclick="location.href='QuizTryServlet?quizId=<%=q.getQuizId() + 1%>'">次の問題</button>
		</div>


		<h2 id="ex-title">解説</h2>
		<hr>
		<br>
		<div id="explanation">
			<%=q.getExplanation()%>
		</div>

	</div>
	<script src="./JavaScript/home.js"></script>
</body>
</html>