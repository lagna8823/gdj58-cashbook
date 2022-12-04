package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.*;

	public class CategoryDao {
		// 수정 : 수정폼(select)과 수정액션(update)으로 구성 
		// 관리자: 카테고리 수정 admin -> updateCategoryAction.jsp
		public int updateCategory(Category updateCategory) throws Exception {
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			//쿼리문
			String sql = "UPDATE category"
						+" SET category_name = ?, updatedate = CURDATE()"
						+" WHERE category_no = ?";

			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, updateCategory.getCategoryName());
				stmt.setInt(2, updateCategory.getCategoryNo());
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
		
		
		// 관리자: 카테고리 수정폼 admin -> updateCategoryForm.jsp(검색)
		public Category selectCategoryList(int categoryNo) throws Exception {
			Category categoryList = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind"
						+" FROM category"
						+" WHERE category_no = ?";
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setInt(1, categoryNo);
				rs = stmt.executeQuery();
				while(rs.next()) {
					categoryList = new Category();
					categoryList.setCategoryNo(rs.getInt("categoryNo"));
					categoryList.setCategoryName(rs.getString("categoryName"));
					categoryList.setCategoryKind(rs.getString("categoryKind"));
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
				return categoryList;
			}
		}
			
		// 관리자: 카테고리 삭제 admin -> deleteCategory.jsp
		public int deleteCategory(int categoryNo) throws Exception {
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			//쿼리문
			String sql = "DELETE FROM category WHERE category_no = ?";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setInt(1, categoryNo);
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
	

		// 관리자: 카테고리 삽입 admin -> insertCategoryAction.jsp
		public int insertCategory(Category category) throws Exception{
			int resultRow = 0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			
			// 쿼리문
			String sql = "INSERT INTO category ("
					+ " category_kind"
					+ ", category_name"
					+ ", updatedate"
					+ ", createdate"
					+ ")  VALUES(?, ?, CURDATE(), CURDATE())";
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, category.getCategoryKind());
				stmt.setString(2, category.getCategoryName());
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
		
		// 관리자: 카테고리목록 admin -> 카테고리관리 ->카테고리 목록
		public ArrayList<Category> selectCategoryListByAdmin() throws Exception {
			ArrayList<Category> list = null; //참조타입들은 null로 받고나서 받는게 좋다.
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName, updatedate, createdate FROM category";
			
			list = new ArrayList<Category>();
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
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
			
		// cash 입력시 <select> 목록 출력
		public ArrayList<Category> selectCategoryList() throws Exception {
			ArrayList<Category> categoryList = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT category_no categoryNo, category_kind categoryKind, category_name categoryName FROM category ORDER BY category_kind";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				rs = stmt.executeQuery();
				categoryList = new ArrayList<Category>();
				while(rs.next()) {
					Category c = new Category(); // Category는 vo.Category 클래스 이용
					c.setCategoryNo(rs.getInt("categoryNo"));
					c.setCategoryKind(rs.getString("categoryKind"));
					c.setCategoryName(rs.getString("categoryName"));
					categoryList.add(c);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					dbUtil.close(rs, stmt, conn);
				} catch(Exception e) {
					e.printStackTrace();
				}
				return categoryList;
			}
		}
		
		// 마지막 페이지를 구할려면 전체 row수가 필요
		public int selectCategoryCount() {
			int count = 0;
			//
			return count;
		}
		
		// 카테고리 cnt 라스트페이지 
		public int count() throws Exception {
			int cnt = 0; // 전체 행의 수
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			// 쿼리문
			String sql = "SELECT COUNT(*) cnt FROM category";
			
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
