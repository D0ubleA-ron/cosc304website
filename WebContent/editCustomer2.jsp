<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>
<%
    String userName = (String) session.getAttribute("authenticatedUser");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String phonenum = request.getParameter("phonenum");
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String stp = request.getParameter("sp");
    String zip = request.getParameter("code");
    String country = request.getParameter("country");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
    String uid = "sa";
    String pw = "304#sa#pw";
    
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();)
    {
        String sql = "SELECT customerId FROM customer WHERE userid = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setString(1, userName);
        ResultSet rst = pstmt.executeQuery();
        while(rst.next()){
            String sql2 = "UPDATE customer SET firstName = ?, lastName = ?, email = ?, phonenum = ?, address = ?, city = ?, state = ?, postalCode = ?, country = ?, userid = ?, password = ? WHERE customerId = ?"; 
            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, fname);
            pstmt2.setString(2, lname);
            pstmt2.setString(3, email);
            pstmt2.setString(4, phonenum);
            pstmt2.setString(5, address);
            pstmt2.setString(6, city);
            pstmt2.setString(7, stp);
            pstmt2.setString(8, zip);
            pstmt2.setString(9, country);
            pstmt2.setString(10, username);
            pstmt2.setString(11, password);
            pstmt2.setString(12, rst.getString(1));
            pstmt2.executeUpdate();
            
        }
    }
    catch (SQLException ex)
    {
    System.err.println("SQLException: " + ex);
    }

%>
<jsp:forward page="customer.jsp" />