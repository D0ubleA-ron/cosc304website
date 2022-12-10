<!DOCTYPE html>
<html>
    <head>
        <title>Account Creation Page</title>
        <link rel="stylesheet" href="./css/product.css">
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
        <div style="margin:0 auto;text-align:center;display:inline">
        <h1>Create an Account</h1>
        <form name="MyForm" method=post action="accountCreated.jsp">
            <table style="display:inline">
            <h2>User info</h2>
            <tr>
                <td><label for="fname">First name:</label></td>
                <td><input type="text" id="fname" name="fname" size=30 required="fname"></td>
            </tr>
            <tr>
                <td><label for="lname">Last name:</label></td>
                <td><input type="text" id="lname" name="lname" size=30></td>
            </tr>
            <tr>
                <td><label for="email">Email:</label></td>
                <td><input type="email" id="email" name="email" size=30 required="email"></td>
            </tr>
            <tr>
                <td><label for="phonenum">Phone Number:</label></td>
                <td> <input type="tel" id="phonenum" name="phonenum" maxlength=12 pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" size=30  placeholder="XXX-XXX-XXXX"></td>
            </tr>
            <tr>
                <td><label for="add">Address:</label></td>
                <td><input type="text" id="add" name="add" size=30 required="addres"></td>
            </tr>
            <tr>
                <td><label for="city">City:</label></td>
                <td><input type="text" id="city" name="city" size=30 required="city"></td>
            </tr>
            <tr>
                <td><label for="sp">State/Province:</label></td>
                <td><input type="text" id="sp" name="sp" size=30><br></td>
            </tr>
            <tr>
                <td><label for="code">Postal code/Zip code:</label></td>
                <td><input type="text" id="code" name="code" maxlength=7 size=30 required="code"></td>
            </tr>
            <tr>
                <td><label for="country">Country:</label></td>
                <td><input type="text" id="country" name="country" size=30 required="country"></td>
            </tr>
            </table>
            <h2>Set username and password</h2>
            <table style="display:inline">
            <tr>
                <td><label for="username">Username:</label></td>
                <td><input type="text" id="username" name="username" size=30 required="username"></td>
            </tr>
            <tr>
                <td><label for="password">Password:</label></td>
                <td><input type="password" id="password" name="password" size=30 required=" password"></td>
            </tr>
            <tr>
                <td><label for="password">Enter Password Again:</label></td>
                <td><input type="password" id="password2" name="password2" size=30 required=" password2"></td>
            </tr>
            </table>
            <br><br>
    <input type="submit" value="Submit">
</form>
</div>
    </body>
</html>