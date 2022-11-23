<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// 1. Controller 
	
	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}

	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list 
		= cashDao.selectCashListByDay(loginMember.getMemberId(), year, month, date);
	
	// view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border="1">
			<tr>
				<td>날짜</td>
				<td>
					<input type="text" name="cashDate" 
						value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>항목</td>
				<td>
					<select name = "categoryKind">
						<%
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryKind()%>"></option>
									
								
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>금액</td>
				<td>
					<select name = "categoryNo">
						<%
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryNo()%>">
								</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>메모</td>
				<td>
					<textarea rows="3" cols="50" name="cashMemo"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
	<!-- cash 목록 출력 -->
	<table border="1">
		<tr>
			<th>구분</th>
			<th>항목</th>
			<th>금액</th>
			<th>메모</th>
			<th>수정</th><!-- /cash/deleteCash.jsp?cashNo= -->
			<th>삭제</th><!-- /cash/updateCashForm.jsp?cashNo= -->
		</tr>
		<tr>
		<%
			for(HashMap<String, Object> m : list) {
					(String)m.get("categoryKind");
					(String)m.get("categoryName");
					(Long)m.get("cashPrice");
					(String)m.get("cashMemo");
			
			}
		%>
		</tr>
	</table>
</body>
</html>

