<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
%>
<!DOCTYPE html>
<html> 
	<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>insertMemberForm.jsp</title>
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">
	
	<link href="https://fonts.googleapis.com/css?family=Raleway:200,300,400,700" rel="stylesheet">
	
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
	<link rel="stylesheet" href="<%=request.getContextPath()%>/Resources/css/style2.css">
	
	<!-- Modernizr JS -->
	<script src="<%=request.getContextPath()%>/Resources/js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	
	<!--스타일 -->
	<style>
	
	body {
	background-color: #FAFAFA;
    background-repeat: no-repeat;
    background-position: right;
    background-attachment: fixed;
    background-size: cover; 
    position: absolute;
	}

	.react1 {
	width: 500px;
	height: 500px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 100px;
    left: 550px;
	}

	.table {
    
    height: 200px;
    border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
    table-layout: fixed;
	 }  
 
	.th {
	width: 500px;
    height:15px;
    border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
	font-weight: bolder !important;
	white-space: nowrap; 
	color : black;
	th-layout: fixed;
	text-align : left;
	}
	td {
	width: 500px;
	padding: 10px;
	border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
	td-layout: fixed;
	overflow:hidden;
	white-space : nowrap;
	color : black;
	text-overflow: ellipsis;
	text-align : center;
	}
   	
   	.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    padding-right: 25px;
    line-height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
    box-sizing: border-box;
    z-index: 10;
    }
     
    .btn_type {
    display: block;
    width: 100%;
    padding: 15px 0 15px;
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
    }
    
   .btn_primary {
    color: #fff;
    border: solid 1px rgba(0,0,0,.08);
    background-color: #27E1CE;
    }
    
    div.indent{ padding-left: 10em }
    p.indent{ padding-right: 13em }
    
    .h1{
    align: center;}
    
	</style>
	</head>
	<body>
		<div class="react1">
		<header id="fh5co-header" role="banner" >
			<div class="container">
				<div class="header-inner">
				<h1><a href="<%=request.getContextPath()%>/loginForm.jsp">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				Flow</a></h1>
				</div>
			</div>
		</header>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			if(request.getParameter("msg") != null){
		%>
			<div align="center"><%=request.getParameter("msg") %></div>
		<%
			}
		%>
		<!-- 폼작성 -->	
		<form id="signinForm" action="<%=request.getContextPath()%>/insertMemberAction.jsp">
			<div>
			<table class="table">
				<tr>
					<th class="th">
						<span>아이디</span>
					</th>
				</tr>
				<tr>
					<td>
						<input type="text" id="memberId" class="int" name="memberId" value="">
					</td>				
				</tr>
				<tr>
					<th class="th">
						<span>비밀번호</span>
					</th>
				</tr>
				<tr>
					<td>
						<input type="password" id="memberPw" class="int" name="memberPw" value="">
					</td>				
				</tr>
				
				<tr>
					<th class="th">
						<span>이름</span>
					</th>
				</tr>
				<tr>
					<td>
					<input type="text" id="memberName" class="int" name="memberName" value="">
					</td>				
				</tr>
				<tr>
					<th>
						<p>개인정보의 수집 및 이용에 대한 동의 <span style="color:red;">(필수)</span></p>
						<p>-Flow에서 이용자 회원가입 시 직접 개인정보를 입력 및 수정하여 개인정보를 수집합니다.</p>
						<div><input type="checkbox" class="ck" name="ck">동의합니다</div>
					</th>
				</tr>
			</table>
			<button type="button" id="signinBtn" class="btn_type btn_primary"><span>가입하기</span></button>
			</div>
		</form>	
	<script>
		let signinBtn = document.querySelector('#signinBtn');
		
		signinBtn.addEventListener('click', function(){
			// 디버깅
			console.log('signinBtn click');
			
			// ID 유효성검사
			let memberId = document.querySelector('#memberId');
			if(memberId.value == ''){
				alert('ID를 입력하세요.');
				memberId.focus(); // 브라우저의 커스를 id태그로 이동
				return;
			}
			
			// PW 유효성검사
			let memberPw = document.querySelector('#memberPw');
			if(memberPw.value == ''){
				alert('비밀번호를 입력하세요.');
				memberPw.focus(); // 브라우저의 커스를 pw태그로 이동
				return;
			}
			
			// NAME 유효성검사
			let memberName = document.querySelector('#memberName');
			if(memberName.value == ''){
				alert('이름을 입력하세요.');
				memberName.focus(); // 브라우저의 커스를 pw태그로 이동
				return;
			}
			
			// 약관동의
			let ck = document.querySelectorAll('.ck:checked');
			console.log(ck.length); // 1
			if(ck.length != 1){
				alert('약관에 동의하세요');
				ck.focus();
				return;
			}
			
			let signinForm = document.querySelector('#signinForm');
			signinForm.submit(); 
		});
	</script>	
	</body>
	</div>
</html>