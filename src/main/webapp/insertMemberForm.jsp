<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm.jsp</title>
	</head>
	<body> 
		<h1>회원가입</h1>	
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			if(request.getParameter("msg") != null){
		%>
			<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
		<!-- 폼작성 -->
		<form action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<table>
				<tr>
					<td>
						<span>아이디</span>
					</td>
					<td>
						<input type="text" name="memberId" value="">
					</td>				
				</tr>
				<tr>
					<td>
						<span>비밀번호</span>
					</td>
					<td>
						<input type="password" name="memberPw" value="">
					</td>				
				</tr>
				<tr>
					<td>
						<span>이름</span>
					</td>
					<td>
					<input type="text" name="memberName" value="">
					</td>				
				</tr>
				<tr>
					<td colspan="2">
					<button type="submit">추가하기</button>
					</td>				
				</tr>
			</table>
		</form>		
	</body>
</html>