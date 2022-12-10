<%@ page import="java.sql.*" %>
<%@ include file="jdbc.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="./css/product.css">
        <title>Account Created!</title>
    </head>
    <body>
        <nav>
            <h1 class="logo"><a href="index.jsp">TECHub</a></h1>
            <div class="links">
                <a href="index.jsp">Home</a>
              <p> | </p>
                 <a href="listprod.jsp">Our Products</a>
            </div>
     </nav>
        <%

            try
            {   // Load driver class
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            }
            catch (java.lang.ClassNotFoundException e)
            {
            out.println("ClassNotFoundException: " +e);
            }

            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String phonenum = request.getParameter("phonenum");
            String address = request.getParameter("add");
            String city = request.getParameter("city");
            String stp = request.getParameter("sp");
            String zip = request.getParameter("code");
            String country = request.getParameter("country");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String password2 = request.getParameter("password2");
            //out.println("<h1>P1: " + password + " P2: " + password2 + "!</h1>");
            
            String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
            String uid = "sa";
            String pw = "304#sa#pw";

            if (password.equals(password2)){
                try ( Connection con = DriverManager.getConnection(url, uid, pw);
                Statement stmt = con.createStatement();)
                {
                    String sql = null;     
                    ResultSet rst = null;
                    sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, fname);
                    pstmt.setString(2, lname);
                    pstmt.setString(3, email);
                    pstmt.setString(4, phonenum);
                    pstmt.setString(5, address);
                    pstmt.setString(6, city);
                    pstmt.setString(7, stp);
                    pstmt.setString(8, zip);
                    pstmt.setString(9, country);
                    pstmt.setString(10, username);
                    pstmt.setString(11, password);
                    int out2 = pstmt.executeUpdate();
                    out.print("<h2>Account create succesfully!</h2>");

                    
                }catch (SQLException ex)
                {
                   System.err.println("SQLException: " + ex);
                }
            } else {
                out.print("<h2>Passwords do not match. Please go back to the previous page and try again</h2>");
            }
            

        %>
        <br>
        <button class="button" onclick="location.href = 'newCustomer.jsp';"> Back </button>
        <button class="button" onclick="location.href = 'index.jsp';"> Home </button>
    </body>
</html>


