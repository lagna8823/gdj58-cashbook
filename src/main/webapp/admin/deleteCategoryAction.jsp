<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>

<%	
	// 1.C
	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
   	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	
	// 분리된M(모델)을 호출
	CategoryDao deleteCategoryDao = new CategoryDao(); // CategoryDao 메서드를 이용해 categoryDao 새로 선언
	int resultRow = deleteCategoryDao.deleteCategory(categoryNo);
	//위에서 내려온 deleteCategory categoryDao.delete() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// CategoryDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		String msg =URLEncoder.encode("삭제할 내역이 없습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/categoryList.jsp?msg="+msg);
		
	}
	// CategoryDao에서 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
%>