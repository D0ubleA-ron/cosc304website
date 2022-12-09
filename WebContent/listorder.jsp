<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
<link rel="stylesheet" href="./css/listorder.css">
</head>
<body>
 
	<nav>
		<h1 class="logo">Our Grocery</h1>
		<div class="links">
         <a href="index.jsp">Home</a>
         <p> | </p>
         <a href="listprod.jsp">Our Products</a>
         <p> | </p>
         <a href="showcart.jsp">Shopping Cart</a>
         <%
        String username = (String) session.getAttribute("authenticatedUser");
        if(username != null){
            out.print("<p> | </p><a href=\"admin.jsp\">Admin</a>");
            out.print("<p> | </p><a href=\"logout.jsp\">Logout</a>");
        }%>
		</div>
 </nav>

<h2>Order List</h2>
 
<%
//Note: Forces loading of SQL Server driver
try
{   // Load driver class
   Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
   out.println("ClassNotFoundException: " +e);
}
 
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00
 
// Make connection
 
// Write query to retrieve all order summary records
 
// For each order in the ResultSet
 
   // Print out the order summary information
   // Write a query to retrieve the products in the order
   //   - Use a PreparedStatement as will repeat this query many times
   // For each product in the order
       // Write out product information
 
// Close connection
 
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";
  
try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
{  
   NumberFormat currFormat = NumberFormat.getCurrencyInstance();
 
   out.println("<table border = 1><tr><th>Order Id</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
   String sql = "SELECT orderId, customer.customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId";
   ResultSet rst = stmt.executeQuery(sql);
   while(rst.next()){
       double totalprice = rst.getDouble(5);
       out.println("<tr><td>"+rst.getInt(1)+"</td>" +"<td>"+rst.getInt(2)+"</td>"+"<td>"+rst.getString(3)+ " " + rst.getString(4)+"</td>"+"<td>"+currFormat.format(totalprice)+"</td></tr>");
 
       String sql2 = "SELECT productId, quantity, price FROM orderproduct JOIN ordersummary ON orderproduct.orderId = ordersummary.orderId WHERE orderproduct.orderId = ?";
       PreparedStatement pstmt = con.prepareStatement(sql2);
       pstmt.setString(1, rst.getString(1));
       ResultSet rst2 = pstmt.executeQuery();
       out.println("<tr><td colspan = 4 align = right><table border = 1><tr><th>Product Id</th><th>Quantity</th><th>Price</th></tr>");
       while(rst2.next()){
           double price = rst2.getDouble(3);
           out.println("<tr><td>"+rst2.getInt(1)+"</td>" +"<td>"+rst2.getInt(2)+"</td>"+"<td>"+currFormat.format(price)+"</td></tr>");
       }
       out.println("</table></td></tr>");
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
 
 

