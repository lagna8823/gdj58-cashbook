<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	// Controller : seesion, request
	// session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	String memberId = loginMember.getMemberId();
	int year = 0;
	if(request.getParameter("year") == null) {
		Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
	}
	
	// 년도별 통계
	CashDao yearCashDao = new CashDao();
	ArrayList<HashMap<String, Object>> yearList = yearCashDao.performanceYear(memberId, year);
	
	// 월별 통계
	CashDao monthCashDao = new CashDao();
	ArrayList<HashMap<String, Object>> monthList = monthCashDao.performanceMonth(memberId, year);
	
	// 페이징 사용할 최소년도와 최대년도
	CashDao CashDao = new CashDao();
	HashMap<String, Object> map = CashDao.selectMaxMinYear();
	
	// 최소년도와 최대년도 값 받아오기
	int minYear = (Integer)(map.get("minYear"));
	int maxYear = (Integer)(map.get("maxYear"));
		
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
	
	.body {
	background-color: #FAFAFA;
    background-repeat: no-repeat;
    background-position: right;
    background-attachment: fixed;
    background-size: cover; 
    position: absolute;
	}
	
	.react1 {
	box-sizing: border-box;
	}
	.react2 {
	width: 1000px;
	height: 1000px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 200px;
	}
	.react3 {
	width: 1000px;
	height: 1000px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 200px;
	left: 900px;
	}
	
	table{
    
    height: 200px;
    table-layout: fixed;
    border: 1px solid #666666;
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
	}
	
}
	</style>
	</head>
	<body>
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
	</div>
	
	<div class="react1">
	<br>
	<!-- 상단 제목 및 이전 페이지-->
 	<p class="indent" align="center">
		<span style="font-size:2em;  color: black; font-weight: bolder !important; padding-left: 11em"> 가계부 통계 </span>
	</p>
		<div class="react2">
		<!-- 년도별 통계 -->
		<div align="center" style = "color: black;">연도별통계</div>
			<table>
				<tr>
					<th>년</th>
					<th>수입일수</th>
					<th>수입합계</th>
					<th>수입평균</th>
					<th>지출일수</th>
					<th>지출합계</th>
					<th>지출평균</th>
				</tr>
				<%
					for(HashMap<String, Object> m : yearList) {
				%>
				<tr>
					<td><%=m.get("year")%></td>
					<td><%=m.get("importCnt")%></td>
					<td><%=m.get("importSum")%></td>
					<td><%=m.get("importAvg")%></td>
					<td><%=m.get("exportCnt")%></td>
					<td><%=m.get("exportSum")%></td>
					<td><%=m.get("exportAvg")%></td>
				<%
					}				
				%>
				</tr>
			</table>
		</div>
		
		<div class="react3">
		<!-- 월별 통계-->
		<p class="indent" align="center" style = "color: black;">월별통계</p>
		<p stlye color="black"><<%=year%>년></p>
			<table>
				<tr>
					<th>월</th>
					<th>수입일수</th>
					<th>수입합계</th>
					<th>수입평균</th>
					<th>지출일수</th>
					<th>지출합계</th>
					<th>지출평균</th>
				</tr>
				<%
					for(HashMap<String, Object> m : monthList) {
				%>
				<tr>
					<td><%=m.get("month")%></td>
					<td><%=m.get("importCnt")%></td>
					<td><%=m.get("importSum")%></td>
					<td><%=m.get("importAvg")%></td>
					<td><%=m.get("exportCnt")%></td>
					<td><%=m.get("exportSum")%></td>
					<td><%=m.get("exportAvg")%></td>
				<%
					}				
				%>
				</tr>
			</table>
		
		<!-- 페이징 -->
		<%
			if(year >minYear){
		%>
			<a href="<%=request.getContextPath()%>/cash/performance.jsp?year=<%=year-1%>">이전년도</a>  
		<%		
			}
		%>
		<%
			if(year <maxYear){
		%>
			<a href="<%=request.getContextPath()%>/cash/performance.jsp?year=<%=year+1%>">다음년도</a>
		<%		
			}
		%>
		</div>
	</div>
	</body>
</html>