package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.AlarmVO;
import vo.Myconn;

/*
	ALarmDAO
	- Insert �˶� ���̺� ������ ������
	- getAlarm seqNo�� �⺻Ű�� ���̺��� �˶������� ��ȯ 
	- getNext getList�� ���� �Լ�
	- getList �˶��� ����Ʈ���ֱ����� �˻��� 10���� �˶��� ����Ʈ�� ��ȯ����
	- nextPage �˶������� 10���� �Ѿ �� ó���� ���� �Լ�
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
			System.out.println("[[[[[AlarmDAO��  Insert �޼ҵ� ����....]]]]]");

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
				System.out.println("AlarmDAO : Insert ����");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("AlarmDAO : Insert ����");

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
		System.out.println("[[[[[AlarmDAO�� getList �޼ҵ� ����....]]]]]");
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
		System.out.println("[[[[[AlarmDAO�� getList �޼ҵ� ��....]]]]]");
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
		System.out.println("[[[[[AlarmDAO�� getAlarm �޼ҵ� ����....]]]]]");
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
				System.out.println("[[[[[AlarmDAO�� getAlarm �޼ҵ� ����....]]]]]");
				return vo;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
