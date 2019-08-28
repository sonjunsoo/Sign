<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
//자바 코드 작성
//username, password
    request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("username");
	String pw = request.getParameter("password");
	
	Connection conn=null;
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:KnDB";
		
	Boolean connect = false;
	Boolean isLogin = false;
		
	try{
		String sql = "select * from users where name = ? and pw = ? ";
	    Class.forName(driver);
	    conn=DriverManager.getConnection(url,"knuser","system"); //자신의 아이디와 비밀번호
	    PreparedStatement pstmt = conn.prepareStatement(sql);	
	    pstmt.setString(1,name);
	    pstmt.setString(2,pw);
	    ResultSet rs = pstmt.executeQuery();
	    if(rs.next()){
		System.out.println(rs.getString("name"));
		System.out.println(rs.getString("pw"));
		System.out.println(rs.getString("email"));
		isLogin = true;
	    } else{
	    	System.out.println("아이디  확인");
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
	이름 : <b style="color:Tomato;"><%=name %></b><br>
	비밀번호 : <b style="color:Tomato;"><%=pw %></b><br>
	<a href="https://github.com/sonjunsoo/Home.git">입장</a>
	
<% } else { %>
	<script>alert("로그인 실패!"); 
	location.href= "../Signup.jsp"; </script>
	
<% } %>


</body>
</html>