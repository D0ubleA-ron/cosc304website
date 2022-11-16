<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>
 
<h1>Search for the products you want to buy:</h1>
 
<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>
 
<% // Get product name to search for
String name = request.getParameter("productName");
      
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
   if(name == null || name.equals("")){
       sql = "SELECT productName, productPrice FROM product";     
       rst = stmt.executeQuery(sql);
   }else{
       name = "%"+name+"%";
       sql = "SELECT productName, productPrice FROM product WHERE productName LIKE ?";
       PreparedStatement pstmt = con.prepareStatement(sql);
       pstmt.setString(1, name);
       rst = pstmt.executeQuery();
   }
   out.println("<h2>All Products</h2>");
   out.println("<table><tr><th></th><th><h3>Product Name</h3></th><th><h3>Price</h3></th></tr>");
   while (rst.next())
   {  
       double price = rst.getDouble(2);
       NumberFormat currFormat = NumberFormat.getCurrencyInstance();
       out.println("<tr><td>Add to Cart</td>"+"<td>"+rst.getString(1)+"</td>" +"<td>"+currFormat.format(price)+"</td></tr>");
       
 
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
