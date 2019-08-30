<%@page import="java.sql.ResultSet"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
//자바 코드 작성
//username, password
    request.setCharacterEncoding("UTF-8");

	String email = request.getParameter("email");
	String pw = request.getParameter("password");
	String name = ""; // db에서 받아온 이름 html 부분에서 출력

//DB에서 받아온 정보로 email과 password 비교
//html부분 사용
	Connection conn=null;
	Boolean connect = false;
	Boolean isLogin = false;	
	String sql = "SELECT * FROM users WHERE email=? AND pw =?";
	
	try{
		Context init = new InitialContext();
	    DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
	    conn = ds.getConnection();
	    
	    PreparedStatement pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, email);
	    pstmt.setString(2, pw);
	    
	    ResultSet rs = pstmt.executeQuery();
	    
	    if(rs.next()){
	    name = rs.getString("name");
	   	System.out.println();
		isLogin = true; //데이터 존재 시 true로 변경
	    } else {
	 		out.println("<script> alert('아이디 또는 패스워드 재확인!'); location.href= '../Signup.jsp';</script>");
	    } 
	    connect = true;
	    conn.close();
	}catch(Exception e){
	    connect = false;
	    e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/process.jsp</title>
</head>
<body>
로그인 처리 결과
<br><br>

<% if(isLogin){%>
	<script> alert("로그인 성공!");</script>
	<b><%=name %></b>님 반갑습니다.<br><br>
	이름 : <b style="color:Tomato;"><%=name %></b><br>
	이메일 : <b style="color:Tomato;"><%=email %></b><br>
	<a href="https://sonjunsoo.github.io/Home/">홈페이지 입장</a>
	
<% } else { %>
	<script>alert("로그인 실패!"); 
	location.href= "../Signup.jsp"; </script>
	
<% } %>


</body>
</html>