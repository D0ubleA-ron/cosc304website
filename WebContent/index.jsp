<!DOCTYPE html>
<html>
<head>
        <title>Ray's Grocery Main Page</title>
        <link rel="stylesheet" href="./css/listprod.css">
</head>

<body>

        <nav>
		<h1 class="logo">TECHub</h1>
 </nav>
<%
        String username = (String) session.getAttribute("authenticatedUser");
        if(username == null){
                out.print("<h2 align=\"center\"><a href=\"login.jsp\">Login</a></h2>");
        }
%>
        <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

        <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

        <h2 align="center"><a href="allCustomers.jsp">List All Customers</a></h2>

        <h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

        <h2 align="center"><a href="admin.jsp">Administrators</a></h2>

        <h2 align="center"><a href="manageDB.jsp">Manage Database</a></h2>
<%
        if(username != null){
                out.print("<h2 align=\"center\"><a href=\"logout.jsp\">Logout</a></h2>");
        }
%>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
if(username != null){
        out.println("<h4 align=\"center\">Signed in as: " + username + "</h4>");
}
%>
</body>
</head>


