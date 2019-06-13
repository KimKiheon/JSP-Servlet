

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import vo.Myconn;
/**
 * Servlet implementation class ReaderG
 */
@WebServlet("/ReaderG")
public class ReaderG extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("ReaderG");
		String code = request.getParameter("code");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String title= null;
		String writer=null;
		String price =null;
		HttpSession session = request.getSession();
		try {
			conn = Myconn.getConn();
			String sql = "select * from goodinfo where code=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code);
			rs = pstmt.executeQuery();
			String pr = null;
			if(!rs.next()){
				pr = "fail";
				response.sendRedirect("inputG.jsp?pr="+pr);
			}
			title=rs.getString("title");
			System.out.printf("title : %s\n", title);
			writer=rs.getString("writer");
			System.out.printf("writer : %s\n", writer);
			price=rs.getString("price");
			System.out.printf("price : %s\n", price);
			response.setCharacterEncoding("utf8");
			session.setAttribute("title", title);
			session.setAttribute("writer", writer);
			session.setAttribute("price", price);
			session.setAttribute("code", code);
			response.sendRedirect("editG.jsp");
			//response.sendRedirect("editG.jsp?code="+code+"&title="+title+"&writer="+writer+"&price="+price);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			try {
				pstmt.close();
			}
			catch(Exception ignored) {
				
			}
			try {
				conn.close();
			}
			catch(Exception ignored) {
				
			}
		}
	}
}
