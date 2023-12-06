<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン画面</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style2.css">
<link rel="stylesheet" href="css/login.css">
</head>
<body>

	<header>
		<div id="header-title">筋トレ</div>
		<div id="header-contents">
			<!--  ヘッダーの右側に入るモノを入れる  -->
		</div>
	</header>

	<%
	request.setCharacterEncoding("UTF-8");
	%>
	<div id="main-contents">
		<form action="LoginServlet" method="post" id="login-form">

			<div id="input-area">
				<label>メールアドレス</label> <input type="text" name="mail"
					placeholder="E-mail"
					value="<%=(request.getParameter("mail") != null) ? request.getParameter("mail") : ""%>"><br>

				<label>パスワード<span class="input-format">※半角英数字8~16文字</span></label><br>
				<div class="password-container">
					<input type="password" name="pw" id="password-input">
					<button type="button" id="toggle-password"
						style="font-family: 'Font Awesome 6 Free Solid';"></button>
				</div>
			</div>

			<button type="submit">ログイン</button>
			<br> <a href="RegisterFormServlet" class="small-link">新規アカウント登録はこちら</a>
			<a href="LinkSendFormServlet" class="small-link">パスワード変更はこちら</a>

		</form>
	</div>

	<script src="JavaScript/password.js"></script>
</body>
</html>