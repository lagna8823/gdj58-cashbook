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
  	top: 160px;
	left: 80px;
	}
	
	.react4 {
	box-sizing: border-box;
	position: absolute;
	top: 50px;
  	left: 1100px;
	} 
	
	.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    padding-right: 25px;
    line-height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
    box-sizing: border-box;
    z-index: 10;
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
	
    div.indent{ padding-right: 11em }
    p.indent{ padding-right: 13em }
    
    .btn_type {
    display: block;
    width: 100%;
    padding: 15px 0 15px;
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    cursor: pointer;
    }
    
   .btn_primary {
    color: #fff;
    border: solid 1px rgba(0,0,0,.08);
    background-color: #27E1CE;
    }
	
	.a:hover {
	color: #fff;
	background-color: #27E1CE;
	text-decoration: none;
	font-weight: bolder !important;
	}  
    
	</style>
		
	</head>
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<header>
			<div>
				<jsp:include page="/inc/menu.jsp"></jsp:include>
		    </div>
	    </header>
	    
	    <article>
		    <div class="react1">
		    
			    <!--배경이미지 -->
		 	    <div class="react2">
		    		<img class="img" src="<%=request.getContextPath()%>/Resources/images/mainm.jpg">
		    	</div>
				
		 	 	
				<div  class="react3">
				<!-- cash(가계부) 상단 제목 및 이전 페이지-->
		 	 	<p class="indent" align="center">
					<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 📖가계부 상세내역 </span>
				</p>
				<div class="indent" align="right">
					<a class="a" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>&date=<%=date%>" 
						style="color: black; font-size:1em; font-weight: bolder !important; text-decoration: none;">&#11013;&#11013;돌아가기🗓️</a>
				</div>
				<!-- cash(가계부) 목록 출력 -->
					<div class="container">
					<table class="table2">
						<tr style= "background-color: rgba(242, 242, 242, 0.6);"> 
							<th class="th2" style="width:10%;">구분</th>
							<th class="th2" style="width:10%;">항목</th>
							<th class="th2" style="width:20%;">금액</th>
							<th class="th2" style="width:40%;">메모</th>
							<th class="th2" style="width:10%;"><span style="color:blue;">수정</span></th><!-- /cash/deleteCash.jsp?cashNo= -->
							<th class="th2" style="width:10%;"><span style="color:red;">삭제</span></th><!-- /cash/updateCashForm.jsp?cashNo= -->
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
			                             	<span class="text-primary">&#10004;&nbsp;<%=(String)m.get("categoryKind")%></span>
			                             <%		
			                             	} else {
			                             %>
			                             	<span class="text-danger">&#10004;&nbsp;<%=(String)m.get("categoryKind")%></span>
			                             	
			                             <%
			                             	}
			                             %>
									</td>
									<td class="td2"><%=(String)m.get("categoryName")%></td>
									<td class="td2"><span style ="font-family: gulim;"><%=(Long)m.get("cashPrice")%></span></td>
									<td class="td2"><span style ="font-family: gulim;"><%=(String)m.get("cashMemo")%></span></td>
									<td class="td2"><a style= "text-decoration: none;" href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>">&#9997;</th></a></td>
									<td class="td2"><a style= "text-decoration: none;" href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=cashNo%>&year=<%=year%>&month=<%=month%>&date=<%=date%>"> &#10060;</a></td>
								</tr>
						<%		
								}
							}
									
						%>
					</table>
					</div>
					<div  class="react4">
				<!-- cash(가계부) 입력 폼 -->
				<form id="signinForm" action="<%=request.getContextPath()%>/cash/insertCashAction.jsp">
					<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
					<input type="hidden" name="year" value="<%=year%>">
					<input type="hidden" name="month" value="<%=month%>">
					<input type="hidden" name="date" value="<%=date%>">
					
					<!-- 가계부입력 부제목 -->
					<table class="table1" style= "background-color: rgba(242, 242, 242, 0.3);">
						<tr>
							<td colspan="2" style="text-align: center;">
								<span style="font-size:1.4em;  color: black; font-weight: bolder !important;"><가계부 입력></span>
							</td>
						</tr>
						<tr>
							<td>&nbsp;
							</td>
						</tr>
						<tr>
							<th class="th1">&#10004;&nbsp;날짜</th>
							<td>
								<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
							</td>
						</tr>
						<tr>
							<th class="th1">&#10004;&nbsp;항목</th>
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
							<th class="th1">&#10004;&nbsp;금액</th>
							<td>
								<span style ="font-family: gulim;"><input tpye="number" id="cashPrice" name="cashPrice"></span>
							</td>
						</tr>
						<tr>
							<th class="th1">&#10004;&nbsp;내역</th>
							<td>
								<textarea id="cashMemo" rows="3" cols="40" name="cashMemo"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" id="signinBtn" class="btn_type btn_primary">추가하기</button> 
							</td>
						</tr>
						<tr>
							<td>
								<!-- msg 파라메타값이 있으면 출력 -->
								<%
									if(request.getParameter("msg") != null){
								%>
									<div><%=request.getParameter("msg") %></div>
								<%
									}
								%>
							</td>
						</tr>
					</table>
					</div>
				</form>
				</div>
				</div>
			</div>
		</article>
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

