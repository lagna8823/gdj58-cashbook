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
	
	// 페이지 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1)*rowPerPage;
		
	
	// Model 호출
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryListByAdmin(beginRow, rowPerPage);
	
	int cnt = categoryDao.count(); 
	// cnt 값을 categoryDao.count() 클래스에로 보내고 결과값으로 cnt값을 받음.
	
	//마지막 페이지 
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>categortList</title>
	
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<linkhref="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<scriptsrc="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

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
	box-sizing: border-box;
	position: absolute;;
	}
	
	.react4 {
	width: 1000px;
	height: 1000px;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 500px;
	}
	
	
	table{
   	text-align : center;
    table-layout: fixed;
	 }  
	 
	.th {
	padding: 10px;
	width: 90px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap;
	color : black;
	text-align : center;
	font-family: gulim;
	}
	
	td {
	padding: 10px;
	border: 1px solid #666666;
	td-layout: fixed;
	overflow:hidden;
	white-space : nowrap;
	color : black;
	text-overflow: ellipsis;
	text-align : center;
	font-family: gulim;
	}
	div.indent{ padding-left: 18em; }
	p.indent{ padding-left: 48em;}
}
	</style>
	</head>
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
		</div>
		
		<div class="react1">
			 <!--배경이미지 -->
	 	    <div class="react2">
	    		<img class="img" src="<%=request.getContextPath()%>/Resources/images/mainm.jpg">
	    	</div>
			<br>
			<div class="react3">
			<!-- 상단 제목 및 이전 페이지-->
				<br>
			 	<p class="indent">
					<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 카테고리 목록 </span>
				</p>
			</div>
			<br>
			<div class="react4">
			<!-- 카테고리 관리 리스트-->
				<div align="left";>
					<a href="<%=request.getContextPath()%>/admin/insertCategoryForm.jsp">카테고리 추가</a> 
				</div>
			<div>
			<table>
				<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
					<th class="th">번호</th>
					<th class="th">수입/지출</th>
					<th class="th">이름</th>
					<th class="th">생성날짜</th>
					<th class="th">마지막 수정날짜</th>
					<th class="th">수정</th>
					<th class="th">삭제</th>
				</tr>
				<!-- 모델데이터 categoryList 출력 -->
				<%
					for(Category c : categoryList){
						
				%>	
					<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
						<td><%=c.getCategoryNo()%></td>
						<td><%=c.getCategoryKind()%></td>
						<td><%=c.getCategoryName()%></td>
						<td><%=c.getCreatedate()%></td> 
						<td><%=c.getUpdatedate()%></td>
						<td><a href="<%=request.getContextPath()%>/admin/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/admin/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
					</tr>
				<%
					}
				%>
			</table>
			</div>
			<br>
			<div align="left"; class="indent"> 
			<!-- 페이징 -->
			
			<!-- 첫 페이지 -->
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=1">처음</a>
			
			<!-- 이전 페이지 -->
			<%
				if(currentPage>1){
			%>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			
			<!-- 현재 페이지 -->
			<%=currentPage%>
			
			<!-- 다음 페이지 -->
			<%
				if(currentPage<lastPage){
			%>
				<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>	
			<!-- 마지막 페이지 -->
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp?currentPage=<%=lastPage%>">마지막</a> 
			</div>
			</div>			
		</div>
	</body>
</html>
