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
  .info-container {
    display: flex;
    justify-content: space-between;
    margin-top: 1px;
  }

  .info-item {
    flex: 5;
    text-align: center;
  }

  .info-text {
    margin-left: 50px;
    margin: 10px; /* 適切なマージンに調整 */
    display: flex; /* フレックスボックスを使用して子要素を横に配置 */
    align-items: center; /* 子要素を垂直方向に中央に配置 */
    border-left: 2px solid #000000; /* 縦線のスタイル */
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

  <canvas id="calorieLineChart" width="900" height="400"></canvas>

  <div class="info-text">
    <p>摂取カロリー： <%= session.getAttribute("totalCalorieIntake") %>kcal</p><br>
  </div>
  <div class="info-text">
    <p>消費カロリー：<%= session.getAttribute("totalCaloriesConsumed") %>kcal</p><br>
  </div>

<!-- 体重記録フォーム -->
<div class="down" style="text-align:center;">
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