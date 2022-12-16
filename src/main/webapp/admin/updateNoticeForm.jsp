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
	
	// 입력값 체크
		if(request.getParameter("noticeNo") == null){
			response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
			return;
		}
	
	// 데이터 받아와 값세팅
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// Model 호출 공지사항 
	NoticeDao noticeDao = new NoticeDao(); // NoticeDao 메서드를 이용해 noticeDao 새로 만듬
	ArrayList<Notice> list = noticeDao.selectNoticeListByMemo(noticeNo);
	// noticeDao클래스의 selectNoticeListByPage로 (beginRow, rowPerPage)보내 결과값 ArrayList<Notice> list을 받아옴
	
	// View
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>updateNoticeForm</title>
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
	left: 580px;
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
	
	p.indent{ padding-left: 6em }
	
	</style>
	</head>
	<body>
		<!-- 메뉴 partial jsp 구성 -->
		<div>
			<jsp:include page="/inc/menu.jsp"></jsp:include>
	    </div>
		<div class="react1">
	
			<!-- 공지사항 수정 상단 제목-->
			<p class="indent" align="center">
				<span style="font-size:2em;  color: black; font-weight: bolder !important;"> 공지사항 수정 </span>
			</p>
			
			<!-- notice 수정 폼 작성 -->	
			<form id="signinForm" action="<%=request.getContextPath()%>/admin/updateNoticeAction.jsp">
				<input type="hidden" name="memberId" value="<%=loginMember.getMemberId()%>">
			<div>
			<table> 
					<%
						for(Notice n : list){
					%>
						<tr>
							<th class="th">공지번호</th>
							<td class="td font"><input type="number" name="noticeNo" value="<%=n.getNoticeNo()%>" readonly="readonly" style="width:430px;"></td>
						</tr>
						<tr>
							<th class="th">생성날짜</th>
							<td class="td font"><input type="text" name="createdate" value="<%=n.getCreatedate()%>" readonly="readonly" style="width:430px;"></td>
						</tr>
						<tr>
							<th class="th">공지내용</th>
							<td class="td"><textarea id="noticeMemo" rows="3" cols="50" name="noticeMemo" value="<%=n.getNoticeMemo()%>"></textarea></td>
						</tr>
					<%
						}
					%>
						<tr>
							<th class="th"><a class="btn_type btn_primary a" 
									href="<%=request.getContextPath()%>/cash/cashList.jsp">돌아가기</a></th>
							<td class="td">
								<button type="button" id="signinBtn" class="btn_type btn_primary">수정하기</button>
							</td>
						</tr>
			</table>
			</div> 
			</form>
		</div>
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			if(request.getParameter("msg") != null){
		%>
			<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
	<script>
		let signinBtn = document.querySelector('#signinBtn');
	
		signinBtn.addEventListener('click', function() {
			// 디버깅
			console.log('signinBtn click!');
			
			//공지사항 폼 유효성 검사
			let noticeMemo = document.querySelector('#noticeMemo');
			if(noticeMemo.value == ''){
				alert('공지내용을 확인하세요.');
				noticeMemo.focus();
				return;
			}
			
			let signinForm =document.querySelector('#signinForm');
			signinForm.submit(); //action=/updateNoticeAction.jsp
		});
	</script>		
	</body>
</html>
