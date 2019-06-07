<%@ page language="java" contentType="text/html; charset=utf8"
   pageEncoding="utf8"%>
<%@page import="vo.MemberVO"%>
<%@page import="dao.MemberDAO"%>
<%@page import="vo.MatchVO"%>
<%@page import="dao.MatchDAO"%>
<%@page import="vo.PeopleVO"%>
<%@page import="dao.PeopleDAO"%>
 <%@ page import="java.util.ArrayList"%>
<%
response.setHeader("Pragma", "no-cache"); //HTTP 1.0
response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
response.setHeader("Cache-Control", "no-store"); //HTTP 1.1
response.setDateHeader("Expires", 0L); // Do not cache in proxy server
%>
<!DOCTYPE html>
<%
   System.out.println("--------------------mypage.jsp--------------------");

   String id = (String) session.getAttribute("id");
   if (id == null) {
      System.out.println("로그인 미완료 : login.jsp로 이동합니다....\n");
   } else
      System.out.printf("Now User ID : %s\n", id);

   MemberVO vo = new MemberVO();
   MemberDAO dao = new MemberDAO();
   vo = dao.getInfo(id);
   int succ = vo.getSuccessMatch();
   int all = vo.getAllMatch();
   double avg = 0;
   if (succ == 0)
      avg = 0;
   else
      avg = (double) (succ / all) * 100;

   //BBS View
   int pageNumber = 1;
   if (request.getParameter("pageNumber") != null) {
      pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
   }
%>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<title>My Page</title>
<link rel="stylesheet" type="text/css" href="style.css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      if(<%=all%> != 0){
         google.charts.setOnLoadCallback(drawChart);
      }
      else{
         google.charts.setOnLoadCallback(defaultDrawChart);
      }
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Effort', 'Amount given'],
          ['참석', <%=succ%>],
          ['불참', <%=all - succ%>]
        ]);
        var options = {
          title: 'Match Success Rate',
          pieHole: 0.5,
          'width': 350,
          chartArea:{
               left:10,
               right:10, // !!! works !!!
               bottom:20,  // !!! works !!!
               top:20,
               width:"100%",
               height:"80%"
             },
          pieSliceTextStyle: {
            color: 'white',
            fontSize: 9,
          },

          tooltip: {trigger: 'selection'},
        };

        var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
        chart.draw(data, options);
      }
      
      function defaultDrawChart() {
          var data = google.visualization.arrayToDataTable([
            ['Effort', 'Amount given'],
            ['no match', 1],
            ['no 1', 0],
            ['no 2', 0],
            ['no 3', 0],
            ['no 4', 0],
          ]);

          var options = {
                title: '아직 매치를 실시하지 않으셨습니다.',
                pieHole: 0.5,
                  'width': 350,
                  chartArea:{
                       left:10,
                       right:10, // !!! works !!!
                       bottom:20,  // !!! works !!!
                       top:20,
                       width:"80%",
                       height:"80%",
                     },
                  pieSliceText: 'none',
                  pieSliceTextStyle: {
                    color: 'white',
                  },
                  legend: 'none',
                  tooltip: {trigger: 'none',},
                  enableInteractivity:'false',
                  
                  colors: ['grey','green'],
          };

          var chart = new google.visualization.PieChart(document.getElementById('donut_single'));
          chart.draw(data, options);
        }
    </script>
</head>
<body>

 <header>
	<div id="HR">
        <%if (id == null) {%>
        <a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
         <%} 
         else {%>
          <a href="mypage.jsp"><%=id %></a> | <a href="LogoutProc">로그아웃</a>
        <%} %> | <a href="alarm.jsp">ALARM</a>
        </div>
		<div class="menu">
				<div id="HL"> <img src="image/basketball.png" width="30" height="30" />&nbsp;<a href="main.jsp">CUKBM</a>
				<span style="font-color:gray; font-size:10px; font-family:고딕">가톨릭대학교 Sports Matching Service</span>
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
				<br><br>
   <%
      if (id == null) {
   %>
   <script language="javascript">
      location.href = "login.jsp";
   </script>
   <%
      } else {
   %>
   <div class="shadow_eff2">
   <form method="get">
         <!--getParameter-->
        <div class="makeinner">
	<h2><%=id %>&nbsp;&nbsp;<span style="font-size:15px;">님 MyPage</span></h2>
	<div style="background-color:#f3f3f3; height:2px; width:100%;">
				</div></div>
   
      <br />
        <div class="makeinner" style="vertical-align:middle; text-align:center;">
	<h2 style="text-align:center;"><span style="font-size:15px;">RATIO</span></h2>
	<div style="background-color:#8080ff; height:2px; width:30%; margin:auto;">
				</div></div>
				<br><br>
      <table class="t" border="1">
         <tr>
            <td style="background: lightgray;">전체 매칭 시도수</td>
            <td><%=all%> 회</td>
            <td rowspan="3"><div id="donut_single" style=" margin:0%; width:50px; float:auto;"></div></td>
         </tr>
         <tr>
            <td style="background: lightgray;">매칭 성공 수</td>
            <td><%=succ%> 회</td>
         </tr>
         <tr>
            <td style="background: lightgray;">매칭 성공률</td>
            <td><%=avg%> %</td>
      </table>
      <br />
     <div class="makeinner" style="vertical-align:middle; text-align:center;">
	<h2 style="text-align:center;"><span style="font-size:15px;">현재 참가중인 매치</span></h2>
	<div style="background-color:#8080ff; height:2px; width:30%; margin:auto;">
				</div></div>
      <br />
      <hr style="MARGIN: auto; width: 80%; border-style: solid" />

      <table class="t" border="1">
         <thead>
            <tr>
               <th style="background-color: #eeeeee; text-align: center;">게시글
                  번호</th>
               <th style="background-color: #eeeeee; text-align: center;">제목</th>
               <th style="background-color: #eeeeee; text-align: center;">시작</th>
               <th style="background-color: #eeeeee; text-align: center;">종료</th>
               <th style="background-color: #eeeeee; text-align: center;">최대인원</th>
               <th style="background-color: #eeeeee; text-align: center;">참가인원</th>
               <th style="background-color: #eeeeee; text-align: center;">작성자</th>
            </tr>
         </thead>
         <tbody>
            <%
               ArrayList<PeopleVO> list = PeopleDAO.getList(pageNumber, id);
                  for (int i = 0; i < list.size(); i++) {
                     MatchVO match = new MatchVO();
                     MatchDAO matchdao = new MatchDAO();
                     match = matchdao.getMatches(list.get(i).getMatchseqNo());
            %>
            <tr>
               <td style="width:9%; text-align: center;"><%=list.get(i).getSeqNo()%></td>
               <td style="text-align: center;"><a
                  href="viewmatch.jsp?seqNo=<%=list.get(i).getMatchseqNo()%>"><%=match.getTitle()%></a></td>
               <td style="text-align: center;"><%=match.getStime()%></td>
               <td style="text-align: center;"><%=match.getEtime()%></td>
               <td style="width:8%; text-align: center;"><%=match.getNeedman()%></td>
               <td style="width:8%; text-align: center;"><%=match.getNowman()%></td>
               <td style="text-align: center;"><%=match.getWriter()%></td>
            </tr>
            <%
               }
            %>
         </tbody>
      </table>

   </form>
   </div>
   <%
      }
   %>
   <br />
   <br />
   <br />
   <br />
   <br />
   <br />
   <br />
   <div class="foot">
      number : 010 - 1234 - 5678<br /> Facebook : object-oriented paradime
      <br /> address : catholic university<br /> name : hong gil dong
   </div>

</body>
</html>