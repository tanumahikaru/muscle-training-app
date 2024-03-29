<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>あなたの今日のメニュー</title>
   <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/header.css">
  <link rel="stylesheet" href="css/training-suggestion.css">
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


<main>
  <h1>あなたの今日のメニュー</h1>
  <div class="menu-list">
    <%	
		ArrayList<MuscleDTO> training_menus = (ArrayList<MuscleDTO>)session.getAttribute("training_list");
		for(MuscleDTO m : training_menus) {
	%>
    <div class="menu-item">
     <figure class="image"><img src="training_images/<%=m.getTraining_event_id() %>.jpg" alt="" style="width:80px; height:70px;"></figure>
      <div class="menu-info">
        <span class="menu-name"><%=m.getEvent_name() %></span>
        <span class="menu-details"><%=m.getDefault_number() %>回</span>
        <span class="menu-details">3セット</span>
      </div>
      <a href="TrainingDetailServlet?id=<%=m.getTraining_event_id() %>"><button class="start-button">詳細</button></a>
    </div>
    <%} %>

  </div>
  <div class="button-group">
    <button onclick="location.href='TopServlet'">TOP</button>
    <button onclick="location.href='NextTrainingServlet'">START</button>
  </div>
</main>

<script src="./JavaScript/home.js"></script>
</body>
</html>