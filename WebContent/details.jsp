<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.io.*,java.text.*,java.util.concurrent.*" %>
<html>
<head>
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
	
	String title = request.getParameter("title");
	
	Map<String,Book> bookMap = new HashMap<String,Book>(); 
	
	// Load the map from the array
	for (String[] book : books) {
		bookMap.put(book[0], new Book(book));
	}

%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%= title %> Details</title>

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


</head>
<body>
	<p>Hello <%= username == null ? "New User" : username %></p>

<table id="t01">
<%
out.print("<tr><th>Book title</th><th>Price</th></tr>"); 
NumberFormat format = new DecimalFormat("#0.00");

for (String[] arr : books) {
	Book book = new Book(arr);
	if (!title.equalsIgnoreCase(book.title)) {
		continue;
	}
    out.print("<tr>");
    out.print(String.format("<td>%s</td><td>%s</td><td><input type=\"submit\" name=\"purchase\" value=\"Add to Cart\"/></td>", 
    		format.format(book.price), book.description));
    out.println("</tr>");
}
%>
</table>

</body>
</html>