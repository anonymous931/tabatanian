/* 変数定義 */
const startBtn = document.getElementById('startBtn');
const stopBtn = document.getElementById('stopBtn');
const cancelBtn = document.getElementById('cancelBtn');
const dropDown1 = document.getElementById('dropdownMenu1');
const dropDown2 = document.getElementById('dropdownMenu2');
const dropDown3 = document.getElementById('dropdownMenu3');
const work_count = document.getElementById('work_count').value;
const workText = document.getElementById('work');
const timer = document.getElementById('timer');

let startTime;
let timeoutId;
let elapsedTime = 0;
let count;
let set = 0;
let total_work;
let current_work = 0;
let before_work;
let workFlg = false; // true = WORK  ,  false = INTERVAL
let count1 = true;
let count2 = true;
let count3 = true;


// ドロップダウンの項目を変更
$(function () {
  $('.dropdown-menu .dropdown-item').on('click' ,function () {
    var visibleItem = $('.dropdown-toggle', $(this).closest('.dropdown'));
    visibleItem.text($(this).attr('value'));
  });
});

// スタートボタン押下時処理
startBtn.addEventListener('click', () => {
  // page切り替え
  document.getElementById('page1').classList.add("displayNone");
  document.getElementById('page2').classList.remove("displayNone");
  document.getElementById( 'sound-file-decision1' ).load();
  document.getElementById( 'sound-file-decision4' ).load();

  workText.textContent = '準備してください';
  total_work = parseInt(work_count) * parseInt(dropDown3.textContent) * 2;
  if (!document.getElementsByClassName('accordion-button py-4 border bg-info')[0]) {
    document.getElementById("work_list_" + current_work).classList.add("bg-info");
  };
  if (document.getElementById("work_list_" + current_work).classList.contains("collapsed")) {
    document.getElementById("work_list_" + current_work).click();
  };
  startTime = Date.now();
  countDown();
});

// 一時停止ボタン押下時処理
stopBtn.addEventListener('click', () => {
  if (stopBtn.textContent == '一時停止') {
    clearTimeout(timeoutId);
    elapsedTime += startTime - Date.now();
    stopBtn.textContent = 'スタート';
  } else {
    stopBtn.textContent = '一時停止';
    startTime = Date.now();
    countDown();
  }
});

// キャンセルボタン押下時処理
cancelBtn.addEventListener('click', () => {
  // page切り替え
  document.getElementById('page1').classList.remove("displayNone");
  document.getElementById('page2').classList.add("displayNone");

  // 初期化
  count1 = true;
  count2 = true;
  count3 = true;
  elapsedTime = 0;
  current_work = 0;
  set = 0;
  workText.textContent = 'ワークアウト';
  stopBtn.textContent = '一時停止';

  clearTimeout(timeoutId);
  workFlg = false;
  document.getElementsByClassName('accordion-button py-4 border bg-info')[0].classList.remove("bg-info");
});

// カウントダウン用関数
function countDown() {
  if (current_work + set == 0) {
    count = 10000;
  } else if (set == parseInt(dropDown3.textContent)) {
    count = 100;
  } else if (workFlg == true) {
    count = 1000 * parseInt(dropDown1.textContent);
  } else {
    count = 1000 * parseInt(dropDown2.textContent);
  }

  const d = new Date(startTime - Date.now()  + elapsedTime + count);
  const s = String(d.getSeconds()).padStart(2, '0');
  timer.textContent = `${s}`;

  // 残り3秒でカウントダウン音開始
  if (s == '03') {
    if (count3 == true) {
      document.getElementById( 'sound-file-decision1' ).play();
      count3 = false;
    }
  }
  if (s == '02') {
    if (count2 == true) {
      document.getElementById( 'sound-file-decision1' ).play();
      count2 = false;
    }
  }
  if (s == '01') {
    if (count1 == true) {
      document.getElementById( 'sound-file-decision1' ).play();
      count1 = false;
    }
  }

  timeoutId = setTimeout(() => {
    countDown();
  }, 10);

  // カウントが０になった時の処理
  if (s == '00') {
    // 初期化処理
    startTime = Date.now();
    elapsedTime = 0;
    // soundFlg = true;
    count1 = true;
    count2 = true;
    count3 = true;
    // 現在のセット数を1増やす
    current_work ++;
    before_work = current_work - 2;

    // 終了サウンド
    document.getElementById( 'sound-file-decision4' ).play();
    if (set == parseInt(dropDown3.textContent)) {
      // page切り替え
      document.getElementById('page1').classList.remove("displayNone");
      document.getElementById('page2').classList.add("displayNone");

      // 初期化
      document.getElementsByClassName('accordion-button py-4 border bg-info')[0].classList.remove("bg-info");
      elapsedTime = 0;
      current_work = 0;
      set = 0;
      workText.textContent = 'ワークアウト';
      stopBtn.textContent = '一時停止'

      clearTimeout(timeoutId);
      workFlg = false;
    } else if (workFlg == true) {
      workFlg = false;
      workText.textContent = 'インターバル';
      if (current_work >= total_work / parseInt(dropDown3.textContent)) {
        document.getElementById("work_list_" + before_work).classList.remove("bg-info");
        if (!document.getElementById("work_list_" + before_work).classList.contains("collapsed")) {
          document.getElementById("work_list_" + before_work).click();
        }
        current_work = 0;
        document.getElementById("work_list_" + current_work).classList.add("bg-info");
        if (document.getElementById("work_list_" + current_work).classList.contains("collapsed")) {
          document.getElementById("work_list_" + current_work).click();
        }
        set ++;
      } else {
        document.getElementById("work_list_" + before_work).classList.remove("bg-info");
        if (!document.getElementById("work_list_" + before_work).classList.contains("collapsed")) {
          document.getElementById("work_list_" + before_work).click();
        }
        document.getElementById("work_list_" + current_work).classList.add("bg-info");
        if (document.getElementById("work_list_" + current_work).classList.contains("collapsed")) {
          document.getElementById("work_list_" + current_work).click();
        }
      }
    } else {
      workFlg = true;
      workText.textContent = 'ワークアウト';
    }
  }
}