<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <title>フリートレーニング一覧</title>
    <script>
        function setAndSubmitForm(positionId) {
            document.getElementById("positionId").value = positionId;
            document.forms["categoryForm"].submit();
        }
    </script>
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
    
    <form action="SearchTrainingServlet" method="post">
        <input type="text" name="searchKeyword" placeholder="検索したいメニューを入力してください">
        <input type="submit" value="検索">
    </form>
    <form action="FreeTrainingServlet" method="post" id="categoryForm">
        <!-- positionIdをサーバーに送信するフォーム -->
        <input type="hidden" name="positionId" id="positionId" value="" />
        
        <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
        <button type="button" onclick="setAndSubmitForm(1)">腕</button>
        <button type="button" onclick="setAndSubmitForm(2)">背筋</button>
        <button type="button" onclick="setAndSubmitForm(3)">腹筋</button>
        <button type="button" onclick="setAndSubmitForm(4)">胸筋</button>
        <button type="button" onclick="setAndSubmitForm(5)">脚</button>
        <button type="button" onclick="setAndSubmitForm(6)">肩</button>
        <button type="button" onclick="setAndSubmitForm(7)">有酸素</button>
    </form>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>種目名</th>
            <th>Met's</th>
        </tr>
        <%
            List<MuscleDTO> training = (ArrayList<MuscleDTO>)request.getAttribute("list");
            for(MuscleDTO m : training) {
        %>
        <tr>
            <td><%=m.getTraining_event_id() %></td>
            <td><%=m.getEvent_name() %></td>
            <td><%=m.getMets() %></td>
        </tr>
        <%} %>
    </table>
    <a href="TopServlet">戻る</a>
     <script src="./JavaScript/home.js"></script>
</body>
</html>