<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	// Controller : seesion, request
	// session에 저장된 멤버(현재 로그인 사용자)
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	Member loginMember = (Member)session.getAttribute("loginMember");
	
	// request 년 + 월
	int year = 0;
	int month = 0;

	if((request.getParameter("year") == null) || request.getParameter("month") == null) {
	   Calendar today = Calendar.getInstance(); // 오늘날짜
	   year = today.get(Calendar.YEAR);
	   month = today.get(Calendar.MONTH);
	} else {
	   year = Integer.parseInt(request.getParameter("year"));
	   month = Integer.parseInt(request.getParameter("month"));
	   // month -> -1, month -> 12 일경우
	   if(month == -1) {
	      month = 11;
	      year -= 1;
	   }
	   if(month == 12) {
	      month = 0;
	      year += 1;
	   }
	}
	
	// 출력하고자 하는 년,월과 월의 1일의 요일(일 1, 월 2, 화 3, ... 토 7)
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	// firstDay는 1일의 요일
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 요일(일 1, 월 2, 화 3, ... 토 7)
	// begin blank개수는 firstDay - 1
	
	// 마지막날짜
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 
	
	// 달력 출력테이블의 시작 공백셀(td)과 마지막 공백셀(td)의 개수
	int beginBlank = firstDay - 1;
	int endBlank = 0; // beginBlank + lastDate + endBlank --> 7로 나누어 떨어진다 --> totalTd
	if((beginBlank + lastDate) % 7 != 0) {
	   endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	
	// 전체 td의 개수 : 7로 나누어 떨어져야 한다
	int totalTd = beginBlank + lastDate + endBlank;
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao(); // CashDao 메서드를 이용하여 cashDao를 새로 선언.
	ArrayList<HashMap<String, Object>> list  = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1);
	/*
	arrayList 형태로 저장되있는 cashDao.select~~Month 메서드로 (loginMeber.getMeberId(),year,month+1)을 보내고,
	결과값 arrayList<해쉬맵> 형태로 list값에 세팅.
	*/
	
	// View : 달력출력 + 일별 cash 목록 출력
