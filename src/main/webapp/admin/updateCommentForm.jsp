<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println( memberId);
	CommentDao commentDao = new CommentDao();
	ArrayList<Comment> list = commentDao.selectCommentList(commentNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCommentForm</title>
	</head>
	<body>
		<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
		<div>
		<!-- comment 답변 폼 작성-->
		<h1>답변 수정 페이지</h1>
		<form action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp" method="post">
		<input type="hidden" name="commentNo" value="<%=commentNo%>">
		<table border="1">
			<%
				for(Comment c : list ){
			%>
				<tr>
					<th>관리자ID</th>
					<td><%=c.getMemberId()%></td>
					
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=c.getCreatedate()%></td>
				</tr>
				<tr>
					<th>답변내용</th>
					<td><textarea rows="6" cols="80" name="commentMemo"><%=c.getCommentMemo()%></textarea></td>
				</tr>
			<%		
				}
			%>
		
		</table>
		<button type="submit">답변 수정</button>
		</form>
		</div>
	</body>
</html>