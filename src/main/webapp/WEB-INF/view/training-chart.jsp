<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
    <div>
        <p><%= ((MuscleDTO)request.getAttribute("training")).getEvent_name() %>の記録</p>
        <%-- 他に表示したいトレーニングデータがあれば適宜追加 --%>
    </div>

    <div class="chart-container"> <%-- グラフとサマリーを包むコンテナ --%>
        <canvas id="myChart" width="750" height="400"></canvas>

        <div class="training-summary">
            <p>合計回数: <span id="totalReps"></span></p>
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

        // グラフ描画のためのデータ
        var trainingData = {
            labels: ['2023-01-01', '2023-01-02', '2023-01-03', '2023-01-04'], // 日付を表示
            datasets: [{
                label: '回数', // ラベル
                data: [5, 8, 3, 10], // 各日ごとの回数のデータ
                backgroundColor: ['#21BC', '#21BC', '#21BC', '#21BC'], // 棒グラフの色
                borderColor: ['#21BC', '#21BC', '#21BC', '#21BC'], // 棒の境界線の色
                borderWidth: 1 // 棒の境界線の太さ
            }]
        };

        // グラフを描画
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
                        labels: ['日付'].concat(trainingData.labels) // 日付を最初に追加
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
    </script>
    <script src="./JavaScript/home.js"></script>
</body>
</html>
