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
	String noticeMemo = request.getParameter("noticeMemo");
  	
	
	
	Notice insertNotice = new Notice(); // 모델 호출시 매개값(vo.Notice의 클래스를 이용하여 insertNotice를 새로 선언)
	insertNotice.setNoticeMemo(noticeMemo);
	
	// 분리된M(모델)을 호출
	NoticeDao noticeDao = new NoticeDao(); // NoticeDao 메서드를 이용해 noticeDao 새로 선언
	int resultRow = noticeDao.insertNotice(insertNotice);
	//위에서 받아온 insertNotice를 noitceDao.insert() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// NoticeDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", insertNotice); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("입력된 값이 없습니다. ","utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/insertNoticeForm.jsp?msg="+msg);
		return;
	}
	// NoticeDao 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp?");	
%>