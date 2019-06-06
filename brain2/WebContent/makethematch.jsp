<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
    <%@page import="vo.MemberVO" %>
     <%@page import="dao.MemberDAO" %>
     <%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
﻿<!DOCTYPE html>
<%
System.out.println("--------------------makethematch.jsp--------------------");

String id = (String)session.getAttribute("id");
if(id == null){
	System.out.println("로그인 미완료 : login.jsp로 이동합니다....\n");
}
else System.out.printf("Now User ID : %s\n",id);
System.out.println("MemberVo 객체 불러오는중 ........\n");
MemberVO vo = new MemberVO();
System.out.println("MemberDAO 객체 생성중 ........\n");
MemberDAO dao = new MemberDAO();
System.out.printf("[%s]의 정보 불러오는중 .......\n",id);
vo = dao.getInfo(id);
int succ = vo.getSuccessMatch();
int all = vo.getAllMatch();
System.out.printf("[%s]의 성사된 매치 수 = %d\n",id,succ);
System.out.printf("[%s]의 총 매치 시도수 = %d\n",id,all);
double avg=0;
if(succ == 0)avg=0;
else avg = (double)(succ/all)*100;
System.out.printf("[%s]의 매치 성사율 = %f\n",id,avg);

%>
<html>
<head>
	<title>매치생성</title>
	<link rel="stylesheet" type="text/css" href="style.css" />
	<style>
		.circle {
			background: aliceblue;
			width: 400px;
			padding: 20px;
			border-radius: 50px;
			text-align: center;
			border-style: solid;
			margin: auto;
		}
		a:hover {
			color:red;
		}
	</style>

</head>
<body>

    <header>
        <div id="HL"> &nbsp;<a href="main.jsp">CUKBM</a></div>

        <div id="HR"><%if (id == null) {%>
        <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
         <%} 
         else {%>
          <a href="mypage.jsp"><%=id %></a> | <a href="LogoutProc">로그아웃</a>
        <%} %> | <a href="alarm.jsp">ALARM</a></div>
        <br />
    </header>
	<div class="header">
		<div class="title">&nbsp;MAKE THE MATCH</div>
		<div class="menu"><img src="image/menubar.png" /></div>
	</div>
	<br />
	<%if(id != null){ %>
	<form>
		<table class="t"border="1">
			<tr>
				<td style="text-align:center;">자신의 매치 성사율</td>
				<td style="text-align:center;">생성중인 매치</td>
			</tr>

		</table>
		<br />
		<table class="t"border="1">
			<tr>
				<td style="background:lightgreen; color:black; font-size:35px; text-align:center; "><%=avg %></td>
				<td style="background:lightgreen; color:black; font-size:35px; text-align:center; "><%= succ%></td>
			</tr>
			<tr>
				<td style="background:lightgray;">매칭 성공 수</td>
				<td><%=succ %></td>
			</tr>
			<tr>
				<td style="background:lightgray;">매칭 성공률</td>
				<td><%=avg %></td>
		</table>
		<br />
		<br />
		<hr style="margin-right:auto; border-style:solid" />

		<br />
		<p style="text-align:center; font-size:20px;border-radius:0px; width:400px; padding:20px; margin:auto; background:orange; color:black;">생성하고 싶은 종목을 선택하세요</p>
		<br />
		<div class="Wheader">
			<div class="circle"><a href="makeasports.jsp">ATHLETIC SPORTS</a></div>
			<div class="circle"><a href="makeesports.jsp">E-SPORTS</a></div>
		</div>

	</form>
	<%}else{ %>
 	 <script language="javascript">
            location.href="login.jsp";
            </script>	<%} %>
		<br />
	<br />
	<br />
	<div class="foot">
		number : 010 - 1234 - 5678<br />
		Facebook : object-oriented paradime	<br />
		address : catholic university<br />
		name : hong gil dong
	</div>
	

</body>
</html>