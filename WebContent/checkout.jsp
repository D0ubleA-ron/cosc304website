<!DOCTYPE html>
<html>
<head>
<title>TECHub Lineup</title>
<link rel="stylesheet" href="./css/listorder.css">
</head>
<body>

 
         <%
        String username = (String) session.getAttribute("authenticatedUser");
        if(username != null){
            response.sendRedirect("order.jsp");	
        }
        else
        {
            response.sendRedirect("login.jsp");	
        }
         %>


</body>
</html>

