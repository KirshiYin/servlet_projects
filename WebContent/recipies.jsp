<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/styles.css" />
<sql:setDataSource var="ds" dataSource="jdbc/recipies" />

<sql:query dataSource="${ds}" sql="select * from recipies " var="results" />
<table class="images">

<c:set var="tablewidth" value="4" />

<c:forEach var="image" items="${results.rows}" varStatus="row">
<%--row.index is the index of the image.the % gives whatever is left over. test to see if the image if divisible by 8 --%>
	<c:if test="${row.index % tablewidth == 0}">
	<tr>
	</c:if>
	<%--stem and extension are the names of the columns from the db --%>
	<c:set scope="page" var="imgname" value="${image.name}.${image.extension}"></c:set>

	<td>
		<a href="<c:url value="/recipies_images?action=image&image=${image.id}" />">
<p> ${image.name}</p>
			<img width="150" src="${pageContext.request.contextPath}/pics/${imgname}" />
		</a>
	</td>
	<%--checks if the last image is divisible by 4. you get 4 rows--%>
	<c:if test="${row.index + 1 % tablewidth == 0}">
	</tr>
	</c:if>

</c:forEach>

</table>