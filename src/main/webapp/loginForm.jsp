<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<div>
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table>
				<tr>
					<th><span>아이디</span></th>
					<td><input type="text" name="memberId"></td>
				</tr>
				<tr>
					<th><span>비밀번호</span></th>
					<td><input type="password" name="memberPw"></td>
				</tr>
			</table>	
			<button type="submit">로그인</button>
		</form>
	</div>
	<div>
		<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
	</div>
</body>
</html>