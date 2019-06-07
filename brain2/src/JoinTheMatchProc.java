
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MatchDAO;
import dao.MemberDAO;
import dao.PeopleDAO;
import dao.AlarmDAO;
import vo.MatchVO;
import vo.Myconn;
import vo.PeopleVO;
import vo.AlarmVO;

/*
 * JoinTheMatchProc.java
 * -매치 참가 처리 서블릿
 * 1. MatchVO에 참가할 매치 정보를 넣음
 * 2. PeopleVO에 참가자 정보와 참가하는 매치 정보를 넣음
 * 3. people 테이블에 참가자 정보 삽입
 * 4. 참가한 매치의 nowman+=1 해줌
 * 5. 매치의 목표인원과 현재인원이 일치한다면 매치 생성자 알림테이블에 삽입
 */

@WebServlet("/JoinTheMatchProc")
public class JoinTheMatchProc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public JoinTheMatchProc() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		System.out.println("<<<<<<<<<<<<<<<<<<< JoinTheMatchProc 실행 >>>>>>>>>>>>>>>>>>>>>");
		HttpSession session = request.getSession();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		MatchDAO matchdao = new MatchDAO();
		MatchVO vo = new MatchVO();
		vo = matchdao.getMatches(Integer.parseInt(request.getParameter("seqNo")));

		PeopleVO peoplevo = new PeopleVO();

		String jm = (String) session.getAttribute("id");
		int msn = Integer.parseInt(request.getParameter("seqNo"));
		int f = 0;
		String result=null;
		try {
			// 참가자 DB삽입
			conn = Myconn.getConn();
			peoplevo.setJoinman(jm);
			peoplevo.setMatchseqNo(msn);
			peoplevo.setFlag(f);
			PeopleDAO.Insert(peoplevo);
			System.out.println("JoinTheMatchProc : DB Insert 성공!");

			// Match nowman+=1
			MatchDAO.Update(vo);
			System.out.println("JoinTheMatchProc : DB Update 성공!");
			
			//매치인원 충족 확인 매치 완료 알람
			vo = matchdao.getMatches(Integer.parseInt(request.getParameter("seqNo")));
			
				AlarmVO alarmvo = new AlarmVO();
				alarmvo.setCreateman(vo.getWriter());
				alarmvo.setJoinman(session.getAttribute("id").toString());

				alarmvo.setFinishtime(java.sql.Timestamp.valueOf(vo.getEtime()));
				alarmvo.setFlag(0);
				alarmvo.setMatchseqNo(vo.getSeqNo());
				if(vo.getNowman() == vo.getNeedman()) {
				alarmvo.setKind(2);
				AlarmDAO.Insert(alarmvo);
				}
				alarmvo.setKind(1);
				AlarmDAO.Insert(alarmvo);
				result = "success";
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("<<<<<<<<<<<<<<<<<<< JoinTheMatchProc 종료 >>>>>>>>>>>>>>>>>>>>>");
		response.sendRedirect("viewmatch.jsp?result="+result+"&seqNo="+msn);
	}
}
