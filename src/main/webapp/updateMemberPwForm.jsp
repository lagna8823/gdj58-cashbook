<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	//1. Controller 

	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember") == null) {
		// 로그인 되지 않은 상태
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	//System.out.print(request.getParameter("loginMember")); // 디버깅
	
	// Model 호출 : Member id값으로 멤버의정보를 가져옴.
	MemberDao memberDao = new MemberDao(); // CashDao 메서드를 이용하여 memberDao 새로 선언.
	ArrayList<HashMap<String, Object>> updateMemberList  = memberDao.selectMemberListById(loginMember.getMemberId());
	/*
	arrayList 형태로 저장되있는 MemberDao.select~~Month 메서드로 (loginMeber.getMeberId()를 보내고,
	결과값 arrayList<해쉬맵> 형태로 updateMemberList값에 세팅.
	*/
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>updateMemberPwForm</title>
	
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
	width: 600px;
	height: 600px;
	border: 0px solid;
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 550px;
	}

	.table {
    
    height: 200px;
    border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
    table-layout: fixed;
	 }  
 
	.th {
	width: 200px;
    height:15px;
    border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
	font-weight: bolder !important;
	white-space: nowrap; 
	color : black;
	th-layout: fixed;
	text-align : left;
	}
	td {
	width: 200px;
	padding: 10px;
	border-right:hidden;
	border-left:hidden;
	border-top:hidden;
	border-bottom:hidden;
	td-layout: fixed;
	overflow:hidden;
	white-space : nowrap;
	color : black;
	text-overflow: ellipsis;
	text-align : center;
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
	
	<body class="body">
	<!-- 메뉴 partial jsp 구성 -->
	<div>
		<jsp:include page="/inc/menu.jsp"></jsp:include>
    </div>
	<div class="react1">
	<!-- 회원정보 수정 상단 제목 및 이전페이지-->
	<p class="indent" align="center">
		<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 비밀번호 수정 </span>
	</p>
	<br>
	<!-- 회원 비밀번호 수정 폼작성 -->
	<form action="<%=request.getContextPath()%>/updateMemberPwAction.jsp" method="post">
		<% /* 위 세팅된 arrayList<해쉬맵> list를 MemberDao 클래스에서 HashMap<String,Object> m으로 생성했기에, for each문이 다음과 같이 쓰임. 
                          		ex)  for(HashMap<String, Object> m : list) {
                          				String memberId = (String)(m.get("memberId")); 
                          		}        (ps. m.get 앞에 String은 형변환을 해줌.)  */
              for(HashMap<String, Object> m : updateMemberList) {
           	   String memberId = (String)(m.get("memberId"));
          %>
		<input type="hidden" name="memberNo" value="">
			<table class="table">
				<tr>
					<th class="th">
						<span>아이디</span>
					</th>
					<td class="td">
						<input class="int" type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</td>				
				</tr>
				<tr>
					<th class="th">
						<span>기존 비밀번호</span>
					</th>
					<td class="td">
						<input class="int" type="password" name="memberPw" value="">
					</td>				
				</tr>
				<tr>
					<th class="th">
						<span>수정 비밀번호</span>
					</th>
					<td class="td">
						<input class="int" type="password" name="memberPw2" value="">
					</td>				
				</tr>
				<tr>
					<th><a class="btn_type btn_primary a" 
							href="<%=request.getContextPath()%>/cash/cashList.jsp">돌아가기</a></th>
					<td>
						<button type="submit" class="btn_type btn_primary">수정하기</button>
					</td>
				</tr>
			</table>
			<!-- msg 파라메타값이 있으면 출력 -->
		<%
			if(request.getParameter("msg") != null){
		%>
			<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
		<%
              }
		%>
		</form>		
		</div>
	</body>
</html>