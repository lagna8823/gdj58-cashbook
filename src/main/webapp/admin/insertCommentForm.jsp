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
	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	String memberId = loginMember.getMemberId();
	
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpNoComment(helpNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCommentForm</title>
</head>
<body>
	<div>
	<!-- comment 답변 폼 작성-->
	<h1>답변 작성 페이지</h1>
	<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
	<input type="hidden" name="helpNo" value="<%=helpNo%>">
	<table border="1">
		<tr>
			<th>회원ID</th>
			<th>문의날짜</th>
			<th>문의내용</th>
			<th>답변내용</th>
		</tr>
		<%
			for(HashMap<String, Object> h : list ){
		%>
			<tr>
				<td><%=h.get("memberId")%></td>
				<td><%=h.get("createdate")%></td>
				<td><%=h.get("helpMemo")%></td>
		<%		
			}
		%>
				<td><textarea rows="6" cols="80" name="commentMemo"></textarea></td>
			</tr>
	</table>
	</form>
	</div>
</body>
</html>