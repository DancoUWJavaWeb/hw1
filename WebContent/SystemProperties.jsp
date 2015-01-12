<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*,java.io.*,java.util.concurrent.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>System Properties</title>
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
<%  %>
<table id="t01">
<%
out.print("<tr><th>Name</th><th>Value</th></tr>"); 
Properties properties = System.getProperties();
Set<Object> keys = properties.keySet();
for (Object key : keys) {
    out.print("<tr>");
    out.print(String.format("<td>%s</td><td>%s</td>", 
    		key.toString(), properties.getProperty(key.toString())));
    out.println("</tr>");
}
%>
</table>
</body>
</html>