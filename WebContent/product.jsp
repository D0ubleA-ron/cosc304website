<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Ray's Grocery - Product Information</title>
<link rel="stylesheet" href="./css/product.css">
</head>
<body>
    <nav>
		<h1 class="logo"><a href="index.jsp">TECHub</a></h1>
		<div class="links">
			<a href="shop.html">Home</a>
      	<p> | </p>
			 <a href="listprod.jsp">Our Products</a>
			 <p> | </p>
			 <a href="listorder.jsp">Orders</a>
             <p> | </p>
			 <a href="admin.jsp">Admin</a>
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
    String sql = "SELECT productName, productPrice, productImageURL, productImage FROM product WHERE productId = ?";
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
        out.println("<b>Id  </b>" + productId + "<br>");
        out.println("<b>Price   </b>" + currFormat.format(prodprice) + "<br>");

        String imageURL = rst.getString(3);
        String imageBinary = rst.getString(4);
        if(imageURL != null ){  
            out.println("<img src = \"" + imageURL + "\" >");
        }
        if(imageBinary != null){
           String str3 = "displayImage.jsp?id=" + productId;
           out.println("<img src =" +str3 + ">"); 
        }
        
        out.println("<h2><a href=\"addcart.jsp?id=" + productId + "&name=" + prodname + "&price=" + prodprice+ "\">Add to Cart</a></h2>");
    }

}
catch (SQLException ex)
{
   System.err.println("SQLException: " + ex);
}


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html>