%>
	<!DOCTYPE html>
	
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>cashList</title>
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--스타일 -->
	<style>
	
	.table {
    width: 300px;
    height: 400px;
    table-layout: fixed;
    algin: left;
	 }   
	 
	.th {
	padding: 10px;
	width: 90px;
    height:15px;
	border: 1px solid #666666;
	white-space: nowrap;
	color : black;
	th-layout: fixed;
	text-align : center;
	
	}
	
	td {
	width: 75px;
    height:150px;
	padding: 10px;
	border: 1px solid #666666;
	td-layout: fixed;
	overflow:hidden;
	white-space : nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
	}
	
	
	font {
	   font-size : 20pt;
	   line-height : 30px;
	   text-algin: center;
	   color : black;
	}
	.background{
	   background-image: url(<%=request.getContextPath()%>/Resources/images/mainm.jpg);
	   background-repeat: no-repeat;
	   background-position: right;
	   background-attachment: fixed;
	   background-size: cover; 
	} 
	
	.word {
        margin:0.2px;
        /* outline: 1px solid black; */
        display: block;
        color: black;
        width: 150px;
        font-size: 15px;
        font-weight: bolder !important;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: normal;
        line-height: 1.2;
        height: 8.4em;
        text-align: left;
        word-wrap: break-word;
        display: -webkit-box;
		-webkit-line-clamp:  7;
        -webkit-box-orient: vertical;
    }
    .a{
    text-decoration: none; width:70%; height: 100px; border: 1px solid rgba(242, 242, 242, 0.2); border-radius: 2em; background-color: rgba(242, 242, 242, 0.8); color:black;}
    .a:hover{
    color:#fff;
    background-color:#27E1CE;
    text-decoration: none;
    font-size: 16px;
    font-weight: bolder !important;
    }
    
    .b:hover{
    font-weight: bolder !important;
    }
    
    .c{
    text-decoration: none; width:70%; height: 100px; border: 1px solid rgba(242, 242, 242, 0.2); border-radius: 2em; background-color: rgba(242, 242, 242, 0.4); color:black;}
    .c:hover{
    color:#fff;
    background-color:#27E1CE;
    text-decoration: none;
    font-size: 16px;
    font-weight: bolder !important;
    }
	</style>
    </head>
	<body class="background">
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
	    <!-- 회원폼  -->
	    <div>
	    <nav role="navigation" align="right">
				<a class="a" href="<%=request.getContextPath()%>/logout.jsp">Logout</a>
				<a class="a" href="<%=request.getContextPath()%>/updateMemberForm.jsp">Information</a>
				<a class="a" href="<%=request.getContextPath()%>/updateMemberPwForm.jsp">Edit password</a>
				<a class="a" href="<%=request.getContextPath()%>/deleteMemberForm.jsp">Withdrawal</a>
			</nav>
		</div>	
		
		<!-- 로그인 정보(세션 loginMember 변수) 출력 -->
		<div style="background-color: rgba(242, 242, 242, 0.5);" align="center">
	   	 <span style = "font-size: 2em; font-weight: bolder !important; color: black; align:center;" ><%=loginMember.getMemberName()%>님의 달력</span> 
		</div>
		<br>
		<!-- 달력 상단 -->
		<div align="center">
			<a class="c" style= " text-decoration: none; font-weight: bolder !important; color:black;"href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">&#8701;이전달&nbsp;&nbsp;</a>
			<span style= " text-decoration: none; font-size:1.2em; font-weight: bolder !important; color:black;"><%=year%></span><span style= "color:black;">년</span>
			<span style= " text-decoration: none; font-size:1.2em; font-weight: bolder !important; color:black;"><%=month+1%></span></span><span style= "color:black;">월</span>
			<a class="c" style= "font-weight: bolder !important; color:black;" href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>">&nbsp;&nbsp;다음달&#8702;</a>
		</div>
		
		<div class="container" algin="center">
	      <!-- 달력 --> 
	      <table class="table"> <!--border="1" width="90%"  -->
	         <tr style= "background-color: rgba(242, 242, 242, 0.3);">
	            <th  class="th" style="color:red;">Sun</th>
	            <th  class="th" style="color:black;">Mon</th>
	            <th  class="th" style="color:black;">Tue</th>
	            <th  class="th" style="color:black;">Wen</th>
	            <th  class="th" style="color:black;">Thr</th>
	            <th  class="th" style="color:black;">Fri</th>
	            <th  class="th" style="color:blue;">Sat</th>
	         </tr>
	         <tr>
	            <%
	               for(int i=1; i<=totalTd; i++) {
	            %>
	                  <td>
	            	<%
	                     int date = i-beginBlank;
	                     if(date > 0 && date <= lastDate) {
	           		%>
	                        <div>
						<%
                       		   if(i%7 == 0){
						%>
									<a href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
										<span class="text-primary b"><%=date%></span> </a>
   						<%
	   							} else if(i%7 == 1){
						%>
									<a href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
										<span class="text-danger b"><%=date%></span> </a>
						<%
   								} else {
 						%>
 								<a href="<%=request.getContextPath()%>/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
										<span class="text-warning b"><%=date%></span> </a>
  						<%
   							}
           				%>
         					</div>
	                        <div class="word">
	                           <% /* 위 세팅된 arrayList<해쉬맵> list를 CashDao 클래스에서 HashMap<String,Object> m으로 생성했기에, for each문이 다음과 같이 쓰임. 
	                           		ex)  for(HashMap<String, Object> m : list) {
	                           				String cashDate = (String)(m.get("cashDate")); 
	                           		}        (ps. m.get 앞에 String은 형변환을 해줌.)  */
	                              for(HashMap<String, Object> m : list) {
	                                 String cashDate = (String)(m.get("cashDate"));
	                                 if(Integer.parseInt(cashDate.substring(8)) == date) {
	                           %>
	                                    <%
	                                    	if(m.get("categoryKind").equals("수입")){
	                                    %>
	                                    	💸
	                                    <%		
	                                    	} else {
	                                    %>
	                                    	&#128204;
	                                    <%
	                                    	}
	                                    %>
	                                    <%=(String)(m.get("categoryName"))%>
	                                    &nbsp;
	                                    <%=(Long)(m.get("cashPrice"))%>원
	                                    <br>
	                           <%
	                                 }
	                              }
	                           %>
	                        </div>
	            <%            
	                     }
	            %>
               		</td>
	            <%
	                  
	                  if(i%7 == 0 && i != totalTd) {
	            %>
	                     </tr><tr> <!-- td7개 만들고 테이블 줄바꿈 -->
	            <%         
	                  }
	               }
	            %>
	         </tr>
	      </table>
		</div>
		<div id="fh5co-header" role="banner" class="container">
			<nav role="navigation">
				<ul>
					<li class="cta"><a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month%>">TopPage</a></li>
				</ul>
			</nav>
		</div>
	</body>
</html>