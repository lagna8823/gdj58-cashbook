package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import util.DBUtil;
import vo.Comment;
import vo.Help;

public class CommentDao {
	
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
	// 입력
	public int insertComment(Comment comment) {
		return 0;
	}
	
	// 수정
	public Comment selectCommentOne(int commentNo) {
		return null;
	}
	public int updateComment(Comment comment) {
		return 0;
	}
	
	// 삭제
	public int deleteComment(int commentNo) {
		return 0;
	}
}