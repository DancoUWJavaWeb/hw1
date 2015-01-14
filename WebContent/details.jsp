<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page session="true" import="java.util.*,java.util.logging.*,java.io.*,java.text.*" %>
<% Logger logger = Logger.getLogger("details.jsp"); %>

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
	<% logger.info(cartValueStr); %>
	<p>Hello <%= username == null ? "New User" : username %> <%= cartValueStr == "NOT_LOGGED_IN" ? "Please log in prior to purchasing." : "Cart Total: " + cartValueStr%></p>

<table id="t01">
<form name="purchaseForm" action="details.jsp" method="POST"></form>
<%
out.print("<tr><th>Price</th><th>Detailed Description</th></tr>"); 

for (String[] arr : books) {
	Book book = new Book(arr);
	if (!title.equalsIgnoreCase(book.title)) {
		continue;
	}
    out.print("<tr>");
    out.print(String.format("<td>%s</td><td>%s</td><td>" + 
    		"<form name=\"purchaseForm\" action=\"details.jsp\" method=\"POST\">" + 
	   		"<input type=\"hidden\" name=\"purchase\" value=\"%s\"/>" + 
 	   		"<input type=\"hidden\" name=\"title\" value=\"%s\"/>" + 
    		"<input type=\"submit\" value=\"Add to Cart\"></form></td>", 
    		format.format(book.price), book.description, book.price, book.title));
    out.println("</tr>");
}
%>
</table>

<form action="index.jsp">
	<input type="submit" value="Continue Shopping" >
</form>

</body>
</html>