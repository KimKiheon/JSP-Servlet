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
<H4>상품 정보가 수정되었습니다.</H4>
수정된 정보를 조회하려면 아래의 링크를 클릭하세요. <BR><BR>
<A HREF=editG.jsp?code=<%=code %>>상품 정보 조회</A>
</body>
</html>