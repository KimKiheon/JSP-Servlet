<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%
System.out.println("--------------------register.jsp--------------------");

%>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script language="javascript">
    function checkIt(){
    	if(!document.userinput.id.value){
    		alert("ID를 입력하세요");
    		document.userinput.id.focus();
    		return false;
    	}
    	if(!document.userinput.pw.value){
    		alert("Password를 입력하세요");
    		document.userinput.pw.focus();
    		return false;
    	}
    	if(!document.userinput.pwc.value){
    		alert("Password재입력 란에 입력하세요");
    		document.userinput.pwc.focus();
    		return false;
    	}
    	if(!(document.userinput.pwc.value
    			== document.userinput.pw.value)){
    		alert("Password가 일치하지 않습니다!");
    		document.userinput.pw.value="";
    		document.userinput.pwc.value="";
    		document.userinput.pw.focus();
    		return false;
    	}
    	if(!document.userinput.name.value){
    		alert("이름을 입력하세요");
    		document.userinput.name.focus();
    		return false;
    	}
    	if(!document.userinput.ktid.value){
    		alert("KAKAO id를 입력해주세요");
    		document.userinput.ktid.focus();
    		return false;
    	}
    	if(!document.userinput.email1.value){
    		alert("Email을 입력해주세요");
    		document.userinput.email1.focus();
    		return false;
    	}
    	if(!document.userinput.email2.value){
    		alert("Email이 정상적으로 입력되지 않았습니다.");
    		document.userinput.email2.focus();
    		return false;
    	}
    	if(document.userinput.idchk.value != "success"){
    		alert("id 중복 체크를 해주세요~");
    		document.userinput.id.focus();
    		return false;
    	}
    }
    
    function openConfirmid(inputid){
    	if(inputid.id.value == ""){
    		alert("중복 확인 에러 : ID를 입력하세요");
    		return ;
    	}
    	url = "ConfirmId?id="+inputid.id.value;
    	open(url,"confirm","toolbar=no, location=no,status=no,scrollbars=no,resizable=no,width=310,height=180");
    }
        
    function chgdomain3(){
    	if(document.userinput.endomain.value ==""){
    		document.userinput.email2.value="";
    		document.userinput.email2.focus();
    	}
    	else{
    		selectedIndex = document.userinput.endomain.options.selectedIndex;
    		console.log(selectedIndex);
    		document.userinput.email2.value =  document.userinput.endomain.options[selectedIndex].value;
    	}
    }
    function test(){
    	document.userinput.idchk.value="fail";
    }
    </script>
    <%
		if(session.getAttribute("id") != null) {
	%>
	<script language="javascript">
		location.href = "main.jsp";
	</script>
	<%
		}
	%>
</head>
<body>
   <header>
	<div id="HR">
        <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
       
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
	<br />
    <div class="shadow_eff2">
    
        <form name ="userinput" action="RegisterProc"
		method="post"
        onsubmit="return checkIt()">
            <div class="row">
                <div class="col-25">
                    <label for="name">이름</label>
                </div>
                <div class="col-75">
                    <input type="text" id="name" name="name" placeholder="홍길동">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="id">아이디</label>
                </div>
                <div class="col-75">
                    <input onchange ="test();" type="text" id="id" name="id" placeholder="ID" maxlength="10"><br />
                    <br /><input type="button" name="confirm_id" value="checkid" onclick="openConfirmid(this.form)" />
                    <input onchange="chkchange()" readonly type="textbox" id="idchk" name="idchk" value="ID중복체크 를 해주세요.">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="pw">비밀번호</label>
                </div>
                <div class="col-75">
                    <input type="password" id="pw" name="pw" placeholder="password" maxlength="10">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="pw">비밀번호 확인</label>
                </div>
                <div class="col-75">
                    <input type="password" id="pwc" name="pwc" placeholder="password" maxlength="10">
                </div>
            </div>
          <div class="row">
                <div class="col-25">
                    <label for="email">E-mail</label>
                </div>
                <div class="col-75">
                    <input type="textbox" id="email1" name="email1" placeholder="Email" maxlength="10">
                   @<input type="textbox" id="email2" name="email2" placeholder="Email2" maxlength="10">
                    <select name="endomain" id="sel_mail" onchange="chgdomain3();" >
                    <option value="">직접 입력</option>
                    <option value="daum.net">다음</option>
                    <option value="naver.com">네이버</option>
                    <option value="gmail.com">구글</option>
                    <option value="nate.com">네이트</option>
                    </select>
                </div>
            </div>
         
            <div class="row">
                <div class="col-25">
                    <label for="id">카카오톡 ID</label>
                </div>
                <div class="col-75">
                    <input type="text" id="ktid" name="ktid" placeholder="카카오톡ID" maxlength="20">
                </div>
            </div>
            <div class="row">
                <a href="main.jsp"> <input type="submit" value="회원가입" onclick="register();"></a>
            </div>
        </form>
    </div>
	<br />
	<br />
	<br>
	<br>
	<div class="foot">
        상호명 : CUKBM / 대표 : 가플리<br />
		전화 : 010 - 1234 - 5678<br />
		Facebook : object-oriented paradime	<br />
		Address : Catholic University Of Korea<br />
        Copyrightⓒ 2019 CUKBM. All rights reserved. E-mail : cukbm2@catholic.ac.kr
	</div>
</body>
</html>