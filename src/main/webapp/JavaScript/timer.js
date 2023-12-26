window.onload = function() {
  // タイマー関連の変数
  let timerIntervals = [];  // タイマーのインターバルを格納する配列
  let startTimes = [];  // 開始時間を格納する配列

  // 各セットのボタンとタイマーの要素を取得
  const startButtons = document.querySelectorAll('.start-button');
  const stopButtons = document.querySelectorAll('.stop-button');
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
          
          numbers[index].value = numbers[index].value || 0; // 回数の値が未入力の場合はデフォルトで 0 を表示
      });
  });

  // ＋ボタンのクリックイベント
  plusButtons.forEach((plusButton, index) => {
      plusButton.addEventListener('click', () => {
          numbers[index].stepUp();
          
          numbers[index].value = numbers[index].value || 0; // 回数の値が未入力の場合はデフォルトで 0 を表示
      });
  });


  // 停止ボタンのクリックイベント
  stopButtons.forEach((stopButton, index) => {
      stopButton.addEventListener('click', () => {
          clearInterval(timerIntervals[index]);
          timerIntervals[index] = null;

          // タイマーの値をフォームに設定
          const timerValue = timeDisplays[index].innerText;
          
           // 回数の値をフォームに設定
          numbers[index].value = numbers[index].value || 0;
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
      numbers[index].value = numbers[index].value || 0;  // 回数の値が未入力の場合はデフォルトで 0 を表示
  }
};
