<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/styles.css" />
<sql:setDataSource var="ds" dataSource="jdbc/recipies" />

<sql:query dataSource="${ds}" sql="select * from recipies where isFavoured=1" var="results" />
<c:choose><c:when test="${results.rowCount == 0}"> No favourites added yet</c:when></c:choose>
<table class="images">

<c:set var="tablewidth" value="4" />

<c:forEach var="image" items="${results.rows}" varStatus="row">

	<c:set scope="page" var="imgname" value="${image.name}.${image.extension}"></c:set>

	<td>
	<!-- recipies_images is the server mapping -->
		<a href="<c:url value="/recipies_images?action=image&image=${image.id}" />">
			<p> ${image.name}</p>
			<img width="180" src="${pageContext.request.contextPath}/pics/${imgname}" />
		</a>
	</td>


</c:forEach>

</table>