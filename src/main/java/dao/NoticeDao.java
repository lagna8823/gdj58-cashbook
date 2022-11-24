package dao;

import java.sql.*;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;
import vo.Notice;

public class NoticeDao {
	// loginForm.jsp 공지목록
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
	
	
	// 공지 마지막 페이지 관련
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
