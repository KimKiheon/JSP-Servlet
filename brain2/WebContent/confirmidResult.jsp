<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>ID중복 체크</title>
</head>
<body>
<%
String result = request.getParameter("result");
String id = request.getParameter("id");
if(result.equals("can")){
%>
<center>
<b><font color = "red"><%=id %>는</font></b><br>
<b><font color = "red">사용하실 수 있는 ID입니다.</font></b>
<br><br>
<input type="button" value="닫기" onclick="setid()">
</center>
<%
} else {
%>
<center>
<b><font color = "red"><%=id %>는</font></b><br>
<b><font color = "red">이미 사용중인 ID입니다.</font></b>
<input type="button" value="닫기" onclick="resetid()">

<br><br>
</center>
<%} %>
<script language="javascript">
function setid(){
	opener.document.userinput.id.value="<%=id%>";
	opener.document.userinput.idchk.value="success";
	window.close();
	opener.wirteForm.pw.focus();
}
function resetid(){
	opener.document.userinput.idchk.value="fail";
	window.close();
	opener.wirteForm.id.focus();
}
</script>
</body>
</html>