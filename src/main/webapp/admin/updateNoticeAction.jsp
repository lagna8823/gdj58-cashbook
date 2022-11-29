<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>
<%
	//Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 입력값 체크
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeMemo") == null || request.getParameter("noticeNo").equals("") || request.getParameter("noticeMemo").equals("")){
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}
	
	// 데이터 받아와 값세팅
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeMemo = request.getParameter("noticeMemo");
	Notice updateNotice = new Notice(); // 모델 호출시 매개값(vo.Notice 클래스를 이용하여 updateNotice를 새로 선언)
	updateNotice.setNoticeNo(noticeNo);
	updateNotice.setNoticeMemo(noticeMemo);
	
	// NoticeDao 클래스 이용하여 noticeDao 새로 생성
	NoticeDao noticeDao = new NoticeDao();
	int resultRow = noticeDao.updateNotice(updateNotice); // noitceDao메서드 호출
	
	// redirect
	// NoticeDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", updateNotice); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("잘못입력된 값이있습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/updateNoticeForm.jsp?msg="+msg);
		return;
	}
	// NoticeDao에서 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	 response.sendRedirect(request.getContextPath() + "/admin/noticeList.jsp");
%>
