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
	MemberDao memberDao = new MemberDao(); //최근멤버
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminMain</title>
</head>
<body>
	<ul>
		<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">공지관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리관리</a></li>
		<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버관리(목록, 레벨수정, 강제탈퇴)</a></li>
	</ul>
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
	
	<div>
		<!-- adminMain contents -->
	</div>
</body>
</html>
