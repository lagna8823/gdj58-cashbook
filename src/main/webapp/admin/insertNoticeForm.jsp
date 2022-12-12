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
	// View
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>insertNoticeForm</title>
		<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--스타일 -->
	<style>
	
	.body {
	background-color: #FAFAFA;
    background-repeat: no-repeat;
    background-position: right;
    background-attachment: fixed;
    background-size: cover; 
    position: absolute;
	}

	.react1 {
	width: 600px;
	height: 600px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
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
 
	th {
	width: 200px;
    height:15px;
    border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
	font-weight: bolder !important;
	white-space: nowrap; 
	color : black;
	th-layout: fixed;
	text-align : center;
	}
	td {
	width: 200px;
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
	
	.a:hover {
	color: #fff;
	background-color: #27E1CE;
	text-decoration: none;
	font-weight: bolder !important;
	}  
	</style>
	</head>
	<body class="body">
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
	    
		<div class="react1">
		<!-- 공지사항 상단 제목-->
		<p class="indent" align="center">
			<span style="font-size:2em;  color: black; font-weight: bolder !important;">공지사항 추가 </span>
		</p>
		<br>
		
		<!-- notice 입력폼 작성 -->	
		<form action="<%=request.getContextPath()%>/admin/insertNoticeAction.jsp">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<table border="1"> 
				<tr>
					<th colspan='2'>공지내용</th>
				</tr>
				<tr>
					<td colspan='2'><textarea rows="3" cols="50" name="noticeMemo"></textarea></td>
				</tr>
				<tr>
					<td><a class="btn_type btn_primary a" 
							href="<%=request.getContextPath()%>/admin/noticeList.jsp">돌아가기</a></td>
					<td cols="50"><button type="submit" class="btn_type btn_primary">수정하기</button></td>
				</tr>
			</table> 
		</form>
		</div>
	</body>
</html>
