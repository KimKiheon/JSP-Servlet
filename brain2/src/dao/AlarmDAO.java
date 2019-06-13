package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.AlarmVO;
import vo.MatchVO;
import vo.Myconn;
import vo.PeopleVO;

/*
	ALarmDAO
	- Insert �븣�엺 �뀒�씠釉붿뿉 �젙蹂대�� �궫�엯�븿
	- getAlarm seqNo瑜� 湲곕낯�궎濡� �뀒�씠釉붿뿉�꽌 �븣�엺�젙蹂대�� 諛섑솚 
	- getNext getList瑜� �쐞�븳 �븿�닔
	- getList �븣�엺�쓣 由ъ뒪�듃�빐二쇨린�쐞�빐 寃��깋�븳 10媛쒖쓽 �븣�엺�쓣 由ъ뒪�듃濡� 諛섑솚�빐以�
	- nextPage �븣�엺�젙蹂닿� 10媛쒕�� �꽆�뼱媛� �븣 泥섎━瑜� �쐞�븳 �븿�닔
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
			System.out.println("[[[[[AlarmDAO�쓽  Insert 硫붿냼�뱶 �떎�뻾....]]]]]");

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
				System.out.println("AlarmDAO : Insert �꽦怨�");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("AlarmDAO : Insert �떎�뙣");

		return 0;
	}
	public static int UpdateAlarm(int asn) {
		try {
			System.out.println("[[[[[MatchDAO占쏙옙  UpdateMatch 占쌨소듸옙 占쏙옙占쏙옙....]]]]]");

			conn = Myconn.getConn();
			String sql = "update alarm set flag = 1 where seqNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, asn);
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("AlarmDAO : Update �꽦怨�");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("AlarmDAO : Update �떎�뙣");
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
		System.out.println("[[[[[AlarmDAO�쓽 getList 硫붿냼�뱶 �떎�뻾....]]]]]");
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
		System.out.println("[[[[[AlarmDAO�쓽 getList 硫붿냼�뱶 醫�....]]]]]");
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
		System.out.println("[[[[[AlarmDAO�쓽 getAlarm 硫붿냼�뱶 �떎�뻾....]]]]]");
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
				System.out.println("[[[[[AlarmDAO�쓽 getAlarm 硫붿냼�뱶 醫낅즺....]]]]]");
				return vo;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static boolean getAlarmBytitle(int matchseqNo) {
		System.out.println("[[[[[AlarmDAO�쓽 getAlarm 硫붿냼�뱶 �떎�뻾....]]]]]");
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
				System.out.println("�씠誘� �엳�뒗 �븣�엺 �궫�엯 x");
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("�뾾�뒗 �븣�엺�엯�땲�떎!");
		return false;
	}
	
	public static boolean checkAlarm(int seqNo) {
		System.out.println("[[[[[AlarmDAO�쓽 getAlarm 硫붿냼�뱶 �떎�뻾....]]]]]");
		try {
			int checknum = 0;
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select count(if(kind = 1, kind, NULL)) from alarm where MatchseqNo = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, seqNo);
			rs = pstmt.executeQuery();
			while (rs.next() != false) {
				String name = rs.getString(1);
				System.out.println(name);
				checknum = Integer.parseInt(name);
				}
			if(checknum != 0 ) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	public static boolean isAlarm(int seqNo) {
		System.out.println("[[[[[AlarmDAO�쓽 getAlarm 硫붿냼�뱶 �떎�뻾....]]]]]");
		try {
			int checknum = 0;
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select count(if(kind = 1, kind, NULL)) from alarm where MatchseqNo = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, seqNo);
			rs = pstmt.executeQuery();
			while (rs.next() != false) {
				String name = rs.getString(1);
				System.out.println(name);
				checknum = Integer.parseInt(name);
				}
			if(checknum != 0 ) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return true;
	}
	
	public boolean incompletion(int seq) {
		System.out.println("[[[[[AlarmDAO의 incompletion 메소드 실행....]]]]]");
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "update alarm set kind='4' where matchseqNo = ? and (kind=1 or kind=0 ) order by seqNo desc";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, seq);
			pstmt.executeUpdate();
			
			System.out.println("[[[[[AlarmDAO의 incompletion 정상 메소드 종료....]]]]]");
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[[[[[AlarmDAO의 incompletion 비정상 메소드 종료....]]]]]");
		return false;
	}
	
	public boolean incompletionCheck(int seq) {
		System.out.println("[[[[[AlarmDAO의 incompletionCheck 메소드 실행....]]]]]");
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			System.out.printf("%d\n",seq);
			String SQL = "select * from alarm where matchseqNo = ? and kind = 4";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, seq);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				System.out.println("[[[[[AlarmDAO의 incompletionCheck 메소드 종료....]]]]]");
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[[[[[AlarmDAO의 getMatches 메소드 비정상 종료....]]]]]");
		return false;
	}
	
	
}
