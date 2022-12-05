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
		<h1>답변 작성 페이지</h1>
		<form action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp" method="post">
		<input type="hidden" name="helpNo" value="<%=helpNo%>">
		<table border="1">
			<%
				for(HashMap<String, Object> h : list ){
			%>
				<tr>
					<th>회원ID</th>
					<td><input type="text" name="memberId" value="<%=h.get("memberId")%>" readonly="readonly"></td>
					
				</tr>
				<tr>
					<th>문의날짜</th>
					<td><%=h.get("createdate")%></td>
				</tr>
				<tr>
					<th>문의내용</th>
					<td><%=h.get("helpMemo")%></td>
				</tr>
			<%		
				}
			%>
				<tr>
				<th>답변내용</th>
				<td><textarea rows="6" cols="80" name="commentMemo"></textarea></td>
				</tr>
		</table>
		<button type="submit">답변 작성</button>
		</form>
		</div>
	</body>
</html>