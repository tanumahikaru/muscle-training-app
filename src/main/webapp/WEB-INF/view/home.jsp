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
  .vertical-line {
    border-right: 2px solid #000000; /* 縦線のスタイル */
    margin: 0 auto; /* 左右のマージンを自動で調整 */
  }

  .info-container {
    display: flex;
    justify-content: space-between;
    margin-top: 1px;
  }

  .info-item {
    flex: 1;
    text-align: center;
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
  <div class="vertical-line">
    <canvas id="calorieLineChart" width="900" height="400"></canvas>
 

  <!-- 消費カロリー、クイズ正当数の表示 -->
  <div class="info-container">
    <div class="info-item">
      <p>消費カロリー</p>
      <% MuscleRecord latestRecord = (MuscleRecord)request.getAttribute("latestRecord"); %>
      <% if (latestRecord != null) { %>
        <p><%= latestRecord.getCalories_burned() %></p>
      <% } %>
    </div>

    <div class="info-item">
      <p>摂取カロリー</p>
      <!-- ここに摂取カロリーのデータを表示するコードを追加 -->
    </div>

    <div class="info-item">
      <p>クイズ正答数</p>
      <!-- ここにクイズ正答数のデータを表示するコードを追加 -->
    </div>
  </div>

  <form action="RegisterWeightServlet" method="post" style="text-align:center;">
    今日の体重を記録：<input type="text" name="weight" placeholder="体重を入力してください" style="text-align:center;"><br>
    <input type="submit" value="記録">
  </form>
   </div>

  <script src="./JavaScript/home.js"></script>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // グラフのデータ
      var calorieData = {
        labels: ['日付1', '日付2', '日付3', '日付4', '日付5','日付1', '日付2', '日付3', '日付4', '日付5','日付1', '日付2', '日付3', '日付4', '日付5','日付1', '日付2', '日付3', '日付4', '日付5','日付1', '日付2', '日付3', '日付4', '日付5'],
        datasets: [{
          label: '摂取カロリー',
          data: [30, 10, 0, 50, 30,50, 40, 80, 70, 30,50, 30, 30, 0, 70,30, 70, 30, 10, 80,20, 30, 60, 60, 30,50, 30, 30, 0, 70],
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
            left: 250,
            top: 0,
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