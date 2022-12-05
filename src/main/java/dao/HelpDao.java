package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import vo.*;
import util.DBUtil;

	public class HelpDao {
		
		// help 수정 insertcomment.jsp / HELP : helpNo 
		public ArrayList<HashMap<String, Object>> selectHelpNoComment(int helpNo) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문 
			String sql = "SELECT h.help_no helpNo, h.help_memo helpMemo, h.createdate createdate, h.member_id memberId"
					+" FROM help h INNER JOIN member m ON h.member_id = m.member_id "
					+" WHERE h.help_no = ?";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setInt(1, helpNo);
				rs = stmt.executeQuery();
				while(rs.next()) {
					HashMap<String, Object> h = new HashMap<String, Object>();
					h.put("helpNo", rs.getInt("helpNo"));
					h.put("helpMemo", rs.getString("helpMemo"));
					h.put("memberId", rs.getString("memberId"));
					h.put("createdate", rs.getString("createdate"));
					list.add(h);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}
				
		// 관리자 : selectHelpList 오버로딩
		public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT h.help_no helpNo"
					+"		, h.help_memo helpMemo"
					+"		, h.member_id memberId"
					+"		, h.createdate helpCreatedate"
					+"		, c.comment_memo commentMemo"
					+"		, c.createdate commentCreatedate"
					+" FROM help h LEFT JOIN comment c"
					+" ON h.help_no = c.help_no"
					+" LIMIT ?, ?";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				rs = stmt.executeQuery();
				list = new ArrayList<HashMap<String,Object>>();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("helpNo", rs.getInt("helpNo"));
					m.put("helpMemo", rs.getString("helpMemo"));
					m.put("memberId", rs.getString("memberId"));
					m.put("helpCreatedate", rs.getString("helpCreatedate"));
					m.put("commentMemo", rs.getString("commentMemo"));
					m.put("commentCreatedate", rs.getString("commentCreatedate"));
					list.add(m);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}
		
		// help 수정 updateHelpAction.jsp
		public int updateHelp(Help help) throws Exception{
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 쿼리문 
			String sql = "UPDATE help SET help_memo=?, updatedate=now() WHERE help_no=?";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 결과 값 저장
				stmt.setString(1, help.getHelpMemo());
				stmt.setInt(2, help.getHelpNo());
				resultRow = stmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(null, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
				return resultRow;
			}
		}
		
		
		// help 삭제 deleteHelpAction.jsp 
		public int deleteHelp(Help help) throws Exception{
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 쿼리문
			String sql = "DELETE FROM help WHERE help_no=?";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 결과 값 저장
				stmt.setInt(1, help.getHelpNo());
				resultRow = stmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(null, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
				return resultRow;
			}
		}
		
		// help 추가(입력) insertHelpAction.jsp / member_id는 세션데이터
		public int insertHelp(Help help) throws Exception{
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 쿼리문
			String sql = "INSERT INTO HELP(help_memo , member_id, updatedate,  createdate) VALUES(?, ?, NOW(), NOW())";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 결과 값 저장
				stmt.setString(1, help.getHelpMemo());
				stmt.setString(2, help.getMemberId());
				resultRow = stmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(null, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
				return resultRow;
			}
		}
		
		// help 수정 updateHelpForm.jsp / HELP : helpNo 
		public ArrayList<HashMap<String, Object>> selectHelpNo(int helpNo) throws Exception {
			ArrayList<HashMap<String, Object>> list = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문 
			String sql = "SELECT help_no helpNo, help_memo helpMemo, createdate createdate, member_id memberId"
					+" FROM help "
					+" WHERE help_no = ?";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setInt(1, helpNo);
				rs = stmt.executeQuery();
				list = new ArrayList<HashMap<String,Object>>();
				while(rs.next()) {
					HashMap<String, Object> h = new HashMap<String, Object>();
					h.put("helpNo", rs.getInt("helpNo"));
					h.put("helpMemo", rs.getString("helpMemo"));
					h.put("createdate", rs.getString("createdate"));
					h.put("member_id", rs.getString("memberId"));
					list.add(h);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}
		
		
		// help목록 helpList.jsp  / HELP : member_id는 세션데이터
		public ArrayList<HashMap<String, Object>> selectHelpList(String memberId) throws Exception {
			ArrayList<HashMap<String, Object>> list = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT h.help_no helpNo"
						+"		, h.help_memo helpMemo"
						+"		, h.createdate helpCreatedate"
						+"		, c.comment_memo commentMemo"
						+"		, c.createdate commentCreatedate"
						+" FROM help h LEFT JOIN comment c"
						+" ON h.help_no = c.help_no"
						+" WHERE h.member_id = ?";
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, memberId);
				rs = stmt.executeQuery();
				list = new ArrayList<HashMap<String,Object>>();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("helpNo", rs.getInt("helpNo"));
					m.put("helpMemo", rs.getString("helpMemo"));
					m.put("helpCreatedate", rs.getString("helpCreatedate"));
					m.put("commentMemo", rs.getString("commentMemo"));
					m.put("commentCreatedate", rs.getString("commentCreatedate"));
					list.add(m);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}
		
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoitceCount() {
		int count = 0;
		//
		return count;
	}
	
	// help 라스트페이지 
		public int count() throws Exception {
			int cnt = 0; // 전체 행의 수
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT COUNT(*) cnt FROM help";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				rs = stmt.executeQuery();
			    if(rs.next()) {
			    cnt = rs.getInt("cnt");
			    }
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			return cnt;
		}
}
