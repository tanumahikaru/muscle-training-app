<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.UserDTO" %>
<%@ page import="dto.WeightDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/register-user-confirm.css">
<script>
    function goBack() {
        window.history.back();
    }
</script>
<title>登録内容確認</title>
<script>
    function goBack() {
        window.history.back();
    }
</script>
</head>
<body>
	 <div class="header-banner">
        <h1 style="color: white;">筋トレ</h1>
    </div>
	<div class="box3">
	<p>下記の内容で登録します。よろしいですか？</p>
	<%
		UserDTO user = (UserDTO)session.getAttribute("input_data");
		WeightDTO we = (WeightDTO)session.getAttribute("weight_data");
		String genderString = (user.getGender() == 1) ? "男性" : "女性";
	%>
	名前：<%=user.getName() %><br>
	性別：<%=genderString %><br>
	生年月日：<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(user.getBirth()) %><br>
	身長：<%=user.getHeight() %><br>
	体重：<%=we.getWeight() %><br>
	メール：<%=user.getMail() %><br>
	パスワード：********<br>
	
	<div class="form-group">
	        <a href="RegisterExecuteServlet">OK</a><br>
	       <button type="button" class="signup-button" onclick="goBack()">戻る</button>
	      </div>
	</div>

</body>
</html>
//こんにちは