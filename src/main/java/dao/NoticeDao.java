package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Category;
import vo.Member;
import vo.Notice;

public class NoticeDao {
	
	//
	public int updateNotice(Notice notice) throws Exception{
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		return 0;
	}
	
	//
	public int updateNotice(Notice notice) throws Exception {
		String sql = "UPDATE notice SET notice_memo = ? WHERE notice_no = ?";
		return 0;
		
	}
	// admin -> deleteNotice.jsp
			public int deleteNotice(int noticeNo) throws Exception {
				int resultRow = 0;
				
				String sql = "DELETE FROM notice WHERE notice_no = ?";
				
				DBUtil dbUtil = new DBUtil();
				Connection conn = null;
				PreparedStatement stmt = null;
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, noticeNo);
				resultRow = stmt.executeUpdate();
				
				dbUtil.close(null, stmt, conn);
				
				return resultRow;
			}
			
	// admin -> insertNoticeAction.jsp
	public int insertNotice(Notice notice) throws Exception {
		String sql = "INSERT notice(notice_memo, updatedate, createdate)"
					+" VALUES(?, NOW(), NOW())";
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		int resultRow = stmt.executeUpdate();
		dbUtil.close(null, stmt, conn);
		return resultRow;
	}
	
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoitceCount() {
		int count = 0;
		//
		return count;
	}
	
	
	// noticeList.jsp <select> + loginForm.jsp 메인공지목록 
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Notice> list = new ArrayList<Notice>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
					+ " FROM notice ORDER BY createdate DESC"
					+ " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		return list;
	}
	
	
	// 공지 라스트페이지 
		public int count() throws Exception {
			
		DBUtil dbUtil = new DBUtil(); // DB 연결
		Connection conn = dbUtil.getConnection();
		int cnt = 0; // 전체 행의 수
		String Sql = "SELECT COUNT(*) cnt FROM notice";
		PreparedStatement stmt = conn.prepareStatement(Sql); 
		ResultSet rs = stmt.executeQuery();
		    if(rs.next()) {
		    cnt = rs.getInt("cnt");
		    }
		    return cnt;
		}
}
