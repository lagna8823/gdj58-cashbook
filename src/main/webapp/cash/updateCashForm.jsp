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
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list 
		= cashDao.selectCashListByDay(loginMember.getMemberId(), year, month, date);
	
	// Model 호출 : 카테고리 목록
		CategoryDao categoryDao = new CategoryDao();
		ArrayList<Category> categoryList = categoryDao.selectCategoryList();
		
	// view
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCashForm</title>
	</head>
	<body>
	<div>
	<jsp:include page="/inc/menu.jsp"></jsp:include>
    </div>
		<!-- cash 수정 폼 -->
		<div align="center"><h1>내역 수정하기</h1></div>
			<div><a href="<%=request.getContextPath()%>/cashDateList.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>"> 돌아가기 </a></div>
			<!-- cash 입력 폼 -->
			<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<input type="hidden" name="cashNo" value="<%=cashNo%>">
				<input type="hidden" name="year" value="<%=year%>">
				<input type="hidden" name="month" value="<%=month%>">
				<input type="hidden" name="date" value="<%=date%>">
				<table border="1">
					<tr>
						<td>날짜</td>
						<td>
							<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
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
										<%=c.getCategoryKind()%>, <%=c.getCategoryName()%>
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
							<input tpye="number" name="cashPrice" value="">
						</td>
					</tr>
					<tr>
						<td>메모</td>
						<td>
							<textarea rows="3" cols="50" name="cashMemo" value=""></textarea>
						</td>
					</tr>
				</table>
				<button type="submit">입력</button>
			</form>
	</body>
</html>

