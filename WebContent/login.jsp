<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style/styles.css" />
<title>Login Page</title>
</head>
<body>
	<div class="loginWrapper">
		<div class="login">
			<!-- calls the controller from here -->

			<form method="post"
				action="<%=response.encodeURL(request.getContextPath() + "/Controller?action=dologin")%>">
				<!-- another way to call the controller -->
				<!-- <form action="/Recipies/Controller" method="post"> -->
				<input type="hidden" name="action" value="dologin">

				<center>
					<table class="loginTable">
						<thead>
							<tr>
								<th colspan="2">Login Here</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>User Name</td>
								<td><input type="text" name="username" value="" /></td>
							</tr>
							<tr>
								<td>Password</td>
								<td><input type="password" name="password" value="" /></td>
							</tr>
							<tr>
								<td></td>
								<td><input type="submit" value="Login" /></td>
							</tr>
						</tbody>
					</table>
				</center>
			</form>
		</div>
	</div>
	<h2><%=request.getAttribute("message")%></h2>

</body>
</html>