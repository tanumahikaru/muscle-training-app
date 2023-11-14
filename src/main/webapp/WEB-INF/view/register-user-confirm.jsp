<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.UserDTO" %>
<%@ page import="dto.WeightDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>下記の内容で登録します。よろしいですか？</p>
	<%
		UserDTO user = (UserDTO)session.getAttribute("input_data");
		WeightDTO we = (WeightDTO)session.getAttribute("weight_data");
	%>
	名前：<%=user.getName() %><br>
	性別：<%=user.getGender() %><br>
	生年月日：<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(user.getBirth()) %><br>
	身長：<%=user.getHeight() %><br>
	体重：<%=we.getWeight() %><br>
	メール：<%=user.getMail() %><br>
	パスワード：********<br>
	
	<a href="RegisterExecuteServlet">OK</a><br>
	<a href="FormServlet">戻る</a>
</body>
</html>