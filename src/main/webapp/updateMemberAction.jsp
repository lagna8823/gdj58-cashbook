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
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String memberId = request.getParameter("loginMember");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	
	/*System.out.println("");
	System.out.println(memberNo+ "<---멤버번호");
	System.out.println(loginMember+ "<---아이디");
	System.out.println(memberPw+ "<---멤버기존");
	System.out.println(memberPw2+ "<---멤버수정");
	System.out.println(memberName+ "<---멤버이름");*/
	
	//if 비밀번호 확인 작성해야함
	
	Member updateMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 updatemMember를 새로 선언)
	updateMember.setMemberId(memberId); // 새로 선언된 updatemMember에 넘겨받은 값 세팅.
	updateMember.setMemberNo(memberNo);
	updateMember.setMemberPw(memberPw);
	updateMember.setMemberPw(memberName);
		
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao(); // memberDao 메서드를 이용해 memberDao를 새로 선언.
	int resultRow = memberDao.update(updateMember); 
	//위에서 내려온 updateMember값을 Memberdao.update() 클래스에로 보내고 결과값으로 resultRow값을 받음.

	// redirect
	String redirectUrl = "/cash/cashList.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow != 0) {
		session.setAttribute("loginMember", updateMember); // session안에 로그인 아이디 & 이름을 저장
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
		
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 실행되지 않은 상황.
	String msg =URLEncoder.encode("값을 확인하세요","utf-8");
	response.sendRedirect(request.getContextPath() + "/updateMemberForm.jsp?msg="+msg);
%>	