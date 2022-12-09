<!DOCTYPE html>
<html>
    <head>
        <title>Account Created!</title>
    </head>
    <body>
        <%
            String username = request.getParameter("username");
            out.println("<h1>Your account has been succesfully created. Welcome " + username + "!</h1>");
        %>
        <br>
        <button class="button" onclick="location.href = 'index.jsp';"> Home </button>
    </body>
</html>

