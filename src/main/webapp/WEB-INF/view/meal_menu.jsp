<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>レシピ検索</title>

    <!-- カテゴリー別に検索する JavaScript 部分 -->
    <script>
        function searchByCategory(category_Id) {
            // カテゴリーIDをパラメータとしてサーブレットに送信
            window.location.href = "SearchServlet?category=" + category_Id;
        }
    </script>
</head>
<body>

 	<%
    // ボタンがクリックされたときにpositionIdを取得するサーブレットのURL
    String servletURL = "RecipeServlet"; // サーブレットのURLに置き換えてください
%>

<form action="<%=servletURL%>" method="post">
    <!-- positionIdをサーバーに送信するフォーム -->
    <input type="hidden" name="category_Id" id="category_Id" value="" />

    <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
    <button type="button" onclick="setAndSubmitForm(1)">肉</button>
    <button type="button" onclick="setAndSubmitForm(2)">魚</button>
    <button type="button" onclick="setAndSubmitForm(3)">野菜</button>

    <!-- JavaScriptでpositionIdを設定し、フォームをサーバーに送信するスクリプト -->
    <script>
        function setAndSubmitForm(category_Id) {
            document.getElementById("category_Id").value = category_Id;
            document.forms[0].submit();
        }
    </script>
	</form>
		<table border="1">
			<tr>
				<th>ID</th>
				<th>メニュー名</th>
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
    <!-- 戻るボタン -->
    <a href="TopServlet">戻る</a>
    
</body>
</html>
