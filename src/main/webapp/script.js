// script.js
document.addEventListener("DOMContentLoaded", function () {
    // グラフを描画するためのデータ
    var intakeCalories = 2000; // 仮の摂取カロリー
    var burnedCalories = 1500; // 仮の消費カロリー

    // グラフを描画する関数
    function drawCalorieGraph() {
        var graphContainer = document.getElementById("calorieGraph");

        // 摂取カロリーバー
        var intakeBar = document.createElement("div");
        intakeBar.className = "bar";
        intakeBar.style.width = (intakeCalories / (intakeCalories + burnedCalories)) * 100 + "%";
        graphContainer.appendChild(intakeBar);

        // 消費カロリーバー
        var burnedBar = document.createElement("div");
        burnedBar.className = "bar";
        burnedBar.style.width = (burnedCalories / (intakeCalories + burnedCalories)) * 100 + "%";
        burnedBar.style.backgroundColor = "#e74c3c"; // 消費カロリーバーの色
        graphContainer.appendChild(burnedBar);
    }
    
    // グラフを描画
    drawCalorieGraph();
});
