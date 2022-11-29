<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	Help deleteHelp = new Help(); // 모델 호출시 매개값(vo.Help 클래스를 이용하여 deleteHelp 새로 선언)
	deleteHelp.setHelpNo(helpNo);
	System.out.println(helpNo);
	// 분리된M(모델)을 호출
	HelpDao helpDaodelete = new HelpDao(); // memberDao 메서드를 이용해 memberDaodelete를 새로 선언.
	int resultRow = helpDaodelete.deleteHelp(deleteHelp); 
	//위에서 내려온 deleteMember값을 memberDaodelete.deleteMember() 클래스에로 보내고 결과값으로 resultRow값을 받음
	
	
	// redirect
	String redirectUrl = "/helpList.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Helpdao에서 넘겨받은 결과 resultRow값이 '0'이 이라면 수행
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>	