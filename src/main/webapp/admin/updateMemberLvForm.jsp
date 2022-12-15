<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	Member updateMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 updateMember를 새로 선언)
	updateMember.setMemberNo(memberNo);
	
	
	// Model 호출
	MemberDao memberDao = new MemberDao();
	ArrayList<HashMap<String, Object>> updateMemberList  = memberDao.selectMemberListByLv(updateMember);
	// View
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberLvForm</title>
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<!--스타일 -->
	<style>
	
	.font {
	font-family: gulim;
	}
	
	.react1 {
	width: 600px;
	height: 340px;
	border: 0px solid 
	text-align: center;
	box-sizing: border-box;
	position: absolute;
    top: 250px;
	left: 550px;
	}

	table {
	width: 600px;
    height: 200px;
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
	
	p.indent{ padding-left: 3em }
	
	</style>
	</head>
	
	<body>
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
		<div class="react1">
		<!-- memberLevel contents... -->
		<!-- 멤버레벨 수정 상단 제목-->
			<p class="indent" align="center">
				<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 멤버 레벨 수정 </span>
			</p>
			<form action="updateMemberLvAction.jsp" method="post">
			<div>
			<table>
				<input type="hidden" name="memberNo" value="<%=memberNo%>">
				<%
			 		for(HashMap<String, Object> m : updateMemberList) {
						String memberId = (String)(m.get("memberId"));
						String memberName = (String)(m.get("memberName"));
				%>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="memberId" value="<%=memberId%>" readonly="readonly"></td>
				</tr>
				<%
					}
				%>
				<tr>
					<th>멤버 레벨</th>
					<td>
						<select name="memberLevel">
							<option  value="0">0</option>
							<option  value="1">1</option>			
						</select>
				</tr>
				<tr>
							<th class="th"><a class="btn_type btn_primary a" 
									href="<%=request.getContextPath()%>/admin/memberList.jsp">돌아가기</a></th>
							<td class="td">
								<button type="button" id="signinBtn" class="btn_type btn_primary">수정하기</button>
							</td>
						</tr>
			</table>
			</div>
			</form>
		</div>
	</body>
</html>
