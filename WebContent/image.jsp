<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/styles.css" />
<form action="${pageContext.request.contextPath}/Controller" method="post">

<sql:setDataSource var="ds" dataSource="jdbc/recipies" />
<!-- checks which image has been clicked -->
<sql:query dataSource="${ds }" sql="select * from recipies where id=?" var="results">
	<sql:param>${param.image}</sql:param>
</sql:query>

<c:set scope="page" var="image" value="${results.rows[0] }"></c:set>

<c:set scope="page" var="imgname" value="${image.name}.${image.extension}"></c:set>
<!-- stores the image id. passed to controller -->
<input type ="hidden"name="imgId"value="${image.id}">

<div class="Recipe">
<td>
	<!-- the source of the image --> <a
	href="<c:url value="/recipies_images?action=image&image=${image.id}" />">
		<h1>${image.name}</h1>
		
		 <img width="380" src="${pageContext.request.contextPath}/pics/${imgname}" />
		 
</a>
<p> ${image.description}</p>
<p><a href="${image.image}">${image.image}</a></p>

</td>
</div>

<br><a href="/Recipies/Controller?action=deleteRecipe&image=${image.id}">Delete</a>
<br><a href="/Recipies/Controller?action=editRecipe&image=${image.id}">Edit</a>
<br><a href="/Recipies/Controller?action=addRecipe&image=${image.id}">Add to Favourites</a>
</form>

