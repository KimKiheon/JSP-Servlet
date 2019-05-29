

import java.io.IOException;
import vo.Myconn;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import javax.servlet.*;

@WebServlet("/LoginProc")
public class LoginProc extends HttpServlet {   
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc ���� >>>>>>>>>>>>>>>>>>>>>");
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		String id = request.getParameter("id");
		System.out.printf("�Է¹��� ID : %s\n",id);

		String passwd = request.getParameter("pw");
		try {
			conn = Myconn.getConn();
			String sql = "select * from members where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			String result =null;
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String userpass = rs.getString("passwd");
				System.out.printf("�Է¹��� password : %s\n",userpass);
				System.out.println("ID ��ġ\n");
				if(userpass.equals(passwd)) {
					//id passwd ��ġ
					System.out.println("password ��ġ\n\n");
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc ���� >>>>>>>>>>>>>>>>>>>>>");

					response.sendRedirect("main.jsp");
				}
				else {
					System.out.println("Password �� ��ġ : �α��� ����\n");
					System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc ���� >>>>>>>>>>>>>>>>>>>>>");

					result = "passwdno";
					response.sendRedirect("login.jsp?result="+result+"&id="+id);

					//passwd ����ġ
				}
			}
			else {
				result = "idno";
				response.sendRedirect("login.jsp?result="+result);

				System.out.println("ID ���� : �α��� ����\n");
				System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc ���� >>>>>>>>>>>>>>>>>>>>>");

				// id�� ����
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
