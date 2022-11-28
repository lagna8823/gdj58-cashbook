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
	
	// 페이지 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
		
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	int cnt = memberDao.count(); 
	// cnt 값을 memberDao.count() 클래스에로 보내고 결과값으로 cnt값을 받음.
	
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
</head>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
    </div>
	<div>
		<!-- memberList contents... -->
		<h1>멤버목록</h1>
		
		<table border="1">
			<tr>
				<th>멤버번호</th>
				<th>아이디</th>
				<th>레벨</th>
				<th>이름</th>
				<th>마지막수정일자</th>
				<th>생성일자</th>
				<th>레벨수정</th>
				<th>멤버강퇴</th>
			</tr>
			<%
				for(Member m : list) {
			%>
			<tr>
			
				<td><%=m.getMemberNo()%></td>
				<td><%=m.getMemberId()%></td>
				<td><%=m.getMemberLevel()%></td>
				<td><%=m.getMemberName()%></td>
				<td><%=m.getUpdatedate()%></td>
				<td><%=m.getCreatedate()%></td>
				<td><a href="<%=request.getContextPath()%>/admin/updateMemberForm.jsp?memberNo=<%=m.getMemberNo()%>&memberLevel=<%=m.getMemberLevel()%>">레벨수정</a></td>
				<td><a href="<%=request.getContextPath()%>/admin/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">멤버강퇴</a></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>
