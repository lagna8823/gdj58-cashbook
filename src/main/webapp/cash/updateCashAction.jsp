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
	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// request
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
   	String cashMemo = request.getParameter("cashMemo");
   	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
   	int year=Integer.parseInt(request.getParameter("year"));
	int month=Integer.parseInt(request.getParameter("month"));
	int date=Integer.parseInt(request.getParameter("date"));
	
	// 가계 금액 입력시 NULL 과 공백값을 처리하기 위한 데이터 타입 변경
		long cashPrice = 0;
		String price = request.getParameter("cashPrice");
	
	// 입력값 체크, 공백값이 넘어왔을 때
	if(price == null || price.equals("") || request.getParameter("cashMemo") == null || request.getParameter("cashNo") == null
		|| request.getParameter("categoryNo").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("") || request.getParameter("cashNo").equals("")) {
		String msg = URLEncoder.encode("입력되지 않은 값이있습니다.", "utf-8"); 
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+cashNo+"&msg="+msg+"&year="+year+"&month="+month+"&date="+date);
		return;
	} else {
		cashPrice = Integer.parseInt(request.getParameter("cashPrice")); //입력받은 값이 NULL이나 공백값이 아니라면 그대로 저장.
	}
	
	Cash updateCash = new Cash(); // 모델 호출시 매개값(vo.Cash의 클래스를 이용하여 updateCash를 새로 선언)
	updateCash.setCashPrice(cashPrice);
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