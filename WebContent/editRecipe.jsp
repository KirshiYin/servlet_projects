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

<c:set scope="page" var="imgname" value="${image.name}.${image.extension}"></c:set>

<c:set scope="page" var="imgId" value="${image.id}"/>
<%-- <c:out value="${imgId}"/> --%>
<td>
<!-- a hidden variable to store the image id which is passed to the controller -->
	<input type ="hidden"name="imgId"value="${image.id}">
	<!-- the description of the image --> 
		<br><textarea name=descriptionArea rows="20" cols="100">${image.description}</textarea>
</td>
</sql:transaction>


<input type="hidden" name="action" value="edit">
    <input type="submit" name="edit" value="save" />
</form> 
