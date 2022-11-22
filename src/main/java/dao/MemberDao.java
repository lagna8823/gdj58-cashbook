package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	public int insertMember(Member checkMember) throws Exception {
		Member resultMember1 = null;
	// DB 연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
	
	String sql1 = "SELECT member_id memberId FROM member WHERE member_id=?";
	PreparedStatement stmt1 = conn.prepareStatement(sql1);
	stmt1.setString(1, checkMember.getMemberId());
	ResultSet rs1 = stmt1.executeQuery();
	if(rs1.next()) {
		resultMember1 = "A";
		
		rs1.close();
		stmt1.close();
		conn.close();
		return resultMember1;
	} 
	
	int resultRow =0;
	String sql2 = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,?,?,curdate(),curdate())";
	PreparedStatement stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, checkMember.getMemberId());
	stmt2.setString(2, checkMember.getMemberPw());
	stmt2.setString(3, checkMember.getMemberName());
	resultRow = stmt2.executeUpdate();
	
	stmt2.close();
	conn.close();
	return resultRow;
	}
