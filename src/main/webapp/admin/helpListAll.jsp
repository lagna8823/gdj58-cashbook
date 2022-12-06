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
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	
	String memberId = loginMember.getMemberId();
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String,Object>> list = helpDao.selectHelpList(beginRow, rowPerPage);
	
	int cnt = helpDao.count();
	//CommentDao.count() 호출하여 결과값으로 cnt값을 받음.
	System.out.println(cnt);
	//마지막 페이지 
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>helpListAll.jsp</title>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
		
		<!-- 고객센터 문의 목록 -->
		<table>
			<tr>
				<th>문의번호</th>
				<th>문의내용</th>
				<th>회원ID</th>
				<th>문의날짜</th>
				<th>답변내용</th>
				<th>답변날짜</th>
				<th>답변추가 / 수정 / 삭제</th>
			</tr>
			<%
				for(HashMap<String, Object> m : list) {
			%>
					<tr>
						<td><%=m.get("helpNo")%></td>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("memberId")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<td>
							<%
								if(m.get("commentMemo") == null) {
							%>
								<span> 답변대기</span>
							<%
								} else {
							%>
								<%=m.get("commentMemo")%>
							<%		
								}
							%>
						</td>
						<td>
							<%
								if(m.get("commentCreatedate") == null) {
							%>
								<span>날짜미정</span>
							<%
								} else {
							%>
								<%=m.get("commentCreatedate") %>
							<%		
								}
							%>
						</td>
						<td>
							<%
								if(m.get("commentMemo") == null) {
							%>
									<a href="<%=request.getContextPath()%>/admin/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>">
										답변입력
									</a>
							<%		
								} else {
							%>
									<a href="<%=request.getContextPath()%>/admin/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">답변수정</a>
									<a href="<%=request.getContextPath()%>/admin/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">답변삭제</a>
							<%		
								}
							%>
						</td>
					</tr>
			<%		
				}
			%>
		</table>
		<!-- 페이징 -->
			
			<!-- 첫 페이지 -->
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1">처음</a>
			
			<!-- 이전 페이지 -->
			<%
				if(currentPage>1){
			%>
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			
			<!-- 현재 페이지 -->
			<%=currentPage%>
			
			<!-- 다음 페이지 -->
			<%
				if(currentPage<lastPage){
			%>
				<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>	
			<!-- 마지막 페이지 -->
			<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>">마지막</a> 
	</body>
</html>