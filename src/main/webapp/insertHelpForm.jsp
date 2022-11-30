<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertHelpForm</title>
	</head>
	<body>
		<h1>문의추가</h1>
		<div>
		<form action="<%=request.getContextPath()%>/insertHelpAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>작성자</th>
					<th>문의내용</th>
				</tr>
				<tr>
					<td><input tpye="hidden" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
					<td><textarea rows="8" cols="80" name="helpMemo"></textarea></td>
				</tr>
			</table>
			<button type="submit">작성완료</button>
		</form>
		<a href="<%=request.getContextPath()%>/helpList.jsp">돌아가기</a>
		</div>
	</body>
</html>