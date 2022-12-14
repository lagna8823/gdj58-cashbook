<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	//System.out.println("");
	//System.out.println(loginMember+ "<---아이디");
	//System.out.println(memberPw+ "<---멤버기존");
	
	// 입력값 체크
	 if(memberPw == null ||  memberPw.equals("")) {
      String msg = URLEncoder.encode("공백을 입력할 수 없습니다.","utf-8"); // get방식 주소창에 문자열 인코딩
      response.sendRedirect(request.getContextPath()+"/deleteMemberForm.jsp?msg="+msg);
      return;
   }
	
	Member deleteMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 deleteMember를 새로 선언)
	deleteMember.setMemberId(memberId); // 새로 선언된 deleteMember에 넘겨받은 값 세팅.
	deleteMember.setMemberPw(memberPw);
	
	// 분리된M(모델)을 호출
	MemberDao memberDaodelete = new MemberDao(); // memberDao 메서드를 이용해 memberDaodelete를 새로 선언.
	int resultRow = memberDaodelete.delete(deleteMember); 
	//위에서 내려온 updateMember값을 Memberdao.delete() 클래스에로 보내고 결과값으로 resultRow값을 받음.
	
	// redirect
	String redirectUrl = "/loginForm.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 실행되지 않은 상황.
	if(resultRow == 0) {
		String msg =URLEncoder.encode("비밀번호가 틀렸습니다","utf-8");
		response.sendRedirect(request.getContextPath() + "/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 수행
	session.invalidate(); // 세션 초기화
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>	