<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
    <%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
﻿<!DOCTYPE html>
<%
System.out.println("--------------------login.jsp--------------------");
String result =request.getParameter("result");
String id = request.getParameter("id");
String rresult = request.getParameter("regiresult");
if(result != null){
if(result.equals("idno")) 
{%>
<script language="javascript">
alert("ID가 존재하지 않습니다.");
document.userinput.id.value="";
</script>
<%} 
if(result.equals("passwdno")) {%>
<script language="javascript">
alert("PW가 일치하지 않습니다.");
document.userinput.id.value=id;
document.userinput.pw.value="";
document.userinput.pw.focus();
</script>
<%}
if(result.equals("regisuccess")) 
{%>
<script language="javascript">
alert("회원가입 성공했습니다 로그인 해 주세요");
document.userinput.id.value="";
</script>
<script type="text/javascript">

		window.history.forward();

		function noBack() {

			window.history.forward();

		}

         </script>
<%}}%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <style>
      #HEADER {
         background: white;
      }

      a {
         text-decoration: none;
         color: black;
      }

      #HL {
         text-align: center;
         font-size: 35px;
      }
      
      #loginarea{
          margin-left:30%;
          margin-right:30%;
      }
      .menubar {
         display: flex;
         background: black;
      }

      .title {
         margin-right: auto;
         color: white;
         font-size: 30px;
      }
      a:hover{
          color:blue;
      }
    </style>
    <script language ="javascript">
    function login(){
    	if(!document.userinput.id.value){
    		alert("ID를 입력하세요");
    		document.userinput.id.focus();
    		return false;
    	}
    	if(!document.userinput.pw.value){
    		alert("PassWord를 입력하세요");
    		document.userinput.pw.focus();
    		return false;
    	}
    }
    document.userinput.reset();
    </script>
        <%if(session.getAttribute("id") != null){ %>
	 <script language="javascript">
           location.href="main.jsp";
           </script> System.out.println("이미 로그인 되어 있습니다.");	<%}%>
</head>
<body onload="document.userinput.reset();">
    <header>
        <div id="HL"> &nbsp;<a href="main.jsp">CUKBM</a></div>
        <div id="HR"><a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a> | <a href="alarm.jsp">ALARM</a></div>
        <br />
        <div class="header">
            <div class="title">&nbsp;Main Page</div>
            <div class="menu">
            <div class="dropdown" style="float:right;">
                <button class="dropbtn"><img src="image/menubar.png" width="30" height="30" /></button>
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
    <article>
        <h2>로그인</h2><br /><br />
        <div id="loginarea">
        <form action="LoginProc" method="post" name="userinput" id ="userinput"  onsubmit="return login()"> 
            <input type="text" name ="id" id="id" maxlength="50" title="id" placeholder="  아이디"><br /><br />
            <input type="text" name="pw" id="pw" maxlength="50" placeholder="  비밀번호"/><br /><br />
            <input type="submit" id="sb"value="로 그 인" /><br /><br />
        </form>
            <h6>아직 회원이 아니신가요? <a href="register.jsp">&nbsp;&nbsp;&nbsp;&nbsp;회원가입하기</a></h6>    
        </div>
    </article>
</body>
</html>