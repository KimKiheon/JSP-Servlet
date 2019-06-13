

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import vo.Myconn;
@WebServlet("/UpdateG")
public class UpdateG extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		Connection conn = null;
		PreparedStatement pstmt = null;
		HttpSession session = request.getSession();
		System.out.println("UpdateG");
		String title = request.getParameter("title");
		String code  = request.getParameter("code");
		String writer = request.getParameter("writer");
		String price = request.getParameter("price");
		try {
			conn = Myconn.getConn();
			String sql ="update goodinfo set title=?, writer=?, price=? where code=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, writer);
			pstmt.setString(3, price);
			pstmt.setString(4, code);
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("update 완료");
				session.setAttribute("title", title);
				session.setAttribute("writer", writer);
				session.setAttribute("price", price);
				session.setAttribute("code", code);
				response.sendRedirect("updateResultG.jsp");
				//response.sendRedirect("updateResultG.jsp?code="+code+"&title="+title+"&writer="+writer+"&price="+price);
			}
			else System.out.println("update 실패");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
