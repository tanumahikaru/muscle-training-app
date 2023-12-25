<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleRecord"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.MuscleDAO"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>トレーニング結果</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="css/free-training-result.css">
<link rel="stylesheet" href="training_result.css">
</head>
<body>
	<div class="header-banner">
		<button type="button" class="menu-btn">
			<i class="fa fa-bars" aria-hidden="true"></i>
		</button>
		<h1>筋トレ</h1>
	</div>
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
	<h2>トレーニング結果</h2>
	<%
	List<MuscleRecord> results = (List<MuscleRecord>) request.getAttribute("result");
	int total = 0;
	for (MuscleRecord re : results) {
	%>
	<%=MuscleDAO.SelectMuscleEventById(re.getTraining_event_id()).getEvent_name()%>
	<%=re.getCalories_burned()%>

	<%
	total += re.getCalories_burned();
	%>
	<br>
	<%
	}
	%>
	<%=total%>kcal
	
	<script src="./JavaScript/home.js"></script>
</body>
</html>