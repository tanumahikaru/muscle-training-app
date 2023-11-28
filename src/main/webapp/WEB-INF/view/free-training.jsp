<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>フリートレーニング一覧</title>
    <script>
        function setAndSubmitForm(positionId) {
            document.getElementById("positionId").value = positionId;
            document.forms["categoryForm"].submit();
        }
    </script>
</head>
<body>
    <form action="SearchTrainingServlet" method="post">
        <input type="text" name="searchKeyword" placeholder="検索したいメニューを入力してください">
        <input type="submit" value="検索">
    </form>
    <form action="FreeTrainingServlet" method="post" id="categoryForm">
        <!-- positionIdをサーバーに送信するフォーム -->
        <input type="hidden" name="positionId" id="positionId" value="" />
        
        <!-- ボタンがクリックされたときにJavaScriptでpositionIdを設定し、フォームをサーバーに送信する -->
        <button type="button" onclick="setAndSubmitForm(1)">腕</button>
        <button type="button" onclick="setAndSubmitForm(2)">肩</button>
        <button type="button" onclick="setAndSubmitForm(3)">脚</button>
    </form>
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
            <td><%=m.getTraining_event_id() %></td>
            <td><%=m.getEvent_name() %></td>
            <td><%=m.getMets() %></td>
        </tr>
        <%} %>
    </table>
    <a href="TopServlet">戻る</a>
    
</body>
</html>