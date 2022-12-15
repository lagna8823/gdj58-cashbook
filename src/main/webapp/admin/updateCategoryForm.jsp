<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	// Controller
	//session 유효성 검증 코드 필요시 redirect!
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 입력값 체크
	if(request.getParameter("categoryNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
	
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	int rowPerPage = 1;
	int beginRow = 0;
	
	// Model 호출 : 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	Category categoryList = categoryDao.selectCategoryList(categoryNo);
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>categoryList</title>
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
    top: 150px;
	left: 430px;
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
	
	p.indent{ padding-left: 18em }
	
	</style>
	</head>
	
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
    	<div class="react1">
			<!-- 카테고리 수정 상단 제목-->
			<p class="indent" align="center">
				<span style="font-size:2em;  color: black; font-weight: bolder !important;">카테고리 수정</span>
			</p>
			
			<!-- 카테고리 추가 폼 작성-->
			<form id="signinForm" action="<%=request.getContextPath()%>/admin/updateCategoryAction.jsp" method="post">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
				<input type="hidden" name="categoryNo" value="<%=categoryNo%>">
			<div>
			<table>
				<tr>
					<th class="th">수입/지출</th>
					<td class="td"><input tpye="text" id="categoryKind" name="categoryKind" value="<%=categoryList.getCategoryKind()%>"></td>
				</tr>
				<tr>
					<th class="th">이름</th>
					<td class="td"><input tpye="text" id="categoryName" name="categoryName" value="<%=categoryList.getCategoryName()%>"></td>
				</tr>
				<tr>
					<th class="th"><a class="btn_type btn_primary a" 
							href="<%=request.getContextPath()%>/admin/categoryList.jsp">돌아가기</a></th>
					<td class="td">
						<button type="button" id="signinBtn" class="btn_type btn_primary">추가하기</button>
					</td>
				</tr>
			</table>
			</div>
			</form>
			<!-- msg 파라메타값이 있으면 출력 -->
			<%
				if(request.getParameter("msg") != null){
			%>
				<div><%=request.getParameter("msg") %></div>
			<%
				}
			%>
		</div>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			// 수입지출 폼 유효성 검사
			let categoryKind = document.querySelector('#categoryKind');
			if(categoryKind.value == ''){
				alert('수입/지출을 확인하세요.');
				categoryKind.focus();
				return;
			}
			
			// 내역 폼 유효성 검사
			let categoryName = document.querySelector('#categoryName');
			if(categoryName.value == ''){
				alert('내역을 확인하세요.');
				categoryName.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/updateCategoryAction.jsp
		});
	</script>
	</body>
</html>
