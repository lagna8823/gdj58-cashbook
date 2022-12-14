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
	String memberId = loginMember.getMemberId();
	
	// Model 호출 : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	/*
	arrayList 형태로 저장되있는categoryDao.selectCategoryList(); 메서드로 ()을 보내고,
	결과값 arrayList 형태로 categoryList값에 세팅.
	*/
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao(); 
	ArrayList<HashMap<String, Object>> list 
		= cashDao.selectCashListByDay(memberId, year, month, date);
	/*
	arrayList 형태로 저장되있는 cashDao.select~~ByDay 메서드로 (memberId, year, month, date)을 보내고,
	결과값 arrayList<해쉬맵> 형태로 list값에 세팅.
	*/
	
	// view
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>cashDateList</title>
	
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
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
	.table1 {
    
    height: 200px;
    table-layout: fixed;
	 }  
	 .table2 {
    width: 1000px;
    table-layout: fixed;
	 }   
	 
	.th1 {
	padding: 10px;
	width: 90px;
    height:15px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap; 
	color : black;
	th-layout: fixed;
	text-align : center;
	}
	
	.th2 {
	padding: 10px;
	width: 90px;
	border: 1px solid #666666;
	font-weight: bolder !important;
	white-space: nowrap;
	color : black;
	th2-layout: fixed;
	text-align : center;
	}
	
	.td2 {
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
	
	.background{
	   background-image: url(<%=request.getContextPath()%>/Resources/images/mainm.jpg);
	   background-repeat: no-repeat;
	   background-position: right;
	   background-attachment: fixed;
	   background-size: cover; 
	} 
    
    div.indent{ padding-left: 10em }
    p.indent{ padding-right: 13em }
    
	</style>
		
	</head>
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
	    <br> 
	    
	    <!-- cash(가계부) 상단 제목 및 이전 페이지-->
    	<h1 style = "background-color: rgba(242, 242, 242, 0.5);"  align="center" >가계부 상세내역</h1>
    	<p class="indent" align="right">
			<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>&date=<%=date%>">돌아가기</a>
		</p>
		
		<!-- cash(가계부) 입력 폼 -->
		<form id="signinForm" action="<%=request.getContextPath()%>/cash/insertCashAction.jsp">
			<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			
			<!-- 가계부입력 부제목 -->
			<div style="width:25%; float : left;">
				<div class="indent">
					<span style="font-size:1.4em;  color: black; background-color:rgba(242, 242, 242, 0.6); font-weight: bolder !important;"> < 가계부 입력 > </span>
				</div>
			<br>
			<table class="table1" style= "background-color: rgba(242, 242, 242, 0.3);">
				<tr>
					<th class="th1">날짜</th>
					<td>
						<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th class="th1">항목</th>
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
					<th class="th1">금액</th>
					<td>
						<input tpye="number" id="cashPrice" name="cashPrice">
					</td>
				</tr>
				<tr>
					<th class="th1">내역</th>
					<td>
						<textarea id="cashMemo" rows="3" cols="40" name="cashMemo"></textarea>
					</td>
				</tr>
			</table>
			<button type="button" id="signinBtn">추가하기</button> 
			<!-- msg 파라메타값이 있으면 출력 -->
		<%
			if(request.getParameter("msg") != null){
		%>
			<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
			</div>
		</form>
		
		<!-- cash(가계부) 목록 출력 -->
		<div class="container" style="width:65%; float : right;">
		<table class="table2">
			<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
				<th class="th2" style="width:10%;">구분</th>
				<th class="th2" style="width:10%;">항목</th>
				<th class="th2" style="width:20%;">금액</th>
				<th class="th2" style="width:40%;">메모</th>
				<th class="th2" style="width:10%;">수정</th><!-- /cash/deleteCash.jsp?cashNo= -->
				<th class="th2" style="width:10%;">삭제</th><!-- /cash/updateCashForm.jsp?cashNo= -->
			</tr>
			<%
				for(HashMap<String, Object> m : list) {
					String cashDate = (String)(m.get("cashDate"));
					if(Integer.parseInt(cashDate.substring(8)) == date) {
						System.out.println(cashDate+"cashDate");
						int cashNo = (Integer)m.get("cashNo");
			%>
					<tr style= "background-color: rgba(242, 242, 242, 1); height:20px;">
						<td class="td2">
							<%
                             	if(m.get("categoryKind").equals("수입")){
                             %>
                             	<span class="text-primary"><%=(String)m.get("categoryKind")%></span>
                             <%		
                             	} else {
                             %>
                             	<span class="text-danger"><%=(String)m.get("categoryKind")%></span>
                             	
                             <%
                             	}
                             %>
						</td>
						<td class="td2"><%=(String)m.get("categoryName")%></td>
						<td class="td2"><%=(Long)m.get("cashPrice")%></td>
						<td class="td2"><%=(String)m.get("cashMemo")%></td>
						<td class="td2"><a style= "text-decoration: none;" href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">수정</a></td>
						<td class="td2"><a style= "text-decoration: none;" href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">삭제</a></td>
					</tr>
			<%		
					}
				}
						
			%>
		</table>
		</div>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			// 금액 유효성 검사.
			let cashPrice = document.querySelector('#cashPrice');
			if(cashPrice.value == '' || cashPrice.value == 0){
				alert('금액을 확인하세요.');
				cashPrice.focus();
				return;
			}
			
			// 내역 유효성 검사
			let cashMemo = document.querySelector('#cashMemo');
			if(cashMemo.value == '' || cashPrice.value == 0){
				alert('내역을 확인하세요.');
				cashMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/insertCashAction.jsp
		});
	</script>
	</body>
</html>

