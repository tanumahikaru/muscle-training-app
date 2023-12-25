<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/free-training-result.css">
    <title>トレーニング結果</title>
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
        String eventName = (String) request.getAttribute("event_name");
	    Double totalCaloriesObj = (Double) request.getAttribute("totalCaloriesLast3");
	    String formattedCalories = (totalCaloriesObj != null) ? String.format("%.1f", totalCaloriesObj) : "0.0";
     %>
   	  <div class="result-container">
        <h2>トレーニングの結果</h2>
        <ul class="result-list">
            <li class="result-item">
                <p>種目名: <%= eventName %></p>
                <p>消費カロリー: <%= formattedCalories %></p>
            </li>
            <!-- 必要に応じて他のアイテムも追加 -->
        </ul>
    </div>
    <form action="FreeTrainingServlet" method="post">
    	<input type="submit" value="戻る" class="back">
    </form>
    <script src="./JavaScript/home.js"></script>
</body>
</html>
