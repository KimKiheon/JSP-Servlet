<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="EUC-KR">
<title>ID�ߺ� üũ</title>
</head>
<body>
<%
String result = request.getParameter("result");
String id = request.getParameter("id");
if(result.equals("can")){
%>
<center>
<b><font color = "red"><%=id %>��</font></b><br>
<b><font color = "red">����Ͻ� �� �ִ� ID�Դϴ�.</font></b>
<br><br>
<input type="button" value="�ݱ�" onclick="setid()">
</center>
<%
} else {
%>
<center>
<b><font color = "red"><%=id %>��</font></b><br>
<b><font color = "red">�̹� ������� ID�Դϴ�.</font></b>
<input type="button" value="�ݱ�" onclick="resetid()">

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