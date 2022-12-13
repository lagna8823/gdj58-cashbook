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
	<meta charset="utf-8">
	<title>menu</title>
	
	
	<link href="https://fonts.googleapis.com/css?family=Raleway:200,300,400,700" rel="stylesheet">
	
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/bootstrap2.css">
	<!-- Theme style  -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/style2.css">
	
	<style>
	
	.body {
	background-color: #F5F5F5;
    background-repeat: no-repeat;
    background-position: right;
    background-attachment: fixed;
    background-size: cover; 
    position: absolute;
	}
	</style>
	</head>
	<body class="body">
	<div id="fh5co-page">
	<header id="fh5co-header" role="banner" style="background-color: #F5F5F5;">
		<div class="container" align="right" >
			<div class="header-inner" >
				<h1><a href=<%=request.getContextPath()%>/cash/cashList.jsp>Flow</a></h1>
				<nav role="navigation" >
				<!-- partial jsp 페이지 사용할 코드-->
					<ul>
						<li><a href="<%=request.getContextPath()%>/cash/cashList.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath()%>/cash/performance.jsp">Performance</a></li>
						<%
							if(loginMember.getMemberLevel() > 0) {
						%>	
							<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">AdminPage</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">Notice</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">Category</a></li>
							<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">Member</a></li>
				   			<li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Comment</a></li>
						<%
							}
						%>
						<li><a href="<%=request.getContextPath() %>/helpList.jsp">Center</a></li>
						<li class="cta"><a href=<%=request.getContextPath()%>/cash/cashList.jsp>Get started</a></li>
					</ul>
				</nav>
		</div>
	</header>
	</div>	
	</body>
</html>