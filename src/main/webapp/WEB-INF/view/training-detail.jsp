<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="dao.MuscleDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Document</title>
  <link rel="stylesheet" href="css/training-detail.css">
</head>
<body>
<header>
  <!-- ここにハンバーガーメニューが入ります -->
  <h1 id="header-title">筋トレ</h1>
  <div class="right">
    <div id="user-level">Lv.13</div>
    <div class="user-icon">
      <img src="user.png" alt="ユーザー画像">
    </div>
  </div>
</header>
<% MuscleDTO training = (MuscleDTO)request.getAttribute("training"); %>

<main>
  <div class="upper-contents">
    <h1><%=training.getEvent_name() %></h1>
    <a href="TrainingSuggestionServlet"><button class="back-button">戻る</button></a>
  </div>

  <%=training.getMovie_url() %>
  <br>
  
  <%
  List<String> explanation = MuscleDAO.selectTrainingExplanation(training.getTraining_event_id());
  %>
  <div class="explanation">
    <%for(int i = 1 ; i <= explanation.size() ; i++){ %>
    <p><%=i %>. <%=explanation.get(i-1) %></p>
    <%} %>
  </div>
</main>
</body>
</html>
