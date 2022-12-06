package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Cash;
import vo.Comment;
import vo.Help;

public class CommentDao {
	
	//수정
	public Comment updateComment(int commentNo) {
		return null;
	}
	public int updateComment(Comment comment) {
		return 0;
	}
	
	// Comment 수정 updateCommentForm.jsp / Comment : commentNo 
	public ArrayList<HashMap<String, Object>> selectHelpNo(int helpNo) {
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
		
	// comment 추가(입력) insertCommentAction.jsp 
	public int insertComment(Comment comment) throws Exception{
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 쿼리문
		String sql = "INSERT INTO comment(help_no, comment_memo , member_id, updatedate,  createdate) VALUES(?, ?, ?, NOW(), NOW())";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
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
	
	// comment 삭제 deleteCommentAction.jsp
	public int deleteComment(Comment comment) throws Exception {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 쿼리문
		String sql = "DELETE FROM comment WHERE comment_no=?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장
			stmt.setInt(1, comment.getCommentNo());
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
	
	// 공지사항 cnt 라스트페이지 
	public int count() throws Exception {
		int cnt = 0; // 전체 행의 수
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT COUNT(*) cnt FROM comment";
		
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