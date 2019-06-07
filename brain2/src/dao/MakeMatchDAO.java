package dao;
import vo.MatchVO;
import vo.MemberVO;
import vo.Myconn;
import java.sql.*;
public class MakeMatchDAO {
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;
	public static java.sql.Timestamp getDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());
	}
	public static int Insert(MatchVO vo){
		try {			
			System.out.println("[[[[[MatchDAO의  Insert 메소드 실행....]]]]]");

			conn = Myconn.getConn();
			String sql = "insert into matches(flag1, flag2, title,stime,etime,contents,"
					+ "addr, teamflag, needman, nowman, writer) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getFlag1());
			pstmt.setString(2, vo.getFlag2());
			pstmt.setString(3, vo.getTitle());
			pstmt.setString(4, vo.getStime());
			pstmt.setString(5, vo.getEtime());
			pstmt.setString(6, vo.getContents());
			pstmt.setString(7, vo.getAddr());
			pstmt.setInt(8, vo.getTeamflag());
			pstmt.setInt(9, vo.getNeedman());
			pstmt.setInt(10, vo.getNowman());
			pstmt.setString(11, vo.getWriter());
			int result = pstmt.executeUpdate();
			if(result == 1) {
				System.out.println("MatchDAO : Insert 성공");
				return 1;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		System.out.println("MatchDAO : Insert 실패");

		return 0;
	}
	public MatchVO getMatch(int seqNo)throws SQLException {
		MatchVO vo = new MatchVO();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = Myconn.getConn();
			String sql = "select * from matches where seqNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, seqNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setSeqNo(rs.getInt("seqNo"));
				vo.setSeqDate(rs.getTimestamp("seqDate"));
				vo.setFlag1(rs.getInt("flag1"));
				vo.setFlag2(rs.getString("flag2"));
				vo.setTitle(rs.getString("title"));
				vo.setStime(rs.getString("stime"));
				vo.setEtime(rs.getString("etime"));
				vo.setContents(rs.getString("contents"));
				vo.setAddr(rs.getString("addr"));
				vo.setTeamflag(rs.getInt("teamflag"));
				vo.setNeedman(rs.getInt("needman"));
				vo.setNowman(rs.getInt("nowman"));
				vo.setWriter(rs.getString("writer"));
			}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return vo;
	}
}
