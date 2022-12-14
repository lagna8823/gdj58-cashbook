<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo);
	
	Help updateHelp = new Help(); // 모델 호출시 매개값(vo.Help 클래스를 이용하여 updateHelp 새로 선언)
	updateHelp.setHelpNo(helpNo);
	
	// 분리된M(모델)을 호출
	HelpDao helpDao = new HelpDao();  // HelpDao 메서드를 이용해 selectHelpNo 새로 선언.
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpNo(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateHelpForm</title>
	</head>
	<body>
	<h1>문의수정</h1>
	<form id="signinForm" action="<%=request.getContextPath()%>/updateHelpAction.jsp">
		<input type="hidden" name="helpNo" value="<%=helpNo%>">
		<div>
		<table border="1">
			<tr>
				<th>번호</th>
				<th>문의날짜</th>
				<th>문의내용</th>
			</tr>
			<tr>
				<%
					for(HashMap<String, Object> h :  list){
				%>
				<td><%=h.get("helpNo")%></td>
				<td><%=h.get("createdate")%></td>
				<td><textarea id="helpMemo" rows="8" cols="80" name="helpMemo"><%=h.get("helpMemo")%></textarea></td>
				<%
					}
				%>
			</tr>
		</table>
		<a href="<%=request.getContextPath()%>/helpList.jsp">돌아가기</a>
		<button tpye="button" id="signinBtn">수정하기</button>
		</div>
	</form>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			//공지사항 폼 유효성 검사
			let helpMemo = document.querySelector('#helpMemo');
			if(helpMemo.value == ''){
				alert('문의내용을 확인하세요.');
				helpMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/insertCashAction.jsp
		});
	</script>
	</body>
</html>