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
//username, email, password, confirm-password
    request.setCharacterEncoding("utf-8");

	String name = request.getParameter("username");
	String email = request.getParameter("email");
	String pw = request.getParameter("password");
	String cp = request.getParameter("confirm-password");

 	System.out.println(name);
 	System.out.println(email);
 	System.out.println(pw);
 	System.out.println(cp);
 	if (!pw.equals(cp)){
 		out.println("<script> alert('패스워드 재확인!'); location.href= '../Signup.jsp';</script>");
 		return;
 	}
 	
 	
// 	DB저장
%>
<%
Connection conn=null;
Boolean connect = false;
String sql = "INSERT INTO users (NAME, PW, EMAIL) VALUES (?, ?, ?)";
try{
	Context init = new InitialContext();
    DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/kndb");
    conn = ds.getConnection();
    
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
<%
if(connect==true){
System.out.println("연결되었습니다.");
}else{
	out.println("회원가입에 실패하였습니다.");
	return;
}%> 
    
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