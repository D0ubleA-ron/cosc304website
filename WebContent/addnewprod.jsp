<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp" %>

<%
String productName = request.getParameter("pname");
String productDesc = request.getParameter("desc");
String productPrice = request.getParameter("price");
String categoryId = request.getParameter("cid");

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
String uid = "sa";
String pw = "304#sa#pw";

Boolean done = false;
  
try ( Connection con = DriverManager.getConnection(url, uid, pw);
       Statement stmt = con.createStatement();)
{ 
    String sql = "INSERT INTO product(productName, productDesc, productPrice, categoryId) VALUES (?,?,?,?)";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, productName);
    pstmt.setString(2, productDesc);
    pstmt.setString(3, productPrice);
    pstmt.setString(4, categoryId);
    pstmt.executeUpdate();

    done = true;

}
catch (SQLException ex)
{
System.err.println("SQLException: " + ex);
}
session.setAttribute("done", done);
%> 
<jsp:forward page="manageDB.jsp" />