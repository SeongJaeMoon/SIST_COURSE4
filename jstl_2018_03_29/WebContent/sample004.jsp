<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- jstl-1.2.jar 파일 필요 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%
	Map<String, String> map = new HashMap<String, String>();
	map.put("1", "hong");
	map.put("2", "park");
	map.put("3", "choi");
	map.put("4", "kim");
	map.put("5", "lee");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1">

<title>SIST_쌍용교육센터</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<style>

div#input:hover, div#output:hover {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}

</style>

<!-- Google Map API -->
<script src="https://maps.googleapis.com/maps/api/js"></script>

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script>
$(document).ready(function(){

	   // jQuery methods go here...

});
</script>
</head>
<body>

<div class="container">
	
	<c:set var="map" value="<%=map%>" />
	<c:forEach var="m" items="${map}" varStatus="c">
		<h1>${c.index+1} / ${m.key} / ${m.value}</h1>
	</c:forEach>

	<c:set var="a" value="0" />
	<c:forEach var="b" begin="1" end="10">
		<h1>${b}</h1>
		<c:set var="a" value="${a+1}" />
	</c:forEach>
	<h1>${a}</h1>

</div>

</body>
</html>