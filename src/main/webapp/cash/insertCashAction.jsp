<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>

<%	
	// 1.C
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	String memberId = request.getParameter("memberId");
	String cashDate = request.getParameter("cashDate");
  	long cashPrice = Integer.parseInt(request.getParameter("cashPrice"));
   	String cashMemo = request.getParameter("cashMemo");
   	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	
	
	Cash insertCash = new Cash(); // 모델 호출시 매개값(vo.Cash의 클래스를 이용하여 insertCash를 새로 선언)
	insertCash.setCategoryNo(categoryNo);
	insertCash.setMemberId(memberId);
	insertCash.setCashDate(cashDate); // 새로 선언된 insertCash에 넘겨받은 값 세팅.
	insertCash.setCashPrice(cashPrice);
	insertCash.setCashMemo(cashMemo);
	
	// 분리된M(모델)을 호출
	CashDao cashDao = new CashDao(); // CashDao 메서드를 이용해 cashDao 새로 선언
	int resultRow = cashDao.insert(insertCash);
	//위에서 내려온 insertCash cashDao.insert() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// CashDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", insertCash); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("중복된 아이디가 있습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?msg="+msg);
		
	}
	// CashDao에서 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	return;
	
	
	
	
%>