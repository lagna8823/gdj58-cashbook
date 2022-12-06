<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	
	// request 
	request.setCharacterEncoding("utf-8"); // 한글버전 패치
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	String commentMemo = request.getParameter("commentMemo");
	
	System.out.println("테스트"+ memberId);
	System.out.println("테스트"+ commentNo);
	System.out.println("테스트"+ commentMemo);
	
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setMemberId(memberId);
	comment.setCommentMemo(commentMemo);
	
	//분리된 모델출력
	CommentDao commentDao = new CommentDao();
	int resultRow = commentDao.updateComment(comment);
	//위에서 받아온 updateComment를 commentDao.update() 클래스에로 보내고 결과값으로 resultRow 받음.
	
	// redirect
	// CategoryDao 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow == 0) {
		
		session.setAttribute("loginMember", comment); // session안에 로그인 아이디 & 이름을 저장
		String msg =URLEncoder.encode("잘못입력된 값이 있습니다.","utf-8");
		response.sendRedirect(request.getContextPath() + "/admin/updateCommentForm.jsp?msg="+msg);
		return;
	}
	// CommentDao 넘겨받은 결과 resultRow값이 0이 아니라면 입력성공!
	response.sendRedirect(request.getContextPath() + "/admin/helpListAll.jsp");
%>