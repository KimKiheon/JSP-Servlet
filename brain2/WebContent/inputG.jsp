<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%String result = request.getParameter("pr");
    if(result!=null){%>
    <script language="javascript">
    alert("�ش� �ڵ带 ���� ��ǰ�� �������� �ʽ��ϴ�!!");
    </script>
    <%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>��ǰ ���� ����</title>
</head>
<body>
 <H4>��ǰ�ڵ带 �Է��ϼ���.</H4>
 <FORM ACTION=ReaderG METHOD=post>
  ��ǰ�ڵ�: <INPUT TYPE=text NAME=code SIZE=5>
 <INPUT TYPE=SUBMIT VALUE="Ȯ��">
 </FORM>
</body>
</html>