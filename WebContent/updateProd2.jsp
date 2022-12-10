<%@ include file="jdbc.jsp" %>
<%
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";


Boolean done = false;

try ( Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();)
{
String productName = request.getParameter("pname");
String productDesc = request.getParameter("desc");
String productPrice = request.getParameter("price");
String categoryId = request.getParameter("cid");
String productId = (String) session.getAttribute("pid");

String sql2 = "UPDATE product SET productName = ?, productDesc = ?, productPrice = ?, categoryId = ? WHERE productId = ?";
PreparedStatement pstmt2 = con.prepareStatement(sql2);
pstmt2.setString(1, productName);
pstmt2.setString(2, productDesc);
pstmt2.setString(3, productPrice);
pstmt2.setString(4, categoryId);
pstmt2.setString(5, productId);
pstmt2.executeUpdate();

done = true;
//out.println("<h4>Product updated successfully!</h4>");

}
catch (SQLException ex)
{
System.err.println("SQLException: " + ex);
}
session.setAttribute("done", done);
%>
<jsp:forward page="manageDB.jsp" />