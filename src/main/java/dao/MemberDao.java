package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Category;
import vo.Member;
import vo.Notice;

public class MemberDao {
	
	//  updatememberLvForm.jsp 관리자 : 멤버레벨수정 
	public ArrayList<HashMap<String, Object>> selectMemberListByLv(Member updateMember) throws Exception {
		ArrayList<HashMap<String, Object>> updateMemberList = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_no =?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection(); 
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
		// 쿼리 값 세팅, 실행 값 저장
		stmt.setInt(1, updateMember.getMemberNo());
		rs = stmt.executeQuery();
		updateMemberList = 	new ArrayList<HashMap<String,Object>>();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("memberNo", rs.getInt("memberNo"));
			m.put("memberId", rs.getString("memberId"));
			m.put("memberName", rs.getString("memberName"));
			m.put("memberLevel", rs.getString("memberLevel"));
			updateMemberList.add(m);
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
		return updateMemberList;
	}
		
		
	// updateMemberLvAction.jsp 관리자 : 멤버레벨수정
	public int updateMemberlv(Member updateMemberlv) throws Exception {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		
		// 쿼리문
		String sql = "UPDATE member SET member_level = ?  WHERE member_no = ?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장
			stmt.setInt(1, updateMemberlv.getMemberLevel());
			stmt.setInt(2, updateMemberlv.getMemberNo());
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
		

	// memberList.jsp : 라스트페이지 
	public int count() throws Exception {
		int cnt = 0; // 전체 행의 수
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT COUNT(*) cnt FROM member";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장.
			rs = stmt.executeQuery();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
			if(rs.next()) {
			    cnt = rs.getInt("cnt");
			    }
			    return cnt;
		}
	}
		
	// memberList.jsp 관리자 : 멤버 리스트
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) throws Exception{ 
		ArrayList<Member> list = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT member_no memberNo, member_id memberId, member_level memberLevel, member_name memberName, updatedate, createdate FROM member ORDER BY createdate DESC LIMIT ?, ?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			// 쿼리 값 세팅, 결과 값 저장.
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			list = new ArrayList<Member>();
			while(rs.next()) {
				Member m = new Member();
				m.setMemberNo(rs.getInt("memberNo"));
				m.setMemberId(rs.getString("memberId"));
				m.setMemberLevel(rs.getInt("memberLevel"));
				m.setMemberName(rs.getString("memberName"));
				m.setUpdatedate(rs.getString("updatedate"));
				m.setCreatedate(rs.getString("createdate"));
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
			return list;
		}
	}
		
		
	// deleteMemberLvAction.jsp 관리자 : 멤버 강퇴 
	public int deleteMember(Member deleteMember) throws Exception {
		int resultRow=0;
		DBUtil dbUtil = null; // 드라이버 로딩 및 연결
		Connection conn = null;
		PreparedStatement stmt = null;// 쿼리 객체 생성
		
		// 쿼리문
		String sql = "DELETE FROM member WHERE member_no=?";
		
		try {
			dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			// 쿼리 값 세팅, 결과 값 저장.
			stmt.setInt(1, deleteMember.getMemberNo());
			resultRow = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch(Exception e){
				e.printStackTrace();
			}
			return resultRow;
		}
	}
	
	/*
	--> DB를 연결하는 코드(명령들)가 Dao 메서드들 거의 공통으로 중복된다.
	--> 중복되는 코드를 하나의 이름(메서드)으로 만들자
	--> 입력값과 반환값 결정해야 한다
	--> 입력값X, 반환값은 Connection타입의 결과값이 남아야 한다.
	*/
	
	
	// loginAction.jsp 로그인 
	public Member login(Member paramMember) throws Exception {
		Member resultMember = null;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt	= null;
		ResultSet rs = null;
		
		// 쿼리문
		String sql = "SELECT member_id memberId, member_level memberLevel, member_name memberName FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			//쿼리 값 세팅 및 결과값 저장
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
			return resultMember;
		}
	}
	
	// insertMemberaction.jsp 회원가입
	public int insert(Member checkMember) throws Exception {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;	
		ResultSet rs = null;	
		
		// 쿼리문
		String sql = "SELECT member_id memberId FROM member WHERE member_id=?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			//쿼리 값 세팅 결과값 저장
			stmt.setString(1, checkMember.getMemberId());
			rs = stmt.executeQuery();
			if(rs.next()) {
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
			return resultRow;
		}
		
		
		// ID 중복검사
		
		ResultSet 
		if(rs.next()) {
			resultRow=0;
			rs.close();
			stmt.close();
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
	
	
	// 회원 정보 및 비밀번호 수정
	
		// 회원정보수정 updateForm.jsp
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

		
		// 회원정보 수정 updateMemberAction.jsp
		public int update(Member updateMember) throws Exception {
		
		DBUtil dbUtil = new DBUtil(); // DB 연결
		Connection conn = dbUtil.getConnection();
		/*System.out.println(updateMember.getMemberName());
		System.out.println(updateMember.getMemberId());
		System.out.println(updateMember.getMemberPw());*/
		int resultRow=0;
		// 회원정보 수정
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
		
		
		// 회원비밀번호 수정 updateMemberPwAction.jsp
		public int updatePw(Member updatePwMember) throws Exception {
			
		DBUtil dbUtil = new DBUtil(); // DB 연결
		Connection conn = dbUtil.getConnection();
		/*System.out.println(updatePwMember.getMemberPw());
		System.out.println(updatePwMember.getMemberId());
		System.out.println(updatePwMember.getMemberPw2());*/
		int resultRow=0;
		// 비밀번호 수정
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
		
		
		//회원탈퇴 deleteMemberAction.jsp
		public int delete(Member deleteMember) throws Exception {
		
		DBUtil dbUtil = new DBUtil(); // DB 연결
		Connection conn = dbUtil.getConnection();
		/*System.out.println(updatePwMember.getMemberPw());
		System.out.println(updatePwMember.getMemberId());
		System.out.println(updatePwMember.getMemberPw2());*/
		int resultRow=0;
		// 비밀번호 삭제
		String sql6 = "DELETE FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt6 = conn.prepareStatement(sql6);
		stmt6.setString(1, deleteMember.getMemberId());
		stmt6.setString(2, deleteMember.getMemberPw());
		resultRow = stmt6.executeUpdate();
		if(resultRow==1)		
				stmt6.close();
				conn.close();
				return resultRow;
		}
		
		
}
