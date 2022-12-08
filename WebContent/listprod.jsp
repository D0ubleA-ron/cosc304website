<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>

<!DOCTYPE html>
<html>
<head>
<title>TECHub</title>
<link rel="stylesheet" href="./css/listprod.css">
</head>
<body>
 
<nav>
<%
String username = (String) session.getAttribute("authenticatedUser");
if(username != null){
   out.println("<h1 class=\"logo\">TECHub  Hello, " + username + "!</h1><div class=\"links\"><a href=\"index.jsp\">Home</a><p> | </p><a href=\"showcart.jsp\">Shopping Cart</a><p> | </p><a href=\"listorder.jsp\">Orders</a></div>");
}else{
   out.println("<h1 class=\"logo\">TECHub</h1><div class=\"links\"><a href=\"index.jsp\">Home</a><p> | </p><a href=\"showcart.jsp\">Shopping Cart</a><p> | </p><a href=\"listorder.jsp\">Orders</a></div>");
}
%>
</nav>
<p class="text">Search for the products you want to buy:</p>
 
<form method="get" action="listprod.jsp">
<input class="searchbar" type="text" name="productName" size="50" placeholder="Search By Product">
<input class="searchbar" type="text" name="productCategory" size="50" placeholder="Search By Category">
<input class="button" type="submit" value="Submit"><input class="button" type="reset" value="Reset"> (Leave blank for all products)
</form>
 
<% // Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("productCategory");
Boolean printHeaders = false;

      
//Note: Forces loading of SQL Server driver
try
{   // Load driver class
   Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
   out.println("ClassNotFoundException: " +e);
}
 
// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!
 
// Make the connection
 
// Print out the ResultSet
 
// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection
 
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00
 
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";
  
try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
{  
   String sql = null;     
   ResultSet rst = null;
   if((name == null || name.equals("")) && (category == null || category.equals(""))){
       printHeaders = true;
       sql = "SELECT productId, productName, productPrice, categoryId FROM product";      
       rst = stmt.executeQuery(sql);
   } else if ((name == null || name.equals(""))){       //checks for blank product id and inputted category
      printHeaders = true;
      name = "%"+name+"%";
      sql = "SELECT productId, productName, productPrice, categoryId FROM product WHERE categoryId = (SELECT categoryId FROM category WHERE categoryName LIKE ?)";
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setString(1, category);
      rst = pstmt.executeQuery();
      if (!rst.isBeforeFirst()){
         printHeaders = false;
         out.println("<h2>Unfortunately, this category does not exist/ has no products. Please try again</h2>");
      }
   } else if (category == null || category.equals("")){
      printHeaders = true;
      name = "%"+name+"%";
      sql = "SELECT productId, productName, productPrice, categoryId FROM product WHERE productName LIKE ?";
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setString(1, name);
      rst = pstmt.executeQuery();
      
      if (!rst.isBeforeFirst()){
         printHeaders = false;
         out.println("<h2>Unfortunately, the current product does not exist within our system. Please try again</h2>");
      }
      
   }else{
      printHeaders = true;
      name = "%"+name+"%";
      sql = "SELECT productId, productName, productPrice, categoryId FROM product WHERE productName LIKE ? AND categoryId = (SELECT categoryId FROM category WHERE categoryName LIKE ?)";
      PreparedStatement pstmt = con.prepareStatement(sql);
      pstmt.setString(1, name);
      pstmt.setString(2, category);
      rst = pstmt.executeQuery();
      if (!rst.isBeforeFirst()){
         printHeaders = false;
         out.println("<h2>Unfortunately, that product does not exist in that category, please try again</h2>");
      }
  }
   //if (printHeaders){
      out.println("<h2>All Products</h2>");
      out.println("<table><tr class=\"table-header\"><th></th><th><h3>Product Name</h3></th><th><h3>Category</h3></th><th><h3>Price</h3></th></tr>");
   //}
   
   
   while (rst.next())
   {
       int prodId = rst.getInt(1);
       String prodname = rst.getString(2);
       double prodprice = rst.getDouble(3);

       String sql2 = "SELECT categoryName FROM category WHERE categoryId = ?";
       PreparedStatement pstmt2 = con.prepareStatement(sql2);
       pstmt2.setInt(1, rst.getInt(4));
       ResultSet rst2 = pstmt2.executeQuery();
       String prodcategory = "";
       while (rst2.next()){
            prodcategory = rst2.getString(1);
       }

       NumberFormat currFormat = NumberFormat.getCurrencyInstance();
       String str = "addcart.jsp?id=" + prodId +"&name=" + prodname + "&price=" +prodprice;
       String str2 = str.replace(' ', '+');
       out.println("<tr><td><a class=\"addcart\" href=" + str2 + "> Add to Cart</a></td>"+"<td><a href = \"product.jsp?id=" + prodId + "\">" + prodname + "</a></td><td>" + prodcategory + "</td><td>"+currFormat.format(prodprice)+"</td></tr>");
 
   }
   out.println("</table>");
}
catch (SQLException ex)
{
   System.err.println("SQLException: " + ex);
}
 
%>
 
</body>
</html>