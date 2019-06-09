

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.AlarmDAO;
import dao.MatchDAO;
import dao.MemberDAO;
import dao.PeopleDAO;
import vo.AlarmVO;
import vo.MatchVO;
import vo.MemberVO;
import vo.Myconn;
import vo.PeopleVO;


@SuppressWarnings("serial")
@WebServlet("/JoinMatchCancelProc")
public class JoinMatchCancelProc extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		System.out.println("<<<<<<<<<<<<<<<<<<< JoinMatchCancelProc ���� >>>>>>>>>>>>>>>>>>>>>");
		HttpSession session = request.getSession();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		MatchDAO matchdao = new MatchDAO();
		MatchVO vo = new MatchVO();
		MemberVO mvo = new MemberVO();
		vo = matchdao.getMatches(Integer.parseInt(request.getParameter("seqNo")));

		PeopleVO peoplevo = new PeopleVO();

		String jm = (String) session.getAttribute("id");
		int msn = Integer.parseInt(request.getParameter("seqNo"));
		int f = 0;
		boolean bool;
		String result=null;
		try {
			// ������ DB����
			conn = Myconn.getConn();
			peoplevo.setJoinman(jm);
			peoplevo.setMatchseqNo(msn);
			PeopleDAO.Delete(peoplevo);
			System.out.println("JoinTheMatchProc : �ش� DB seqNo ���� ����!");

			// Match nowman-=1
			MatchDAO.UpdateDelete(vo);
			System.out.println("JoinTheMatchProc : DB Update ����!");
			
			mvo.setId(jm);
			bool = MemberDAO.deleteMatch(mvo);
			if(bool == true) System.out.println("�ش� member all decrease success");
			else System.out.println("�ش� member all decrease fail");
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("<<<<<<<<<<<<<<<<<<< JoinTheMatchCancelProc ���� >>>>>>>>>>>>>>>>>>>>>");
		response.sendRedirect("jointhematch.jsp");
	}

}
