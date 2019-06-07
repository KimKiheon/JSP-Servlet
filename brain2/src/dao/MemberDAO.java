package dao;

import java.sql.*;
import vo.MemberVO;
import vo.Myconn;

public class MemberDAO {
	public static boolean makeMatch(String id) {
		MemberVO vo = new MemberVO();
		System.out.println("[[[[[MemberDAO의 makeMatch 메소드 실행....]]]]]");
		Connection conns = null;
		PreparedStatement pstmts = null;
		ResultSet rs = null;
		System.out.printf("받아온 아이디 %s\n", id);
		try {
			conns = Myconn.getConn();
			String sql = "update members set allMatch=allMatch+1 where id='" + id + "'";
			pstmts = conns.prepareStatement(sql);
			int result = pstmts.executeUpdate();
			if (result == 1) {
				System.out.println("[[[[[MemberDAO의 getInfo 메소드 성공!!]]]]]");
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[[[[[MemberDAO의 getInfo 메소드 실패!!]]]]]");
		return false;
	}

	public MemberVO getInfo(String id) {
		System.out.println("[[[[[MemberDAO의 getInfo 메소드 실행....]]]]]");

		MemberVO vo = new MemberVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Myconn.getConn();
			String sql = "select * from members where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				vo.setId(rs.getString("id"));
				System.out.printf("ID : %s\n", vo.getId());
				vo.setAllMatch(rs.getInt("allMatch"));
				System.out.printf("총 매치 시도 수 : %d\n", vo.getAllMatch());
				vo.setSuccessMatch(rs.getInt("successMatch"));
				System.out.printf("성사된 매치 수 : %d\n", vo.getSuccessMatch());
				vo.setName(rs.getString("Uname"));
				System.out.printf("이름 : %s\n", vo.getName());
				vo.setEmail(rs.getString("email"));
				System.out.printf("E-mail : %s\n", vo.getEmail());
				vo.setPasswd(rs.getString("passwd"));
				System.out.printf("PassWord : %s\n", vo.getPasswd());
				vo.setKtid(rs.getString("ktid"));
				System.out.printf("KaKao Talk ID : %s\n", vo.getKtid());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[[[[[MemberDAO의 getInfo 메소드 종료....]]]]]");
		return vo;
	}
	
	
	public void updateInfo(String id) {
		System.out.println("[[[[[MemberDAO의 updateInfo 메소드 실행....]]]]]");

		MemberVO vo = new MemberVO();
		MemberDAO memberdao = new MemberDAO();
		vo = memberdao.getInfo(id);
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Myconn.getConn();
			String sql = "update members set successMatch = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getSuccessMatch() + 1);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("[[[[[MemberDAO의 updateInfo 메소드 종료....]]]]]");
	}
}