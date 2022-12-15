<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	String memberId = loginMember.getMemberId();
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	System.out.println( memberId);
	CommentDao commentDao = new CommentDao();
	ArrayList<Comment> list = commentDao.selectCommentList(commentNo);
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCommentForm</title>
	<!-- 부트스트랩과의 약속! -->
	<!-- Latest compiled and minified CSS -->
	<linkhref="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Latest compiled JavaScript -->
	<scriptsrc="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>

	<!--스타일 -->
	<style>
	
	.font {
	font-weight: bolder !important;
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
	<br>
	<!-- 답변(comment)수정 상단 제목-->
 	<p class="indent" align="center">
		<span style="font-size:2em;  color: black; font-weight: bolder !important;">답변 수정</span>
	</p>
		
	<!-- comment 답변 폼 작성-->
	<form id="signinForm" action="<%=request.getContextPath()%>/admin/updateCommentAction.jsp">
	<input type="hidden" name="commentNo" value="<%=commentNo%>">
	<div>
	<table border="1">
		<%
			for(Comment c : list ){
		%>
			<tr>
				<th class="th">관리자ID</th>
				<td class="td font"><%=c.getMemberId()%></td>
				
			</tr>
			<tr>
				<th class="th">작성일</th>
				<td class="td font"><%=c.getCreatedate()%></td>
			</tr>
			<tr>
				<th class="th">답변내용</th>
				<td class="td"><textarea id="commentMemo" rows="6" cols="80" name="commentMemo"><%=c.getCommentMemo()%></textarea></td>
			</tr>
		<%		
			}
		%>
		<tr>
			<th class="th"><a class="btn_type btn_primary a" 
					href="<%=request.getContextPath()%>/admin/helpListAll.jsp">돌아가기</a></th>
			<td class="td">
				<button type="button" id="signinBtn" class="btn_type btn_primary">수정하기</button>
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
			
			//문의내용 폼 유효성 검사
			let commentMemo = document.querySelector('#commentMemo');
			if(commentMemo.value == ''){
				alert('문의내용을 확인하세요.');
				commentMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/updateCommentAction.jsp
		});
	</script>
	</body>
</html>