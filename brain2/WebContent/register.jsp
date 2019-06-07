<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%
System.out.println("--------------------register.jsp--------------------");

%>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>ȸ������</title>
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script language="javascript">
    function checkIt(){
    	if(!document.userinput.id.value){
    		alert("ID�� �Է��ϼ���");
    		document.userinput.id.focus();
    		return false;
    	}
    	if(!document.userinput.pw.value){
    		alert("Password�� �Է��ϼ���");
    		document.userinput.pw.focus();
    		return false;
    	}
    	if(!document.userinput.pwc.value){
    		alert("Password���Է� ���� �Է��ϼ���");
    		document.userinput.pwc.focus();
    		return false;
    	}
    	if(!(document.userinput.pwc.value
    			== document.userinput.pw.value)){
    		alert("Password�� ��ġ���� �ʽ��ϴ�!");
    		document.userinput.pw.value="";
    		document.userinput.pwc.value="";
    		document.userinput.pw.focus();
    		return false;
    	}
    	if(!document.userinput.name.value){
    		alert("�̸��� �Է��ϼ���");
    		document.userinput.name.focus();
    		return false;
    	}
    	if(!document.userinput.ktid.value){
    		alert("KAKAO id�� �Է����ּ���");
    		document.userinput.ktid.focus();
    		return false;
    	}
    	if(!document.userinput.email1.value){
    		alert("Email�� �Է����ּ���");
    		document.userinput.email1.focus();
    		return false;
    	}
    	if(!document.userinput.email2.value){
    		alert("Email�� ���������� �Էµ��� �ʾҽ��ϴ�.");
    		document.userinput.email2.focus();
    		return false;
    	}
    	if(document.userinput.idchk.value != "success"){
    		alert("id �ߺ� üũ�� ���ּ���~");
    		document.userinput.id.focus();
    		return false;
    	}
    }
    
    function openConfirmid(inputid){
    	if(inputid.id.value == ""){
    		alert("�ߺ� Ȯ�� ���� : ID�� �Է��ϼ���");
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
        <a href="login.jsp">�α���</a> | <a href="register.jsp">ȸ������</a>
       
        </div>
		<div class="menu">
				<div id="HL"> <img src="image/basketball.png" width="30" height="30" />&nbsp;<a href="main.jsp">CUKBM</a>
				<span style="color:gray; font-size:10px; font-family:���">���縯���б� Sports Matching Service</span>
           		 <div class="dropdown" style="float:right;">
                <button class="dropbtn"><img src="image/menubar.png" width="20" height="20" /></button>
                <div class="dropdown-content">
                    <a href="login.jsp">�α���</a>
                    <a href="register.jsp">ȸ�� ����</a>
                    <a href="alarm.jsp">�˸�</a>
                    <a href="makethematch.jsp">��ġ ����</a>
                    <a href="jointhematch.jsp">��ġ ����</a>
                    <a href="mypage.jsp">���� ������</a>
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
                    <label for="name">�̸�</label>
                </div>
                <div class="col-75">
                    <input type="text" id="name" name="name" placeholder="ȫ�浿">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="id">���̵�</label>
                </div>
                <div class="col-75">
                    <input onchange ="test();" type="text" id="id" name="id" placeholder="ID" maxlength="10"><br />
                    <br /><input type="button" name="confirm_id" value="checkid" onclick="openConfirmid(this.form)" />
                    <input onchange="chkchange()" readonly type="textbox" id="idchk" name="idchk" value="ID�ߺ�üũ �� ���ּ���.">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="pw">��й�ȣ</label>
                </div>
                <div class="col-75">
                    <input type="password" id="pw" name="pw" placeholder="password" maxlength="10">
                </div>
            </div>
            <div class="row">
                <div class="col-25">
                    <label for="pw">��й�ȣ Ȯ��</label>
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
                    <option value="">���� �Է�</option>
                    <option value="daum.net">����</option>
                    <option value="naver.com">���̹�</option>
                    <option value="gmail.com">����</option>
                    <option value="nate.com">����Ʈ</option>
                    </select>
                </div>
            </div>
         
            <div class="row">
                <div class="col-25">
                    <label for="id">īī���� ID</label>
                </div>
                <div class="col-75">
                    <input type="text" id="ktid" name="ktid" placeholder="īī����ID" maxlength="20">
                </div>
            </div>
            <div class="row">
                <a href="main.jsp"> <input type="submit" value="ȸ������" onclick="register();"></a>
            </div>
        </form>
    </div>
	<br />
	<br />
	<br>
	<br>
	<div class="foot">
        ��ȣ�� : CUKBM / ��ǥ : ���ø�<br />
		��ȭ : 010 - 1234 - 5678<br />
		Facebook : object-oriented paradime	<br />
		Address : Catholic University Of Korea<br />
        Copyright�� 2019 CUKBM. All rights reserved. E-mail : cukbm2@catholic.ac.kr
	</div>
</body>
</html>