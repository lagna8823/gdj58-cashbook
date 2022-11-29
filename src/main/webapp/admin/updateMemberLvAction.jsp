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
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	
	Member updateMemberLv = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 updateMemberLv를 새로 선언)
	updateMemberLv.setMemberNo(memberNo);
	updateMemberLv.setMemberLevel(memberLevel);
	
	// 분리된M(모델)을 호출
	MemberDao memberDaoUpdateLv = new MemberDao(); // memberDao 메서드를 이용해 memberDaoUpdateLv를 새로 선언.
	int resultRow = memberDaoUpdateLv.updateMemberlv(updateMemberLv); 
	//위에서 내려온 updateMemberLv값을 memberDaoUpdateLv.updateMemberlv() 클래스에로 보내고 결과값으로 resultRow값을 받음.
	
	// redirect
	String redirectUrl = "/admin/memberList.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 실행되지 않은 상황.
	if(resultRow == 0) {
		String msg =URLEncoder.encode("수정되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/memberList.jsp?msg="+msg);
		return;
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이 이라면 수행
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>	