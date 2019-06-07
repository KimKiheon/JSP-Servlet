package dao;

import java.sql.*;
import java.util.ArrayList;

import vo.MatchVO;
import vo.Myconn;

/*
 * MatchDAO 留ㅼ튂 DAO
 * - Insert 留ㅼ튂�젙蹂대�� DB�뿉 �궫�엯�빐二쇰뒗 �븿�닔
 * 			DB�뿉 �궫�엯�븷�븣 nowman�� 1�쓽 �긽�깭濡� �뱾�뼱媛�寃뚮맖
 * - Update 留ㅼ튂 �젙蹂댁쨷 �씤�썝�씠 李멸��뻽�쓣�븣 洹� 寃뚯떆湲��쓽 �쁽�옱 李멸��씤�썝�쓣 +=1 �빐二쇰뒗 �븿�닔
 * 			留뚯빟 李멸��씤�썝�씠 理쒕��씤�썝怨� �씪移섑븳�떎硫� �옉�꽦�옄 �븣由쇳뀒�씠釉� �궫�엯
 * - getCur MakeMatchProc.java�뿉�꽌 留ㅼ튂 �깮�꽦�옄瑜� 洹� 留ㅼ튂�쓽 李멸��옄濡� �꽔�쓣�븣 泥섎━瑜� �쐞�븳 �븿�닔, 留ㅼ튂 寃뚯떆湲��쓽 媛��옣 留덉�留됱쓣 諛섑솚�븿
 * - getNext getList瑜� �쐞�븳 �븿�닔
 * - getList 留ㅼ튂�젙蹂대�� 由ъ뒪�듃�븯湲� �쐞�븳 �븿�닔, 留ㅼ튂�젙蹂� 10媛쒕�� 由ъ뒪�듃�삎�깭濡� 諛섑솚�븿
 * - nextPage 10媛쒓� �꽆�뼱媛� 寃쎌슦 �럹�씠吏� 泥섎━瑜� �쐞�븳 �븿�닔
 * - getMatches 留ㅼ튂�젙蹂대�� 諛섑솚�븯�뒗 �븿�닔
 */
public class MatchDAO {
	static Connection conn = null;
	static PreparedStatement pstmt = null;
	static ResultSet rs = null;

	public static java.sql.Timestamp getDate() {
		java.util.Date today = new java.util.Date();
		return new java.sql.Timestamp(today.getTime());
	}
	public static int UpdateMatch(MatchVO vo) {
		try {
			System.out.println("[[[[[MatchDAO占쏙옙  UpdateMatch 占쌨소듸옙 占쏙옙占쏙옙....]]]]]");

			conn = Myconn.getConn();
			String sql = "update matches set flag1 = ?, title = ?, stime = ?,etime = ?,contents = ?,"
					+ "addr = ?, teamflag  = ?, needman = ? where seqNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getFlag1());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getStime());
			pstmt.setString(4, vo.getEtime());
			pstmt.setString(5, vo.getContents());
			pstmt.setString(6, vo.getAddr());
			pstmt.setInt(7, vo.getTeamflag());
			pstmt.setInt(8, vo.getNeedman());
			pstmt.setInt(9, vo.getSeqNo());
			int result = pstmt.executeUpdate();
			
			if (result == 1) {
				System.out.println("MatchDAO : Update 占쏙옙占쏙옙");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("MatchDAO : Update 占쏙옙占쏙옙");
		return 0;
	}
	// �깉濡쒖슫 留ㅼ튂 �깮�꽦�떆 DB�뿉 異붽�
	public static int Insert(MatchVO vo) {
		try {
			System.out.println("[[[[[MatchDAO�쓽  Insert 硫붿냼�뱶 �떎�뻾....]]]]]");

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
				System.out.println("MatchDAO : Insert �꽦怨�");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("MatchDAO : Insert �떎�뙣");

		return 0;
	}

	// �궗�슜�옄 李멸��떆 nowman�냽�꽦 +1 �뾽�뜲�씠�듃 �븿�닔
	public static int Update(MatchVO vo) {
		try {
			System.out.println("[[[[[MatchDAO�쓽  Update 硫붿냼�뱶 �떎�뻾....]]]]]");

			conn = Myconn.getConn();
			String sql = "update matches set nowman = ? where seqNo = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, vo.getNowman() + 1);
			pstmt.setInt(2, vo.getSeqNo());
			int result = pstmt.executeUpdate();
			if (result == 1) {
				System.out.println("MatchDAO : Update �꽦怨�");
				return 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("MatchDAO : Update �떎�뙣");
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

	// 留ㅼ튂 由ъ뒪�듃 異쒕젰 �븿�닔
	public static ArrayList<MatchVO> getList(int pageNumber) {
		System.out.println("[[[[[MatchDAO�쓽 getList 硫붿냼�뱶 �떎�뻾....]]]]]");
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
		System.out.println("[[[[[MatchDAO�쓽 getList 硫붿냼�뱶 醫�....]]]]]");
		return list;
	}
	public static ArrayList<MatchVO> getList(int pageNumber,String flag2) {
		System.out.println("[[[[[MatchDAO�쓽 getList 硫붿냼�뱶 �떎�뻾....]]]]]");
		ArrayList<MatchVO> list = new ArrayList<MatchVO>();
		try {
			Connection conn = Myconn.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			String SQL = "select * from matches where seqNo < ? and flag2 like ? order by seqNo desc LIMIT 10";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setString(2, flag2);
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
		System.out.println("[[[[[MatchDAO�쓽 getList 硫붿냼�뱶 醫�....]]]]]");
		return list;
	}
	//page '�씠�쟾','�떎�쓬'  踰꾪듉 以� 紐⑤몢 �떎 蹂댁뿬議뚯쓣�븣 '�떎�쓬' 踰꾪듉 �젣�뼱.
		public static int fullPage() {
			int checknum = 1;
			try {
				Connection conn = Myconn.getConn();
				Statement stmt = null;
				ResultSet rs = null;

				String SQL = "select count(*) as count from matches";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(SQL);

				while (rs.next() != false) {
					String name = rs.getString(1);
					System.out.println(name);
					checknum = Integer.parseInt(name);
					}
				System.out.println(checknum);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if(checknum % 10 == 0) {
				return (checknum/10);
			}
			return (checknum / 10) + 1;
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

	// 留ㅼ튂 �젙蹂� 諛섑솚 �븿�닔
	public MatchVO getMatches(int seqNo) {
		System.out.println("[[[[[MatchDAO�쓽 getMatches 硫붿냼�뱶 �떎�뻾....]]]]]");
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
				System.out.println("[[[[[MatchDAO�쓽 getMatches 硫붿냼�뱶 醫낅즺....]]]]]");
				return match;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
