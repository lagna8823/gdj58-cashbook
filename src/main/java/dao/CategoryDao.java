package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.*;

	public class CategoryDao {
		// 수정 : 수정폼(select)과 수정액션(update)으로 구성 
		// admin -> updateCategoryAction.jsp
		public int updateCategory(Category updateCategory) throws Exception {
			int resultRow = 0;
			
			String sql = "UPDATE category"
						+" SET category_name = ?, updatedate = CURDATE()"
						+" WHERE category_no = ?";
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, updateCategory.getCategoryName());
			stmt.setInt(2, updateCategory.getCategoryNo());
			resultRow = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			return resultRow;
		}
		
		// admin -> updateCategoryForm.jsp(검색)
		public Category selectCategoryList(int categoryNo) throws Exception {
			Category categoryList = null;
			String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind"
						+" FROM category"
						+" WHERE category_no = ?";
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				categoryList = new Category();
				categoryList.setCategoryNo(rs.getInt("categoryNo"));
				categoryList.setCategoryName(rs.getString("categoryName"));
				categoryList.setCategoryKind(rs.getString("categoryKind"));
			}
			
			dbUtil.close(rs, stmt, conn);
			
			return categoryList;
		}
		
		// admin -> deleteCategory.jsp
		public int deleteCategory(int categoryNo) throws Exception {
			int resultRow = 0;
			
			String sql = "DELETE FROM category WHERE category_no = ?";
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryNo);
			resultRow = stmt.executeUpdate();
			
			dbUtil.close(null, stmt, conn);
			
			return resultRow;
		}
	

		// admin -> insertCategoryAction.jsp
		public int insertCategory(Category category) throws Exception{
			
			String sql = "INSERT INTO category ("
					+ " category_kind"
					+ ", category_name"
					+ ", updatedate"
					+ ", createdate"
					+ ")  VALUES(?, ?, CURDATE(), CURDATE())";
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			ResultSet rs = null;
			
			conn = dbUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, category.getCategoryKind());
			stmt.setString(2, category.getCategoryName());
			int resultRow = stmt.executeUpdate();
			dbUtil.close(null, stmt, conn);
			return resultRow;
		}
		
		
		// admin -> 카테고리관리 ->카테고리 목록
		public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
			ArrayList<Category> list = null; //참조타입들은 null로 받고나서 받는게 좋다.
			list = new ArrayList<Category>();
			
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
			
			// db자원(jdbc api자원) 초기화
			Connection conn = null;
			DBUtil dbUtil = new DBUtil();
			ResultSet rs = null;
			
			conn = dbUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category(); // Category는 vo.Category 클래스 이용
				c.setCategoryNo(rs.getInt("categoryNo")); //rs.getInt(1);  1- 셀렉트 절의 순서
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				c.setUpdatedate(rs.getString("updatedate")); // DB날짜 타입이지만 자바단에서 문자열 타입으로 받는다.
				c.setCreatedate(rs.getString("createdate"));
				list.add(c);
			}
			
			// db자원(jdbc api자원) 반납
			dbUtil.close(rs, stmt, conn);
			return list;
		}
		
		// cash 입력시 <select> 목록 출력
		public ArrayList<Category> selectCategoryList() throws Exception {
			ArrayList<Category> categoryList = new ArrayList<Category>();
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind";
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				Category c = new Category(); // Category는 vo.Category 클래스 이용
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				categoryList.add(c);
			}
			rs.close();
			stmt.close();
			conn.close();
			return categoryList;
		}
		
		// 마지막 페이지를 구할려면 전체row수가 필요
		public int selectCategoryCount() {
			int count = 0;
			//
			return count;
		}
		
		// 카테고리 라스트페이지 
			public int count() throws Exception {
				
			DBUtil dbUtil = new DBUtil(); // DB 연결
			Connection conn = dbUtil.getConnection();
			int cnt = 0; // 전체 행의 수
			String Sql = "SELECT COUNT(*) cnt FROM category";
			PreparedStatement stmt = conn.prepareStatement(Sql); 
			ResultSet rs = stmt.executeQuery();
			    if(rs.next()) {
			    cnt = rs.getInt("cnt");
			    }
			    return cnt;
			}
}
