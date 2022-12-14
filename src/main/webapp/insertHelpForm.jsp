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
		<form id="signinForm" action="<%=request.getContextPath()%>/insertHelpAction.jsp">
			<table border="1">
				<tr>
					<th>작성자</th>
					<th>문의내용</th>
				</tr>
				<tr>
					<td><input tpye="hidden" name="memberId" value="<%=loginMember.getMemberId()%>" readonly="readonly"></td>
					<td><textarea id="helpMemo" rows="8" cols="80" name="helpMemo"></textarea></td>
				</tr>
			</table>
			<button type="button" id="signinBtn">추가하기</button>
		</form>
		<a href="<%=request.getContextPath()%>/helpList.jsp">돌아가기</a>
		</div>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			//공지사항 폼 유효성 검사
			let helpMemo = document.querySelector('#helpMemo');
			if(helpMemo.value == ''){
				alert('문의내용을 확인하세요.');
				helpMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/insertHelpAction.jsp
		});
	</script>	
	</body>
</html>