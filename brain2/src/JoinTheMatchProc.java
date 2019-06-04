
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
 * -��ġ ���� ó�� ����
 * 1. MatchVO�� ������ ��ġ ������ ����
 * 2. PeopleVO�� ������ ������ �����ϴ� ��ġ ������ ����
 * 3. people ���̺� ������ ���� ����
 * 4. ������ ��ġ�� nowman+=1 ����
 * 5. ��ġ�� ��ǥ�ο��� �����ο��� ��ġ�Ѵٸ� ��ġ ������ �˸����̺� ����
 * 6. �ο� ������ �׳� �˸�
 * 
 * �˸�����
 * -1- ��ġ�ο� ������
 * -2- ��ġ�ο� ������
 * -3- ��¥ ������ �� // ���⼭���� �ȵ�
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
		System.out.println("<<<<<<<<<<<<<<<<<<< JoinTheMatchProc ���� >>>>>>>>>>>>>>>>>>>>>");
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

		try {
			// ������ DB����
			conn = Myconn.getConn();
			peoplevo.setJoinman(jm);
			peoplevo.setMatchseqNo(msn);
			peoplevo.setFlag(f);
			PeopleDAO.Insert(peoplevo);
			System.out.println("JoinTheMatchProc : DB Insert ����!");

			// Match nowman+=1
			MatchDAO.Update(vo);
			System.out.println("JoinTheMatchProc : DB Update ����!");
			
			//��ġ�ο� ���� Ȯ�� ��ġ �Ϸ� �˶�
			vo = matchdao.getMatches(Integer.parseInt(request.getParameter("seqNo")));
			if(vo.getNowman() == vo.getNeedman()) {
				AlarmVO alarmvo = new AlarmVO();
				alarmvo.setCreateman(vo.getWriter());
				alarmvo.setJoinman(session.getAttribute("id").toString());
				alarmvo.setKind(1);
				alarmvo.setFinishtime(java.sql.Timestamp.valueOf(vo.getEtime()));
				alarmvo.setFlag(0);
				alarmvo.setMatchseqNo(vo.getSeqNo());
				AlarmDAO.Insert(alarmvo);
			}
			//�ο� ������ �˶�
			vo = matchdao.getMatches(Integer.parseInt(request.getParameter("seqNo")));
			if(session.getAttribute("id").toString() != vo.getWriter()) {
				AlarmVO alarmvo = new AlarmVO();
				alarmvo.setCreateman(vo.getWriter());
				alarmvo.setJoinman(session.getAttribute("id").toString());
				alarmvo.setKind(2);
				alarmvo.setFinishtime(java.sql.Timestamp.valueOf(vo.getEtime()));
				alarmvo.setFlag(0);
				alarmvo.setMatchseqNo(vo.getSeqNo());
				AlarmDAO.Insert(alarmvo);
			}
			response.sendRedirect("viewmatch.jsp?seqNo="+vo.getSeqNo());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("<<<<<<<<<<<<<<<<<<< JoinTheMatchProc ���� >>>>>>>>>>>>>>>>>>>>>");
	}
}
