<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	//1. Controller 

	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	String memberId = loginMember.getMemberId();
	String memberPw = request.getParameter("memberPw");
	String memberPw2 = request.getParameter("memberPw2");
	
	System.out.println("");
	System.out.println(loginMember+ "<---아이디");
	System.out.println(memberPw+ "<---멤버기존");
	System.out.println(memberPw2+ "<---멤버수정 여기까지");
	
	//if 비밀번호 확인 작성해야함
	
	Member updatePwMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 updatemMember를 새로 선언)
	updatePwMember.setMemberId(memberId); // 새로 선언된 updatemMember에 넘겨받은 값 세팅.
	updatePwMember.setMemberPw(memberPw);
	updatePwMember.setMemberPw2(memberPw2);
	
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao(); // memberDao 메서드를 이용해 memberDao를 새로 선언.
	int resultRow = memberDao.updatePw(updatePwMember); 
	//위에서 내려온 updateMember값을 Memberdao.update() 클래스에로 보내고 결과값으로 resultRow값을 받음.
	
	// redirect
	String redirectUrl = "/cash/cashList.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 실행되지 않은 상황.
	if(resultRow == 0) {
		String msg =URLEncoder.encode("비밀번호가 틀렸습니다","utf-8");
		response.sendRedirect(request.getContextPath() + "/updateMemberPwForm.jsp?msg="+msg);
		return;
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	session.setAttribute("loginMember", updatePwMember); // session안에 로그인 아이디 & 이름을 저장
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>	