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
	
	// 입력값 체크
		if(request.getParameter("noticeNo") == null){
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
			return;
		}
		
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		
		// Model 호출 : 카테고리 목록
		NoticeDao noticedao = new NoticeDao();
		Notice NoticeList = noticeDao.selectCategoryList(noticeNo);
		
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
	<div>
		<!-- notice 입력폼 작성 -->
		<h1>공지 수정 페이지</h1>
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
				<td><textarea rows="3" cols="50" name="noticeMemo" ></textarea></td>
			</tr>
		</table> 
		<button type="submit">수정하기</button>
		</form>
	</div>
</body>
</html>
