<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>TECHub - Product Information</title>
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

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";
  
try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
{ 
    String sql = "SELECT productName, productPrice, productImageURL, productImage, productDesc FROM product WHERE productId = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, productId);
    ResultSet rst = pstmt.executeQuery();
    String prodname;
    double prodprice;
    while(rst.next()){
        prodname = rst.getString(1);
        prodprice = rst.getDouble(2);
        NumberFormat currFormat = NumberFormat.getCurrencyInstance();
        out.println("<h1>" + prodname + "</h1>");
        out.println("<b>Id:  </b>" + productId + "<br>");
        out.println("<b>Price:   </b>" + currFormat.format(prodprice) + "<br>");
        out.println("<b>Description:   </b>" + rst.getString(5) + "<br>");

        String imageURL = rst.getString(3);
        String imageBinary = rst.getString(4);
        if(imageURL != null ){  
            out.println("<img src = \"" + imageURL + "\" >");
        }
        if(imageBinary != null){
           String str3 = "displayImage.jsp?id=" + productId;
           out.println("<img src =" +str3 + ">"); 
        }
        session.setAttribute("productId", productId);
        out.println("<h2><a href=\"addcart.jsp?id=" + productId + "&name=" + prodname + "&price=" + prodprice+ "\">Add to Cart</a></h2>");
        out.println("<a href=\"review.jsp?id=" + productId + "\">Add Review</a>");


    }
    out.println("<h2><a href=\"listprod.jsp\">Continue Shopping</a></h2>");
    out.println("<h1>Reviews</h1>");

    String sql2 = "SELECT * FROM review WHERE productId = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql2);
    pstmt2.setString(1, productId);
    ResultSet rst2 = pstmt2.executeQuery();
    while(rst2.next()){
        out.println("<p>Comment: "+ rst2.getString(6) + "</p>");
    }
    
   
}
catch (SQLException ex)
{
   System.err.println("SQLException: " + ex);
}

%>
</body>
</html>

