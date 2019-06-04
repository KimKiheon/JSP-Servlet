
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.sql.Date;
import vo.Myconn;
import vo.MatchVO;
import vo.MemberVO;
import vo.PeopleVO;
import dao.MatchDAO;
import dao.MemberDAO;
import dao.PeopleDAO;

/*
 * UpdateMatchProc.java
 * - ��ġ ���� ����
 * 1. MatchVO�� ����� �� ������ matches���̺� ������Ʈ(��ġ ����)
 */
@WebServlet("/UpdateMatchProc")
public class UpdateMatchProc extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		System.out.println("<<<<<<<<<<<<<<<<<<< UpdateMatchProc ���� >>>>>>>>>>>>>>>>>>>>>");
		HttpSession session = request.getSession();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MatchVO vo = new MatchVO();
		PeopleVO peoplevo = new PeopleVO();
		String st = request.getParameter("stime");
		String et = request.getParameter("etime");
		try {
			// ��ġ DB����
			conn = Myconn.getConn();
			vo.setSeqNo(Integer.parseInt(request.getParameter("seqNo")));
			vo.setTitle(request.getParameter("title"));
			System.out.println(" <<<<<<<<<<<<<<<"+request.getParameter("title"));
			vo.setStime(st);
			vo.setEtime(et);
			vo.setContents(request.getParameter("contents"));
			vo.setAddr(request.getParameter("addr"));
			vo.setTeamflag(Integer.parseInt(request.getParameter("teamflag")));
			vo.setFlag1(Integer.parseInt(request.getParameter("flag1")));
			vo.setFlag2(request.getParameter("flag2"));
			vo.setNeedman(Integer.parseInt(request.getParameter("needman")));
			vo.setNowman(Integer.parseInt(request.getParameter("nowman")));
			MatchDAO.UpdateMatch(vo);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("<<<<<<<<<<<<<<<<<<< UpdateMatchProc ���� >>>>>>>>>>>>>>>>>>>>>");
		response.sendRedirect("jointhematch.jsp");
	}
}
