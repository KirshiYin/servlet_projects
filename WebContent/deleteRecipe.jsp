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

Are you sure you want to delete this recipe from your Favourites?
<input type="hidden" name="action" value="delete">
<input type="submit" name="delete" value="yes" />
<input type="submit" name="back"   value="back" />

</form> 
