<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	System.out.println(helpNo);
	
	Help updateHelp = new Help(); // 모델 호출시 매개값(vo.Help 클래스를 이용하여 updateHelp 새로 선언)
	updateHelp.setHelpNo(helpNo);
	
	// 분리된M(모델)을 호출
	HelpDao helpDao = new HelpDao();  // HelpDao 메서드를 이용해 selectHelpNo 새로 선언.
	ArrayList<HashMap<String, Object>> list = helpDao.selectHelpNo(helpNo);
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateHelpForm</title>
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--스타일 -->
	<style>
	
	.font {
	font-family: gulim;
	font-weight: bolder !important;
	}
	
	.react1 {
	width: 600px;
	height: 340px;
	border: 0px solid 
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 150px;
	left: 500px;
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
	.td {
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
	
	p.indent{ padding-left: 13em }
	
	</style>
	</head>
	
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
    	<div class="react1">
			<!-- 문의수정 상단 제목-->
			<p class="indent" align="center">
				<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 문의 수정 </span>
			</p>
			<br>
			<!-- 문의 수정 폼작성 -->
			<form id="signinForm" action="<%=request.getContextPath()%>/updateHelpAction.jsp">
				<input type="hidden" name="helpNo" value="<%=helpNo%>">
				<div>
				<table>
						<%
							for(HashMap<String, Object> h :  list){
						%>
					<tr>
						<th class="th">번호</th>
						<td class="td font"><%=h.get("helpNo")%></td>
					</tr>
					<tr>
						<th class="th">문의날짜</th>
						<td class="td font"><%=h.get("createdate")%></td>
					</tr>
					<tr>	
						<th class="th">문의내용</th>
						
						<td class="td"><textarea id="helpMemo" rows="8" cols="80" name="helpMemo"><%=h.get("helpMemo")%></textarea></td>
						<%
							}
						%>
					</tr>
					<tr>
						<th class="th"><a class="btn_type btn_primary a" 
								href="<%=request.getContextPath()%>/helpList.jsp">돌아가기</a></th>
						<td class="td">
							<button type="button" id="signinBtn" class="btn_type btn_primary">수정하기</button>
						</td>
					</tr>
				</table>
			</div>
		</form>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			//공지사항 폼 유효성 검사
			let helpMemo = document.querySelector('#helpMemo');
			if(helpMemo.value == ''){
				alert('문의내용을 확인하세요.');
				helpMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/insertCashAction.jsp
		});
	</script>
	</body>
</html>