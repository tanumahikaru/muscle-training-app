<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>記録</title>
    
    <link rel="stylesheet" href="css/user-log.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
    <style>
        #calorieGraph {
            display: block;
            margin: 0 auto; /* 水平方向に中央に配置 */
        }
    </style>
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
<main>
<!-- グラフ描画のための canvas 要素を追加 -->
<div style="margin-top: 100px;">
    <canvas id="calorieGraph" width="800" height="370"></canvas>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 過去2週間の日付を計算
    var today = new Date();
    var pastTwoWeeks = [];
    for (var i = 13; i >= 0; i--) {
        var date = new Date(today);
        date.setDate(today.getDate() - i);
        pastTwoWeeks.push(date.toISOString().split('T')[0]);
    }

    var trainingData = {
        labels: pastTwoWeeks,
        datasets: [{
            label: '摂取カロリー',
            data: [2345, 2012, 2198, 1825, 2276, 2026, 1956, 2234, 2339, 1833, 2134, 2445, 1978, 2299],
            backgroundColor: 'rgba(33, 187, 504, 0.7)',
            borderColor: 'rgba(33, 187, 204, 1)',
            borderWidth: 1,
            type: 'bar'
        }, {
            label: '消費カロリー',
            data: [-2239, -1987, -2401, -1876, -2130, -2290, -2045, -2433, -1950, -2365, -1812, -2178, -2489, -1989],
            backgroundColor: 'rgba(255, 87, 51, 0.7)',
            borderColor: 'rgba(255, 87, 51, 1)',
            borderWidth: 1,
            type: 'bar'
        }, {
            label: 'カロリー差分',
            data: [106, 25, -203, -51, 146, -264, -89, -199, 389, -532, 322, 267, -511, 388],
            fill: false,
            backgroundColor: '#4CAF50',
            borderColor: '#4CAF50',
            borderWidth: 2,
            pointRadius: 4,
            yAxisID: 'calorieSum',
            type: 'line' // 折れ線グラフに変更
        }]
    };

    var ctx = document.getElementById('calorieGraph').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: trainingData,
        options: {
            responsive: false,
            layout: {
                padding: {
                    left: 60,
                    top: 10,
                    right: 10,
                }
            },
            scales: {
                xAxes: [{
                    type: 'category',
                    labels: ['日付'].concat(trainingData.labels)
                }],
                yAxes: [{
                    id: 'calorieSum',
                    type: 'linear',
                    position: 'right',
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
});

</script>
    <div class="button-group">
        <form action="TrainingLogServlet" method="post">
            <button type="submit" class="training_records">トレーニング記録</button>
        </form>
        <div class="space"></div> <!-- ここにスペースを追加 -->
        <form action="RecipeLogServlet" method="post">
            <button type="submit" class="meal_records">食事記録</button>
        </form>
    </div>
    <div class="button-group center-button">
        <form action="TopServlet" method="post">
            <button class="top-button">TOP</button>
        </form>
    </div>	
</main>
    <script src="./JavaScript/home.js"></script>
</body>
</html>