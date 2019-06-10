<%@ page language="java" contentType="text/html; charset=utf8"
	pageEncoding="utf-8"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.MatchDAO"%>
<%@ page import="vo.MatchVO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="dao.PeopleDAO" %>
<%@ page import="dao.AlarmDAO"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
<%--
viewmatch.jsp
매치 리스트를 보여주는 페이지
 --%>
<!DOCTYPE html>
<%
	System.out.println("--------------------viewmatch.jsp--------------------");
	String result = request.getParameter("result");
	String id = (String) session.getAttribute("id");
	System.out.printf("now id : %s\n", id);
	if (id == null) {
		System.out.println("로그인 미완료 : login.jsp로 이동합니다....\n");
	} else
		System.out.printf("Now User ID : %s\n", id);

	MemberVO vo = new MemberVO();
	MemberDAO dao = new MemberDAO();
	MatchDAO mdao = new MatchDAO();
	vo = dao.getInfo(id);
	int succ = vo.getSuccessMatch();
	int all = vo.getAllMatch();
	boolean bool = false;
	double avg = 0;
	if (succ == 0 || all == 0)
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
	bool = mdao.MatchFull(match.getSeqNo());
	String teamF = null;
	String flag1 = null;
	if(match.getTeamflag() == 1){
		teamF = "팀전";
	}
	else teamF = "개인전";
	if(match.getFlag1() == 1){
		flag1 = "Athletic Sports";
	}
	else flag1 = "Esports";
	String state = null;
	if(id != null){
	state = PeopleDAO.matchstate(seqNo,id);
	System.out.printf("%s\n",state);
	}	
	String sasn = null;
	sasn = (String)request.getParameter("asn");
	System.out.printf("읽은 매치는 : %s\n",sasn);
	if(sasn != null){
		int asn = Integer.parseInt(sasn);
		System.out.printf("%d\n",asn);
		AlarmDAO.UpdateAlarm(asn);
	}
%>
<html>
<head>
<title>매치 게시글</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script>
	function joincancel(){
		if (confirm("참가 취소 하시겠습니까?")) {
			// 확인 버튼 누르면 서블릿으로 이동
			JoinMatchCancelControl.action = "JoinMatchCancelProc";
			JoinMatchCancelControl.method = "post";
			JoinMatchCancelControl.submit();
        } else {
        }
	}
</script>
<style>
</style>
<%
if(result != null){	%>
<script language="javascript">
alert("참가되었습니다!");
state="joinman";
</script>
<%} %>
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
				</div>
	<br />
	<%
		if (id != null) {
	%>
	<div class="shadow_eff2">

		<div class="rrow">
			<form id = "JoinMatchCancelControl" action="JoinTheMatchProc" method="post">
				<div class="hidden" style="display:none;">
					<input type="number" id="seqNo" name="seqNo" readonly
						value="<%=match.getSeqNo()%>">
				</div>
				<div>
				<h1>
				<span><%=match.getTitle()%></span>
				<span style=" height:30px; font-size:20px; background-color:#45a049; color:white;">&nbsp;&nbsp;<%=flag1%>&nbsp;&nbsp;</span>
				<%if(state == null && bool == false) {%>
				<span><input type="submit" value="참가하기"></span>
				<%}else if(state == null && bool == true) {%>
				<span><input type="Button" value="참가 마감"></span>
				<%}
				else {
				System.out.printf("%s\n",match.getWriter());
				System.out.printf("%s\n",id);
				if(id.equals(match.getWriter())) {%>
				<span><input type="Button" onclick="location.href='updatematch.jsp?seqNo=<%=seqNo%>'" value="수정"></span>
				<%}
				if(id.equals(match.getWriter())){
					%>
					<script>function alertJoinCancel(){
						alert("생성자는 매치를 취소할 수 없습니다.");
					}</script>
					<span><input type="Button" onclick="javascript:alertJoinCancel()" value="참가 중"></span>
				<%
				}
				else if(bool == true){%>
					<script>function full(){
						alert("매치가 확정되어 취소할 수 없습니다.");
					}</script>
					<span><input type="Button" onclick="javascript:full()" value="참가 중"></span>
				<%	
				}
				else{%>
					<span><input type="Button" onclick="javascript:joincancel()" value="참가 중"></span>
				<% 
				}
				%>	
				
				
				<span><input type="Button" onclick="location.href='viewpeople.jsp?seqNo=<%=seqNo%>'" value="참가자 보기"></span>
				<%} %>
				
				</h1>
				</div>		
				<div style="background-color:#f3f3f3; height:3px; width:100%;">
				</div>
				<table class="matchinfo">
					<thead>
						<tr>
							<td >작성자</td>
							<td >종목</td>
							<td >시작시간</td>
							<td>종료시간</td>
							<td >장소</td>
							<td>팀/개인전 구분</td>
							<td>필요 인원 수</td>
							<td >현재 신청자 수</td>
						</tr>
					</thead>				
					<tbody>
						<tr>
							<td  id="writer"><%=match.getWriter()%></td>
							<td id="flag2"><%=match.getFlag2()%></td>
							<td  id="stime"><%=match.getStime()%></td>
							<td  id="etime"><%=match.getEtime()%></td>
							<td id="addr"><%=match.getAddr()%></td>
							<td  id="teamflag"><%=teamF%></td>						
							<td  id="needman"><%=match.getNeedman()%></td>		
							<td id="nowman"><%=match.getNowman()%></td>
						</tr>

					</tbody>
					
				</table>
				<br><br><br><br>
				<div style="height:300px; width:50%"><h3>추가사항</h3>
				<div style="background-color:#f3f3f3; height:1px; width:100%;">
				</div>
							<%=match.getContents()%>
							</div>
				<br />
				<a href="jointhematch.jsp"><p id="tablelist">목록</p></a>  
			</form>
		</div>
		</div>
	<%
		}
		else {
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