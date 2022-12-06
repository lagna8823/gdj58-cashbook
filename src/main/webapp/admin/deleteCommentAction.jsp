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
   	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
   	String memberId = loginMember.getMemberId();
   	System.out.println(commentNo);
   	
   	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setMemberId(memberId);
	
	// 분리된M(모델)을 호출
	CommentDao commentDao = new CommentDao();
	int resultRow = commentDao.deleteComment(comment);
	
	
	// redirect
	response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp");
%>