<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 관리자페이지 최근공지 5개, 최근멤버 5명
	int rowPerPage = 5;
	int beginRow = 0;
	
	// Model 호출 (최근공지)
	NoticeDao noticeDao = new NoticeDao(); 
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	
	// Model 호출 (최근 멤버)
	MemberDao memberDao = new MemberDao(); 
	ArrayList<Member> list2 = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>adminMain</title>
	
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--스타일 -->
	<style>
	
	.img{
	width: 300%;
 	}

	.react1 {
	box-sizing: border-box;
	}
	.react2 {
	box-sizing: border-box;
	position: absolute;
	}
	.react3 {
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 200px;
	left: 250px;
	}
	.react4 {
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 200px;
	left: 1000px;
	}
	
	table {
    table-layout: fixed;
    text-align : center;
	 }  
 
	.th {
	padding: 10px;
	width: 200px;
    border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap; 
	color : black;
	text-align : center;
	}
	
	td {
	width: 200px;
	height: 25px;
	padding: 10px;
	border: 1px solid #666666;
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
	
	p.indent{ padding-left: 8em }
	
	</style>
	</head>
	<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
    </div>
	    <div class="react1">
			<!--배경이미지 -->
	    	<div  class="react2">
	    		<img class="img" src="<%=request.getContextPath()%>/Resources/images/mainm.jpg">
	    	</div>
			<!-- 최근공지 5개 출력 -->
			<div class="react3" style="width:45%; float : left;">
				<p class="indent" align="center">
					<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 최근 공지사항 </span>
				</p>
				<!-- adminMain Notice contents -->
				<table> 
					<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
						<th class="th">번호</th>
						<th class="th">공지내용</th>
						<th class="th">생성날짜</th>
					</tr>
					<%
						for(Notice n : list){
					%>
					<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
						<td><%=n.getNoticeNo() %></td>
						<td><%=n.getNoticeMemo() %></td>
						<td><%=n.getCreatedate()%></td>
					<%
						}				
					%>
					</tr>
				</table>
			</div>
			
			<!-- 최근멤버 5명 출력 -->
			<div class="react4" style="width:40%; float : right;">
				<p class="indent" align="center">
					<span style="font-size:2em;  color: black; font-weight: bolder !important; "> 최근 가입멤버 </span>
				</p>
				<!-- adminMain contents -->
				<table class="table"> 
					<tr  style= "background-color: rgba(242, 242, 242, 0.6); "> 
						<th class="th">번호</th>
						<th class="th">멤버이름</th>
						<th class="th">가입날짜</th>
					</tr>
					<%
						for(Member m : list2) {
					%>
					<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
						<td><%=m.getMemberNo()%></td>
						<td><%=m.getMemberName()%></td>
						<td><%=m.getCreatedate()%></td>
					<%
						}				
					%>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>
