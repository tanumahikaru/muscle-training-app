<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>新規登録画面</title>
<link rel="stylesheet" href="css/style.css">
</head>

<body>
<div class="header-banner">
        <h1>筋トレ</h1>
    </div>
  <div class="signup-container">
  あとで修正
    <header>
      <h1>新規登録</h1>
    </header>
    <form class="signup-form">
      <div class="form-group">
        <label for="username">ニックネーム</label>
        <input type="text" id="username" name="username">
      </div>
      <div class="form-group">
        <label>性別</label>
        <input type="radio" id="male" name="gender" value="male">
        <label for="male">男性</label>
        <input type="radio" id="female" name="gender" value="female">
        <label for="female">女性</label>
      </div>
      <div class="form-group">
        <label for="birthdate">生年月日</label>
        <input type="date" id="birthdate" name="birthdate">
      </div>
      <div class="form-group">
        <label for="height">身長</label>
        <input type="number" id="height" name="height" placeholder="cm">
      </div>
      <div class="form-group">
        <label for="weight">体重</label>
        <input type="number" id="weight" name="weight" placeholder="kg">
      </div>
      <div class="form-group">
        <label for="email">メールアドレス</label>
        <input type="email" id="email" name="email">
      </div>
      <div class="form-group">
        <label for="password">パスワード *</label>
        <input type="password" id="password" name="password">
        <span class="hint">半角英数字8〜16文字</span>
      </div>
      <div class="form-group">
        <button type="submit" class="signup-button">確認</button>
      </div>
    </form>
  </div>
  
</body>
</html>
