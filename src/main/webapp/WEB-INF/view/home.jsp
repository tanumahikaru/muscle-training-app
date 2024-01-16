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

  <canvas id="calorieLineChart" width="1000" height="400"></canvas>

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
  <%
    List<Double> weightData = (List<Double>) request.getAttribute("weightData");
  %>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // グラフのデータ
      var today = new Date();
      var oneWeekAgo = new Date(today);
      oneWeekAgo.setDate(today.getDate() - 7);

      var labels = [];
      for (var i = 8; i >= 0; i--) { // 今日を中心に後ろ10日間分の日付を取得
          var date = new Date(today);
          date.setDate(today.getDate() - i);
          labels.push(date.toLocaleDateString());
      }
      console.log("Labels: ", labels); // デバッグステートメント

      var weightData = [
        <%= weightData != null && weightData.size() > 0 ? weightData.get(1) : 0 %>,
        <%= weightData != null && weightData.size() > 1 ? weightData.get(2) : 0 %>,
        <%= weightData != null && weightData.size() > 2 ? weightData.get(3) : 0 %>,
        <%= weightData != null && weightData.size() > 3 ? weightData.get(4) : 0 %>,
        <%= weightData != null && weightData.size() > 4 ? weightData.get(5) : 0 %>,
        <%= weightData != null && weightData.size() > 5 ? weightData.get(10) : 0 %>,
        <%= weightData != null && weightData.size() > 6 ? weightData.get(11) : 0 %>,
        <%= weightData != null && weightData.size() > 7 ? weightData.get(12) : 0 %>,
        <%= weightData != null && weightData.size() > 8 ? weightData.get(15) : 0 %>        
      ];

      console.log("Weight Data: ", weightData); // デバッグステートメント

      var calorieData = {
        labels: labels,
        datasets: [{
          label: 'あなたの体重',
          data: weightData,
          fill: false,
          borderColor: 'blue',
          borderWidth: 2,
        }]
      };

      console.log("Calorie Data: ", calorieData); // デバッグステートメント

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