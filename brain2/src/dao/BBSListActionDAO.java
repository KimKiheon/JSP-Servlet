package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;

import vo.MatchVO;
import vo.Myconn; 

public class BBSListActionDAO extends HttpServlet {	
	public String getDate() {
		String SQL="select now()";
		try {
			Connection conn=Myconn.getConn(); ;
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			ResultSet rs=null;
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public static int getNext() {
		String SQL="select seqNo from matches order by seqNo desc";
		try {
			Connection conn=Myconn.getConn(); ;
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			ResultSet rs=null;
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e){
			e.printStackTrace();
		}
		return -1;
	}
	
	public static ArrayList<MatchVO> getList(int pageNumber){
		ArrayList<MatchVO> list = new ArrayList<MatchVO>();
		try {
			Connection conn=Myconn.getConn(); 
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			
			String SQL="select * from matches where seqNo < ? order by seqNo desc LIMIT 10";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery(); 
			while(rs.next()) {
				MatchVO match =new MatchVO();
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
				list.add(match);
			}			
		} catch(SQLException e) {
			e.printStackTrace();
		} 
		return list;
	}
	
	public static boolean nextPage(int pageNumber) {
		try {
			Connection conn=Myconn.getConn();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int pagenumber=1;
			
			String SQL="select * from matches where seqNo < ? AND seqNo > 0";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext()-(pagenumber-1)*10);
			rs = pstmt.executeQuery(); 
			while(rs.next()) {
				return true;
			}			
		} catch(SQLException e) {
			e.printStackTrace();
		} 
		return false;
	}
	
	public MatchVO getMatches(int seqNo) {
		try {
			Connection conn=Myconn.getConn();
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int pagenumber=1;
			
			String SQL="select * from matches where seqNo = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,seqNo);
			rs = pstmt.executeQuery(); 
			while(rs.next()) {
				MatchVO match =new MatchVO();
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
				return match;
			}			
		} catch(SQLException e) {
			e.printStackTrace();
		} 
		return null;
	}
}
