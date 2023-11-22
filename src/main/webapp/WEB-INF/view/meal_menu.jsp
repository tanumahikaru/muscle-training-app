<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>フリートレーニング一覧</title>
</head>
<body>
<form action="SearchServlet" method="get">
  <input type="text" name="search" placeholder="Search...">
  <button type="submit">Search</button>
</form>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>レシピ名</th>
			<th>カロリー</th>
		</tr>
	<%
		List<Meal_menuDTO> meal_menu = (ArrayList<Meal_menuDTO>)request.getAttribute("list");
		for(Meal_menuDTO m : meal_menu) {
	%>
		<tr>
			<td><%=m.getFood_id() %>
			<td><%=m.getFood_name() %></td>
			<td><%=m.getCalorie() %></td>
		</tr>
	<%} %>
	</table>
	
	<a href="TopServlet">戻る</a>
</body>
</html>