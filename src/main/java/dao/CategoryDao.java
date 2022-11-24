package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.*;

	public class CategoryDao {
		
		//
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
			}
			rs.close();
			stmt.close();
			conn.close();
			return categoryList;
	}
}
