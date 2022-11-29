package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;
import util.DBUtil;

	public class HelpDao {
		//관리자
		// selectHelpList 오브로딩
		public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			String sql = "SELECT h.help_no helpNo"
						+"		, h.help_memo helpMemo"
						+ "		, h.member_id memberId"
						+"		, h.createdate helpCreatedate"
						+"		, c.comment_memo commentMemo"
						+"		, c.createdate commentCreatedate"
						+" FROM help h LEFT JOIN comment c"
						+" ON h.help_no = c.help_no"
						+" LIMIT ?, ?";
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
			}
			
			dbUtil.close(rs, stmt, conn);
			return list;
		}
		
		// updateHelpAction.jsp help 수정 :
		public int updateHelp(Help help) throws Exception{
			String sql = "UPDATE help SET help_memo=?, updatedate=now() WHERE help_no=?";
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			ResultSet rs = null;
			conn = dbUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setInt(2, help.getHelpNo());
			int resultRow = stmt.executeUpdate();
			dbUtil.close(null, stmt, conn);
			return resultRow;
			}
		
		// deleteHelpAction.jsp help 삭제 :
		public int deleteHelp(Help help) throws Exception{
			String sql = "DELETE FROM help WHERE help_no=?";
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			ResultSet rs = null;
			conn = dbUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, help.getHelpNo());
			int resultRow = stmt.executeUpdate();
			dbUtil.close(null, stmt, conn);
			return resultRow;
			}
		
		
		// insertHelpAction.jsp help 입력 : member_id는 세션데이터
		public int insertHelp(Help help) throws Exception{
			String sql = "INSERT INTO HELP(help_memo , member_id, updatedate,  createdate) VALUES(?, ?, NOW(), NOW())";
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			
			conn = dbUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, help.getHelpMemo());
			stmt.setString(2, help.getMemberId());
			int resultRow = stmt.executeUpdate();
			dbUtil.close(null, stmt, conn);
			return resultRow;
			}
		
		// updateHelpForm.jsp HELP : helpNo 
				public ArrayList<HashMap<String, Object>> selectHelpNo(int helpNo) throws Exception {
					ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
					String sql = "SELECT help_no helpNo, help_memo helpMemo"
								+" FROM help "
								+" WHERE help_no = ?";
					
					DBUtil dbUtil = new DBUtil();
					Connection conn = null;
					PreparedStatement stmt = null;
					ResultSet rs = null;
					
					conn = dbUtil.getConnection();
					stmt = conn.prepareStatement(sql);
					stmt.setInt(1, helpNo);
					rs = stmt.executeQuery();
					
					while(rs.next()) {
						HashMap<String, Object> h = new HashMap<String, Object>();
						h.put("helpNo", rs.getInt("helpNo"));
						h.put("helpMemo", rs.getString("helpMemo"));
						list.add(h);
					}
					return list;
				}	
		// helpList.jsp HELP : member_id는 세션데이터
		public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			String sql = "SELECT h.help_no helpNo"
						+"		, h.help_memo helpMemo"
						+"		, h.createdate helpCreatedate"
						+"		, c.comment_memo commentMemo"
						+"		, c.createdate commentCreatedate"
						+" FROM help h LEFT JOIN comment c"
						+" ON h.help_no = c.help_no"
						+" WHERE h.member_id = ?";
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));
				list.add(m);
			}
			
			dbUtil.close(rs, stmt, conn);
			return list;
		}
	
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoitceCount() {
		int count = 0;
		//
		return count;
	}
	
	// 공지 라스트페이지 
		public int count() throws Exception {
			
		DBUtil dbUtil = new DBUtil(); // DB 연결
		Connection conn = dbUtil.getConnection();
		int cnt = 0; // 전체 행의 수
		String Sql = "SELECT COUNT(*) cnt FROM help";
		PreparedStatement stmt = conn.prepareStatement(Sql); 
		ResultSet rs = stmt.executeQuery();
		    if(rs.next()) {
		    cnt = rs.getInt("cnt");
		    }
		    return cnt;
		}
}
