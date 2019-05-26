<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
    <%@page import="vo.MemberVO" %>
     <%@page import="dao.MemberDAO" %>
﻿<!DOCTYPE html>
<%
String id = (String)session.getAttribute("id");
System.out.printf("now id : %s\n",id);
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
    <style>
    .hidden{
    display:none;
    }
      #HEADER {
         background: white;
      }

      #HR {
         text-align: right;
      }

      a {
         text-decoration: none;
         color: black;
      }

      #HL {
         text-align: center;
         font-size: 35px;
         
      }
    .header {
         display:flex;
         background: black;
      }
      .title {
         margin-right: auto;
         color: white;
         font-size: 30px;
      }
      #thematch{
          font-size:15px
      }
      #articleheader{
          font-size:30px;
          background-color:white;
      }
      #hr{
          padding:3px;
      }
    </style>
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
    </script>
</head>
<body>
    <header>
        <div id="HL"> &nbsp;<a href="main.html">CUKBM</a></div>

       <div id="HR"> <%if (id == null) {%>
        <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
         <%} 
         else {%>
          <a href="mypage.jsp"><%=id %></a> | <a href="LogoutProc">로그아웃</a>
        <%} %> | <a href="alarm.jsp">ALARM</a></div>
        <br />
    </header>
    <div class="header">
        <div class="title">&nbsp;Make&nbsp;<span id="thematch">The&nbsp;Match</span></div>
        <div class="menu"><img src="image/menubar.png" /></div>
    </div>
    <article>
        <div id="articleheader">Athletic Sports</div>
        <hr id="hr"/>
       	<div class="container">  <%if (id != null) {%>
            <form action="MakeAsportsProc" method="post" name="userinput" onsubmit="return checkIt()">
                <div class="hidden">
                        <input type="number" id="flag1" name="flag1" readonly value="1">
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
                        <input type="text" id="place" name="place" >
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="teamQ">팀/개인 여부</label>
                    </div>
                    <div class="col-75">
                        <select id="teamfa" name="teamflag">
                            <option value=1>팀</option>
                            <option value=2>개인</option>
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
                        <label for="AEvent">종목선택</label>
                    </div>
                    <div class="col-75">
                        <select id="AEvent" name="AEvent">
                            <option value="축구">축구</option>
                            <option value="농구">농구</option>
                            <option value="테니스">테니스</option>
                            <option value="배드민턴">배드민턴</option>
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