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
	
	// 입력값 체크
	if(request.getParameter("categoryNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	int rowPerPage = 1;
	int beginRow = 0;
	
	// Model 호출 : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	Category categoryList = categoryDao.selectCategoryList(categoryNo);
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
			<h1>수정하기</h1>
			<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
			<form id="signinForm" action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
			<table>
				<tr>
					<th>수입/지출</th>
					<th>이름</th>
				</tr>
					<tr>
						<td><input tpye="text" id="categoryKind" name="categoryKind" value="<%=categoryList.getCategoryKind()%>"></td>
						<td><input tpye="text" id="categoryName" name="categoryName" value="<%=categoryList.getCategoryName()%>"></td>
					</tr>
			</table>
			<button type="button" id="signinBtn">수정하기</button>
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
			signinForm.submit(); //action=/updateCategoryAction.jsp
		});
	</script>
	</body>
</html>
