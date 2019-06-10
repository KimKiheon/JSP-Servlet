<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf-8"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
﻿<!DOCTYPE html>
<%
System.out.println("--------------------main.jsp--------------------");
String id = (String)session.getAttribute("id");
String logout = request.getParameter("logout");
if(logout != null){
System.out.println("뒤로가기 버튼 방지--");
%>

	<script language="javascript">
	response.setHeader("Pragma", "No-cache"); 
	response.setDateHeader("Expires", 0); 
	response.setHeader("Cache-Control", "no-Cache"); 
	history.pushState(null, null, location.href);

	window.onpopstate = function(event) {

		history.go(1);

	};
	
	</script>
<%}
if(id == null){
	System.out.println("로그인 미완료 \n");
}
else System.out.printf("Now User ID : %s\n",id);
String result = request.getParameter("result");
if(result != null){
%>
<script language="javascript">
alert("글 작성 성공!");
</script>
<%result =null;} %>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="utf-8" />
	<title></title>

	<link rel="stylesheet" type="text/css" href="style.css" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<header>
	<div id="HR">
        <%if (id == null) {%>
        <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
         <%} 
         else {%>
          <a href="mypage.jsp"><%=id %></a> | <a href="LogoutProc">로그아웃</a>
        <%} %> | <a href="alarm.jsp">ALARM</a>
        </div>
		<div class="menu">
				<div id="HL"> <img src="image/basketball.png" width="30" height="30" />&nbsp;<a href="main.jsp">CUKBM</a>
				<span style="font-color:gray; font-size:10px; font-family:고딕">가톨릭대학교 Sports Matching Service</span>
           		 <div class="dropdown" style="float:right;">
                <button class="dropbtn"><img src="image/menubar.png" width="20" height="20" /></button>
                <div class="dropdown-content">
                    <a href="login.jsp">로그인</a>
                    <a href="register.jsp">회원 가입</a>
                    <a href="alarm.jsp">알림</a>
                    <a href="makethematch.jsp">매치 생성</a>
                    <a href="jointhematch.jsp">매치 참가</a>
                    <a href="mypage.jsp">마이 페이지</a>
                </div>
            	</div>
        		</div>
		</div>
        
		
	</header>

	<article>
	<div style="background-color:#f3f3f3; height:5px; width:100%;">
				</div>
	<div class="Carousel">
			<ol class="dots"></ol>
			<ol class="slides">
				<li class="slide link">
					<img src="image/축구.jpg" alt="매칭 생성 이미지" />
				</li>
				<li class="slide link">
					<img src="image/농구.jpg" alt="매칭 참가 이미지" />
				</li>
				<li class="slide link">
					<img src="image/게임.jpg" alt="My Page 이미지" />
				</li>
			</ol>
			<div class="next">
				<div class="button"></div>
			</div>
			<div class="prev">
				<div class="button"></div>
			</div>
		</div>
		<table id="mainimage" border="0">
			<tbody>
				<tr>
					<td style="font-size:20px"><a href="jointhematch.jsp?pageNumber=1&flag1=1">Sports</a></td>
					<td rowspan="5"><img src="image/main.png" width="300" height="340" /></td>
					<td style="font-size:20px"><a href="jointhematch.jsp?flag1=2">E-Sports</a></td>
				</tr>
				<tr>
					<td><a href="jointhematch.jsp?flag2=축구"><img src="image/soccer.png"  width="70" height="50"/><br />축구</a></td>
					<td><a href="jointhematch.jsp?flag2=lol"><img src="image/lol.png" width="70" height="50" /><br />롤</a></td>
				</tr>
				<tr>
					<td><a href="jointhematch.jsp?flag2=농구"><img src="image/basketball.png" width="70" height="50" /><br />농구</a></td>
					<td><a href="jointhematch.jsp?flag2=battleground"><img src="image/battleground.png" width="70" height="50" /><br />배틀그라운드</a></td>
				</tr>
				<tr>
					<td><a href="jointhematch.jsp?flag2=배드민턴"><img src="image/badminton.png" width="70" height="50" /><br />배드민턴</a></td>
					<td><a href="jointhematch.jsp?flag2=kartrider"><img src="image/kartrider.png" width="70" height="50" /><br />카트라이더</a></td>
				</tr>
				<tr>
					<td><a href="jointhematch.jsp?flag2=테니스"><img src="image/tennis.png" width="70" height="50" /><br />테니스</a></td>
					<td><a href="jointhematch.jsp?flag2=overwatch"><img src="image/overwatch.png" width="70" height="50" /><br />오버워치</a></td>

				</tr>
			</tbody>
		</table>

		<br />

		
		<script type="text/javascript" src="script.js"></script>

		<table id="Category">
			<tr>
                <td rowspan="5">
                    <a href="makethematch.jsp"><img src="image/생성.png" width="200" height="200" /></a>
                </td>
				<td rowspan="5">
					<a href="jointhematch.jsp"><img src="image/참가.png" width="200" height="200" /></a>
				</td>
				<td rowspan="5">
					<a href="mypage.jsp"><img src="image/마이페이지.png" width="200" height="200" /></a>
				</td>
			</tr>

		</table>
	</article>

	<div class="foot">
        상호명 : CUKBM / 대표 : 가플리<br />
		전화 : 010 - 1234 - 5678<br />
		Facebook : object-oriented paradime	<br />
		Address : Catholic University Of Korea<br />
        Copyrightⓒ 2019 CUKBM. All rights reserved. E-mail : cukbm2@catholic.ac.kr
	</div>
</body>
</html>