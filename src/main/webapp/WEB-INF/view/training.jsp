<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="dto.ExplanationDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/training.css">
    <title>フリートレーニング</title>
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
		MuscleDTO training = (MuscleDTO) request.getAttribute("training");
	%>
	
	
    <form action="FreeTrainingResultServlet" method="post" id="form">
        <button class="breakBtn">中断</button>

	<h1 class="titile"><%=training.getEvent_name()%></h1>
	
        <!-- タイマーの値を送信するhiddenフィールドを追加 -->
        <input type="hidden" name="timerValue1" id="hiddenTimerValue1">
        <input type="hidden" name="timerValue2" id="hiddenTimerValue2">
        <input type="hidden" name="timerValue3" id="hiddenTimerValue3">

        <div class="set" id="set1">
            1セット目:
            <div id="timer1">
                <div class="time-display">00:00:00</div>
                <button type="button" class="start-button">開始</button>
                <button type="button" class="stop-button">停止</button>
                <button type="button" class="minus">ー</button>
                <input type="number" name="numberSet1" class="number" min="0">
                <button type="button" class="plus">＋</button>
            </div>
        </div>

        <div class="set" id="set2">
            2セット目:
            <div id="timer2">
                <div class="time-display">00:00:00</div>
                <button type="button" class="start-button">開始</button>
                <button type="button" class="stop-button">停止</button>
                <button type="button" class="minus">ー</button>
                <input type="number" name="numberSet2" class="number" min="0">
                <button type="button" class="plus">＋</button>
            </div>
        </div>

        <div class="set" id="set3">
            3セット目:
            <div id="timer3">
                <div class="time-display">00:00:00</div>
                <button type="button" class="start-button">開始</button>
                <button type="button" class="stop-button">停止</button>
                <button type="button" class="minus">ー</button>
                <input type="number" name="numberSet3" class="number" min="0">
                <button type="button" class="plus">＋</button>
            </div>
        </div>

        <button type="button" class="recordBtn" onclick="recordTraining()">記録</button><br>
    </form>

    <form action="FreeTrainingServlet" method="post">
        <button type="submit" class="backBtn">戻る</button>
    </form>

    <h3>やり方</h3>

    <hr>
	
	 <%
        List<ExplanationDTO> ex = (ArrayList< ExplanationDTO>)request.getAttribute("explanation");
        for( ExplanationDTO e : ex) {
     %>
	<div class="explanation">
	    <p>step:<%=e.getStep() %></p>
	    <p><%=e.getExplanation() %></p>
	</div>
	<%} %>
    <script src="./JavaScript/home.js"></script>
    <script src="./JavaScript/timer.js"></script>
    <script>
    function recordTraining() {
    	 var numberSet1 = document.getElementById("timer1").querySelector("input").value || 0;
    	 var numberSet2 = document.getElementById("timer2").querySelector("input").value || 0;
    	 var numberSet3 = document.getElementById("timer3").querySelector("input").value || 0;
    	        

        // 時間の値を数値に変換
        var timerValue1 = convertTimeToNumber(document.getElementById("timer1").querySelector(".time-display").innerText);
        var timerValue2 = convertTimeToNumber(document.getElementById("timer2").querySelector(".time-display").innerText);
        var timerValue3 = convertTimeToNumber(document.getElementById("timer3").querySelector(".time-display").innerText);

        // hiddenフィールドにタイマーの値を設定
        document.getElementById("hiddenTimerValue1").value = timerValue1;
        document.getElementById("hiddenTimerValue2").value = timerValue2;
        document.getElementById("hiddenTimerValue3").value = timerValue3;

        // 各セットの回数の値を設定
        document.getElementById("form").querySelector("input[name='numberSet1']").value = numberSet1;
        document.getElementById("form").querySelector("input[name='numberSet2']").value = numberSet2;
        document.getElementById("form").querySelector("input[name='numberSet3']").value = numberSet3;

        // フォームを送信
        document.getElementById("form").submit();
    }

    function convertTimeToNumber(timeString) {
        const timeArray = timeString.split(':');
        const hours = parseInt(timeArray[0]);
        const minutes = parseInt(timeArray[1]);
        const seconds = parseInt(timeArray[2] || 0);  // 秒の部分は整数として取得。ない場合は0とする

        const totalSeconds = hours * 3600 + minutes * 60 + seconds;
        const totalTimeInHours = totalSeconds / 3600;
        const totalTimeInHoursWithDecimals = totalTimeInHours.toFixed(2);

        return parseFloat(totalTimeInHoursWithDecimals);
    }
    </script>
</body>
</html>
