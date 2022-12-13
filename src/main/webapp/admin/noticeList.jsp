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
	
	// 페이지 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
	
	// Model 호출 공지사항 NoticeDao noticeDao = new NoticeDao(); // NoticeDao 메서드를 이용해 noticeDao 새로 만듬
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, rowPerPage);
	// noticeDao클래스의 selectNoticeListByPage로 (beginRow, rowPerPage)보내 결과값 ArrayList<Notice> list을 받아옴
	
	int cnt = noticeDao.count(); 
	// cnt 값을 noticeDao.count() 클래스에로 보내고 결과값으로 cnt값을 받음.
	
	//마지막 페이지 
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>noticeManin</title>
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<linkhref="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<scriptsrc="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

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
	
	table{
    
    height: 200px;
    table-layout: fixed;
	 }  
	 
	th {
	padding: 10px;
	width: 90px;
    height:15px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap; 
	color : black;
	th-layout: fixed;
	text-align : center;
	}
	
	th {
	padding: 10px;
	width: 90px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap;
	color : black;
	th2-layout: fixed;
	text-align : center;
	}
	
	td {
	width: 75px;
	padding: 10px;
	border: 1px solid #666666;
	td-layout: fixed;
	overflow:hidden;
	white-space : nowrap;
	color : black;
	text-overflow: ellipsis;
	text-align : center;
	}
	
	<%-- .background{
	   background-image: url(<%=request.getContextPath()%>/Resources/images/mainm.jpg);
	   background-repeat: no-repeat;
	   background-position: right;
	   background-attachment: fixed;
	   background-size: cover; 
	}  --%>
    
    div.indent{ padding-left: 10em }
    p.indent{ padding-right: 13em }
    
	</style>
	</head>
	<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	    
	<!-- 공지사항관리 리스트 -->
	<h1>공지사항 목록(관리자페이지)</h1>
	<div><a href="<%=request.getContextPath()%>/admin/insertNoticeForm.jsp">공지사항 추가</a></div>
	<div>
		<table class="table1" style= "background-color: rgba(242, 242, 242, 0.3);">
			<tr>
				<th>번호</th>
				<th>공지내용</th>
				<th>생성날짜</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%
				for(Notice n : list){
			%>
			<tr>
				<td><%=n.getNoticeNo() %></td>
				<td><%=n.getNoticeMemo() %></td>
				<td><%=n.getCreatedate()%></td>
				<td><a style= "text-decoration: none;" href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>&noticeMemo=<%=n.getNoticeMemo()%>">수정</a></td>
				<td><a style= "text-decoration: none;" href="<%=request.getContextPath()%>/admin/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a></td>
			<%
				}				
			%>
			</tr>
		</table>
		
		<!-- 페이징 -->
		
		<!-- 첫 페이지 -->
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
		
		<!-- 이전 페이지 -->
		<%
			if(currentPage>1){
		%>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<!-- 현재 페이지 -->
		<%=currentPage%>
		
		<!-- 다음 페이지 -->
		<%
			if(currentPage<lastPage){
		%>	
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>	
		<!-- 마지막 페이지 -->
		<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a> 
	</body>
</html>