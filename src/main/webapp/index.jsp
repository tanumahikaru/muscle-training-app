<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/index.css">
<title>ログイン画面</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		if(request.getParameter("error") != null){	
	%>
	<p style="color:red">ログイン失敗</p>
	<p>○○図書館</p><br>
	<div class="box3">
	<form action="LoginServlet" method="post">
		<input type="text" name="mail" placeholder="E-mail" value="<%=request.getParameter("mail") %>"><br>
		<input type="password" name="pw" placeholder="password"><br>
		<input type="submit" value="SIGN-IN">
	</form>

	<a href="RegisterFormServlet">新規登録</a><br>
	<a href="ForgetPasswordFormServlet">パスワードを忘れた方はこちらから</a>
  	</div>
    
	<%
		} else {
	%>
	<p>○○図書館</p><br>
	<div class="box3">
	<form action="LoginServlet" method="post">
		<input type="text" name="mail" placeholder="E-mail" required><br>
		<input type="password" name="pw" placeholder="password" required><br>
		<input type="submit" value="SIGN-IN" class="hoge">
	</form>
	<a href="RegisterFormServlet">新規登録</a><br>
	<a href="ForgetPasswordFormServlet">パスワードを忘れた方はこちらから</a>
</div>
	<%
		}
	%>
</body>
</html>