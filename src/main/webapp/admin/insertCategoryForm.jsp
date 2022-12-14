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
			<form id="signinForm" action="<%=request.getContextPath()%>/admin/insertCategoryAction.jsp">
			<input type="hidden"  name="memberId" value="<%=loginMember.getMemberId()%>">
			<table>
				<tr>
					<th>수입/지출</th>
					<th>내역</th>
				</tr>
					<tr>
						<td><input tpye="text" id="categoryKind" name="categoryKind" value=""></td>
						<td><input tpye="text" id="categoryName" name="categoryName" value=""></td>
					</tr>
			</table>
			<button type="button" id="signinBtn">추가하기</button>
			</form>
		</div>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			// 수입지출 폼 유효성 검사
			let categoryKind = document.querySelector('#categoryKind');
			if(categoryKind.value == ''){
				alert('수입/지출을 확인하세요.');
				categoryKind.focus();
				return;
			}
			
			// 내역 폼 유효성 검사
			let categoryName = document.querySelector('#categoryName');
			if(categoryName.value == ''){
				alert('내역을 확인하세요.');
				categoryName.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/insertCategoryAction.jsp
		});
	</script>
	</body>
</html>
