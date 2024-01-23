<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.UserDTO"%>
<%@ page import="dto.Quiz"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Document</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/quiz-try.css">
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

	<button class="back-button" onclick="location.href='QuizServlet'">戻る</button>

	<div id="quiz">
		<%
		Quiz q = (Quiz) request.getAttribute("quiz");
		%>
		<h2>
			問題<%=q.getQuizId()%></h2>
		<p><%=q.getQuestion()%></p>
		<div id="answer">
			<button class="ans-button"
				onclick="location.href='QuizResultServlet?ans=1&quizId=<%=q.getQuizId()%>'">
				1.<%=q.getChoices_1()%></button>
			<button class="ans-button"
				onclick="location.href='QuizResultServlet?ans=2&quizId=<%=q.getQuizId()%>'">
				2.<%=q.getChoices_2()%></button>
			<button class="ans-button"
				onclick="location.href='QuizResultServlet?ans=3&quizId=<%=q.getQuizId()%>'">
				3.<%=q.getChoices_3()%></button>
			<button class="ans-button"
				onclick="location.href='QuizResultServlet?ans=4&quizId=<%=q.getQuizId()%>'">
				4.<%=q.getChoices_4()%></button>
		</div>
	</div>
	<script src="./JavaScript/home.js"></script>
</body>
</html>