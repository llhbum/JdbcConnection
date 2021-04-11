<%@page import="oracle.jdbc.pool.OracleDataSource"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="oracle.sql.*" %>
<%@page import="oracle.jdbc.OracleDriver" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

   String title = request.getParameter("title");
   String name = request.getParameter("name");
   String password = request.getParameter("password");
   String content=request.getParameter("content");
   
   StringBuffer sql = new StringBuffer();
   sql.append("insert into t_board(no, title, name, password, content)");
   sql.append("values(seq_board.nextval,?,?,?,?)");
   
   
   try{
	   //Class.forName("oracle.jdbc.driver.OracleDriver");
	   Class.forName("oracle.jdbc.OracleDriver");
   }catch(Exception e){
      e.printStackTrace();      
   }
   
   boolean result = false;
   
   OracleDataSource ods = new OracleDataSource();
   ods.setURL("jdbc:oracle:thin:@localhost:1521/xe");
   ods.setUser("c##xci");
   ods.setPassword("xci");
   try(Connection conn = ods.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString()))
   {
      ps.setString(1, title);
      ps.setString(2, name);
      ps.setString(3, password);
      ps.setString(4, content);
      ps.executeUpdate();
      result = true;
   }catch(Exception e){
      e.printStackTrace();
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% if (result) {%>
글이 입력되었습니다.<br/>
<a href="list_original.jsp">리스트</a>
<% } else { %>
<script type="text/javascript">
	alert('글 입력 실패')
	location.href="javascript:history.back()"
</script>
<% } %>
</body>
</html>