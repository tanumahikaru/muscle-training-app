<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.MuscleRecord" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.MuscleDAO" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title>トレーニング結果</title>
<link rel="stylesheet" href="training_result.css">
</head>
<body>
    <h2>トレーニング結果</h2>
    <%
    List<MuscleRecord> results = (List<MuscleRecord>)request.getAttribute("result");
    for (MuscleRecord re : results) { 
    %>
    <%= MuscleDAO.SelectMuscleEventById(re.getTraining_event_id()).getEvent_name() %>
    <%=re.getCalories_burned() %>
    <br>
    <%} %>
</body>
</html>