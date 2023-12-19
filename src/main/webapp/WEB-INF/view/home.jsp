<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="dto.MuscleRecord" %>
<%@ page import="dao.MuscleRecordDAO" %>
<%@ page import="dto.UserDTO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width">
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="css/style.css">
  <link rel="stylesheet" href="css/training_suggestion.css">
  <link rel="stylesheet" href="css/home.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
  <title>TOP</title>
  <style>

    .graph-container {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
    }

    .graph-info {
      text-align: right;
    }

    .graph-info p {
      margin: 0;
    }

    .graph-divider {
      border-right: 1px solid #ccc;
      height: 100%;
      margin-right: 20px; /* 必要に応じて調整してください */
    }
  </style>
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

  <!-- 折れ線グラフの描画領域 -->
  <canvas id="calorieLineChart" width="400" height="200"></canvas>

  <!-- 消費カロリーの表示 ... -->
  <% MuscleRecord latestRecord = (MuscleRecord)request.getAttribute("latestRecord"); %>
  <% if (latestRecord != null) { %>
    <p>calories_burned: <%= latestRecord.getCalories_burned() %></p>
  <% } %>

  <form action="RegisterWeightServlet" method="post">
    今日の体重を記録：<input type="text" name="weight" placeholder="体重を入力してください"><br>
    <input type="submit" value="記録">
  </form>

  <hr class="graph-divider"> <!-- 新しい水平線 -->
  
  <div class="graph-container">
    <!-- 折れ線グラフの描画領域 -->
    <canvas id="calorieLineChart" width="400" height="200"></canvas>

      <div>
        <p>摂取カロリー</p>
      </div>
      <div>
        <p>消費カロリー</p>
      </div>
      <div>
        <p>クイズ正答数</p>
      </div>
    </div>
 <script src="./JavaScript/home.js"></script>
 <script>
    document.addEventListener("DOMContentLoaded", function () {
      // グラフのデータ
      var calorieData = {
        labels: ['日付1', '日付2', '日付3', '日付4', '日付5'],
        datasets: [{
          label: '摂取カロリー',
          data: [30, 30, 30, 30, 30],
          fill: false,
          borderColor: 'blue',
          borderWidth: 2,
          pointRadius: 4
        }]
      };

      // グラフ描画のためのCanvas要素
      var ctx = document.getElementById('calorieLineChart').getContext('2d');

      // グラフのオプション
      var options = {
        responsive: false,
        layout: {
          padding: {
            left: 10,
            right: 10,
            top: 10,
            bottom: 10
          }
        },
        scales: {
          xAxes: [{
            type: 'category',
            labels: calorieData.labels,
            scaleLabel: {
              display: true,
              labelString: '日付'
            }
          }],
          yAxes: [{
            ticks: {
              beginAtZero: true
            },
            scaleLabel: {
              display: true,
              labelString: '摂取カロリー'
            }
          }]
        }
      };

      // 折れ線グラフの描画
      var lineChart = new Chart(ctx, {
        type: 'line',
        data: calorieData,
        options: options
      });
    });
  </script>
   

</body>
</html>