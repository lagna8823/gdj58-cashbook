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
	// 값세팅
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	
	// Model 호출 : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	/*
	arrayList 형태로 저장되있는categoryDao.selectCategoryList(); 메서드로 ()을 보내고,
	결과값 arrayList 형태로 categoryList값에 세팅.
	*/
	
	// Model 호출 : 카테고리 목록
	CashDao cashDaoList = new CashDao();
	ArrayList<Cash> cashList = cashDaoList.selectCashList();
		
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list 
		= cashDao.selectCashListByDay(loginMember.getMemberId(), year, month, date);
	/*
	arrayList 형태로 저장되있는 cashDao.select~~ByDay 메서드로 (loginMember.getMemberId(), year, month, date)을 보내고,
	결과값 arrayList<해쉬맵> 형태로 list값에 세팅.
	*/

	
	// view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
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
						<select name = "categoryNo">
							<%
								for(Category c : categoryList) {
							%>
									<option  value="<%=c.getCategoryNo()%>">
									<%=c.getCategoryKind()%> <%=c.getCategoryName()%>
									</option>
									
							<%
								}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>금액</td>
					<td>
						<select name = "categoryPrice">
							<% 
								for(Cash c : cashList) {
							%>
									<option value="<%=c.getCashPrice()%>">
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
			<%
				for(HashMap<String, Object> m : list) {
			%>
					<tr>
						<td><%=(String)m.get("categoryKind")%></td>
						<td><%=(String)m.get("categoryName")%></td>
						<td><%=(Long)m.get("cashPrice")%></td>
						<td><%=(String)m.get("cashMemo")%></td>
						<td><a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp">수정</a></td>
						<td><a href="<%=request.getContextPath()%>/cash/deleteCashForm.jsp">삭제</a></td>
					</tr>
			<%		
				}
			%>
		</table>
	</body>
</html>

