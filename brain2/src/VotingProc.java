import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;
import vo.Myconn;
import vo.AlarmVO;
import dao.AlarmDAO;
import dao.MemberDAO;
import dao.PeopleDAO;

@WebServlet("/VotingProc")
public class VotingProc extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AlarmVO alarm = new AlarmVO();
		
		
	}
}
