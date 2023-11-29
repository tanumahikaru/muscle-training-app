<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.MuscleRecord" %>
<%@ page import="dao.MuscleRecordDAO" %>
<%@ page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/home.css">
  <title>TOP</title>
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
      <div class="menu__item"><a href="MealMenuDetailServlet">食事</a></div>
      <div class="menu__item"><a href="FreeTrainingServlet">フリートレーニング</a></div>
      <div class="menu__item"><a href="RecipeServlet">レシピ検索</a></div>
      <div class="menu__item"><a href="UserLogServlet">記録</a></div>
      <div class="menu__item"><a href="QuizServlet">クイズ</a></div>
   	  <div class="menu__item"><a href="LogoutServlet">ログアウト</a></div>
	</div>
  <form action="RegisterWeightServlet" method="post">
    今日の体重を記録：<input type="text" name="weight" placeholder="体重を入力してください"><br>
    <input type="submit" value="記録">
  </form>
  
 <div>
  <p>摂取カロリー</p>
  
  <p>消費カロリー</p>
  
   <% MuscleRecord latestRecord = (MuscleRecord)request.getAttribute("latestRecord"); %>
        <% if (latestRecord != null) { %>
            <p>calories_burned: <%= latestRecord.getCalories_burned() %></p>
        <% } %>
  </div>
  
  <p>クイズ正答数</p>
  

  <script src="./JavaScript/home.js"></script>
</body>

</html>