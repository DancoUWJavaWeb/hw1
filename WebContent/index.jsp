<%@ page language="java" 
	contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.io.*,java.text.*,java.util.concurrent.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UW Java Web App Development Homework 1</title>
<script type="text/javascript" src="uwjava_functions.js" >
</script>

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
<body onload="addRowHandlers()">
<%@ include file="book_data.jsp" %>

<%
	Map<String,Book> bookMap = new HashMap<String,Book>(); 
	
	// Load the map from the array
	for (String[] book : books) {
		bookMap.put(book[0], new Book(book));
	}
	
	// Write the map contents to the page
/* 	for (Book book : bookMap.values()) {
		out.println(book + "<br>");
	}
 */
 
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
	
	boolean isSciFiSelected = true;
	boolean isClassicsSelected = true;
	boolean isFantasySelected = true;
	String[] genresSelected = request.getParameterValues("genre") != null ? 
			request.getParameterValues("genre") : 
			new String[] {"classics", "sci-fi", "fantasy"};
	List<String> genres = Arrays.asList(genresSelected);
	if (genresSelected != null && genresSelected.length > 0) {
		genres = Arrays.asList(genresSelected);
		isSciFiSelected = genres.contains("sci-fi");
		isClassicsSelected = genres.contains("classic");
		isFantasySelected = genres.contains("fantasy");
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
	if (!genres.contains(book.genre)) {
		continue;
	}
    out.print("<tr>");
    String anchor = String.format("<a href=\"details.jsp?title=%s\">%s</a>", book.title, book.title);
    out.print(String.format("<td>%s</td><td style=\"text-align:right\">%s</td><td><input type=\"submit\" name=\"purchase\" value=\"Add to Cart\"/></td>", 
    		anchor, format.format(book.price)));
    out.println("</tr>");
}
%>
</table>

<form action="index.jsp">
	<input type="checkbox" name="genre" value="sci-fi" <%= isSciFiSelected ? "checked" : "" %>>SciFi
	<input type="checkbox" name="genre" value="classic" <%= isClassicsSelected ? "checked" : "" %>>Classics
	<input type="checkbox" name="genre" value="fantasy" <%= isFantasySelected ? "checked" : "" %>>Fantasy<br>
	<input type="submit" value="Filter Genre" >
</form>

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
