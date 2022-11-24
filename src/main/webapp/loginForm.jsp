<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>
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
	//위에서 내려온 cnt 값을 noticeDao.count() 클래스에로 보내고 결과값으로 cnt값을 받음.
	
	//마지막 페이지 
	int lastPage = (int)(Math.ceil((double)cnt / (double)rowPerPage));
	
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
	</head>
	<body>
		<div align=center><h1>WELCOME</h1></div>
		<div align= right>
			<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
				<table>
					<tr>
						<th><span>아이디</span></th>
						<td><input type="text" name="memberId"></td>
					</tr>
					<tr>
						<th><span>비밀번호</span></th>
						<td><input type="password" name="memberPw"></td>
					</tr>
				</table>	
				<button type="submit">로그인</button>
			</form>
		</div>
		<div align= right>
			<a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
		</div>
		
		<!-- 공지 (5개) 목록 페이징 -->
		<h1>공지사항</h1>
		<div align= left>
			<table border="1">
				<tr>
					<th>공지내용</th>
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
		<div>
			<!-- 처음 -->
			
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
			
		 	<!-- 이전 -->
			<%
				if(currentPage >1){
			%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
			<% 
				}
			%>
			
			<!-- 현재 -->
			<%=currentPage%>
			
			<!-- 다음 -->
			<%
				if(currentPage < lastPage){
			%>
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
			<% 
				}
			%>
			<!-- 마지막 -->
			
				<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>
		</div>
	</body>
</html>