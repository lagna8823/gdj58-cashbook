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
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	Member updateMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 updateMember를 새로 선언)
	updateMember.setMemberNo(memberNo);
	
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<HashMap<String, Object>> updateMemberList  = memberDao.selectMemberListByLv(updateMember);
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberLvForm</title>
	</head>
	<body>
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
		<!-- memberList contents... -->
		<h1>멤버목록</h1>
		<form action="updateMemberLvAction.jsp" method="post">
		<div>
		<table border="1">
			<input type="hidden" name="memberNo" value="<%=memberNo%>">
			<tr>
				<th>아이디</th>
				<th>레벨수정</th>
			</tr>
			<%
		 		for(HashMap<String, Object> m : updateMemberList) {
					String memberId = (String)(m.get("memberId"));
					String memberName = (String)(m.get("memberName"));
			%>
			<tr>
				<td><input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"></td>
			<%
				}
			%>
				<td>
					<select name="memberLevel">
						<option  value="0">0</option>
						<option  value="1">1</option>			
					</select>
			</tr>
		</table>
		</div>
		<button type="submit">수정하기</button>
		</form>
	</body>
</html>
