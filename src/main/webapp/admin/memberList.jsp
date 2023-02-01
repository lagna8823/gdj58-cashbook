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
	MemberDao memberDao = new MemberDao();
	ArrayList<Member> list = memberDao.selectMemberListByPage(beginRow, rowPerPage);
	
	int cnt = memberDao.count(); 
	// cnt 값을 memberDao.count() 클래스에로 보내고 결과값으로 cnt값을 받음.
	
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
	position: absolute;
	}
	
	.react4 {
	width: 1000px;
	height: 1000px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 550px;
	}
	
	
	table{
	border: 1px solid #666666;
    height: 200px;
    table-layout: fixed;
	 }  
	 
	.th {
	padding: 10px;
	width: 90px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap;
	color : black;
	th2-layout: fixed;
	text-align : center;
	font-family: gulim;
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
	font-family: gulim;
	}
	p.indent{ 
	padding-left: 52em;
	}
	div.indent{ 
	padding-right: 15em;
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
			<div class="react3">
			<!-- 상단 제목 및 이전 페이지-->
				<br><br>
			 	<p class="indent">
					<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 멤버 목록 </span>
				</p>
			</div>
			<div class="react4">
			<!-- memberList contents... -->
			<div>
			<table>
				<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
					<th class="th">멤버번호</th>
					<th class="th">아이디</th>
					<th class="th">레벨</th>
					<th class="th">이름</th>
					<th class="th">마지막수정일자</th>
					<th class="th">생성일자</th>
					<th class="th">레벨수정</th>
					<th class="th">멤버강퇴</th>
				</tr>
				<%
					for(Member m : list) {
				%>
				<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
					<td><%=m.getMemberNo()%></td>
					<td><%=m.getMemberId()%></td>
					<td><%=m.getMemberLevel()%></td>
					<td><%=m.getMemberName()%></td>
					<td><%=m.getUpdatedate()%></td>
					<td><%=m.getCreatedate()%></td>
					<td><a href="<%=request.getContextPath()%>/admin/updateMemberLvForm.jsp?memberNo=<%=m.getMemberNo()%>">레벨수정</a></td>
					<td><a href="<%=request.getContextPath()%>/admin/deleteMemberLvAction.jsp?memberNo=<%=m.getMemberNo()%>">멤버강퇴</a></td>
				</tr>
				<%
					}
				%>
			</table>
			</div>
			<br>
			<div class="indent" align="center";>
			<!-- 페이징 -->
			<!-- 첫 페이지 -->
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1">처음</a>
			
			<!-- 이전 페이지 -->
			<%
				if(currentPage>1){
			%>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<%
				}
			%>
			
			<!-- 현재 페이지 -->
			<%=currentPage%>
			
			<!-- 다음 페이지 -->
			<%
				if(currentPage<lastPage){
			%>	
				<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<%
				}
			%>	
			<!-- 마지막 페이지 -->
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>">마지막</a> 
			</div>
			</div>
		</div>		
	</body>
</html>
