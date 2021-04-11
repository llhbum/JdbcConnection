<%@page import="board.model.BoardDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 

long pg = 1;
try{
	pg = Long.parseLong(request.getParameter("pg"));
}catch(Exception e){
	
}
int pageSize = 3;

StringBuffer sql_count = new StringBuffer();
sql_count.append("select count(*) as cnt from t_board");

StringBuffer sql = new StringBuffer();
sql.append("select no, title,readcount, name, regdate ");
sql.append("from t_board ");
sql.append("order by no desc ");





try{
   Class.forName("oracle.jdbc.OracleDriver");
}catch(Exception e){
   e.printStackTrace();      
}



List<BoardDTO> list= new ArrayList();
try(Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "c##xci","xci");
      PreparedStatement ps = conn.prepareStatement(sql.toString());)
{
   try(ResultSet rs = ps.executeQuery())
   {
      while(rs.next()){
         BoardDTO dto = new BoardDTO();
         dto.setNo(rs.getLong("no"));
         dto.setTitle(rs.getString("title"));
         dto.setName(rs.getString("name"));
         dto.setRegdate(rs.getDate("regdate"));
         dto.setReadcount(Integer.parseInt(rs.getString("readcount")));
         list.add(dto);
      }
      
   }
   }catch(Exception e)
   {
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
	<table>
		<caption>게시물 리스트</caption>
		<thead>
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>이름</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		<%
		      for(BoardDTO record :list){      
		%>
		<tr>
			<td><%=record.getNo() %></td>
			<td><a href="detail.jsp?no=<%=record.getNo()%>"><%=record.getTitle() %></a></td>
			<td><%=record.getName() %></td>
			<td><%=record.getRegdate() %></td>
			<td align="right"><%=record.getReadcount() %></td>
		</tr>
		<%
		      }
		%>
		
		</tbody>
	</table><br/>
<a href="insert.jsp">글쓰기</a>
</body>
</html>