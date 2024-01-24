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
    flex-direction: column;
    align-items: flex-end;
    margin-left: 1200px;
  }
  .info-text {
    display: flex;
    align-items: center;
  }
  .info-text p {
    margin: 0;
  }
  .graph-container {
    display: flex;
    flex-direction: column;
    align-items: center; /* グラフを中央に配置 */
    margin-left: -230px;
    margin-top: 0px;
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
   <div class="graph-container">
    <div class="info-container">
      <div class="info-text">
        <p>摂取カロリー：<%= session.getAttribute("totalCalorieIntake") %>kcal</p>
      </div>
      <div class="info-text">
        <p>消費カロリー：<%= session.getAttribute("totalCaloriesConsumed") %>kcal</p>
      </div>
    </div>
    <canvas id="calorieLineChart" width="1000" height="400"></canvas>
  </div>
  <!-- 体重記録フォーム -->
  <div class="down" style="text-align:center;">
    <form action="RegisterWeightServlet" method="post" style="text-align:center;">
      今日の体重を記録：<input type="text" name="weight" placeholder="体重を入力してください" style="text-align:center;"><br>
      <input type="submit" class="recordBtn" value="記録">
    </form>
  </div>
  <script src="./JavaScript/home.js"></script>
  <%
    List<Double> weightData = (List<Double>)request.getAttribute("weightData");
  %>
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      // グラフのデータ
      var labels = [];
      // 今日を中心に後ろ10日間分の日付を取得
      for (var i = 1; i <= 8; i++) {
          labels.push(" " + i + "回目");
      }
      console.log("Labels: ", labels); // デバッグステートメント
      var weightData = [
    	    <%
    	        if (weightData != null) {
    	            for (int i = 0; i < weightData.size(); i++) {
    	    %>
    	                <%= weightData.get(i) %>,
    	    <%
    	            }
    	        } else {
    	            for (int i = 0; i < 9; i++) {
    	    %>
    	                0,
    	    <%
    	            }
    	        }
    	    %>
    	];
      console.log("Weight Data: ", weightData); // デバッグステートメント
      var calorieData = {
        labels: labels,
        datasets: [{
          label: 'あなたの体重（kg）',
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
    x: {
      type: 'category',
      labels: calorieData.labels,
      title: {
        display: true,
        text: '測定日（回）'
      },
      maxRotation: 90,  // ラベルを最大90度回転
      minRotation: 90   // ラベルを最小90度回転
    },
    y: {
      beginAtZero: true,
      title: {
        display: true,
        text: '摂取カロリー (kg)'
      },
      ticks: {
        callback: function(value, index, values) {
          return value + ' kg';
        }
      }
    }
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
