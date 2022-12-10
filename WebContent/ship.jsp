<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>TECHub Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("id");
          
	// TODO: Check if valid order id
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";    
	String uid = "sa";
	String pw = "304#sa#pw";

	try ( Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();)
	{ 	
		Boolean done = false;
		String sql = "SELECT orderId FROM ordersummary WHERE orderId = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, orderId);
		ResultSet rst = pstmt.executeQuery();
		if(!rst.next()){
			out.println("Invalid order id");
		}else{
			con.setAutoCommit(false);
			String sql2 = "SELECT productId, quantity FROM orderproduct WHERE orderId = ?";
			PreparedStatement pstmt2 = con.prepareStatement(sql2);
			pstmt2.setString(1, orderId);
			ResultSet rst2 = pstmt2.executeQuery();
			while(rst2.next()){
				String sql3 = "SELECT quantity FROM productInventory WHERE productId = ?";
				PreparedStatement pstmt3 = con.prepareStatement(sql3);
				pstmt3.setInt(1, rst2.getInt(1));
				ResultSet rst3 = pstmt3.executeQuery();
				if(rst3.next() && (rst2.getInt(2) <= rst3.getInt(1))){
					String sql4 = "UPDATE productInventory SET quantity = ? WHERE productId = ?";
					PreparedStatement pstmt4 = con.prepareStatement(sql4);
					pstmt4.setInt(1, (rst3.getInt(1) - rst2.getInt(2)));
					pstmt4.setInt(2, rst2.getInt(1));
					pstmt4.executeUpdate();
					
					String sql5 = "INSERT INTO shipment(shipmentDate, warehouseId) VALUES (?, 1)";
					PreparedStatement pstmt5 = con.prepareStatement(sql5);
					pstmt5.setDate(1, java.sql.Date.valueOf(java.time.LocalDate.now()));
					pstmt5.executeUpdate();

					con.commit();

					out.println("<h2>Ordered Product: " + rst2.getInt(1) + " Previous Inventory: " + rst3.getInt(1) + " New Inventory: ");
					out.println((rst3.getInt(1) - rst2.getInt(2)) + "</h2><br>");
					done = true;
				}else{
					con.rollback();
					out.println("<h1>Shipment not done. Insufficient inventory for product id: " + rst2.getInt(1) + "</h1><br>");
					done = false;
					break;
				}
			}
			con.setAutoCommit(true);
			if(done == true){
				out.println("<h1>Shipment successfully processed.</h1><br>");
			}
		}
	}
	catch (SQLException ex)
	{
		con.rollback();
		out.println("SQLException: " + ex);
	}finally{
		
	}

%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
