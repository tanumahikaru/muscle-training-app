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
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/home.css">
<link rel="stylesheet" href="training_result.css">
</head>
<body>
	<header>
		<button type="button" class="menu-btn">
		<h1 id="header-title">筋トレ</h1>
		<div class="right">
			<div id="user-level">Lv.13</div>
			<div class="user-icon">
				<img src="../training_result/user.png" alt="ユーザー画像">
			</div>
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
	
	<main>
  <h1>今日の消費カロリー</h1>
  <div id="total_cal"></div>

  <div id="training-list">
    <%
    List<MuscleRecord> results = (List<MuscleRecord>) request.getAttribute("result");
    int total = 0;
    for (MuscleRecord re : results) {
    %>
    <div class="training">
      <div><%=MuscleDAO.SelectMuscleEventById(re.getTraining_event_id()).getEvent_name()%></div>
      <div><%=re.getCalories_burned()%></div>
    </div>
  </div>

</main>
	<%
	total += re.getCalories_burned();
	%>
	<br>
	<%
	}
	%>
	
	<script>
	  let div = document.getElementById('total_cal')
	  div.innerText = <%=total%>+'kcal'
	</script>
    
    
    
	<script src="./JavaScript/home.js"></script>
</body>
</html>