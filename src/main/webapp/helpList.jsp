<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp#login");
		return;
	}
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int beginRow = (currentPage-1) * rowPerPage;
	
	String memberId = loginMember.getMemberId();
	int helpNo= 0;
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpList(memberId,beginRow,rowPerPage);
	
	int cnt = helpDao.count();
	//CommentDao.count() 호출하여 결과값으로 cnt값을 받음.
	System.out.println(cnt);
	//마지막 페이지 
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>고객센터</title>
	
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
	left: 600px;
	}
	
	
	table{
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
	padding-left: 50em;
	}
	div.indent{ 
	padding-right: 30em;
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
					<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 고객센터 </span>
				</p>
			</div>
			<div>
				<a href="<%=request.getContextPath()%>/insertHelpForm.jsp">문의추가</a>
			</div>
			<div class="react4">
				<!-- helpList contents... -->
				<div>
				<table>
					<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
						<th class="th">문의내용</th>
						<th class="th">문의날짜</th>
						<th class="th">답변내용</th>
						<th class="th">답변날짜</th>
						<th class="th">수정</th>
						<th class="th">삭제</th>
					</tr>
					<%
						for(HashMap<String, Object> m : list) {
					%>
							<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
								<td><%=m.get("helpMemo")%></td>
								<td><%=m.get("helpCreatedate")%></td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											답변전
									<%		
										} else {
									%>
											<%=m.get("commentMemo")%>
									<%	
										}
									%>	
								</td>
								<td>
									<%
										if(m.get("commentCreatedate") == null) {
									%>
											답변전	
									<%		
										} else {
									%>
											<%=m.get("commentCreatedate")%>
									<%	
										}
									%>	
								</td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											<a href="<%=request.getContextPath()%>/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>">수정</a>	
									<%		
										} else {
									%>
											&nbsp;
									<%	
										}
									%>	
								</td>
								<td>
									<%
										if(m.get("commentMemo") == null) {
									%>
											<a href="<%=request.getContextPath()%>/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>">삭제</a>	
									<%		
										} else {
									%>
											&nbsp;
									<%	
										}
									%>
								</td>
							</tr>
					<%		
						}
					%>
				</table>
				</div>
				<br>
				<div align="center" class="indent">
				<!-- 페이징 -->
				
				<!-- 첫 페이지 -->
				<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=1">처음</a>
				
				<!-- 이전 페이지 -->
				<%
					if(currentPage>1){
				%>
				<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
				%>
				
				<!-- 현재 페이지 -->
				<%=currentPage%>
				
				<!-- 다음 페이지 -->
				<%
					if(currentPage<lastPage){
				%>
					<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>	
				<!-- 마지막 페이지 -->
				<a href="<%=request.getContextPath()%>/helpList.jsp?currentPage=<%=lastPage%>">마지막</a> 
				</div>
			</div>
		</div>
	</body>
</html>