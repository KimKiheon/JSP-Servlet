<%@ page language="java" contentType="text/html; charset=utf8"
    %>
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
System.out.println("--------------------makeEsports.jsp--------------------");

String id = (String)session.getAttribute("id");
if(id == null){
	System.out.println("로그인 미완료 : login.jsp로 이동합니다....\n");
}
else System.out.printf("Now User ID : %s\n",id);
MemberVO vo = new MemberVO();
MemberDAO dao = new MemberDAO();
vo = dao.getInfo(id);
int succ = vo.getSuccessMatch();
int all = vo.getAllMatch();
double avg=0;
if(succ == 0)avg=0;
else avg = (double)(succ/all)*100;
%>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8" />
    <title>Make the match</title>
    <script language="javascript">
    function checkIt(){
    	if(!document.userinput.title.value){
    		alert("제목을 입력하세요");
    		document.userinput.title.focus();
    		return false;
    	}
    	if(!document.userinput.place.value){
    		alert("장소를 입력하세요");
    		document.userinput.place.focus();
    		return false;
    	}
    	if(!document.userinput.teamQ.value){
    		alert("팀/개인 여부를 입력하세요");
    		document.userinput.teamQ.focus();
    		return false;
    	}
    	if(!document.userinput.stime.value){
    		alert("시작 시간을 입력하세요");
    		document.userinput.stime.focus();
    		return false;
    	}
    	if(!document.userinput.etime.value){
    		alert("종료시간을 입력해주세요");
    		document.userinput.etime.focus();
    		return false;
    	}
     	if(document.userinput.stime.value > 
     	document.userinput.etime.value){
     		console.log(document.userinput.stime.value);
     		console.log(document.userinput.etime.value);
    		alert("종료시간이 시작시간보다 빠릅니다!");
    		document.userinput.etime.value="";
    		document.userinput.etime.focus();
    		return false;
    	}
    	if(!document.userinput.memnum.value){
    		alert("목표인원을 입력해주세요");
    		document.userinput.memnum.focus();
    		return false;
    	}
    }
    document.userinput.reset();
    </script>
</head>
<body onload="document.userinput.reset();">
    <header>
        <div id="HL"> &nbsp;<a href="main.html">CUKBM</a></div>

        <div id="HR"><%if (id == null) {%>
        <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
         <%} 
         else {%>
          <a href="mypage.jsp"><%=id %></a> | <a href="LogoutProc">로그아웃</a>
        <%} %> | <a href="alarm.jsp">ALARM</a></div></div>
        <br />
    </header>
    <div class="header">
        <div class="title">&nbsp;Make&nbsp;<span id="thematch">The&nbsp;Match</span></div>
        <div class="menu">
            <div class="dropdown" style="float:right;">
                <button class="dropbtn"><img src="image/menubar.png" width="30" height="30" /></button>
                <div class="dropdown-content">
                    <a href="login.html">로그인</a>
                    <a href="register.html">회원 가입</a>
                    <a href="alarm.html">알림</a>
                    <a href="makethematch.html">매치 생성</a>
                    <a href="jointhematch.html">매치 참가</a>
                    <a href="mypage.html">마이 페이지</a>
                </div>
            </div>
        </div>
    </div>
    <article>
        <div id="articleheader">E-Sports</div>
        <hr id="hr" />
        <div class="container">  <%if(id != null){ %>
		<form action="MakeMatchProc" method="post" name="userinput" onsubmit="return checkIt()">            
		<div style="display:none;">
             <input type="number" id="flag1" name="flag1" readonly value="2">
             </div>
                <div class="row">
                    <div class="col-25">
                        <label for="title">제목</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="title" name="title">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="place">장소</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="place" name="place">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="teamQ">팀/개인 여부</label>
                    </div>
                    <div class="col-75">
                        <select id="teamQ" name="teamflag">
                            <option value="1">팀</option>
                            <option value="2">개인</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="stime">시작시간</label>
                    </div>
                    <div class="col-75">
                        <input type="datetime-local" id="stime" name="stime" step="1">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="etime">종료시간</label>
                    </div>
                    <div class="col-75">
                        <input type="datetime-local" id="etime" name="etime" step="1">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="Event">종목선택</label>
                    </div>
                    <div class="col-75">
                        <select id="Event" name="Event">
                            <option value="lol">리그 오브 레전드</option>
                            <option value="battleground">배틀그라운드</option>
                            <option value="overwatch">오버워치</option>
                            <option value="kartrider">카트라이더</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="memnum">목표 매치 인원</label>
                    </div>
                    <div class="col-75">
                        <input type="text" id="memnum" name="memnum">
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="etc">기타 요구사항</label>
                    </div>
                    <div class="col-75">
                        <textarea id="etc" name="etc" style="height:200px"></textarea>
                    </div>
                </div>
                <div class="row">
                    <input type="submit" value="완료">
                </div>
                  </form><%}else{ %>
            <script language="javascript">
            location.href="login.jsp";
            </script>
            <%} %>
        </div>
    </article>
</body>
</html>