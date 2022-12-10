<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Manage Datatabase page</title>
</head>
<body>
    <h3>Add new product</h3>
    <form name="form1" method=post action="addnewprod.jsp">
        <table style="display:inline">
            <tr>
                <td><label for="pname">Product name:</label></td>
                <td><input type="text" id="pname" name="pname" size=30 required="pname"></td>
            </tr>
            <tr>
                <td><label for="desc">Product Description:</label></td>
                <td><input type="text" id="desc" name="desc" size=30 required="desc"></td>
            </tr>
            <tr>
                <td><label for="price">Product Price:</label></td>
                <td><input type="text" id="price" name="price" size=30 required="price"></td>
            </tr>
            <tr>
                <td><label for="cid">Category Id:</label></td>
                <td><input type="number" id="cid" name="cid" size=30 required="cid"></td>
            </tr> 
        </table>
        <br><br>
        <input type="submit" value="Add product">
    </form>
    <br>
    <%
    if(session.getAttribute("done") != null){
        Boolean added = (boolean) session.getAttribute("done");
        if(added){
            out.println("<b>Product added successfully!</b>");
        }else{
            out.println("<b>Product not added successfully</b>");
        }
    } 
%>
    <h3>Update/Delete existing product</h3>
    <form name ="form2" method=post action="updateProd.jsp">
        <label for="pid">Please enter the product Id:</label>
        <input type="number" id="pid" name="pid" size=30 required="pid">
        <br><br>
        <input type="submit" value="Update product">
        <input type="submit" value="Delete product" formaction="manageDB.jsp" formmethod="get">
    </form>
    <br>
    <%
    if(session.getAttribute("done") != null){
        Boolean added = (boolean) session.getAttribute("done");
        if(added){
            out.println("<b>Product updated successfully!</b>");
        }else{
            out.println("<b>Product not added successfully</b>");
        }
    } 
%>
   
<%

String productId = request.getParameter("pid");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";
  
try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
{ 
    if(productId != null){
        String sql = "SELECT productName FROM product WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, productId);
        ResultSet rst = pstmt.executeQuery();
        if(!rst.next()){
            out.println("<p>Invalid id. Try again.</p>");
        }else{ 
            String sql2 = "DELETE FROM product WHERE productId = ?";
            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, productId);
            pstmt2.executeUpdate();
            out.println("<h4>Product \"" + rst.getString(1) + "\" deleted!</h4>");
        } 
    } 

}
catch (SQLException ex)
{
System.err.println("SQLException: " + ex);
}

%> 

</body>
</html>