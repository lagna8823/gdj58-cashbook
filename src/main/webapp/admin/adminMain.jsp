<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 관리자페이지 최근공지 5개, 최근멤버 5명
	int rowPerPage = 5;
	int beginRow = 0;
	
	// Model 호출
	NoticeDao noticeDao = new NoticeDao(); // 최근공지 
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>adminMain</title>
	</head>
	<body>
		<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
		<!-- 최근공지 5개 출력 -->
		<h1>최근 공지사항</h1>
		<div>
			<table border="1"> 
				<tr>
					<th>번호</th>
					<th>공지내용</th>
					<th>생성날짜</th>
				</tr>
				<%
					for(Notice n : list){
				%>
				<tr>
					<td><%=n.getNoticeNo() %></td>
					<td><%=n.getNoticeMemo() %></td>
					<td><%=n.getCreatedate()%></td>
				<%
					}				
				%>
				</tr>
			</table>
		</div>
		<!-- 최근멤버 5명 출력 -->
		<h1>최근 가입멤버</h1>
		<div>
			<table border="1"> 
				<!-- adminMain contents -->
				<tr>
					<th>번호</th>
					<th>공지내용</th>
					<th>생성날짜</th>
				</tr>
				<%
					for(Notice n : list){
				%>
				<tr>
					<td><%=n.getNoticeNo() %></td>
					<td><%=n.getNoticeMemo() %></td>
					<td><%=n.getCreatedate()%></td>
				<%
					}				
				%>
				</tr>
			</table>
		</div>
	</body>
</html>
