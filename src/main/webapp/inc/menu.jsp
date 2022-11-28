<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<% 
	// session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>menu.jsp</title>
      
      <!-- 부트스트랩과의 약속! -->
      <!-- Latest compiled and minified CSS -->
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
      <!-- Latest compiled JavaScript -->
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
      
	</head>
	<body>
	<!-- partial jsp 페이지 사용할 코드-->
		<div ="bold" >
			<a href="<%=request.getContextPath() %>/cash/cashList.jsp">홈으로</a>
			<a href="<%=request.getContextPath() %>/admin/noticeList.jsp">공지사항관리</a>
			<a href="<%=request.getContextPath() %>/admin/categoryList.jsp">카테고리관리</a>
			<a href="<%=request.getContextPath() %>/admin/memberList.jsp">멤버관리</a>
		   	<a href="<%=request.getContextPath() %>/admin/adminMain.jsp">관리자페이지</a>
		   	   
			
		</div>
	</body>
</html>
	<%-- <%
				if(loginMember.getMemberLevel() > 0){ 
			%>	
			 		
			<%
				}
			%>	 --%>