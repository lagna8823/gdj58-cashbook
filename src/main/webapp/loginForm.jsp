<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 5;
	int beginRow = (currentPage-1)*rowPerPage;
	
	// 분리된M(모델)을 호출
	NoticeDao noticeDao = new NoticeDao(); // NoticeDao 메서드를 이용해 noticeDao 새로 만듬
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	// noticeDao클래스의 selectNoticeListByPage로 (beginRow, rowPerPage)보내 결과값 ArrayList<Notice> list을 받아옴
	
	int cnt = noticeDao.count(); 
	//cnt 값을 noticeDao.count() 클래스에로 보내고 결과값으로 cnt값을 받음.
	
	//마지막 페이지 
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
%>


<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>logimForm</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	<meta name="author" content="FreeHTML5.co" />

  <!-- 
	//////////////////////////////////////////////////////

	FREE HTML5 TEMPLATE 
	DESIGNED & DEVELOPED by FreeHTML5.co
		
	Website: 		http://freehtml5.co/
	Email: 			info@freehtml5.co
	Twitter: 		http://twitter.com/fh5co
	Facebook: 		https://www.facebook.com/fh5co

	//////////////////////////////////////////////////////
	 -->

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
   <link rel="shortcut icon" href="favicon.ico">

   <link href="https://fonts.googleapis.com/css?family=Raleway:200,300,400,700" rel="stylesheet">
   
   <!-- Animate.css -->
   <link rel="stylesheet" href="./Resources/css/animate.css">
   <!-- Icomoon Icon Fonts-->
   <link rel="stylesheet" href="./Resources/css/icomoon.css">
   <!-- Bootstrap  -->
   <link rel="stylesheet" href="./Resources/css/bootstrap.css">
   <!-- Flexslider  -->
   <link rel="stylesheet" href="./Resources/css/flexslider.css">
   <!-- Owl Carousel  -->
   <link rel="stylesheet" href="./Resources/css/owl.carousel.min.css">
   <link rel="stylesheet" href="./Resources/css/owl.theme.default.min.css">
   <!-- Theme style  -->
   <link rel="stylesheet" href="./Resources/css/style2.css">

   <!-- Modernizr JS -->
   <script src="./Resources/js/modernizr-2.6.2.min.js"></script>
   <!-- FOR IE9 below -->
   <!--[if lt IE 9]>
   <script src="js/respond.min.js"></script>
   <![endif]-->
	
	<style>
	.btn_type {
    display: block;
    width: 80%;
    font-size: 18px;
    font-weight: 180;
    text-align: center;
    cursor: pointer;
    }
    
   .btn_primary {
    color: #000000;
    border: solid 1px rgba(0,0,0,.08);
    font-weight: bolder !important;
    background-color: #fff;
    }
    
    .div:hover{
    color:#fff;
    background-color:#27E1CE;
    }
    
	</style>
  	</head>
	<body>
	<div id="fh5co-page">
	<header id="fh5co-header" role="banner">
		<div class="container">
			<div class="header-inner">
				<h1><a href="loginForm.jsp">Flow</a></h1>
				<nav role="navigation">
					<ul>
						<li><a href="#login">Work</a></li>
						<li><a href="#service">Services</a></li>
						<li><a href="#price">Pricing</a></li>
						<li><a href="#login">About</a></li>
						<li><a href="<%=request.getContextPath()%>/helpList.jsp">Center</a></li>
						<li class="cta"><a href="#login">Login</a></li>
					</ul>
				</nav>
			</div>
		</div>
	</header>
	
	<div class="container">
		
	</div>
	<aside id="fh5co-hero" class="js-fullheight">
		<div class="flexslider js-fullheight">
			<ul class="slides">
		   	<li style="background-image: url(./Resources/images/slide_1.jpg);">
		   		<div class="overlay-gradient"></div>
		   		<div class="container">
		   			<div class="col-md-10 col-md-offset-1 text-center js-fullheight slider-text">
		   				<div class="slider-text-inner">
		   					<h2>Start Your Calendar</h2>
		   					<p><a href="#login" class="btn btn-primary btn-lg">Get started</a></p>
		   				</div>
		   			</div>
		   		</div>
		   	</li>
		   	<li style="background-image: url(./Resources/images/slide_2.jpg);">
		   		<div class="container">
		   			<div class="col-md-10 col-md-offset-1 text-center js-fullheight slider-text">
		   				<div class="slider-text-inner">
		   					<h2>Take Your Daily life To The Next Level</h2>
		   					<p><a href="#login" class="btn btn-primary btn-lg">Get started</a></p>
		   				</div>
		   			</div>
		   		</div>
		   	</li>
		   	<li style="background-image: url(./Resources/images/slide_3.jpg);">
		   		<div class="container">
		   			<div class="col-md-10 col-md-offset-1 text-center js-fullheight slider-text">
		   				<div class="slider-text-inner">
		   					<h2>We Think Different That Others Can't</h2>
		   					<p><a href="#login" class="btn btn-primary btn-lg">Get started</a></p>
		   				</div>
		   			</div>
		   		</div>
		   	</li>
		  	</ul>
	  	</div>
	</aside>
	<h1 id="login"></h1>
	<div id="fh5co-services-section">
		<div class="container">
			<div class="row">
				<div class="col-md-6 col-md-offset-3 text-center fh5co-heading animate-box">
					<h2>Login</h2>
					<p>Hompage Renewal</p>
				</div>
				<div class="row">
					<div class="col-md-8 animate-box">
						<div class="services">
							<i class="icon-server"></i>
							<div class="desc">
								<h3>최근 공지사항</h3>
								<!-- 공지 (5개) 목록 페이징 -->
								<div align= left>
									<table>
										<tr>
											<th>공지사항 목록</th>
											<th>날짜</th>
										</tr>
										<%
											for(Notice n : list) {
										%>
												<tr>
													<td><%=n.getNoticeMemo()%></td>
													<td><%=n.getCreatedate()%></td>
												</tr>
										<%		
											} 
										%>
									</table>
								</div>
								<br>
								<div>
									<!-- 처음 -->
									<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1#login" style="text-decoration: none;">처음</a>
									
								 	<!-- 이전 -->
									<%
										if(currentPage >1){
									%>
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>#login" style="text-decoration: none;">이전</a>
									<% 
										}
									%>
									
									<!-- 현재 -->
									<%=currentPage%>
									
									<!-- 다음 -->
									<%
										if(currentPage < lastPage){
									%>
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>#login" style="text-decoration: none;">다음</a>
									<%  
										}
									%>
									<!-- 마지막 -->
									
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>#login" style="text-decoration: none;">마지막</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-4 animate-box">
						<div class="services">
							<i class="icon-laptop"></i>
							<div class="desc">
								<h3>Login</h3>
								<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
									<div>
									<table>
										<tr>
											<th><span>ID &nbsp; </span></th>
											<td><input type="text" name="memberId" value="test"></td>
										</tr>
										<tr>
											<th><span>PW &nbsp;</span></th>
											<td><input type="password" name="memberPw" value="1234"></td>
										</tr>
									</table>	
									</div>
									<br>
									<div align="left">
										<div >
											<div>
											<button type="submit" class="btn_type btn_primary div">login</button>
											</div> 
										</div>
										<div >
											<a href="<%=request.getContextPath()%>/insertMemberForm.jsp" class="btn_type btn_primary div" style="text-decoration: none;" >Sign up</a>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br><br><br><br><br>
	<br><br><br><br><br>
	
	
	<br id="service">
	<div id="fh5co-work-section" class="fh5co-light-grey-section">
		<div class="container">
			<div class="row">
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_1.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">CashDateList</h3>
								<h5 class="category">메인 페이지, 회원정보 기능</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_2.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">CashOne </h3>
								<h5 class="category">상세내역 및 가계부 추가</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_3.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">Performance</h3>
								<h5 class="category">년도별, 월별 지출내역</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_4.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">AdminPage</h3>
								<h5 class="category">최근 공지, 최근 가입멤버</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_5.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">Noteice</h3>
								<h5 class="category">공지사항 관리</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_6.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">Category</h3>
								<h5 class="category">카테고리 관리</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_7.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">Member</h3>
								<h5 class="category">멤버 관리, 멤버 레벨</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_8.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">Comment</h3>
								<h5 class="category">답변 관리</h5>
							</div>
						</div>
					</a>
				</div>
				<div class="col-md-4 animate-box">
					<a href="#" class="item-grid text-center">
						<div class="image" style="background-image: url(images/image_9.png)"></div>
						<div class="v-align">
							<div class="v-align-middle">
								<h3 class="title">Center</h3>
								<h5 class="category">고객센터</h5>
							</div>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<br id="price">
	
	
	
		<div id="fh5co-pricing-section">
		<div  class="container" >
			<div class="row">
				<div class="col-md-6 col-md-offset-3 text-center fh5co-heading animate-box">
					<h2>Pricing</h2>
					<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. </p>
				</div>
			</div>
			<div class="row">
				<div class="pricing">
					<div class="col-md-3 animate-box">
						<div class="price-box">
							<h2 class="pricing-plan">Starter</h2>
							<div class="price"><sup class="currency">$</sup>9<small>/month</small></div>
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. </p>
							<a href="#" class="btn btn-select-plan btn-sm">Select Plan</a>
						</div>
					</div>

					<div class="col-md-3 animate-box">
						<div class="price-box">
							<h2 class="pricing-plan">Basic</h2>
							<div class="price"><sup class="currency">$</sup>27<small>/month</small></div>
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. </p>
							<a href="#" class="btn btn-select-plan btn-sm">Select Plan</a>
						</div>
					</div>

					<div class="col-md-3 animate-box">
						<div class="price-box popular">
							<h2 class="pricing-plan pricing-plan-offer">Pro <span>Best Offer</span></h2>
							<div class="price"><sup class="currency">$</sup>74<small>/month</small></div>
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. </p>
							<a href="#" class="btn btn-select-plan btn-sm">Select Plan</a>
						</div>
					</div>

					<div class="col-md-3 animate-box">
						<div class="price-box">
							<h2 class="pricing-plan">Unlimited</h2>
							<div class="price"><sup class="currency">$</sup>140<small>/month</small></div>
							<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. </p>
							<a href="#" class="btn btn-select-plan btn-sm">Select Plan</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<footer id="fh5co-footer" role="contentinfo">
	
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