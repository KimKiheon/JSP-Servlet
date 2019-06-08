package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.AlarmVO;
import vo.MatchVO;
import vo.Myconn;

/*
	ALarmDAO
	- Insert 알람 테이블에 정보를 삽입함
	- getAlarm seqNo를 기본키로 테이블에서 알람정보를 반환 
	- getNext getList를 위한 함수
	- getList 알람을 리스트해주기위해 검색한 10개의 알람을 리스트로 반환해줌
	- nextPage 알람정보가 10개를 넘어갈 때 처리를 위한 함수
*/
public class AlarmDAO {
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static java.sql.Timestamp getDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());
	}

	public static int Insert(AlarmVO vo) {
		try {
			System.out.println("[[[[[AlarmDAO의  Insert 메소드 실행....]]]]]");

			conn = Myconn.getConn();

			String sql = "insert into alarm(joinman,createman,kind,finishtime,flag,matchseqNo) values(?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getJoinman());
			pstmt.setString(2, vo.getCreateman());
			pstmt.setInt(3, vo.getKind());
			pstmt.setTimestamp(4, vo.getFinishtime());
			pstmt.setInt(5, vo.getFlag());
			pstmt.setInt(6, vo.getMatchseqNo());
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("AlarmDAO : Insert 성공");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("AlarmDAO : Insert 실패");

		return 0;
	}
	public static int UpdateAlarm(int asn) {
		try {
			System.out.println("[[[[[MatchDAO��  UpdateMatch �޼ҵ� ����....]]]]]");

			conn = Myconn.getConn();
			String sql = "update alarm set flag = 1 where seqNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, asn);
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("AlarmDAO : Update 성공");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("AlarmDAO : Update 실패");
		return 0;
	}
	
	public static int getNext() {
		String SQL = "select seqNo from alarm order by seqNo desc";
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

	public static ArrayList<AlarmVO> getList(int pageNumber, String id) {
		System.out.println("[[[[[AlarmDAO의 getList 메소드 실행....]]]]]");
		ArrayList<AlarmVO> list = new ArrayList<AlarmVO>();
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select * from alarm where seqNo < ? and createman = ? order by seqNo desc LIMIT 10";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AlarmVO vo = new AlarmVO();
				vo.setSeqNo(rs.getInt(1));
				vo.setJoinman(rs.getString(2));
				vo.setCreateman(rs.getString(3));
				vo.setKind(rs.getInt(4));
				vo.setFinishtime(rs.getTimestamp(5));
				vo.setFlag(rs.getInt(6));
				vo.setMatchseqNo(rs.getInt(7));
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[[[[[AlarmDAO의 getList 메소드 종....]]]]]");
		return list;
	}

	public static boolean nextPage(int pageNumber) {
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int pagenumber = 1;

			String SQL = "select * from alarm where seqNo < ? AND seqNo > 0";
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

	public static AlarmVO getAlarm(int seqNo) {
		System.out.println("[[[[[AlarmDAO의 getAlarm 메소드 실행....]]]]]");
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select * from alarm where seqNo = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, seqNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				AlarmVO vo = new AlarmVO();
				vo.setSeqNo(rs.getInt(1));
				vo.setJoinman(rs.getString(2));
				vo.setCreateman(rs.getString(3));
				vo.setKind(rs.getInt(4));
				vo.setFinishtime(rs.getTimestamp(5));
				vo.setFlag(rs.getInt(6));
				vo.setMatchseqNo(rs.getInt(7));
				System.out.println("[[[[[AlarmDAO의 getAlarm 메소드 종료....]]]]]");
				return vo;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static boolean getAlarmBytitle(int matchseqNo) {
		System.out.println("[[[[[AlarmDAO의 getAlarm 메소드 실행....]]]]]");
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			System.out.printf("%d\n",matchseqNo);
			String SQL = "select * from alarm where matchseqNo = ? and kind = 3";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, matchseqNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				System.out.println("이미 있는 알람 삽입 x");
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("없는 알람입니다!");
		return false;
	}
}
