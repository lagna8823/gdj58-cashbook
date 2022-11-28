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
	
	// 입력값 체크
		if(request.getParameter("noticeNo") == null){
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
			return;
		}
	
	// 데이터 받아와 값세팅
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// Model 호출 공지사항 
	NoticeDao noticeDao = new NoticeDao(); // NoticeDao 메서드를 이용해 noticeDao 새로 만듬
	ArrayList<Notice> list = noticeDao.selectNoticeListByMemo(noticeNo);
	// noticeDao클래스의 selectNoticeListByPage로 (beginRow, rowPerPage)보내 결과값 ArrayList<Notice> list을 받아옴
	
	// View
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateNoticeForm</title>
</head>
<body>
	<div>
		<!-- notice 입력폼 작성 -->
		<h1>공지 수정 페이지</h1>
		<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
		<form action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border="1"> 
			<tr>
				<th>공지번호</th>
				<th>공지내용</th>
				<th>생성날짜</th>
			</tr>
			<tr>
				<%
					for(Notice n : list){
				%>
					<td><input type="number" name="noticeNo" value="<%=n.getNoticeNo()%>" readonly="readonly"></td>
					<td><textarea rows="3" cols="50" name="noticeMemo" value="<%=n.getNoticeMemo()%>"></textarea></td>
					<td><input type="text" name="createdate" value="<%=n.getCreatedate()%>" readonly="readonly"></td>
				<%
					}
				%>
			</tr>
		</table> 
		<button type="submit">수정하기</button>
		</form>
	</div>
</body>
</html>
