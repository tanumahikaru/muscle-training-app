<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/password-change.css">
<title>パスワード変更</title>
</head>
<body>
  <div class="header-banner">
   	<h1>筋トレ</h1>
  </div>
  <div class="box">
	  <h2 class="PasswordChange">パスワード変更</h2>
	  <form action="PasswordChangeConfirmServlet" method="post">
	  	<p>メールアドレス</p><br>
	  	<input type="text" name="mail" class="mail"><br>
	  	<input type="submit" value="送信" class="send">
	  </form>
        <button type="button" class="signup-button" onclick="goBack()">戻る</button>
  </div>
</body>
</html>