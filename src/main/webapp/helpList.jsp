<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp#login");
		return;
	}
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	String memberId = loginMember.getMemberId();
	int helpNo= 0;
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId,beginRow,rowPerPage);
	
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
<title>고객센터</title>
</head>
<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
<body>
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
	<h1>고객센터</h1>
	<div>
		<a href="<%=request.getContextPath()%>/insertHelpForm.jsp">문의추가</a>
	</div>
	<table border="1">
		<tr>
			<th>문의내용</th>
			<th>문의날짜</th>
			<th>답변내용</th>
			<th>답변날짜</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=m.get("helpMemo")%></td>
					<td><%=m.get("helpCreatedate")%></td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								답변전
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
								답변전	
						<%		
							} else {
						%>
								<%=m.get("commentCreatedate")%>
						<%	
							}
						%>	
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>">수정</a>	
						<%		
							} else {
						%>
								&nbsp;
						<%	
							}
						%>	
					</td>
					<td>
						<%
							if(m.get("commentMemo") == null) {
						%>
								<a href="<%=request.getContextPath()%>/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>	
						<%		
							} else {
						%>
								&nbsp;
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
			<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=1">처음</a>
			
			<!-- 이전 페이지 -->
			<%
				if(currentPage>1){
			%>
			<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			
			<!-- 현재 페이지 -->
			<%=currentPage%>
			
			<!-- 다음 페이지 -->
			<%
				if(currentPage<lastPage){
			%>
				<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>	
			<!-- 마지막 페이지 -->
			<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=<%=lastPage%>">마지막</a> 
</body>
</html>