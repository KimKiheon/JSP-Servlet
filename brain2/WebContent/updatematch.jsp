<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.MatchDAO"%>
<%@ page import="vo.MatchVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%--
updatematch.jsp
매치 수정 페이지
 --%>
<!DOCTYPE html>
<%
	System.out.println("--------------------updatematch.jsp--------------------");

	String id = (String) session.getAttribute("id");
	System.out.printf("now id : %s\n", id);
	if (id == null) {
		System.out.println("로그인 미완료 : login.jsp로 이동합니다....\n");
	} else
		System.out.printf("Now User ID : %s\n", id);

	MemberVO vo = new MemberVO();
	MemberDAO dao = new MemberDAO();
	vo = dao.getInfo(id);
	int succ = vo.getSuccessMatch();
	int all = vo.getAllMatch();
	double avg = 0;
	if (succ == 0)
		avg = 0;
	else
		avg = (double) (succ / all) * 100;

	//BBS View
	int seqNo = 1;
	if (request.getParameter("seqNo") != null) {
		seqNo = Integer.parseInt(request.getParameter("seqNo"));
	}
	if (seqNo == 0) {
		out.println("<script>");
		out.println("alert('존재하지 않는 글입니다.')");
		out.println("location.href = 'jointhematch.jsp'");
		out.println("</script>");
	}
	MatchVO match = new MatchDAO().getMatches(seqNo);
%>
<html>
<head>
<title>매치 게시글</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<style>
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
				</div><br><br>

	<br />
	<%
		if (id != null) {
	%>
	<div class="shadow_eff2">
		<div class="row">
			<form action="UpdateMatchProc" method="post">
				<div class="hidden">
					<input type="number" id="seqNo" name="seqNo" readonly
						value="<%=match.getSeqNo()%>">
						<input type="text" id="flag1" name="flag1" readonly value="<%=match.getFlag1() %>">
						<input type="text" id="nowman" name="nowman" readonly value="<%=match.getNowman() %>">
						<input type="text" id="flag2" name="flag2" readonly value="<%=match.getFlag2() %>">
		
				</div>
					<div>
				<h1>
				<span><%=match.getTitle()%></span><span style="font-size:15px;">&nbsp;&nbsp;글 수정</span>
				</h1>
				</div>		
				<div style="background-color:#f3f3f3; height:3px; width:100%;">
				</div>
				<br><br>
				<table style="width:100%">
					<thead>
						
					</thead>
					<tbody>
						<tr>
							<td id="leftT">글 제목</td>
							<td><input type="text" name="title"
								value="<%=match.getTitle()%>"></td>
						</tr>
						<tr>
							<td id="leftT" >작성자</td>
							<td ><input type="text" readonly name="writer"
								value="<%=match.getWriter()%>"></td>
						</tr>
						<tr>
							<td id="leftT">시작 시간</td>
							<td ><input type="datetime-local" id="stime" name="stime" step="1"></td>
						</tr>
						<tr>
							<td id="leftT">종료 시간</td>
							<td ><input type="datetime-local" id="etime" name="etime" step="1"></td>
						</tr>
					
						<tr>
							<td id="leftT">장소</td>
							<td ><input type="text" name="addr"
								value="<%=match.getAddr()%>"></td>
						</tr>
						<tr>
							<td id="leftT">팀/개인 유무</td>
							<td><input type="text" readonly name="teamflag"
								value="<%=match.getTeamflag()%>"></td>
						</tr>
						<tr>
							<td id="leftT">필요 인원</td>
							<td><input type="text" name="needman"
								value="<%=match.getNeedman()%>"></td>
						</tr>
						<tr>
							<td id="leftT" >추가 사항</td>
							<td><input type="text" name="contents" style="width:90%; height:300px;"
								value="<%=match.getContents()%>"></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" value="수정하기">
			</form>
		</div>
	</div>
	<%
		} else {
	%>
	<script language="javascript">
		location.href = "login.jsp";
	</script>
	<%
		}
	%>
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