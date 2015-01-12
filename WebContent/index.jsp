<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.io.*,java.text.*,java.util.concurrent.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UW Java Web App Development Homework 1</title>
<style>
table, th, td {
    border: 1px solid black;
    text-align: left;
}
table#t01 tr:nth-child(even) {
    background-color: #eee;
}
table#t01 tr:nth-child(odd) {
    background-color: #fff;
}
table#t01 th {
    color: white;
    background-color: black;
} 
</style>

<script type="text/javascript" src="uwjava_functions.js" >
</script>
</head>
<body onload="addRowHandlers()">
<%@ include file="book_data.jsp" %>
<%
	String username = null;
	String name = request.getParameter("username");
	if (name != null && name.length() > 0) {
		Cookie cookie = new Cookie("username", name);
		cookie.setMaxAge(60*60*30);
		response.addCookie(cookie);
		username = name;
	}
	if (username == null){
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username")) {
					username = cookie.getValue();
					//System.out.println("Found a username = " + username);
				}
			}
		}
	}
	String reset = request.getParameter("logout");
	if (reset != null && reset.equals("true")) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username")) {
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
		}
	}
%>

	<p>Hello <%= username == null ? "New User" : username %></p>
	
<% if (username == null)  {%>
	<form method=POST action="index.jsp">
		Username: <input type=text name=username size=32/><br>
		Password: <input type=password name=password size=32/><br>
		<input type="submit" value="submit">			
	</form>
<% } else  {%>
	<form method=POST action="index.jsp">
	<input type=hidden name=logout value="true"/>
	<input type=submit value="Logout"/>
	</form>
<%} %>

<p>Books available for purchase:</p>
<table id="t01">
<%
out.print("<tr><th>Book title</th><th>Price</th></tr>"); 
NumberFormat format = new DecimalFormat("#0.00");

for (String[] arr : books) {
	Book book = new Book(arr);
    out.print("<tr>");
    out.print(String.format("<td>%s</td><td style=\"text-align:right\">%s</td>", 
    		book.title, format.format(book.price)));
    out.println("</tr>");
}
%>
</table>

<% if (username != null) { %>
	<form method=POST action="searchByTitle.jsp">
		Search by title: <input type=text name=title size=32/><input type="submit" value="submit">			
	</form>
	<form method=POST action="searchByAuthor.jsp">
		Search by author: <input type=text name=author size=32/><input type="submit" value="submit">			
	</form>
<%} %>

<%
	String jspPath = session.getServletContext().getRealPath("/");
	String bookFile = jspPath + File.separator + "books.java";
    BufferedReader reader = new BufferedReader(new FileReader(bookFile));
    StringBuilder sb = new StringBuilder();
    String line;

    while((line = reader.readLine())!= null){
//        sb.append(line+"\n");
    }
//    out.println(sb.toString());
    reader.close();
%>
</body>
</html>