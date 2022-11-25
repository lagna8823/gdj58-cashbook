<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// 1. Controller 
	String memberId = request.getParameter("memberId"); // loginForm에서 넘겨받음.
	String memberPw = request.getParameter("memberPw");
	int memberLevel=0;
	
	Member paramMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 paramMember를 새로 선언)
	paramMember.setMemberId(memberId); // 새로 선언된 paramMeber에 넘겨받은 값 세팅.
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberLevel(memberLevel);
	
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao(); // memberDao 메서드를 이용해 memberDao를 새로 선언.
	Member resultMember = memberDao.login(paramMember); 
	//위에서 내려온 parpamMeber값을 Memberdao.login() 클래스에로 보내고 결과값으로 resultMeber값을 받음.
	
	String redirectUrl = "/loginForm.jsp"; // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	
	if(resultMember != null) { // Memberdao에서 넘겨받은 결과 resultMember값이 null이 아니라면 수행.
		session.setAttribute("loginMember", resultMember); // session안에 로그인 아이디 & 이름&레벨을 저장.
		redirectUrl = "/cash/cashList.jsp"; // 로그인 후 cashList 화면으로 ...
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
	
%>
