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
	// 변수선언
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	
	// Model 호출 : 일별 cash 목록
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list 
		= cashDao.selectCashListByDay(loginMember.getMemberId(), year, month, date);
	
	// view
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- cash 입력 폼 -->
	<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
		<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
		<table border="1">
			<tr>
				<td>categoryNo</td>
				<td>
					<select name = "categoryNo">
						<%
							for(Category c : categoryList) {
						%>
								<option value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>cashDate</td>
				<td>
					<input type="text" name="cashDate" 
						value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td>cashMemo</td>
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
			<th>categoryKind</th>
			<th>categoryName</th>
			<th>cashPrice</th>
			<th>cashMemo</th>
			<th>수정</th><!-- /cash/deleteCash.jsp?cashNo= -->
			<th>삭제</th><!-- /cash/updateCashForm.jsp?cashNo= -->
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%></td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td><a href="<%=request.getContextPath()%>/cash/UpdateCashForm.jsp">수정</a></td>
					<td><a href="<%=request.getContextPath()%>/cash/DeleteCashForm.jsp">삭제</a></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>

