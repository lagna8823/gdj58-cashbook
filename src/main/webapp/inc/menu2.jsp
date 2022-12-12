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
	<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
	<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
	<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
	<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>menu2</title>
	

	<!-- Bootstrap  -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/bootstrap.css">
	<!-- Theme style  -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/style2.css">
	
	<!-- Modernizr JS -->
	<script src="<%=request.getContextPath()%>/Resources/js/modernizr-2.6.2.min.js"></script>

	</head>
	<body>
	<div id="fh5co-page" align="left">
	<header id="fh5co-header" role="banner">
		<div class="container">
			<div class="header-inner">
				<h1><a href=<%=request.getContextPath()%>/cash/cashList.jsp>Flow</a></h1>
				<nav role="navigation">
				
				<!-- partial jsp 페이지 사용할 코드-->
				<div align="left"><a href=<%=request.getContextPath()%>/cash/cashList.jsp>Home</a></div>
				<%
					if(loginMember.getMemberLevel() > 0) {
				
				%>
					<div align="left"><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">AdminPage</a></div>
					<div align="left"><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">Notice</a></div>
					<div align="left"><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">Category</a></div>
					<div align="left"><a href="<%=request.getContextPath()%>/admin/memberList.jsp">Member</a></div>
		   			<div align="left"><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Comment</a></div>
				<%
					}
				%>
				<div align="left"><a href="<%=request.getContextPath() %>/helpList.jsp">Center</a></div>
				<div align="left"><a href=<%=request.getContextPath()%>/cash/cashList.jsp>Get started</a></div>
		</div>
	</header>
	</div>	
		<!-- jQuery -->
		<script src="<%=request.getContextPath()%>/Resources/js/jquery.min.js"></script>
		<!-- jQuery Easing -->
		<script src="<%=request.getContextPath()%>/Resources/js/jquery.easing.1.3.js"></script>
		<!-- Bootstrap -->
		<script src="<%=request.getContextPath()%>/Resources/js/bootstrap.min.js"></script>
		<!-- Waypoints -->
		<script src="<%=request.getContextPath()%>/Resources/js/jquery.waypoints.min.js"></script>
		<!-- Owl Carousel -->
		<script src="<%=request.getContextPath()%>/Resources/js/owl.carousel.min.js"></script>
		<!-- Flexslider -->
		<script src="<%=request.getContextPath()%>/Resources/js/jquery.flexslider-min.js"></script>
		
		<!-- MAIN JS -->
		<script src="<%=request.getContextPath()%>/Resources/js/main.js"></script>
		
	</body>
</html>