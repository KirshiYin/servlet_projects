<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/styles.css" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>
<body>
<div class="loggedin">
<p>Logged in as user: <%= request.getAttribute("username") %></p>
 <input type ="hidden" name="action" value="goRecipies">
<br><a href="/Recipies/Controller?action=goRecipies">Go to the Recipies </a>
<br><a href="/Recipies/Controller?action=goFavourites">Go to Favourites </a>
<br><a href="/Recipies/Controller?action=insertRecipe">Upload Recipe </a>
</div>
</body>
</html>