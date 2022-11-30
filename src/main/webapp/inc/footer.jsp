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
	<title>menu</title>
	

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
   <link rel="shortcut icon" href="favicon.ico">

   <link href="https://fonts.googleapis.com/css?family=Raleway:500,300,400,700" rel="stylesheet">
   
   <!-- Animate.css -->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/animate.css">
   <!-- Icomoon Icon Fonts-->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/icomoon.css">
   <!-- Bootstrap  -->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/bootstrap.css">
   <!-- Flexslider  -->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/flexslider.css">
   <!-- Owl Carousel  -->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/owl.carousel.min.css">
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/owl.theme.default.min.css">
   <!-- Theme style  -->
   <link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/style.css">

   <!-- Modernizr JS -->
   <script src="<%=request.getContextPath()%>/Resources/js/modernizr-2.6.2.min.js"></script>
   <!-- FOR IE9 below -->
   <!--[if lt IE 9]>
   <script src="js/respond.min.js"></script>
   <![endif]-->

   </head>
	<body>
	<footer id="fh5co-adminFooter" role="contentinfo">
	
		<div class="container">
			<div class="col-md-3 col-sm-12 col-sm-push-0 col-xs-12 col-xs-push-0">
				<h3>About Us</h3>
				<p>We are a company operating in Korea. We will give you innovative support. </p>
				<p><a href="#" class="btn btn-primary btn-outline with-arrow btn-sm">Join Us <i class="icon-arrow-right"></i></a></p>
			</div>
			<div class="col-md-6 col-md-push-1 col-sm-12 col-sm-push-0 col-xs-12 col-xs-push-0">
				<h3>Our Services</h3>
				<ul class="float">
					<li><a href="#">Web Design</a></li>
					<li><a href="#">Branding &amp; Identity</a></li>
					<li><a href="#">Free HTML5</a></li>
					<li><a href="#">HandCrafted Templates</a></li>
				</ul>
				<ul class="float">
					<li><a href="#">Free Bootstrap Template</a></li>
					<li><a href="#">Free HTML5 Template</a></li>
					<li><a href="#">Free HTML5 &amp; CSS3 Template</a></li>
					<li><a href="#">HandCrafted Templates</a></li>
				</ul>

			</div>

			<div class="col-md-2 col-md-push-1 col-sm-12 col-sm-push-0 col-xs-12 col-xs-push-0">
				<h3>Follow Us</h3>
				<ul class="fh5co-social">
					<li><a href="#"><i class="icon-twitter"></i></a></li>
					<li><a href="#"><i class="icon-facebook"></i></a></li>
					<li><a href="#"><i class="icon-google-plus"></i></a></li>
					<li><a href="#"><i class="icon-instagram"></i></a></li>
				</ul>
			</div>
			
			
			<div class="col-md-12 fh5co-copyright text-center">
				<p>&copy; 2016 Free HTML5 template. All Rights Reserved. <span>Designed with <i class="icon-heart"></i> by <a href="http://freehtml5.co/" target="_blank">FreeHTML5.co</a> Demo Images by <a href="http://unsplash.com/" target="_blank">Unsplash</a></span></p>	
			</div>
			
		</div>
	</footer>
	</div>
		<!-- jQuery -->
		<script src="./Resources/js/jquery.min.js"></script>
		<!-- jQuery Easing -->
		<script src="./Resources/js/jquery.easing.1.3.js"></script>
		<!-- Bootstrap -->
		<script src="./Resources/js/bootstrap.min.js"></script>
		<!-- Waypoints -->
		<script src="./Resources/js/jquery.waypoints.min.js"></script>
		<!-- Owl Carousel -->
		<script src="./Resources/js/owl.carousel.min.js"></script>
		<!-- Flexslider -->
		<script src="./Resources/js/jquery.flexslider-min.js"></script>
		
		<!-- MAIN JS -->
		<script src="./Resources/js/main.js"></script>
	</body>
</html>