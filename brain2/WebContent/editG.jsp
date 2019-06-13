<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
    
    <%
    request.setCharacterEncoding("euc-kr");
    String code = (String)session.getAttribute("code");
	System.out.printf("세션 code : %s\n", code);
    String writer =	(String)session.getAttribute("writer");
	System.out.printf("세션 writer : %s\n", writer);
    String title = (String)session.getAttribute("title");
	System.out.printf("세션 title : %s\n", title);
    String price = (String)session.getAttribute("price");
	System.out.printf("세션 price : %s\n", price);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 정보 관리</title>
</head>
<body>
<h4>상품 정보를 수정한 후 수정 버튼을 누르세요</h4>
<form action="UpdateG" method="post">
코드 : <input type="text" name="code" size="5" value="<%=code %>" readonly=true><br>
제목 : <input type="text" name="title" size="50" value="<%=title%>"><br>
저자: <INPUT TYPE=TEXT NAME=writer SIZE=20 VALUE= "<%=writer %>"> <BR>
가격: <INPUT TYPE=TEXT NAME=price SIZE=8 VALUE= "<%=price%>">원 <BR>
<INPUT TYPE=SUBMIT VALUE= "수정">
<br>
</form>
</body>
</html>