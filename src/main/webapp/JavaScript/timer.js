window.onload = function() {
  // タイマー関連の変数
  let timerIntervals = [];  // タイマーのインターバルを格納する配列
  let startTimes = [];  // 開始時間を格納する配列

  // 各セットのボタンとタイマーの要素を取得
  const startButtons = document.querySelectorAll('.start-button');
  const stopButtons = document.querySelectorAll('.stop-button');
  const resetButtons = document.querySelectorAll('.reset-button');
  const timeDisplays = document.querySelectorAll('.time-display');
  const numbers = document.querySelectorAll('.number');
  const minusButtons = document.querySelectorAll('.minus');
  const plusButtons = document.querySelectorAll('.plus');

  // 開始ボタンのクリックイベント
  startButtons.forEach((startButton, index) => {
      startButton.addEventListener('click', () => {
          if (timerIntervals[index]) return;  // タイマーが既に動いていれば何もしない
          startTimes[index] = Date.now();
          timerIntervals[index] = setInterval(() => updateTime(index), 10);  // 10ミリ秒ごとに更新
      });
  });

  // －ボタンのクリックイベント
  minusButtons.forEach((minusButton, index) => {
      minusButton.addEventListener('click', () => {
          numbers[index].stepDown();
      });
  });

  // ＋ボタンのクリックイベント
  plusButtons.forEach((plusButton, index) => {
      plusButton.addEventListener('click', () => {
          numbers[index].stepUp();
      });
  });

  // リセットボタンのクリックイベント
  resetButtons.forEach((resetButton, index) => {
      resetButton.addEventListener('click', () => {
          clearInterval(timerIntervals[index]);
          timerIntervals[index] = null;
          timeDisplays[index].innerText = "00:00.00";
          startTimes[index] = 0;
      });
  });

  // 停止ボタンのクリックイベント
  stopButtons.forEach((stopButton, index) => {
      stopButton.addEventListener('click', () => {
          clearInterval(timerIntervals[index]);
          timerIntervals[index] = null;

          // タイマーの値をフォームに設定
          const timerValue = timeDisplays[index].innerText;
          document.getElementById(`timer${index + 1}`).querySelector(".number").value = timerValue;
      });
  });

  // 時間更新の関数
  function updateTime(index) {
      const currentTime = Date.now();
      const timeElapsed = new Date(currentTime - startTimes[index]);

      const minutes = timeElapsed.getUTCMinutes().toString().padStart(2, '0');
      const seconds = timeElapsed.getSeconds().toString().padStart(2, '0');
      const milliseconds = Math.floor(timeElapsed.getMilliseconds() / 10).toString().padStart(2, '0');

      timeDisplays[index].innerText = `${minutes}:${seconds}.${milliseconds}`;
  }
};
