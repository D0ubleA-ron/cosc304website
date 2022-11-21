<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import = "java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
<link rel="stylesheet" href="./css/order.css">
</head>
<body>
 
	<nav>
		<h1 class="logo">Our Grocery</h1>
		<div class="links">
         <a href="shop.html">Home</a>
         <p> | </p>
         <a href="listprod.jsp">Our Products</a>
		</div>
 </nav>

<%
// Get customer id
String custId = request.getParameter("customerId");
String custPw = request.getParameter("customerPw");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
 
 
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";
  
try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
{  
   // Determine if valid customer id was entered
   String sql = "SELECT customerId, firstName, lastName, password FROM customer WHERE customerId = ?";
   PreparedStatement pstmt = con.prepareStatement(sql);
   pstmt.setString(1, custId);
   ResultSet rst = pstmt.executeQuery();
 
   try{
       Integer.parseInt(custId);
       if(custId.equals("") || !rst.next() || custPw.equals("")){
           out.println("<h2>Invalid Id/Password. Go to previous page and try again.</h2>");
       // Determine if there are products in the shopping cart
       }else if(productList.isEmpty()){
           out.println("<h2>Your shopping cart is empty!</h2>");
       }else{
            if (custPw.equals(rst.getString(4))){
                double total = 0;
           NumberFormat currFormat = NumberFormat.getCurrencyInstance();
 
           out.println("<h1>Your Order Summary</h1>");
           out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
           Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
               while (iterator.hasNext())
               {
                   Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                   String productId = (String) product.get(0);
                   String name = (String) product.get(1);
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
                   total = total+pr*qty;
              
                   // Print out order summary
                   out.println("<tr><td>" + productId + "</td><td>" + name + "</td><td>" + qty + "</td><td>" + currFormat.format(pr) + "</td><td>" + currFormat.format(pr*qty) + "</td></tr>");
               }
 
           String sql2 = "INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (?, ?, ?)";
           PreparedStatement pstmt2 = con.prepareStatement(sql2, Statement.RETURN_GENERATED_KEYS);
           pstmt2.setString(1, custId);
           pstmt2.setDate(2, java.sql.Date.valueOf(java.time.LocalDate.now()));
           pstmt2.setDouble(3, total);
           pstmt2.executeUpdate();
           ResultSet keys = pstmt2.getGeneratedKeys();
           keys.next();
           int orderId = keys.getInt(1);
 
           out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
           out.println("</table>");
           out.println("<h1>Order completed. Will be shipped soon...</h1>");
           out.println("<h1>Your order reference number is: " + orderId + "</h1>");
           out.println("<h1>Shipping to customer: " + custId + " Name: " + rst.getString(2) + " " + rst.getString(3) + "</h1>");
 
           // Insert each item into OrderProduct table using OrderId from previous INSERT
           Iterator<Map.Entry<String, ArrayList<Object>>> iterator2 = productList.entrySet().iterator();
               while (iterator2.hasNext())
               {
                   Map.Entry<String, ArrayList<Object>> entry = iterator2.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
                   String productId = (String) product.get(0);
                   String name = (String) product.get(1);
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
                   total = total+pr*qty;
                   String sql3 = "INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
                   PreparedStatement pstmt3 = con.prepareStatement(sql3); 
                   pstmt3.setInt(1, orderId);
                   pstmt3.setString(2, productId);
                   pstmt3.setInt(3, qty);
                   pstmt3.setDouble(4, pr);
                   pstmt3.executeUpdate();
               }
           // Clear cart if order placed successfully
           productList.clear();

            } else{
                out.println("<h2>Invalid Password. Go to previous page and try again.</h2>");
            }
           
       }
   } 
   catch (NumberFormatException e) 
   {
       out.println("<h2>Invalid Id/Password. Go to previous page and try again.</h2>");
   }
  
}
catch (SQLException ex)
{
   System.err.println("SQLException: " + ex);
}  
 
 
 
 
// If either are not true, display an error message
 
// Make connection
 
// Save order information to database
 
 
   /*
   // Use retrieval of auto-generated keys.
   PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);          
   ResultSet keys = pstmt.getGeneratedKeys();
   keys.next();
   int orderId = keys.getInt(1);
   */
 
 
// Update total amount for order record
 
// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
 
/*
   Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
   while (iterator.hasNext())
   {
       Map.Entry<String, ArrayList<Object>> entry = iterator.next();
       ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
       String productId = (String) product.get(0);
       String price = (String) product.get(2);
       double pr = Double.parseDouble(price);
       int qty = ( (Integer)product.get(3)).intValue();
           ...
   }
*/
 
 
 
 
  
%>
</BODY>
</HTML>
 
 
