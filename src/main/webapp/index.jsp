<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>ログイン画面</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		if(request.getParameter("error") != null){	
	%>
	<div class="header-banner">
        <h1>筋トレ</h1>
    </div>
	<div class="box3">
	<p style="color:red">ログイン失敗</p>
	<form action="LoginServlet" method="post">
		メールアドレス<input type="text" name="mail" placeholder="E-mail" value="<%= (request.getParameter("mail") != null) ? request.getParameter("mail") : "" %>"><br>
		<div class="password-container">
			パスワード<br>
			半角英数字8~16文字<input type="password" name="pw" class="password-input" placeholder="password">
			 <span class="toggle-password" onclick="togglePasswordVisibility(this)">👁</span>
		</div>	
		<input type="submit" value="ログイン">
	</form>

	<a href="RegisterFormServlet">新規登録</a><br>
	<a href="ForgetPasswordFormServlet">パスワードを忘れた方はこちらから</a>
	</div>

	<%
		} else {
	%>

	<div class="header-banner">
        <h1>筋トレ</h1>
    </div>

	<div class="box3">
	<form action="LoginServlet" method="post">
		メールアドレス<input type="text" name="mail" placeholder="E-mail" value="<%= (request.getParameter("mail") != null) ? request.getParameter("mail") : "" %>"><br>
		<div class="password-container">
			パスワード<br>
			半角英数字8~16文字<input type="password" name="pw" class="password-input" placeholder="password">
			 <span class="toggle-password" onclick="togglePasswordVisibility(this)">👁</span>
		</div>	
		<input type="submit" value="ログイン">
	</form>
	<a href="RegisterFormServlet">新規アカウント登録はこちら</a><br>
	<a href="ForgetPasswordFormServlet">パスワード変更はこちらから.</a>
</div>
	<%
		}
	%>
<script>
function togglePasswordVisibility() {
    var passwordInput = document.querySelector('.password-input');
    passwordInput.type = (passwordInput.type === 'password') ? 'text' : 'password';
}
</script>
</body>
</html>