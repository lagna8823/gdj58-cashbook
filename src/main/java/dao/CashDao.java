package dao;
import vo.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

import java.net.URLEncoder;

public class CashDao {
	
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
	
	// cashDateList.jsp(검색)
	public ArrayList<HashMap<String, Object>> selectCashListByDay(String memberId, int year, int month, int date) throws Exception {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
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
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
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
		
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
	// cashDateList.jsp (cash 추가,삽입)
		public int insert(Cash insertCash) throws Exception {
		DBUtil dbUtil = new DBUtil(); // DB 연결
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO cash(category_no, member_id, cash_date, cash_price, cash_memo, updatedate, createdate) values(?, ?, ?, ?, ?, curdate(), curdate())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, insertCash.getCategoryNo());
		stmt.setString(2, insertCash.getMemberId());
		stmt.setString(3, insertCash.getCashDate());
		stmt.setLong(4, insertCash.getCashPrice());
		stmt.setString(5, insertCash.getCashMemo());
		int resultRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return resultRow;
	}
		
		
		// 호출 : cashList.jsp
		public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception {
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String,Object>>();
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
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
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			ResultSet rs = stmt.executeQuery();
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
			
			rs.close();
			stmt.close();
			conn.close();
			return list;
		}
		
	// updateCahAction.jsp (cash 내역수정)
		public int update(Cash updateCash) throws Exception {
			DBUtil dbUtil = new DBUtil(); // DB 연결
			Connection conn = dbUtil.getConnection();
			String sql = "UPDATE cash SET category_no=?, cash_date=?, cash_price=?, cash_memo=? WHERE cash_no=? ";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, updateCash.getCategoryNo());
			stmt.setString(2, updateCash.getCashDate());
			stmt.setLong(3, updateCash.getCashPrice());
			stmt.setString(4, updateCash.getCashMemo());
			stmt.setInt(5, updateCash.getCashNo());
			
			int resultRow = stmt.executeUpdate();
			stmt.close();
			conn.close();
			return resultRow;
		}
	
	// deleteCahAction.jsp (cash 내역삭제)
			public int delete(Cash deteteCash) throws Exception {
				DBUtil dbUtil = new DBUtil(); // DB 연결
				Connection conn = dbUtil.getConnection();
				String sql = "DELETE FROM cash WHERE cash_no=?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setInt(1, deteteCash.getCashNo());
				int resultRow = stmt.executeUpdate();
				stmt.close();
				conn.close();
				return resultRow;
			}	
		
}

