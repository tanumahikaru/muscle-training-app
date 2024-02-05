<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="dto.MuscleRecord" %>
<%@ page import="dao.MuscleRecordDAO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/training-chart.css">
    <title>トレーニングチャート</title>
    <!-- Chart.jsのCDNを追加 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
    <%-- サーブレットから受け取ったトレーニングデータを表示 --%>
    <%
        MuscleDTO training = (MuscleDTO) request.getAttribute("training2");
    %>
    
    <h1 class="record_title"><%=training.getEvent_name() %>の記録</h1>
    
    <div class="chart-container"> <%-- グラフとサマリーを包むコンテナ --%>
        <canvas id="myChart" width="750" height="400"></canvas>
        <div class="training-summary">
        <div class="info-text">
            <p>合計回数：<%= request.getAttribute("totalNumber") %></p>
            <p>合計セット数: <%=request.getAttribute("totalSetNumber") %><span id="totalSets"></span></p>
            <p>平均回数: <%=request.getAttribute("avgNumber") %> <span id="avgReps"></span></p>
            <p>MAX: <%=request.getAttribute("maxNumber") %><span id="maxReps"></span></p>
            <p>MIN: <%=request.getAttribute("minNumber") %><span id="minReps"></span></p>
            <p>消費カロリー: <%=request.getAttribute("totalCalories_burned") %> <span id="calories"></span> kcal</p>
        </div>
        </div>
    </div>
    <div class="centered-link-container">
        <a href="TrainingLogServlet" class="back">戻る</a>
    </div>
    <%
        // 今日の日付を取得
        java.time.LocalDate today = java.time.LocalDate.now();
        // 過去5日分の日付を生成
        java.util.List<String> dateLabels = new java.util.ArrayList<>();
		for (int i = 0; i < 5; i++) {
    		dateLabels.add(today.plusDays(i).toString());
		}
        // リクエストから回数のデータを取得
        int totalNumber = (int) request.getAttribute("todaystotalNumber");
        List<Integer> totalNumberList = new java.util.ArrayList<>();
        totalNumberList.add(totalNumber);
    %>
   <script>
    // グラフ描画のためのデータ
    var trainingData = {
        labels: [
            <%-- 生成した日付をJavaScriptの形式で出力 --%>
            <% for (int i = dateLabels.size() - 1; i >= 0; i--) { %>
                '<%= dateLabels.get(i) %>',
            <% } %>
        ],
        datasets: [{
            label: '回数', // ラベル
            data: [
                <%-- 合計回数のデータを出力 --%>
                <% for (int i = 0; i < totalNumberList.size(); i++) { %>
                    <%= totalNumberList.get(i) %>,
                <% } %>
            ],
            backgroundColor: ['#21BC', '#21BC', '#21BC', '#21BC', '#21BC'], // 棒グラフの色
            borderColor: ['#21BC', '#21BC', '#21BC', '#21BC', '#21BC'], // 棒の境界線の色
            borderWidth: 1, // 棒の境界線の太さ
            datalabels: {
                align: 'end', // データラベルを棒グラフの右端に配置
                anchor: 'end', // データラベルを棒グラフの右上に配置
                display: true // データラベルを表示
            }
        }]
    };

    // グラフを描画
    document.addEventListener("DOMContentLoaded", function () {
        var ctx = document.getElementById('myChart').getContext('2d');
        var myChart = new Chart(ctx, {
            type: 'bar', // 棒グラフを指定
            data: trainingData,
            options: {
                responsive: false, // グラフのサイズを固定
                layout: {
                    padding: {
                        left: 110, // 左
                    }
                },
                scales: {
                    xAxes: [{
                        type: 'category', // 横軸のスケールをカテゴリに設定
                        labels: trainingData.labels.reverse(), // 日付を逆順に追加
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true // 縦軸のスケールを0から始める
                        }
                    }]
                },
                plugins: {
                    // 背景色のプラグイン
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
    });
</script>
   
    <script src="./JavaScript/home.js"></script>
</body>
</html>
