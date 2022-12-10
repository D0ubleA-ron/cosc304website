<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link rel="stylesheet" href="./css/product.css">
</head>
<body>
    <nav>
		<h1 class="logo"><a href="index.jsp">TECHub</a></h1>
		<div class="links">
			<a href="index.jsp">Home</a>
      	<p> | </p>
			 <a href="listprod.jsp">Our Products</a>
			 <p> | </p>
			 <a href="listorder.jsp">Orders</a>
             <%
            String username = (String) session.getAttribute("authenticatedUser");
            if(username != null){
                out.print("<p> | </p><a href=\"admin.jsp\">Admin</a>");
                out.print("<p> | </p><a href=\"logout.jsp\">Logout</a>");
            }%>
		</div>
 </nav>

 	
 	
	<form method="get" action="review.jsp?">

		<label for="reviewComment">Review Comment: </label><br>
		<input type="text" id="reviewComment" name="reviewComment" required="reviewComment">
		<br>
	
	<%
	String productId = (String) session.getAttribute("productId");
	String reviewComment = request.getParameter("reviewComment");
	out.println("<p>" + productId +"</p>");
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
    String uid = "sa";
    String pw = "304#sa#pw";

	try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
	{ 
			if(reviewComment != null && productId != null){
				String sql = "INSERT INTO review(reviewComment, productId) VALUES (?,?) ";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1, reviewComment);
				pstmt.setString(2, productId);
				pstmt.executeUpdate();
				out.println("<p>Review added!</p>");
			}
	}
	catch (SQLException ex)
	{
		System.err.println("SQLException: " + ex);
	}
	%>
	<input type="submit" value="submit">
	</form>
</body>
</html>


