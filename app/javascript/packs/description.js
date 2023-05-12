const sessionKey = "accessed";
const sessionValue = true;

//sessionStorageにsessionKeyというデータの有無を判別
if (!sessionStorage.getItem(sessionKey)) {
  //初回アクセス時の処理
  document.getElementById("modal").style.display = "block";
  document.querySelector(".c-btn").addEventListener("click", () => {
    document.getElementById("modal").style.display = "none";
    //sessionStorageにデータを追加
    sessionStorage.setItem(sessionKey, sessionValue);
  });

  document.querySelector(".sessionStore").addEventListener("click", () => {
    document.getElementById("modal").style.display = "none";
    //sessionStorageにデータを追加
    sessionStorage.setItem(sessionKey, sessionValue);
  });
}