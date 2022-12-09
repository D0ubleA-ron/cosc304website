<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="./css/listprod.css">
</head>
<body>


<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.NumberFormat" %>
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
        out.print("<p> | </p><a href=\"logout.jsp\">Logout</a>");
    }%>
    </div>
</nav>
<%

// TODO: Write SQL query that prints out total order amount by day

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();)
{ 
    String sql = "SELECT CAST(orderDate AS DATE), SUM(totalAmount) FROM ordersummary GROUP BY CAST(orderDate AS DATE)";
    ResultSet rst = stmt.executeQuery(sql);
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();
    out.println("<h3>Administrator Sales Report by Day</h3>");
    out.println("<table border = 1><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    while(rst.next()){
        out.println("<tr><td>" + rst.getDate(1) + "</td><td>" +  currFormat.format(rst.getDouble(2)) + "</td></tr>");
    }
    out.println("</table>");
}
catch (SQLException ex)
{
    out.println("SQLException: " + ex);
}

%>

</body>
</html>

