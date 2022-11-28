<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertNoticeForm</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
	<div>
		<!-- notice 입력폼 작성 -->
		<h1>공지 추가 페이지</h1>
		<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
		<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border="1"> 
			<tr>
				<th>공지내용</th>
			</tr>
			<tr>
				<td><textarea rows="3" cols="50" name="noticeMemo"></textarea></td>
			</tr>
		</table> 
		<button type="submit">추가하기</button>
		</form>
	</div>
</body>
</html>
