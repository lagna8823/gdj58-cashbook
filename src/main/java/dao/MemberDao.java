package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Member;

public class MemberDao {
	// 로그인
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		/*
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/cashbook","root","java1234");
		--> DB를 연결하는 코드(명령들)가 Dao 메서드들 거의 공통으로 중복된다.
		--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
		--> 입력값과 반환값 결정해야 한다
		--> 입력값X, 반환값은 Connection타입의 결과값이 남아야 한다.
		*/
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	// 회원가입
	public int insert(Member checkMember) throws Exception {
		
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// ID 중복검사
		int resultRow = 0;
		String sql1 = "SELECT member_id memberId FROM member WHERE member_id=?";
		PreparedStatement stmt1 = conn.prepareStatement(sql1);
		stmt1.setString(1, checkMember.getMemberId());
		ResultSet rs1 = stmt1.executeQuery();
		if(rs1.next()) {
			resultRow=0;
			rs1.close();
			stmt1.close();
			return resultRow;
		}
		
		// 입력
		
		String sql2 = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,PASSWORD(?),?,curdate(),curdate())";
		PreparedStatement stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, checkMember.getMemberId());
		stmt2.setString(2, checkMember.getMemberPw());
		stmt2.setString(3, checkMember.getMemberName());
		resultRow = stmt2.executeUpdate();
		
		stmt2.close();
		conn.close();
		return resultRow;
	}
	
	
	// 회원수정
	
		// updateForm.jsp
		public ArrayList<HashMap<String, Object>> selectMemberListById(String memberId) throws Exception {
			ArrayList<HashMap<String, Object>> updateMemberList = new ArrayList<HashMap<String,Object>>();
			DBUtil dbUtil = new DBUtil();
			Connection conn = dbUtil.getConnection();
			String sql3 = "SELECT member_no memberNo, member_id memberId, member_name memberName FROM member WHERE member_id=? ";
			PreparedStatement stmt3 = conn.prepareStatement(sql3);
			stmt3.setString(1, memberId);
			ResultSet rs3 = stmt3.executeQuery();
			while(rs3.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("memberNo", rs3.getInt("memberNo"));
				m.put("memberId", rs3.getString("memberId"));
				m.put("memberName", rs3.getString("memberName"));
				updateMemberList.add(m);
			}
			
			rs3.close();
			stmt3.close();
			conn.close();
			return updateMemberList;
		}

		
		//updateMemberAction.jsp
		public int update(Member updateMember) throws Exception {
			
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		/*System.out.println(updateMember.getMemberName());
		System.out.println(updateMember.getMemberId());
		System.out.println(updateMember.getMemberPw());*/
		int resultRow=0;
		// 수정
		String sql4 = "UPDATE member SET member_name=? WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt4 = conn.prepareStatement(sql4);
		stmt4.setString(1, updateMember.getMemberName());
		stmt4.setString(2, updateMember.getMemberId());
		stmt4.setString(3, updateMember.getMemberPw());
		resultRow = stmt4.executeUpdate();
		if(resultRow==1)		
				stmt4.close();
				conn.close();
				return resultRow;
		
		}
		
		//updateMemberPwAction.jsp
		public int updatePw(Member updatePwMember) throws Exception {
			
		// DB 연결
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		/*System.out.println(updatePwMember.getMemberPw());
		System.out.println(updatePwMember.getMemberId());
		System.out.println(updatePwMember.getMemberPw2());*/
		int resultRow=0;
		// 수정
		String sql5 = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt5 = conn.prepareStatement(sql5);
		stmt5.setString(1, updatePwMember.getMemberPw2());
		stmt5.setString(2, updatePwMember.getMemberId());
		stmt5.setString(3, updatePwMember.getMemberPw());
		resultRow = stmt5.executeUpdate();
		if(resultRow==1)		
				stmt5.close();
				conn.close();
				return resultRow;
		
		}
		
		
}
