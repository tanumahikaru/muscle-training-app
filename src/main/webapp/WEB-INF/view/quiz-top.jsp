<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.UserDTO"%>
<%@ page import="dto.Quiz"%>
<%@ page import="dao.QuizDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quiz</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/quiz-top.css">
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
		<h1 id="page-title">筋トレクイズ</h1>
		<div id="quiz-chart">
			<div id="quiz-records">
				<%
				UserDTO user = (UserDTO) session.getAttribute("user");
				int countCorrect = QuizDAO.CountCorrect(user.getId());
				int countAns = QuizDAO.CountAns(user.getId());
				int countFail = countAns - countCorrect;
				int notAns = 25 - countAns;
				%>

				<span class="records" style="color: #B01B3C">正解:<%=countCorrect%></span>
				<span class="records" style="color: #2941BC">不正解:<%=countFail%></span>
				<span class="records" style="color: #aac">未回答:<%=notAns%></span>
			</div>
			<div id="chart">
				<div class="bad" data-bad="<%=countAns%>">
					<div class="good" data-good="<%=countCorrect%>"></div>
				</div>
			</div>
		</div>
		<div id="quiz-list">
			<!--  このクイズ一つ一つをfor文で繰り返す  -->
			<%
			ArrayList<Quiz> quizList = (ArrayList<Quiz>) request.getAttribute("quizList");
			for (Quiz q : quizList) {
			%>
			<a href="QuizTryServlet?quizId=<%=q.getQuizId()%>">
				<div class="quiz">
					<div class="quiz-num">
						問題<%=q.getQuizId()%></div>
					<div class="quiz-title"><%=q.getTitle()%></div>
					<div class="quiz-status">
						<%
						if (q.getStatus() == 0) {
						%>
						ー
						<%
						} else if (q.getStatus() == 1) {
						%>
						◯
						<%
						} else {
						%>
						✕
						<%
						}
						%>
					</div>
				</div>
			</a>
			<%
			}
			%>
		</div>
		<button class="top-btn">TOP</button>
	</div>
	<div class="right-upper-contents">
		<div id="correct-answers">
			正答数 <span class="correct-count"><%=countCorrect%></span>/25
		</div>
		<!-- <button>ランダム出題</button> -->
	</div>

	<script>
		let bad = document.querySelector(".bad")
		let badCount = document.querySelector(".bad").dataset.bad;
		bad.style.width = (badCount * 24) + 'px'

		let good = document.querySelector(".good")
		let goodCount = document.querySelector(".good").dataset.good;
		good.style.width = (goodCount * 24) + 'px'
	</script>
	<script src="./JavaScript/home.js"></script>
</body>
</html>