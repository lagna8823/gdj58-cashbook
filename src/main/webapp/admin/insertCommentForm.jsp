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
		<form id="signinForm" action="<%=request.getContextPath()%>/admin/insertCommentAction.jsp">
		<input type="hidden" name="helpNo" value="<%=helpNo%>">
		<input type="hidden" name="memberId" value="<%=memberId%>">
		<table border="1">
			<%
				for(HashMap<String, Object> h : list ){
			%>
				<tr>
					<th>회원ID</th>
					<td><%=h.get("memberId")%></td>
					
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
				<td><textarea id="commentMemo" rows="6" cols="80" name="commentMemo"></textarea></td>
				</tr>
		</table>
		<button type="button" id="signinBtn">답변 추가</button>
		<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
		</form>
		</div>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			//공지사항 폼 유효성 검사
			let commentMemo = document.querySelector('#commentMemo');
			if(commentMemo.value == ''){
				alert('문의내용을 확인하세요.');
				commentMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/insertCommentAction.jsp
		});
	</script>
	</body>
</html>