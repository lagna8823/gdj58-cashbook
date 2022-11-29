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
	
	// 
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String helpMemo = request.getParameter("helpMemo");
	
	Help updateHelp = new Help(); // 모델 호출시 매개값(vo.Help 클래스를 이용하여 updateHelp 새로 선언)
	updateHelp.setHelpNo(helpNo);
	updateHelp.setHelpMemo(helpMemo);
	
	// 분리된M(모델)을 호출
	HelpDao helpDaoUpdate = new HelpDao();  // HelpDao 메서드를 이용해 helpDaoUpdate를 새로 선언.
	int resultRow = helpDaoUpdate.updateHelp(updateHelp); 
	//위에서 내려온 updateHelp값을 helpDaoUpdate.updateHelp() 클래스에로 보내고 결과값으로 resultRow값을 받음
	
	// redirect
	String redirectUrl = "/helpList.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 실행되지 않은 상황.
	if(resultRow == 0) {
		String msg =URLEncoder.encode("수정되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/updateHelpForm.jsp?msg="+msg);
		return;
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이 이라면 수행
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
