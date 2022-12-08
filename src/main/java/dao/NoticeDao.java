package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Category;
import vo.Member;
import vo.Notice;

public class NoticeDao {
	
	// 관리자 : 공지수정폼 admin -> updateNoticeForm.jsp
	public ArrayList<Notice> selectNoticeListByMemo(int noticeNo)  {
		ArrayList<Notice> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice"
				+ " WHERE notice_no=? ORDER BY createdate DESC";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			list = new ArrayList<Notice>();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
			return list;
		}
	}
	
	// 관리자: 공지수정 admin ->updateNoticeAction.jsp
	public int updateNotice(Notice updateNotice) {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		//쿼리문
		String sql = "UPDATE notice SET notice_memo = ?, updatedate = CURDATE() WHERE notice_no = ?";
			
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setString(1, updateNotice.getNoticeMemo());
			stmt.setInt(2, updateNotice.getNoticeNo());
			resultRow = stmt.executeUpdate();
		} catch(Exception e){
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
	
	
	// 관리자 공지삭제 admin ->deleteNotice.jsp
	public int deleteNotice(int noticeNo)  {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		//쿼리문
		String sql = "DELETE FROM notice WHERE notice_no = ?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setInt(1, noticeNo);
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
			
	// 관리자 공지 삽입 admin ->insertNoticeAction.jsp
	public int insertNotice(Notice notice)  {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		//쿼리문
		String sql = "INSERT notice(notice_memo, updatedate, createdate)"
					+" VALUES(?, NOW(), NOW())";
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setString(1, notice.getNoticeMemo());
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
	
	// 마지막 페이지를 구할려면 전체row수가 필요
	public int selectNoitceCount() {
		int count = 0;
		return count;
	}
	
	
	// 관리자 공지목록 admin ->noticeList.jsp <select> + 일반멤버 loginForm.jsp에도 참조
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage)  {
		ArrayList<Notice> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?, ?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			list = new ArrayList<Notice>();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
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
	
	// 공지사항 cnt 라스트페이지 
		public int count()  {
			int cnt = 0; // 전체 행의 수
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT COUNT(*) cnt FROM notice";
			
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
