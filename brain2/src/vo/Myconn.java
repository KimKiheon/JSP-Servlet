package vo;
import java.sql.*;
public class Myconn {
	private Myconn() {
		
	}
	public static Connection getConn()
			throws SQLException{
		String driver ="com.mysql.jdbc.Driver";
		String url  = "jdbc:mysql://localhost:3306/testdb";
		String root = "root";
		String pw = "1234";
		 Connection result =null;
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 result = DriverManager.getConnection(url,root,pw);
		}
		catch(ClassNotFoundException e) {
			System.out.println("����̹��� ã������ ����.");
		}
		return result;
	}
}
