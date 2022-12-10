<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Update product page</title>
</head>
<body>
    <h3>Update product</h3>
    <form name="form1" method="post" action="updateProd2.jsp">
        <table style="display:inline">
                
    <%
    String productId = request.getParameter("pid");

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
    String uid = "sa";
    String pw = "304#sa#pw";
    
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();)
    {
        if(productId != null){
            String sql = "SELECT productName, productDesc, productPrice, categoryId FROM product WHERE productId = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, productId);
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                out.println("<tr><td><label for=pname>Product name:</label></td>");
                out.println("<td><input type=text id=pname name=pname size=30 required=pname value=\"" + rst.getString(1) + "\"></td></tr>");
                out.println("<tr><td><label for=desc>Product Description:</label></td>");
                out.println("<td><input type=text id=desc name=desc size=30 required=desc value=\"" + rst.getString(2) + "\"></td></tr>");
                out.println("<tr><td><label for=price>Product Price:</label></td>");
                out.println("<td><input type=text id=price name=price size=30 required=price value=\"" + rst.getString(3) + "\"></td></tr>");
                out.println("<tr><td><label for=cid>Category Id:</label></td>");
                out.println("<td><input type=number id=cid name=cid size=30 required=cid value=\"" + rst.getString(4)+ "\"></td></tr> ");
            }

        }
        out.println("</table>");
        out.println("<br><br><input type=submit value=\"Update product\">");
        out.println("<input type=button value=Cancel onclick=\"location.href=\'manageDB.jsp\';\">");
        out.println("</form>");
        
        
    }
    catch (SQLException ex)
    {
    System.err.println("SQLException: " + ex);
    }
    session.setAttribute("pid", productId);
    %>

</body>
</html>
