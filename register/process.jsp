<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<% 
//자바 코드 작성
//username, email, password, confirm-password
    request.setCharacterEncoding("utf-8");

	String name = request.getParameter("username");
	String email = request.getParameter("email");
	String pw = request.getParameter("password");
	String cp = request.getParameter("confirm-password");

// 	System.out.println(name);
// 	DB저장
%>
    <%
Connection conn=null;
String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:KnDB";
	
Boolean connect = false;
	
try{
	String sql = "INSERT INTO USERS (NAME, PW, EMAIL) VALUES (?, ?, ?)";
    Class.forName(driver);
    conn=DriverManager.getConnection(url,"knuser","system"); //자신의 아이디와 비밀번호
    PreparedStatement pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, name);
    pstmt.setString(2, pw);
    pstmt.setString(3, email);
	pstmt.executeUpdate();
	
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
<title>register/process.jsp</title>
</head>
<body>
회원가입 처리 결과
<br><br>
이름 : <%=name %><br>
이메일 : <%=email %><br>
비밀번호 : <%=pw %><br>
비밀번호 확인: <%=cp %><br>
<br>
회원가입이 완료 되었습니다.
<a href="../Signup.jsp">로그인 하기</a>

</body>
</html>