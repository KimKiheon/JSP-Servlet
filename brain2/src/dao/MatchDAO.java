package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.MatchVO;
import vo.Myconn;

/*
 * MatchDAO 매치 DAO
 * - Insert 매치정보를 DB에 삽입해주는 함수
 * 			DB에 삽입할때 nowman은 1의 상태로 들어가게됨
 * - Update 매치 정보중 인원이 참가했을때 그 게시글의 현재 참가인원을 +=1 해주는 함수
 * 			만약 참가인원이 최대인원과 일치한다면 작성자 알림테이블 삽입
 * - getCur MakeMatchProc.java에서 매치 생성자를 그 매치의 참가자로 넣을때 처리를 위한 함수, 매치 게시글의 가장 마지막을 반환함
 * - getNext getList를 위한 함수
 * - getList 매치정보를 리스트하기 위한 함수, 매치정보 10개를 리스트형태로 반환함
 * - nextPage 10개가 넘어갈 경우 페이지 처리를 위한 함수
 * - getMatches 매치정보를 반환하는 함수
 */
public class MatchDAO {
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static java.sql.Timestamp getDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());
	}

	// 새로운 매치 생성시 DB에 추가
	public static int Insert(MatchVO vo) {
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
			pstmt.setInt(10, 1);
			pstmt.setString(11, vo.getWriter());
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("MatchDAO : Insert 성공");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("MatchDAO : Insert 실패");

		return 0;
	}

	// 사용자 참가시 nowman속성 +1 업데이트 함수
	public static int Update(MatchVO vo) {
		try {
			System.out.println("[[[[[MatchDAO의  Update 메소드 실행....]]]]]");

			conn = Myconn.getConn();
			String sql = "update matches set nowman = ? where seqNo = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getNowman() + 1);
			pstmt.setInt(2, vo.getSeqNo());
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("MatchDAO : Update 성공");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("MatchDAO : Update 실패");
		return 0;
	}

	public static int getCur() {
		String SQL = "select seqNo from matches order by seqNo desc";
		try {
			Connection conn = Myconn.getConn();
			;
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			ResultSet rs = null;
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public static int getNext() {
		String SQL = "select seqNo from matches order by seqNo desc";
		try {
			Connection conn = Myconn.getConn();
			;
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			ResultSet rs = null;
			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 매치 리스트 출력 함수
	public static ArrayList<MatchVO> getList(int pageNumber) {
		System.out.println("[[[[[MatchDAO의 getList 메소드 실행....]]]]]");
		ArrayList<MatchVO> list = new ArrayList<MatchVO>();
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select * from matches where seqNo < ? order by seqNo desc LIMIT 10";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MatchVO match = new MatchVO();
				match.setSeqNo(rs.getInt(1));
				match.setSeqDate(rs.getTimestamp(2));
				match.setFlag1(rs.getInt(3));
				match.setFlag2(rs.getString(4));
				match.setTitle(rs.getString(5));
				match.setStime(rs.getTimestamp(6).toString());
				match.setEtime(rs.getTimestamp(7).toString());
				match.setContents(rs.getString(8));
				match.setAddr(rs.getString(9));
				match.setTeamflag(rs.getInt(10));
				match.setNeedman(rs.getInt(11));
				match.setNowman(rs.getInt(12));
				match.setWriter(rs.getString(13));
				list.add(match);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[[[[[MatchDAO의 getList 메소드 종....]]]]]");
		return list;
	}

	public static boolean nextPage(int pageNumber) {
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int pagenumber = 1;

			String SQL = "select * from matches where seqNo < ? AND seqNo > 0";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pagenumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	// 매치 정보 반환 함수
	public MatchVO getMatches(int seqNo) {
		System.out.println("[[[[[MatchDAO의 getMatches 메소드 실행....]]]]]");
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select * from matches where seqNo = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, seqNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MatchVO match = new MatchVO();
				match.setSeqNo(rs.getInt(1));
				match.setSeqDate(rs.getTimestamp(2));
				match.setFlag1(rs.getInt(3));
				match.setFlag2(rs.getString(4));
				match.setTitle(rs.getString(5));
				match.setStime(rs.getTimestamp(6).toString());
				match.setEtime(rs.getTimestamp(7).toString());
				match.setContents(rs.getString(8));
				match.setAddr(rs.getString(9));
				match.setTeamflag(rs.getInt(10));
				match.setNeedman(rs.getInt(11));
				match.setNowman(rs.getInt(12));
				match.setWriter(rs.getString(13));
				System.out.println("[[[[[MatchDAO의 getMatches 메소드 종료....]]]]]");
				return match;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
