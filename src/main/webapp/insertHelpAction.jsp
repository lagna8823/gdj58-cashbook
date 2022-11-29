<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
	String memberId = loginMember.getMemberId(); //memberId값에 세션에 저장된 멤버id값 (작성자) 넣음.
	String helpMemo = request.getParameter("helpMemo"); //insert form 에서 받온 문의내용 넣음.
	
	// vo 안에 Help 호출하여  새로운 insertHelp를 생성. insertHelp 메서드로 setter로 각각 값세팅.
	Help insertHelp = new Help();
	insertHelp.setMemberId(memberId);
	insertHelp.setHelpMemo(helpMemo);
	
	HelpDao helpDao = new HelpDao();
	int resultRow = helpDao.insertHelp(insertHelp);
	
	// redirect
	String redirectUrl = "/helpList.jsp";  // redirectUrl값에 필요시 돌아갈 주소값 세팅.
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 실행되지 않은 상황.
	if(resultRow == 0) {
		String msg =URLEncoder.encode("수정되지 않았습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/insertHelpForm.jsp?msg="+msg);
		return;
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이 이라면 수행
	response.sendRedirect(request.getContextPath()+redirectUrl);
%>
