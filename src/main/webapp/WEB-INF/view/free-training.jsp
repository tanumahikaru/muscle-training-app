<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フリートレーニング一覧</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>種目名</th>
			<th>Met's</th>
		</tr>
	<%
		List<MuscleDTO> training = (ArrayList<MuscleDTO>)request.getAttribute("list");
		for(MuscleDTO m : training) {
	%>
		<tr>
			<td><%=m.getTraining_event_id() %>
			<td><%=m.getEvent_name() %></td>
			<td><%=m.getMets() %></td>
		</tr>
	<%} %>
	</table>
	
	<a href="TopServlet">戻る</a>
</body>
</html>