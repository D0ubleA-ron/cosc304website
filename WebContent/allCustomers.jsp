<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE HTML>
<head>
    <title>All customers page</title>
</head>
<body>
<%
      
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
    String uid = "sa";
    String pw = "304#sa#pw";
    
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();)
    {
        String sql = "SELECT customerId, firstName, lastName, userId FROM customer";
        ResultSet rst = stmt.executeQuery(sql);
        out.println("<h1>All Customers</h1>");
        out.println("<table border = 1><tr><th>Customer Id</th><th>First Name</th><th>Last Name</th><th>User Id</th></tr>");
        while(rst.next()){
           out.println("<tr><td>" + rst.getInt(1) + "</td><td>" + rst.getString(2) + "</td><td>" + rst.getString(3) + "</td><td>" + rst.getString(4) +"</td></tr>");
        }
        out.println("</table>");
    }
    catch (SQLException ex)
    {
    System.err.println("SQLException: " + ex);
    }
%>
</body>