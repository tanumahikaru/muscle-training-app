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
    <link rel="stylesheet" href="css/free-training.css">
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
    
    <form action="SearchTrainingServlet" method="post" class="search-menu">
        <input type="text" name="searchKeyword" placeholder="検索したいメニューを入力してください">
        <input type="submit" value="検索">
    </form>
    <form action="TrainingLogServlet" method="post" id="categoryForm">
        <!-- positionIdをサーバーに送信するフォーム -->
        <input type="hidden" name="positionId" id="positionId" value="" />
    <div class="form-buttons">
        <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
        <button type="button" class="button-outline" onclick="setAndSubmitForm(1)">腕</button>
        <button type="button" class="button-outline" onclick="setAndSubmitForm(2)">背筋</button>
        <button type="button" class="button-outline" onclick="setAndSubmitForm(3)">腹筋</button>
        <button type="button" class="button-outline" onclick="setAndSubmitForm(4)">胸筋</button>
        <button type="button" class="button-outline" onclick="setAndSubmitForm(5)">脚</button>
        <button type="button" class="button-outline" onclick="setAndSubmitForm(6)">肩</button>
        <button type="button" class="button-outline" onclick="setAndSubmitForm(7)">有酸素</button>
    </div>
    </form>
    
    <hr>
    
    <h2><%=request.getAttribute("positionName") %>のメニュー一覧</h2>
    
    <div class="card-container type2">
        <%
            List<MuscleDTO> training = (ArrayList<MuscleDTO>)request.getAttribute("list");
            for(MuscleDTO m : training) {
        %>
        
        <div class="card-body">
        	<figure class="image" style="font-family: 'Font Awesome 6 Free Solid'; font-size: 50px;"></figure>    
            <h2><a href="TrainingChartServlet?id=<%=m.getTraining_event_id() %>"><%=m.getEvent_name() %></a></h2>
            <h1><%=m.getMets() %>Met's</h1>
        </div>
        <%} %>
    </div>
    <div class="centered-link-container">
    	<a href="TopServlet" class="back">戻る</a>
	</div>
     <script src="./JavaScript/home.js"></script>
</body>
</html>