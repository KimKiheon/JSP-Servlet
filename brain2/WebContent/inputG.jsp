<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%String result = request.getParameter("pr");
    if(result!=null){%>
    <script language="javascript">
    alert("해당 코드를 가진 상품은 존재하지 않습니다!!");
    </script>
    <%} %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>상품 정보 관리</title>
</head>
<body>
 <H4>상품코드를 입력하세요.</H4>
 <FORM ACTION=ReaderG METHOD=post>
  상품코드: <INPUT TYPE=text NAME=code SIZE=5>
 <INPUT TYPE=SUBMIT VALUE="확인">
 </FORM>
</body>
</html>