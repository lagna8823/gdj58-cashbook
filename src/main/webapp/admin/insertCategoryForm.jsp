<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
	</head>
	<body>
		<div>
			<!-- adminMain contents -->
			<h1>카테리고리 목록</h1>
			<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
			<form action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<table>
				<tr>
					<th>수입/지출</th>
					<th>이름</th>
				</tr>
					<tr>
						<td><input tpye="text" name="categoryKind" value=""></td>
						<td><input tpye="text" name="categoryName" value=""></td>
					</tr>
			</table>
			<button type="submit">추가하기</button>
			</form>
		</div>
	</body>
</html>