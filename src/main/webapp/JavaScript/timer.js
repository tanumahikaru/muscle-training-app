/**
 * 
 */
 
 //１つ前のページに戻る
function goBack() {
	window.history.back();
}


//初期値の設定
let startTime = 0;
let timerInterval = null;

//開始ボタンの動作の設定
document.getElementById("start-button").addEventListener("click", function() {
  if (timerInterval) return;
  startTime = Date.now();
  timerInterval = setInterval(updateTime, 10); // 10ミリ秒ごとに更新
});

//停止ボタンの動作の設定
document.getElementById("stop-button").addEventListener("click", function() {
  clearInterval(timerInterval);
  timerInterval = null;
});

//リセットボタンの動作の設定
document.getElementById("reset-button").addEventListener("click", function() {
  clearInterval(timerInterval);
  timerInterval = null;
  document.getElementById("time-display").innerText = "00:00.00";
  startTime = 0;
});

function updateTime() {
  const currentTime = Date.now();
  const timeElapsed = new Date(currentTime - startTime);

  const minutes = timeElapsed.getUTCMinutes().toString().padStart(2, '0');
  const seconds = timeElapsed.getSeconds().toString().padStart(2, '0');
  // ミリ秒の上位2桁を取得
  const milliseconds = Math.floor(timeElapsed.getMilliseconds() / 10).toString().padStart(2, '0');

  document.getElementById("time-display").innerText = `${minutes}:${seconds}.${milliseconds}`;
}

//要素の取得
let numbers = document.querySelectorAll('.number');
let plusBtns = document.querySelectorAll('.plus');
let minusBtns = document.querySelectorAll('.minus');

//＋ボタンのイベント設定
plusBtns.forEach((plusBtn, index) => {
  plusBtn.addEventListener('click', () => {
    numbers[index].stepUp();
  });
});

//－ボタンのイベント設定
minusBtns.forEach((minusBtn, index) => {
  minusBtn.addEventListener('click', () => {
    numbers[index].stepDown();
  });
});
