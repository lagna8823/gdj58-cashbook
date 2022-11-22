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
	 if(memberId == null || memberName == null || memberId.equals("") || memberPw == null || memberName.equals("")|| memberPw.equals("")) {
      String msg = URLEncoder.encode("입력된값을 확인하세요","utf-8"); // get방식 주소창에 문자열 인코딩
      response.sendRedirect(request.getContextPath()+"/cash/insertCashForm.jsp?msg="+msg);
      return;
   }

	
	// 2. M
	// DB정보 연결
	DBUtil dbUtil = new DBUtil();
	Connection conn = dbUtil.getConnection();
%>