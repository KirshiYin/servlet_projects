<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/styles.css" />


<form action="${pageContext.request.contextPath}/Controller" method="post">
	<sql:transaction dataSource="jdbc/recipies">
	
	<sql:query sql="select * from recipies where id=?" var="results">
			<sql:param>${param.image}</sql:param>
		</sql:query>

<c:set scope="page" var="image" value="${results.rows[0] }"></c:set>

<c:set scope="page" var="imgId" value="${image.id}"/>
<td>
<!-- a hidden variable to store the image id which is passed to the controller -->
	<input type ="hidden"name="imgId"value="${image.id}">
	
</td>
</sql:transaction>


<input type="hidden" name="action" value="addToFavs">
    <input type="submit" name="addToFavs" value="Add To Favourites" />
</form> 
