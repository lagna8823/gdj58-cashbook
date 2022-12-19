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
	
	.img{
	width: 1730px;
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
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 200px;
	}
	.react5 {
	width: 1000px;
	height: 1000px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 900px;
	}
	
	table{
    table-layout: fixed;
    text-align : center;
	 }  
	
	.th {
	padding: 10px;
	width: 90px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap;
	color : black;
	text-align : center;
	}
	
	td {
	width: 75px;
	padding: 10px;
	border: 1px solid #666666;
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
		<br>
		<div class="react3">
		<!-- 상단 제목 및 이전 페이지-->
		 	<p class="indent">
				<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 가계부 통계 </span>
			</p>
		</div>
		
		<div class="react4">
		<!-- 년도별 통계 -->
		<div class="container" align="center" style = "color: black; padding-right:5em; font-weight: bolder !important;">
			<연도별 통계내역>
		</div>
			<table>
				<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
					<th class="th">년</th>
					<th class="th">수입일수</th>
					<th class="th">수입합계</th>
					<th class="th">수입평균</th>
					<th class="th">지출일수</th>
					<th class="th">지출합계</th>
					<th class="th">지출평균</th>
				</tr>
				<%
					for(HashMap<String, Object> m : yearList) {
				%>
				<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
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
			
		<div class="react5">
		<!-- 월별 통계-->
		<div  align="center" style = "color: black; padding-left:6em; font-weight: bolder !important;" ><<%=year%>년 &nbsp; 월별통계></div>
			<table>
				<tr style= "background-color: rgba(242, 242, 242, 0.6);" > 
					<th class="th">월</th>
					<th class="th">수입일수</th>
					<th class="th">수입합계</th>
					<th class="th">수입평균</th>
					<th class="th">지출일수</th>
					<th class="th">지출합계</th>
					<th class="th">지출평균</th>
				</tr>
				<%
					for(HashMap<String, Object> m : monthList) {
				%>
				<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
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