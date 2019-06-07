
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.sql.Date;
import java.util.ArrayList;

import vo.Myconn;
import vo.MatchVO;
import vo.MemberVO;
import vo.PeopleVO;
import dao.MatchDAO;
import dao.MemberDAO;
import dao.PeopleDAO;

/*
 * UpdatePeopleProc.java
 * - 참가자정보 업데이트 서블릿
 * 1. 
 */
@WebServlet("/UpdatePeopleProc")
public class UpdatePeopleProc extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		System.out.println("<<<<<<<<<<<<<<<<<<< UpdatePeopleProc 실행 >>>>>>>>>>>>>>>>>>>>>");
		HttpSession session = request.getSession();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MatchVO vo = new MatchVO();
		PeopleVO peoplevo = new PeopleVO();
		int seqNo = Integer.parseInt(request.getParameter("seqNo"));
		try {
			// 매칭확인 후 삽입
			ArrayList<PeopleVO> list = PeopleDAO.getList(1, seqNo);
			for (int i = 0; i < list.size(); i++) {
				MemberVO membervo = new MemberVO();
				MemberDAO memberdao = new MemberDAO();
				membervo = memberdao.getInfo(list.get(i).getJoinman());
				String result = request.getParameter(membervo.getId());
				System.out.println("<<<<<<<<<<<<<<<<<<< "+result+" >>>>>>>>>>>>>>>>>>>>>");
				memberdao.updateInfo(membervo.getId());
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("<<<<<<<<<<<<<<<<<<< UpdatePeopleProc 종료 >>>>>>>>>>>>>>>>>>>>>");
		response.sendRedirect("alarm.jsp");
	}
}
