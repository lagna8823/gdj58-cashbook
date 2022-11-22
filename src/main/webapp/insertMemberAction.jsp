<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "vo.*" %>
<%@ page import = "util.*" %>

<%	
	// 1.C
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)	
  	String memberId = request.getParameter("memberId");
   	String memberName = request.getParameter("memberName");
   	String memberPw = request.getParameter("memberPw");
   	
	// 입력값 체크
	 if(memberId == null || memberName == null || memberPw == null || memberId.equals("") || memberName.equals("")|| memberPw.equals("")) {
      String msg = URLEncoder.encode("입력된값을 확인하세요","utf-8"); // get방식 주소창에 문자열 인코딩
      response.sendRedirect(request.getContextPath()+"/cash/insertMemberForm.jsp?msg="+msg);
      return;
   }

	

	Member checkMember = new Member(); // 모델 호출시 매개값
	checkMember.setMemberId(memberId);
	checkMember.setMemberPw(memberPw);
	
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember1 = memberDao.insertMember(checkMember);
	
	
	
	
	response.sendRedirect(request.getContextPath()+"/inserMemberForm.jsp");
	
	String redirectUrl = "/loginForm.jsp";
	
	if(resultMember != null) {
		session.setAttribute("loginMember", resultMember); // session안에 로그인 아이디 & 이름을 저장
		redirectUrl = "/cash/cashList.jsp";
	}
	
	// redirect
	response.sendRedirect(request.getContextPath()+redirectUrl);
	
%>