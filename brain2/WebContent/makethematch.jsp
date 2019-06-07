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
		
	</style>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      if(<%=all%> != 0){
         google.charts.setOnLoadCallback(drawChart);
      }
      else{
         google.charts.setOnLoadCallback(defaultDrawChart);
      }
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Effort', 'Amount given'],
          ['참석', <%=succ%>],
          ['불참', <%=all - succ%>]
        ]);
        var options = {
          title: 'Match Success Rate',
          pieHole: 0.5,
          'width': 350,
          chartArea:{
               left:10,
               right:10, // !!! works !!!
               bottom:20,  // !!! works !!!
               top:20,
               width:"100%",
               height:"80%"
             },
          pieSliceTextStyle: {
            color: 'white',
            fontSize: 9,
          },

          tooltip: {trigger: 'selection'},
        };

        var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
        chart.draw(data, options);
      }
      
      function defaultDrawChart() {
          var data = google.visualization.arrayToDataTable([
            ['Effort', 'Amount given'],
            ['no match', 1],
            ['no 1', 0],
            ['no 2', 0],
            ['no 3', 0],
            ['no 4', 0],
          ]);

          var options = {
                title: '아직 매치를 실시하지 않으셨습니다.',
                pieHole: 0.5,
                  'width': 350,
                  chartArea:{
                       left:10,
                       right:10, // !!! works !!!
                       bottom:20,  // !!! works !!!
                       top:20,
                       width:"80%",
                       height:"80%",
                     },
                  pieSliceText: 'none',
                  pieSliceTextStyle: {
                    color: 'white',
                  },
                  legend: 'none',
                  tooltip: {trigger: 'none',},
                  enableInteractivity:'false',
                  
                  colors: ['grey','green'],
          };

          var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
          chart.draw(data, options);
        }
    </script>
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
				<span style="color:gray; font-size:10px; font-family:고딕">가톨릭대학교 Sports Matching Service</span>
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
	<div style="background-color:#f3f3f3; height:5px; width:100%;">
				</div>
	<br />
	<%if(id != null){ %>
	<div class="shadow_eff2">
	<form>
	<div class="makeinner">
	<h2><%=id %>&nbsp;&nbsp;<span style="font-size:15px;">의 매칭 내역</span></h2>
	<div style="background-color:#f3f3f3; height:2px; width:100%;">
				</div>
				<br><br><br>
	 <table class="t" border="1">
         <tr>
            <td style="background: lightgray;">전체 매칭 시도수</td>
            <td><%=all%> 회</td>
            <td rowspan="3"><div id="donut_single" style=" margin:0%; width:50px; float:auto;"></div></td>
         </tr>
         <tr>
            <td style="background: lightgray;">매칭 성공 수</td>
            <td><%=succ%> 회</td>
         </tr>
         <tr>
            <td style="background: lightgray;">매칭 성공률</td>
            <td><%=avg%> %</td>
      </table>
		<br />
		<br />
		<br />
			</div>
			<h2 style="font-size:20px;">매칭 생성</h2>
	<div style="background-color:#f3f3f3; height:2px; width:100%;">
				</div>
	<br><br>
		<br />
		 <table class="tt">
         <tr>
            <td style="vertical-align:center; background-color:#f4f4f4;"><a href="makeasports.jsp">ATHLETIC SPORTS</a></td>
            <th style="width : 20px;"></th>
            <td style="background-color:#f4f4f4;"> <a href="makeesports.jsp">E-SPORTS</a></td>
         </tr>
      	</table>

	</form>
	</div>
	<%}else{ %>
 	 <script language="javascript">
            location.href="login.jsp";
            </script>	<%} %>
		<br />
	<br />
	<br />
	
	
	<div class="foot">
        상호명 : CUKBM / 대표 : 가플리<br />
		전화 : 010 - 1234 - 5678<br />
		Facebook : object-oriented paradime	<br />
		Address : Catholic University Of Korea<br />
        Copyrightⓒ 2019 CUKBM. All rights reserved. E-mail : cukbm2@catholic.ac.kr
	</div>
	

</body>
</html>