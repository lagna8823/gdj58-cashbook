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
	
	// 관리자 : 멤버레벨수정  updatememberLvForm.jsp 
	public ArrayList<HashMap<String, Object>> selectMemberListByLv(Member updateMember)  {
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
		
		
	// 관리자 : 멤버레벨수정 updateMemberLvAction.jsp 
	public int updateMemberlv(Member updateMemberlv)  {
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
		

	// 멤버리스트 : 라스트페이지 memberList.jsp  
	public int count()  {
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
			    return cnt;
		}
	}
		
	// 관리자 : 멤버 리스트 memberList.jsp 
	public ArrayList<Member> selectMemberListByPage(int beginRow, int rowPerPage) { 
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
		
		
	// 관리자 : 멤버 강퇴  deleteMemberLvAction.jsp 
	public int deleteMember(Member deleteMember)  {
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
	
	
	// 로그인 loginAction.jsp 
	public Member login(Member paramMember)  {
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
	
	// 회원가입 insertMemberaction.jsp 
	public int insert(Member checkMember)  {
		int resultRow = 0;
		DBUtil dbUtil = null;
		Connection conn = null;
		PreparedStatement stmt = null;	
		ResultSet rs = null;	
		
		// 쿼리문 ID 중복검사
		String sql = "SELECT member_id memberId FROM member WHERE member_id=?";
		
		try {
			dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
			//쿼리 값 세팅 결과값 저장
			stmt.setString(1, checkMember.getMemberId());
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultRow=0;
				return  resultRow;
			} else {
			// 입력
			String sql2 = "INSERT INTO member(member_id, member_pw, member_name, updatedate, createdate) VALUES(?,PASSWORD(?),?,curdate(),curdate())";
			stmt = conn.prepareStatement(sql2); // 객체에 쿼리 새로운 쿼리 저장
			//쿼리 값 세팅 및 결과값 저장
			stmt.setString(1, checkMember.getMemberId());
			stmt.setString(2, checkMember.getMemberPw());
			stmt.setString(3, checkMember.getMemberName());
			resultRow = stmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
			return  resultRow;
		}
	}
	
	// 회원 정보 및 비밀번호 수정
	
		// 회원정보수정 updateForm.jsp 
		public ArrayList<HashMap<String, Object>> selectMemberListById(String memberId)  {
			ArrayList<HashMap<String, Object>> updateMemberList = null;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt =null;
			ResultSet rs = null;
			
			//쿼리문
			String sql = "SELECT member_no memberNo, member_id memberId, member_name memberName FROM member WHERE member_id=? ";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, memberId);
				rs = stmt.executeQuery();
				updateMemberList = new ArrayList<HashMap<String,Object>>();
				while(rs.next()) {
					HashMap<String, Object> m = new HashMap<String, Object>();
					m.put("memberNo", rs.getInt("memberNo"));
					m.put("memberId", rs.getString("memberId"));
					m.put("memberName", rs.getString("memberName"));
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
				return updateMemberList;
			}
		}	
		
			
			

		
		// 회원정보 수정 updateMemberAction.jsp
		public int update(Member updateMember)  {
			int resultRow=0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt =null;
			
		
			//쿼리문
			String sql = "UPDATE member SET member_name=? WHERE member_id=? AND member_pw = PASSWORD(?)";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, updateMember.getMemberName());
				stmt.setString(2, updateMember.getMemberId());
				stmt.setString(3, updateMember.getMemberPw());
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
		
		
		// 회원비밀번호 수정  updateMemberPwAction.jsp 
		public int updatePw(Member updatePwMember)  {
			int resultRow=0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt =null;
		
			// 쿼리문
			String sql = "UPDATE member SET member_pw = PASSWORD(?) WHERE member_id=? AND member_pw = PASSWORD(?)";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, updatePwMember.getMemberPw2());
				stmt.setString(2, updatePwMember.getMemberId());
				stmt.setString(3, updatePwMember.getMemberPw());
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
		
				
		
		
		// 회원탈퇴 deleteMemberAction.jsp
		public int delete(Member deleteMember)  {
			int resultRow=0;
			DBUtil dbUtil = null;
			Connection conn = null;
			PreparedStatement stmt =null;
			
			// 쿼리문
			String sql = "DELETE FROM member WHERE member_id=? AND member_pw = PASSWORD(?)";
			
			try {
				dbUtil = new DBUtil(); // 드라이버 로딩 및 연결
				conn = dbUtil.getConnection(); 
				stmt = conn.prepareStatement(sql); // 쿼리 객체 생성
				// 쿼리 값 세팅, 실행 값 저장
				stmt.setString(1, deleteMember.getMemberId());
				stmt.setString(2, deleteMember.getMemberPw());
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
