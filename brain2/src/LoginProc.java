

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
		System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc 실행 >>>>>>>>>>>>>>>>>>>>>");
		PreparedStatement pstmt = null;
		Connection conn = null;
		ResultSet rs = null;
		String id = request.getParameter("id");
		System.out.printf("입력받은 ID : %s\n",id);

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
				System.out.printf("입력받은 password : %s\n",userpass);
				System.out.println("ID 일치\n");
				if(userpass.equals(passwd)) {
					//id passwd 일치
					System.out.println("password 일치\n\n");
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc 성공 >>>>>>>>>>>>>>>>>>>>>");
					response.sendRedirect("main.jsp");
				}
				else {
					System.out.println("Password 불 일치 : 로그인 실패\n");
					System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc 실패 >>>>>>>>>>>>>>>>>>>>>");

					result = "passwdno";
					response.sendRedirect("login.jsp?result="+result+"&id="+id);

					//passwd 불일치
				}
			}
			else {
				result = "idno";
				response.sendRedirect("login.jsp?result="+result);

				System.out.println("ID 없음 : 로그인 실패\n");
				System.out.println("<<<<<<<<<<<<<<<<<<< LoginProc 실패 >>>>>>>>>>>>>>>>>>>>>");

				// id가 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
