<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "util.*" %>

<%	
	// 1.C
	request.setCharacterEncoding("utf-8"); // 한글버전 패치 (값이 넘어오니까 인코딩)	
  	String memberId = request.getParameter("memberId");
   	String memberName = request.getParameter("memberName");
   	String memberPw = request.getParameter("memberPw");
   	
	// 입력값 체크
	 if(memberId == null || memberName == null || memberPw == null || memberId.equals("") || memberName.equals("")|| memberPw.equals("")) {
      String msg = URLEncoder.encode("필수정보를 입력해주세요","utf-8"); // get방식 주소창에 문자열 인코딩
      response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp?msg="+msg);
      return;
   }
	
	Member checkMember = new Member(); // 모델 호출시 매개값(vo.Member의 클래스를 이용하여 checkMember를 새로 선언)
	checkMember.setMemberId(memberId); // 새로 선언된 checkMember에 넘겨받은 값 세팅.
	checkMember.setMemberPw(memberPw);
	checkMember.setMemberName(memberName);
	
	// 분리된M(모델)을 호출
	MemberDao memberDao = new MemberDao(); // memberDao 메서드를 이용해 memberDao를 새로 선언
	int resultRow = memberDao.insert(checkMember);
	//위에서 내려온 checkMember값을 Memberdao.insert() 클래스에로 보내고 결과값으로 resultMeber값을 받음.
	
	
	
	// redirect
	
	// redirectUrl값에 필요시 돌아갈 주소값 세팅.
	String redirectUrl = "/loginForm.jsp?#login";
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이 아니라면 수행
	if(resultRow != 0) {
		session.setAttribute("loginMember", checkMember); // session안에 로그인 아이디 & 이름을 저장
		response.sendRedirect(request.getContextPath()+redirectUrl);
		return;
		
	}
	// Memberdao에서 넘겨받은 결과 resultRow값이 '0'이라면 id가 중복되어 실행되지 않았으므로 중복된 아이디값이 있다.
	String msg =URLEncoder.encode("중복된 아이디가 있습니다.","utf-8");
	response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?msg="+msg);
	
	
	
	
%>