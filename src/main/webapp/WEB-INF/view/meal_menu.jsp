<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Meal_menuDTO" %>
<%@ page import="dto.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>レシピ検索</title>

    <!-- カテゴリー別に検索する JavaScript 部分 -->
    <script>
        function searchByCategory(categoryId) {
            // カテゴリーIDをパラメータとしてサーブレットに送信
            window.location.href = "SearchServlet?category=" + categoryId;
        }
    </script>
</head>
<body>

    <!-- カテゴリーボタン -->
    <div>
        <button onclick="searchByCategory(1)">肉</button>
        <button onclick="searchByCategory(2)">魚</button>
        <!-- 他のカテゴリーボタンも追加 -->
    </div>

    <!-- 検索フォーム -->
    <form action="SearchServlet" method="get">
        <input type="text" name="search" placeholder="Search...">
        <button type="submit">Search</button>
    </form>

 <!-- メニュー一覧の表示 -->
<table border="1">
    <tr>
        <th>ID</th>
        <th>レシピ名</th>
        <th>カロリー</th>
        <th>カテゴリー</th>
    </tr>
    <%
        List<Meal_menuDTO> meal_menu = (ArrayList<Meal_menuDTO>) request.getAttribute("list");
        Integer selectedCategoryId = (Integer) request.getAttribute("selectedCategoryId");  // 新しく追加

        for (Meal_menuDTO m : meal_menu) {
            // 選択されたカテゴリーIDとメニューのカテゴリーIDが一致する場合のみ表示
            if (selectedCategoryId == null || m.getCategory().getCategory_id() == selectedCategoryId) {
    %>
    <tr>
        <td><%=m.getFood_id() %></td>
        <td><%=m.getFood_name() %></td>
        <td><%=m.getCalorie() %></td>
        <td><%= (m.getCategory() != null) ? m.getCategory().getCategory_name() : "Unknown Category" %></td>
        
    </tr>
    <%
            }
        }
    %>
</table>

<%
    List<Meal_menuDTO> meal_menu_debug = (ArrayList<Meal_menuDTO>) request.getAttribute("list");
    if (meal_menu_debug != null && !meal_menu_debug.isEmpty()) {
        out.println("<h3>Debugging Information:</h3>");
        for (Meal_menuDTO m : meal_menu_debug) {
            out.println("Food ID: " + m.getFood_id() + "<br>");
            out.println("Food Name: " + m.getFood_name() + "<br>");
            out.println("Category: " + m.getCategory() + "<br>");  // 追加
            // 他のプロパティも同様に表示
            out.println("<br>");
        }
    } else {
        out.println("List is null or empty.");
    }
%>

    <!-- 戻るボタン -->
    <a href="TopServlet">戻る</a>
</body>
</html>
