<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true" import="java.util.*,java.util.logging.*,java.io.*,java.text.*" %>
<% Logger logger = Logger.getLogger("details.jsp"); %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%@ include file="book_data.jsp" %>
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
<%
String username = null;
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("username")) {
			username = cookie.getValue();
			//System.out.println("Found a username = " + username);
		}
	}
}

NumberFormat format = new DecimalFormat("#0.00");

String cartValueStr = null;

if (username != null) {
	String bookValue = request.getParameter("purchase");
	logger.info("Book value: " + bookValue);
	if (bookValue != null && bookValue.length() > 0) {
		if (session.getAttribute("cart") == null) {
			logger.info("Cart value set to: " + bookValue);
			session.setAttribute("cart", bookValue);
		} else {
			Double cartValue = Double.parseDouble(session.getAttribute("cart").toString());
			cartValue += Double.parseDouble(bookValue);
			session.setAttribute("cart", cartValue);
		}
		cartValueStr = format.format(Double.parseDouble(session.getAttribute("cart").toString()));
	} 
} else {
	cartValueStr = "NOT_LOGGED_IN";
}


%>

</head>
<body>
	<p>Hello <%= username == null ? "New User" : username %> <%= cartValueStr == null ? "" : "Cart Total: " + cartValueStr%></p>

<%	
String title = request.getParameter("title");
logger.info("Book title: " + title);
 %>
<table id="t01">
<%
out.print("<tr><th>Book title</th><th>Price</th></tr>"); 

for (String[] arr : books) {
	Book book = new Book(arr);
	if (book.title.equalsIgnoreCase(title)) {
	    out.print("<tr>");
	    out.print(String.format("<td>%s</td><td style=\"text-align:right\">%s</td>", book.title, format.format(book.price)));
	    out.println("</tr>");
	}
}
%>
</table>

</body>
</html>