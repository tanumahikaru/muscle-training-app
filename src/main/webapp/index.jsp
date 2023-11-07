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
    <div class="main">
	<p style="color:red">ログイン失敗</p>
	<div class="box3">
	<form action="LoginServlet" method="post">
		メールアドレス<input type="text" name="mail" placeholder="E-mail" value="<%=request.getParameter("mail") %>"><br>
		<p>パスワード</p><br>
		半角英数字8~16文字<input type="password" name="pw" placeholder="password"><br>
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
		メールアドレス<input type="text" name="mail" placeholder="E-mail" value="<%=request.getParameter("mail") %>"><br>
		パスワード<br>
		半角英数字8~16文字<input type="password" name="pw" placeholder="password"><br>
	</form>
	<a href="RegisterFormServlet">新規アカウント登録はこちら</a><br>
	<a href="ForgetPasswordFormServlet">パスワード変更はこちらから</a>
</div>

	<%
		}
	%>
</body>
</html>