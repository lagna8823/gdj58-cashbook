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
	</head>
	<body> 
		<h1>회원탈퇴</h1>	
		<!-- msg 파라메타값이 있으면 출력 -->
		<%
			if(request.getParameter("msg") != null){
		%>
			<div><%=request.getParameter("msg") %></div>
		<%
			}
		%>
		<!-- 폼작성 -->
		<form action="<%=request.getContextPath()%>/deleteMemberAction.jsp" method="post">
			<% /* 위 세팅된 arrayList<해쉬맵> list를 MemberDao 클래스에서 HashMap<String,Object> m으로 생성했기에, for each문이 다음과 같이 쓰임. 
                           		ex)  for(HashMap<String, Object> m : list) {
                           				String memberId = (String)(m.get("memberId")); 
                           		}        (ps. m.get 앞에 String은 형변환을 해줌.)  */
               for(HashMap<String, Object> m : updateMemberList) {
            	   String memberId = (String)(m.get("memberId"));
           %>
			<input type="hidden" name="memberNo" value="">
			<table>
			
				<tr>
					<td>
						<span>아이디</span>
					</td>
					<td>
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</td>				
				</tr>
				<tr>
					<td>
						<span>기존 비밀번호</span>
					</td>
					<td>
						<input type="password" name="memberPw" value="">
					</td>				
				</tr>
			</table>
			<button type="submit">탈퇴</button>
			<%
               }
			%>
		</form>		
	</body>
</html>