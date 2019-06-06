<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf8"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.MatchDAO"%>
<%@ page import="vo.MatchVO"%>
<%@ page import="dao.PeopleDAO"%>
<%@ page import="vo.PeopleVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
<%--
viewpeople.jsp
현재 매치의 참가한 참가자의 리스트를 보여주는 페이지
 --%>
<!DOCTYPE html>
<%
	System.out.println("--------------------viewmatch.jsp--------------------");

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
	int pageNumber = 1;
	int seqNo = 1;
	if (request.getParameter("seqNo") != null) {
		seqNo = Integer.parseInt(request.getParameter("seqNo"));
	}
%>
<html>
<head>
<title>매치 게시글</title>
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

.hidden {
	display: none;
}

a:hover {
	color: red;
}
</style>

</head>
<body>

	<header>
		<div id="HL">
			&nbsp;<a href="main.jsp">CUKBM</a>
		</div>

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
		<br />
	</header>
	<div class="header">
		<div class="title">&nbsp;참가자 정보</div>
		<div class="menu">
			<img src="image/menubar.png" />
		</div>
	</div>
	<br />
	<%
		if (id != null) {
	%>
	<div class="container1">
		<div class="row">
			<table id="viewrtable"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">참가자</th>
						<th style="background-color: #eeeeee; text-align: center;">전체
							매칭 시도수</th>
						<th style="background-color: #eeeeee; text-align: center;">매칭
							성공 수</th>
						<th style="background-color: #eeeeee; text-align: center;">매칭
							성공률</th>
						<th style="background-color: #eeeeee; text-align: center;">카카오톡
							ID</th>
						<th style="background-color: #eeeeee; text-align: center;">방장</th>
					</tr>
				</thead>
				<tbody>
					<%
						PeopleVO peoplevo = new PeopleVO();
							ArrayList<PeopleVO> list = PeopleDAO.getList(pageNumber, seqNo);
							for (int i = 0; i < list.size(); i++) {
								MemberVO membervo = new MemberVO();
								MemberDAO memberdao = new MemberDAO();
								membervo = memberdao.getInfo(list.get(i).getJoinman());
					%>
					<tr>
						<td><%=list.get(i).getJoinman()%></td>
						<td><%=membervo.getAllMatch()%></td>
						<td><%=membervo.getSuccessMatch()%></td>
						<td>수식</td>
						<td><%=membervo.getKtid()%></td>
						<%
							if (list.get(i).getFlag() == 1) {
						%>
						<td>O</td>
						<%
							} else {
						%>
						<td>X</td>
						<%
							}
								}
						%>
					</tr>
				</tbody>
			</table>
			<br /> <a href="jointhematch.jsp"><p id="tablelist">목록</p></a>
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