<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="dto.MuscleRecord" %>
<%@ page import="dao.MuscleRecordDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/training-chart.css">    
   	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">5555555555555555555555555555555555 
   
    <title>トレーニングチャート</title>
    <!-- Chart.jsのCDNを追加 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <header>
    <div class="header-banner">
        <button type="button" class="menu-btn">
            <i class="fa fa-bars" aria-hidden="true"></i>
        </button>
        <h1 id="header-title">筋トレ</h1>
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
    </header>
    <%-- サーブレットから受け取ったトレーニングデータを表示 --%>
    <div>
        <p><%= ((MuscleDTO)request.getAttribute("training")).getEvent_name() %>の記録</p>
        <%-- 他に表示したいトレーニングデータがあれば適宜追加 --%>
    </div>

    <div class="chart-container"> <%-- グラフとサマリーを包むコンテナ --%>
        <canvas id="myChart" width="750" height="400"></canvas>

        <div class="training-summary">
		<div class="info-text">
            <p>合計回数：<%= request.getAttribute("totalNumber") %></p>
        </div>
            <p>合計セット数: <span id="totalSets"></span></p>
            <p>一セット当たりの回数(平均): <span id="avgReps"></span></p>
            <p>MAX: <span id="maxReps"></span></p>
            <p>MIN: <span id="minReps"></span></p>
            <p>消費: <span id="calories"></span> kcal</p>
        </div>
    </div>

    <div class="button-group center-button">
        <button type="button" onclick="goBack()">戻る</button>
    </div>

    <script>
    function goBack() {
        window.history.back();
    }

    // 現在の日付を取得
    var today = new Date();
    var formattedDate = today.getFullYear() + '-' + (today.getMonth() + 1).toString().padStart(2, '0') + '-' + today.getDate().toString().padStart(2, '0');

    // labels配列に過去3日分の日付を追加
    var labels = [];
    for (var i = 3; i >= 0; i--) {
        var date = new Date(today);
        date.setDate(today.getDate() - i);
        var formatted = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0');
        labels.push(formatted);
    }

    var trainingData = {
        labels: labels,
        datasets: [{
            label: '回数',
            data: [5, 8, 3, 4], // 適切なデータを設定
            backgroundColor: ['#21BC', '#21BC', '#21BC'],
            borderColor: ['#21BC', '#21BC', '#21BC'],
            borderWidth: 1
        }]
    };

    // グラフを描画
    var ctx = document.getElementById('myChart').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: trainingData,
        options: {
            responsive: false,
            layout: {
                padding: {
                    left: 110
                }
            },
            scales: {
                xAxes: [{
                    type: 'category',
                    labels: ['日付'].concat(trainingData.labels)
                }],
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            },
            plugins: {
                backgroundColorPlugin: {
                    beforeDraw: function (chart) {
                        var ctx = chart.canvas.getContext('2d');
                        ctx.save();
                        ctx.globalCompositeOperation = 'destination-over';
                        ctx.fillStyle = 'white';
                        ctx.fillRect(0, 0, chart.width, chart.height);
                        ctx.restore();
                    }
                }
            }
        }
    });
</script>


    <script src="./JavaScript/home.js"></script>
</body>
</html>
