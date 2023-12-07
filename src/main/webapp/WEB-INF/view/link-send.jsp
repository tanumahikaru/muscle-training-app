<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>パスワード変更</title>
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
		<form action="CodeInputServlet" method="post"  id="link-send-form">
			<h2 style="margin-top: 20px">パスワード変更</h2>
			<div id="input-area">
				<label>メールアドレス</label> <input id=mail type="text" name="mail"
					placeholder="E-mail"
					value="<%=(request.getParameter("mail") != null) ? request.getParameter("mail") : ""%>"><br>
			</div>

			<button type="submit">送信</button>
			<br>
		</form>
		<button id="back-button" onclick="location.href='/'">戻る</button>
	</div>
</body>
</html>