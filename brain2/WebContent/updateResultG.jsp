<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%
    String code = (String)session.getAttribute("code");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<H4>��ǰ ������ �����Ǿ����ϴ�.</H4>
������ ������ ��ȸ�Ϸ��� �Ʒ��� ��ũ�� Ŭ���ϼ���. <BR><BR>
<A HREF=editG.jsp?code=<%=code %>>��ǰ ���� ��ȸ</A>
</body>
</html>