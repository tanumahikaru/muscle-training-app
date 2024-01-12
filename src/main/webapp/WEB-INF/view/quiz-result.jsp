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
  <link rel="stylesheet" href="css/reset.css">
  <link rel="stylesheet" href="css/style2.css">
  <link rel="stylesheet" href="css/quiz-result.css">

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
<%
int result = (int)request.getAttribute("result");
Quiz q = (Quiz)request.getAttribute("quiz");
String correct = (String)request.getAttribute("correct");
%>
  <div id="result">
  <% if(result == 1) { %>
    <span class="res">正解です!</span>
    <span class="res">◯</span>
    <%} else { %>
    <span class="res">不正解です...</span>
    <span class="res">✕</span>
    <%} %>
  </div>
  <br>
  <div>正解は<%=q.getCorrect() %>. <%=correct %></div>
  <div id="button-group">
    <button onclick="location.href='QuizServlet'">クイズ一覧</button>
    <button onclick="location.href='QuizTryServlet?quizId=<%=q.getQuizId()+1 %>'">次の問題</button>
  </div>


  <h2 id="ex-title">解説</h2>
  <hr>
  <br>
  <div id="explanation">
  <%=q.getExplanation() %>
  </div>

</div>
</body>
</html>