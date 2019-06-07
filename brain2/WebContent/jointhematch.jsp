<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.MatchDAO"%>
<%@ page import="vo.MatchVO"%>
<%@ page import="java.util.ArrayList"%>
<%
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
	response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
﻿
<!DOCTYPE html>
<%
	String flag2 = request.getParameter("flag2");
	System.out.println("--------------------jointhematch.jsp--------------------");
	String id = (String) session.getAttribute("id");
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
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<html>
<head>
<title>매치 참가</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<style>
</style>

</head>
<body>

	<header>
		<div id="HR">
			<%
				if (id == null) {
			%>
			<a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
			<%
				} else {
			%>
			<a href="mypage.jsp"><%=id%></a> | <a href="LogoutProc">로그아웃</a>
			<%
				}
			%>
			| <a href="alarm.jsp">ALARM</a>
		</div>
		<div class="menu">
			<div id="HL">
				<img src="image/basketball.png" width="30" height="30" />&nbsp;<a
					href="main.jsp">CUKBM</a> <span
					style="font-color: gray; font-size: 10px; font-family: 고딕">가톨릭대학교
					Sports Matching Service</span>
				<div class="dropdown" style="float: right;">
					<button class="dropbtn">
						<img src="image/menubar.png" width="20" height="20" />
					</button>
					<div class="dropdown-content">
						<a href="login.jsp">로그인</a> <a href="register.jsp">회원 가입</a> <a
							href="alarm.jsp">알림</a> <a href="makethematch.jsp">매치 생성</a> <a
							href="jointhematch.jsp">매치 참가</a> <a href="mypage.jsp">마이 페이지</a>
					</div>
				</div>
			</div>
		</div>
	</header>
	<div style="background-color: #f3f3f3; height: 5px; width: 100%;">



	</div>
	<br />
	<%
		if (id != null) {
	%>
	<div class="shadow_eff2">
		<div id="articleheader">
			Join Match...&nbsp;&nbsp;<span
				style="height: 30px; font-size: 20px; background-color: #45a049; color: white;">&nbsp;&nbsp;Athletic
				Sports&nbsp;&nbsp;</span> &nbsp;<span
				style="height: 30px; font-size: 20px; background-color: #ff6262; color: white;">&nbsp;&nbsp;E-Sports&nbsp;&nbsp;</span>
		</div>
		<div style="background-color: #f3f3f3; height: 2px; width: 100%;">
		</div>
		<div class="rrow">
			<table class="viewertable">
				<thead>
					<tr>
						<th width="70">번호</th>
						<th width="1000">제목</th>
						<th width="100">종목</th>
						<th width="120">시작</th>
						<th width="100">종료</th>
						<th width="100">최대인원</th>
						<th width="100">참가인원</th>
						<th width="100">작성자</th>
					</tr>
				</thead>
				<tbody>
					<%
						ArrayList<MatchVO> list;
							MatchVO match = new MatchVO();
							if (request.getParameter("flag2") != null) {
								list = MatchDAO.getList(pageNumber, request.getParameter("flag2"));
							} else {
								list = MatchDAO.getList(pageNumber);
							}
							for (int i = 0; i < list.size(); i++) {
					%>
					<tr id="matches">
						<td height="1100" width="70"><%=list.get(i).getSeqNo()%></td>
						<td width="500"><a
							href="viewmatch.jsp?seqNo=<%=list.get(i).getSeqNo()%>"><%=list.get(i).getTitle()%></a></td>
						<td width="100"><%=list.get(i).getFlag2()%></td>
						<td width="120"><%=list.get(i).getStime()%></td>
						<td width="100"><%=list.get(i).getEtime()%></td>
						<td width="100"><%=list.get(i).getNeedman()%></td>
						<td width="100"><%=list.get(i).getNowman()%></td>
						<td width="100"><%=list.get(i).getWriter()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="jointhematch.jsp?pageNumber=<%=pageNumber - 1%>&flag2=<%=flag2%>">이전</a>
			<%
				}
					System.out.println(pageNumber + " " + MatchDAO.fullPage());
					if (MatchDAO.nextPage(pageNumber + 1) && MatchDAO.fullPage() > pageNumber) {
			%>
			<a href="jointhematch.jsp?pageNumber=<%=pageNumber + 1%>&flag2=<%=flag2%>">다음</a>
			<%
				}
			%>
			<a href="makethematch.jsp" class="btn btn-primary pull-right">글쓰기</a>
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
		number : 010 - 1234 - 5678<br /> Facebook : object-oriented paradime
		<br /> address : catholic university<br /> name : hong gil dong
	</div>


</body>
</html>