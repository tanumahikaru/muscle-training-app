<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>Insert title here</title>
</head>
<body>
	<div class="header-banner">
        <h1>筋トレ</h1>
    </div>
    
     <button type="button" class="menu-btn">
      <i class="fa fa-bars" aria-hidden="true"></i>
    </button>
    <div class="menu">
      <div class="menu__item"><a href="menuServlet">トップ</a></div>
      <div class="menu__item"><a href="AnswerlistServlet">今日のトレーニング</a></div>
      <div class="menu__item"><a href="NewServlet">フリートレーニング</a></div>
      <div class="menu__item"><a href="DeleteServlet">レシピ検索</a></div>
      <div class="menu__item"><a href="UpdateServlet">記録</a></div>
      <div class="menu__item"><a href="SelectAllQuizServlet">ゲーム</a></div>
   	  <div class="menu__item"><a href="SelectAllQuizServlet">ログアウト</a></div>
    </div>
    
    
    
    <p>摂取カロリー</p>
    <p>消費カロリー</p>
    <p>クイズ正答数</p>
</body>
</html>