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
<%@ page import="dao.AlarmDAO" %>
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
	if (succ == 0 || all == 0)
		avg = 0;
	else
		avg = (double) (succ / all) * 100;
	//BBS View
	int pageNumber = 1;
	int seqNo = 1;
	if (request.getParameter("seqNo") != null) {
		seqNo = Integer.parseInt(request.getParameter("seqNo"));
	}
	String state = null;
	if(id != null){
		state = PeopleDAO.matchstate(seqNo,id);
		System.out.printf("%s\n",state);
	}	
	MatchVO match = new MatchDAO().getMatches(seqNo);
	
%>
<html>
<head>
<title>매치 게시글</title>
<link rel="stylesheet" type="text/css" href="style.css" />

</head>
<%
if(state == null){	
%>
<script language="javascript">
		location.href = "jointhematch.jsp";
	</script>
<body>
<%} %>
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
				</div>
	<br />
	<%
		if (id != null) {
	%>
	<div class="shadow_eff2">
		<div class="rrow">
		<div style="text-align:center;">
				<h1>
				<span><%=match.getTitle()%></span> 
<span style=" height:30px; font-size:20px; background-color:#45a049; color:white;">&nbsp;&nbsp;참가자 정보&nbsp;&nbsp;</span>				</h1>
				 
				</div>		
				<div style="background-color:#f3f3f3; height:3px; width:100%;">
				</div>
			<table class="matchinfo">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">참가자</th>
						<th style="background-color: #eeeeee; text-align: center;">전체 매치 수</th>
						<th style="background-color: #eeeeee; text-align: center;">참가</th>
						<th style="background-color: #eeeeee; text-align: center;">신뢰율</th>
						<th style="background-color: #eeeeee; text-align: center;">카카오톡
							ID</th>
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
						<td><%=list.get(i).getJoinman()%>
						<%
							if (list.get(i).getFlag() == 1) {
						%>
						<span style=" height:30px; font-size:15px; background-color:#45a049; color:white;">&nbsp;&nbsp; 방장 &nbsp;&nbsp;</span>	
						<%} %>
						</td>
						<td><%=membervo.getAllMatch()%></td>
						<td><%=membervo.getSuccessMatch()%></td>
						<%
						int msucc = membervo.getSuccessMatch();
						int mall = membervo.getAllMatch();
						double mavg;
						if(mall == 0 || msucc == 0)mavg = 0;
						else mavg = msucc/mall*100;
						%>
						<td><%=mavg%>%</td>
						<td><%=membervo.getKtid()%></td>
						<%
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
        상호명 : CUKBM / 대표 : 가플리<br />
		전화 : 010 - 1234 - 5678<br />
		Facebook : object-oriented paradime	<br />
		Address : Catholic University Of Korea<br />
        Copyrightⓒ 2019 CUKBM. All rights reserved. E-mail : cukbm2@catholic.ac.kr
	</div>
</body>
</html>