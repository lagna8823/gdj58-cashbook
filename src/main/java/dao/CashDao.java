package dao;
import vo.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

import java.net.URLEncoder;

public class CashDao {
	
	// 페이징에 사용할 최소년도 최대년도
	public HashMap<String, Object> selectMaxMinYear() throws Exception {
		HashMap<String, Object> map = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	(SELECT MIN(YEAR(cash_date)) FROM cash) minYear"
				+ ", (SELECT MAX(YEAR(cash_date))FROM cash) maxYear"
				+ " FROM DUAL";
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성	
			rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("minYear", rs.getInt("minYear"));
				map.put("maxYear", rs.getInt("maxYear"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	// 사용자별 월별 수입/지출 sum,avg
	public ArrayList<HashMap<String, Object>> performanceMonth(String memberId, int year){
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = " SELECT "
				+ "		MONTH(t2.cashDate) month"
				+ "		, COUNT(t2.importCash) importCnt"
				+ "		, IFNULL(SUM(t2.importCash), 0) importSum"
				+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) importAvg"
				+ "		, COUNT(t2.exportCash) exportCnt"
				+ "		, IFNULL(SUM(t2.exportCash), 0) exportSum"
				+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) exportAvg"
				+ "	FROM"
				+ "		(SELECT "
				+ "			memberId"
				+ "			, cashNo"
				+ "			, cashDate"
				+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
				+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
				+ "		FROM (SELECT cs.cash_no cashNo"
				+ "		, cs.cash_date cashDate"
				+ "		, cs.cash_price cashPrice"
				+ "		, cg.category_kind categoryKind"
				+ "		, cs.member_id memberId"
				+ "				FROM cash cs "
				+ "				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
				+ "	WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?" 
				+ "	GROUP BY MONTH(t2.cashDate)"
				+ "	ORDER BY MONTH(t2.cashDate) ASC";
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String,Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("month", rs.getInt("month"));
				m.put("importCnt", rs.getInt("importCnt"));
				m.put("importSum", rs.getInt("importSum"));
				m.put("importAvg", rs.getInt("importAvg"));
				m.put("exportCnt", rs.getInt("exportCnt"));
				m.put("exportSum", rs.getInt("exportSum"));
				m.put("exportAvg", rs.getInt("exportAvg"));
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
	
	// 사용자별 년도별 수입/지출 sum,avg
		public ArrayList<HashMap<String, Object>> performanceYear(String memberId, int year){
			ArrayList<HashMap<String, Object>> list = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = " SELECT "
					+ "		YEAR(t2.cashDate) year"
					+ "		, COUNT(t2.importCash) importCnt"
					+ "		, IFNULL(SUM(t2.importCash), 0) importSum"
					+ "		, IFNULL(ROUND(AVG(t2.importCash)), 0) importAvg"
					+ "		, COUNT(t2.exportCash) exportCnt"
					+ "		, IFNULL(SUM(t2.exportCash), 0) exportSum"
					+ "		, IFNULL(ROUND(AVG(t2.exportCash)), 0) exportAvg"
					+ "	FROM"
					+ "		(SELECT "
					+ "			memberId"
					+ "			, cashNo"
					+ "			, cashDate"
					+ "			, IF(categoryKind = '수입', cashPrice, null) importCash"
					+ "			, IF(categoryKind = '지출', cashPrice, null) exportCash"
					+ "		FROM (SELECT cs.cash_no cashNo"
					+ "		, cs.cash_date cashDate"
					+ "		, cs.cash_price cashPrice"
					+ "		, cg.category_kind categoryKind"
					+ "		, cs.member_id memberId"
					+ "				FROM cash cs "
					+ "				INNER JOIN category cg ON cs.category_no = cg.category_no) t) t2"
					+ "	WHERE t2.memberId = ?"
					+ "	GROUP BY YEAR(t2.cashDate)"
					+ "	ORDER BY YEAR(t2.cashDate) ASC";
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
					m.put("year", rs.getInt("year"));
					m.put("importCnt", rs.getInt("importCnt"));
					m.put("importSum", rs.getInt("importSum"));
					m.put("importAvg", rs.getInt("importAvg"));
					m.put("exportCnt", rs.getInt("exportCnt"));
					m.put("exportSum", rs.getInt("exportSum"));
					m.put("exportAvg", rs.getInt("exportAvg"));
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
		
	
	/*
	SELECT 
		c.cash_no cashNo
		, c.cash_date cashDate
		, c.cash_price cashPrice
		, c.category_no categoryNo
		, ct.category_kind categoryKind
		, ct.category_name categoryName
	FROM cash c INNER JOIN category ct
	ON c.category_no = ct.category_no
	WHERE YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
	ORDER BY c.cash_date ASC;
	해쉬맵을 쓰는 이유 : 소규모프로젝트에서 조인때문에 매번 만들기는 비효율적
	 */
	
	// 가계부 리스트 cashDateList.jsp(검색)
	public ArrayList<HashMap<String, Object>> selectCashListByDay(String memberId, int year, int month, int date){
		ArrayList<HashMap<String, Object>> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT"
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, c.cash_price cashPrice"
				+ "		, c.cash_memo cashMemo"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "		, c.member_id memberId"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ?"
				+ " AND YEAR(c.cash_date) = ?"
				+ " AND MONTH(c.cash_date) = ?"
				+ " AND DAY(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
		try {
			
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 실행 값 저장
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			list = new ArrayList<HashMap<String,Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("cashNo", rs.getInt("cashNo"));
				m.put("cashDate", rs.getString("cashDate"));
				m.put("cashPrice", rs.getLong("cashPrice"));
				m.put("cashMemo", rs.getString("cashMemo"));
				m.put("categoryKind", rs.getString("categoryKind"));
				m.put("categoryName", rs.getString("categoryName"));
				m.put("memberId", rs.getString("memberId"));
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
	
	// 가계부상세페이지 cashDateList.jsp (cash 추가,삽입)
	public int insert(Cash insertCash) {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 쿼리문
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) values(?, ?, ?, ?, ?, curdate(), curdate())";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장
			stmt.setInt(1, insertCash.getCategoryNo());
			stmt.setString(2, insertCash.getMemberId());
			stmt.setString(3, insertCash.getCashDate());
			stmt.setLong(4, insertCash.getCashPrice());
			stmt.setString(5, insertCash.getCashMemo());
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
	
		// 호출 : cashList.jsp
		public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
			ArrayList<HashMap<String, Object>> list = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			//쿼리문
			String sql = "SELECT"
					+ "		c.cash_no cashNo"
					+ "		, c.cash_date cashDate"
					+ "		, c.cash_price cashPrice"
					+ "		, c.category_no categoryNo"
					+ "		, ct.category_kind categoryKind"
					+ "		, ct.category_name categoryName"
					+ "	FROM cash c INNER JOIN category ct"
					+ "	ON c.category_no = ct.category_no"
					+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
					+ "	ORDER BY c.cash_date ASC, ct.category_kind ASC"; 
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, memberId);
				stmt.setInt(2, year);
				stmt.setInt(3, month);
				rs = stmt.executeQuery();
				list = new ArrayList<HashMap<String,Object>>();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("cashNo", rs.getInt("cashNo"));
					m.put("cashDate", rs.getString("cashDate"));
					m.put("cashPrice", rs.getLong("cashPrice"));
					m.put("categoryNo", rs.getInt("categoryNo"));
					m.put("categoryKind", rs.getString("categoryKind"));
					m.put("categoryName", rs.getString("categoryName"));
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
		
		
		// 가계부 수정 updateCashAction.jsp (cash 내역수정)
		public int update(Cash updateCash) {
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 쿼리문
			String sql = "UPDATE cash SET category_no=?, cash_date=?, cash_price=?, cash_memo=?, updatedate=now() WHERE cash_no=? ";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection();
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 결과 값 저장
				stmt.setInt(1, updateCash.getCategoryNo());
				stmt.setString(2, updateCash.getCashDate());
				stmt.setLong(3, updateCash.getCashPrice());
				stmt.setString(4, updateCash.getCashMemo());
				stmt.setInt(5, updateCash.getCashNo());
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
	
	// 가계부 삭제 deleteCahAction.jsp (cash 내역삭제)
	public int delete(Cash deteteCash) {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 쿼리문
		String sql = "DELETE FROM cash WHERE cash_no=?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장
			stmt.setInt(1, deteteCash.getCashNo());
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
}

