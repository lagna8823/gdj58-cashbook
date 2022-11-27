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
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
   	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
   	
   	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	
	Cash deleteCash = new Cash(); // 모델 호출시 매개값(vo.Cash의 클래스를 이용하여 deleteCash를 새로 선언)
	deleteCash.setCashNo(cashNo);
	
	// 분리된M(모델)을 호출
	CashDao deleteCashDao = new CashDao(); // CashDao 메서드를 이용해 cashDao 새로 선언
	int resultRow = deleteCashDao.delete(deleteCash);
	//위에서 내려온 deleteCash cashDao.delete() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// CashDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", deleteCash); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("삭제할 내역이 없습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/cashDateList.jsp?msg="+msg);
		
	}
	// CashDao에서 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	return;
	
	
	
	
%>