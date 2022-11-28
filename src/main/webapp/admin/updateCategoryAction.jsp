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
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
   	
	// 입력값 체크
	if(request.getParameter("categoryNo") == null || request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null  
		|| request.getParameter("categoryNo").equals("") || request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")) {
		String msg = URLEncoder.encode("입력되지 않은 값이있습니다.", "utf-8"); 
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+categoryNo);
		return;
	}
	
	Category updateCategory = new Category(); // 모델 호출시 매개값(vo.Category의 클래스를 이용하여 updateCategory를 새로 선언)
	updateCategory.setCategoryNo(categoryNo);
	updateCategory.setCategoryKind(categoryKind);
	updateCategory.setCategoryName(categoryName); 
	
	// 분리된M(모델)을 호출
	CategoryDao updateCategoryDao = new CategoryDao(); // CashDao 메서드를 이용해 cashDao 새로 선언
	int resultRow = updateCategoryDao.updateCategory(updateCategory);
	//위에서 내려온 updateCash cashDao.update() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// CashDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", updateCategory); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("중복된 아이디가 있습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/updateCashForm.jsp?msg="+msg);
		return;
	}
	// CashDao에서 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/admin/categoryList.jsp");
	
	
	
	
	
%>