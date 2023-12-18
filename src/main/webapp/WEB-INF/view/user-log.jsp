<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>記録</title>
    
    <link rel="stylesheet" href="css/user-log.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/training-suggestion.css">
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
        <div class="right">
            <div id="user-level">Lv.13
                <img src="user.png" alt="ユーザー画像">
            </div>
        </div>
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
    <div style="margin-top: 150px;">
        <canvas id="calorieGraph" width="800" height="400"></canvas>
    </div>

   <script>
   document.addEventListener("DOMContentLoaded", function () {
	    var trainingData = {
	        labels: ['2023-01-01', '2023-01-02', '2023-01-03', '2023-01-04', '2023-01-01', '2023-01-02', '2023-01-03', '2023-01-04', '2023-01-01', '2023-01-02', '2023-01-03', '2023-01-04', '2023-01-03', '2023-01-04'],
	        datasets: [{
	            label: '回数',
	            data: [5, 8, 3, 10, 6, 12, 4, 9, 7, 11, 8, 5, 10, 6],
	            backgroundColor: ['#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC'],
	            borderColor: ['#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC', '#21BC'],
	            borderWidth: 1
	        }, {
	            label: '別のデータ',
	            data: [-8, -4, -6, -9, -5, -11, -7, -10, -8, -3, -12, -6, -9, -7],
	            backgroundColor: ['#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733'],
	            borderColor: ['#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733', '#FF5733'],
	            borderWidth: 1,
	            yAxisID: 'y-axis-1'
	        }]
	    };

	    // 別のデータの数値だけを絶対値に変換
	    trainingData.datasets[1].data = trainingData.datasets[1].data.map(Math.abs);

	    var ctx = document.getElementById('calorieGraph').getContext('2d');
	    var myChart = new Chart(ctx, {
	        type: 'bar',
	        data: trainingData,
	        options: {
	            responsive: false,
	            layout: {
	                padding: {
	                    left: 110,
	                    top: 10,
	                    right: 10,
	                    bottom: 150
	                }
	            },
	            scales: {
	                xAxes: [{
	                    type: 'category',
	                    labels: ['日付'].concat(trainingData.labels)
	                }],
	                yAxes: [{
	                    ticks: {
	                        beginAtZero: false,
	                    },
	                    position: 'right'
	                }, {
	                    id: 'y-axis-1',
	                    ticks: {
	                        beginAtZero: false,
	                    },
	                    position: 'left'
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
            <button type="submit">トレーニング記録</button>
        </form>
        <div class="space"></div> <!-- ここにスペースを追加 -->
        <form action="RecipeServlet" method="post">
            <button>食事記録</button>
        </form>
    </div>
    <div class="button-group center-button">
        <form action="TopServlet" method="post">
            <button class="start-button">TOP</button>
        </form>
    </div>	
</main>
</body>
</html>
