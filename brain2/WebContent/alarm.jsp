<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
﻿<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.AlarmDAO"%>
<%@ page import="vo.AlarmVO"%>
<%@ page import="dao.MatchDAO"%>
<%@ page import="vo.MatchVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
<!DOCTYPE html>
<%

	System.out.println("--------------------main.jsp--------------------");
	String id = (String) session.getAttribute("id");
	if (id == null) {
		System.out.println("로그인 미완료 \n");
	} else
		System.out.printf("Now User ID : %s\n", id);
	String result = request.getParameter("result");
	if (result != null) {
%>
<script language="javascript">
	alert("글 작성 성공!");
</script>
<%
	result = null;
	}

	//list View
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<%if(id == null){ %>
 	 <script language="javascript">
            location.href="login.jsp";
            </script>	<%}%>
            
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css" href="style.css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title></title>
<style>
table { /* 이중 테두리 제거 */
	border-collpase: none;
}

td, th { /* 모든 셀에 적용 */
	text-align: left;
	padding: 5px;
	height: 15px;
	width: 100px;
}

thead, tfoot {
	background: darkgray;
	color: yellow;
}

tbody tr:nth-child(odd) {
	background: aliceblue;
}

tbody tr:nth-child(1) {
	border-right: 1px dashed red;
	border-left: 1px dashed darkgray;
}

tbody td:nth-child(3) {
	border-left: 1px dashed red;
	border-right: 1px dashed darkgray;
}
</style>
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
<div style="background-color:#f3f3f3; height:5px; width:100%;">
				</div><br><br>

<div class="shadow_eff2">
	<h2><%=id %>&nbsp;&nbsp;<span style="font-size:15px;">님 Alarm</span></h2>
	<div style="background-color:#f3f3f3; height:2px; width:100%;">
				</div>
	<br />
	<br />
	<table width="80%" style="margin: auto">
		<thead>
			<tr>
				<th colspan="3">ATHlETIC OR ESPORTS</th>
				<th colspan="5">해당하는 스포츠의 종목</th>
				<th colspan="5">제목</th>
				<th colspan="5">현재인원</th>
			</tr>
		</thead>
		<tbody>
			<%
				AlarmVO alarm = new AlarmVO();
				ArrayList<AlarmVO> list = AlarmDAO.getList(pageNumber, id);
				for (int i = 0; i < list.size(); i++) {
					MatchVO match = new MatchVO();
					MatchDAO matchdao = new MatchDAO();
					match = matchdao.getMatches(list.get(i).getMatchseqNo());
			%>
			<tr>
				<td colspan="3"><%=list.get(i).getSeqNo()%></td>
				<td colspan="5"><a
					href="viewalarm.jsp?seqNo=<%=list.get(i).getSeqNo()%>"><%=match.getFlag2()%></a></td>
				<td colspan="5"><%=match.getTitle()%></td>
				<td colspan="5"><%=match.getNowman()%></td>
			</tr>
			<%
				}
			%>
		</tbody>
	</table>
	</div>
	<Br><br><br><br>
	<div class="foot" style="">
		number : 010 - 1234 - 5678<br /> Facebook : object-oriented paradime
		<br /> address : catholic university<br /> name : hong gil dong
	</div>

</body>
</html>