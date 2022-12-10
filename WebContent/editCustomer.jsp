<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp"%>

<!DOCTYPE HTML>
<html>
<head>
    <title>Edit customer page</title>
</head>
<body>
    <div style="margin:0 auto;text-align:center;display:inline">
        <h1>Edit Account</h1>
        <form name="MyForm" method="post" action="editCustomer2.jsp">
            <table style="display:inline">
            <tr>
                <td><label for="fname">First name:</label></td>
                <%
                String firstname = (String) session.getAttribute("firstName");
                out.println("<td><input type=text id=fname name=fname size=30 value=\"" + firstname + "\" required=fname></td>");
                %>
            </tr>
            <tr>
                <td><label for="lname">Last name:</label></td>
                <%
                String lastname = (String) session.getAttribute("lastName");
                out.println("<td><input type=text id=lname name=lname size=30 value=\"" + lastname + "\" required=lname></td>");
                %>
            </tr>
            <tr>
                <td><label for="email">Email:</label></td>
                <%
                String email = (String) session.getAttribute("email");
                out.println("<td><input type=email id=email name=email size=30 required=email value=\"" + email + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="phonenum">Phone Number:</label></td>
                <%
                String phonenum = (String) session.getAttribute("phone");
                out.println("<td><input type=tel id=phonenum name=phonenum maxlength=12 pattern=\"[0-9]{3}-[0-9]{3}-[0-9]{4}\" size=30 value=\"" + phonenum + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="address">Address:</label></td>
                <%
                String address = (String) session.getAttribute("address");
                out.println("<td><input type=text id=address name=address size=30 required=address value=\""+ address + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="city">City:</label></td>
                <%
                String city = (String) session.getAttribute("city");
                out.println("<td><input type=text id=city name=city size=30 required=city value=\"" + city + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="sp">State/Province:</label></td>
                <%
                String state = (String) session.getAttribute("state");
                out.println("<td><input type=text id=sp name=sp size=30 value =\"" + state + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="code">Postal code/Zip code:</label></td>
                <%
                String code = (String) session.getAttribute("code");
                out.println("<td><input type=text id=code name=code maxlength=7 size=30 required=code value=\"" + code + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="country">Country:</label></td>
                <%
                String country = (String) session.getAttribute("country");
                out.println("<td><input type=text id=country name=country size=30 required=country value=\"" + country + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="username">Username:</label></td>
                <%
                String username = (String) session.getAttribute("userid");
                out.println(" <td><input type=text id=username name=username maxlength=10 size=30 required=username value=\"" + username + "\"></td>");
                %>
            </tr>
            <tr>
                <td><label for="password">Password:</label></td>
                <%
                String password = (String) session.getAttribute("pwd");
                out.println("<td><input type=password id=password name=password maxlength=10 size=30 required=password value=\"" + password + "\"></td>");
                %>
            </tr>
            </table>
            <br><br>
            <input type="submit" value="Update">
        </form>
   

</div>
</body>
</html>