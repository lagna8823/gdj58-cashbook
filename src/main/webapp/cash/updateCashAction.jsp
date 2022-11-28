<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%	
	// 1.C
	// Controller
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
  	long cashPrice = Integer.parseInt(request.getParameter("cashPrice"));
  	String cashDate = request.getParameter("cashDate");
   	String cashMemo = request.getParameter("cashMemo");
   	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
   	
   	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	
	// 입력값 체크
	if(request.getParameter("categoryNo") == null || request.getParameter("cashPrice") == null || request.getParameter("cashDate") == null || request.getParameter("cashMemo") == null || request.getParameter("cashNo") == null
		|| request.getParameter("categoryNo").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashDate") == "" || request.getParameter("cashMemo").equals("") || request.getParameter("cashNo").equals("")) {
		String msg = URLEncoder.encode("입력되지 않은 값이있습니다.", "utf-8"); 
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+cashNo+"&msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	}
	
	Cash updateCash = new Cash(); // 모델 호출시 매개값(vo.Cash의 클래스를 이용하여 updateCash를 새로 선언)
	updateCash.setCategoryNo(categoryNo);
	updateCash.setCashPrice(cashPrice);
	updateCash.setCashDate(cashDate); 
	updateCash.setCashMemo(cashMemo);
	updateCash.setCashNo(cashNo);
	
	// 분리된M(모델)을 호출
	CashDao updateCashDao = new CashDao(); // CashDao 메서드를 이용해 cashDao 새로 선언
	int resultRow = updateCashDao.update(updateCash);
	//위에서 내려온 updateCash cashDao.update() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// CashDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", updateCash); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("중복된 아이디가 있습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/updateCashForm.jsp?msg="+msg);
		
	}
	// CashDao에서 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	return;
	
	
	
	
%>