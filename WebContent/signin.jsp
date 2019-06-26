<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
	
    

<!DOCTYPE html>
<html lang="en" class="full-height">

<head>
    <jsp:include page="z_head.jsp"></jsp:include>
</head>

<body>

<jsp:include page="z_navbar.jsp"></jsp:include>


<main text-center py-5 style="margin-top: 150px">

	<div class="container-fluid">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
			<%
			String uId = request.getParameter("userId");
			String uPass = request.getParameter("userPass");
			if (uId == null && uPass == null) {
			// myText is null when the page is first requested, 
			// so do nothing
			} else { 
			if (uId.length() == 0 || uPass.length()==0) {
			// There was a querystring like ?myText=
			// but no text, so myText is not null, but 
			// a zero length string instead.
			%>
			<p class="black-text" Style="text-align:center;">User id or password field is blank. Try again</p>
			<% } else { 
				Class.forName("com.mysql.jdbc.Driver");
				// 1. get a connection to data base
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
				// 2. create a statement
				Statement st = con.createStatement();
				//3. execute the sql queries
				ResultSet rs = st.executeQuery("select a_id, a_password from admin");
				// 4. process the resultset
				while(rs.next()) {
					String mainId=rs.getString("a_id");
					String mainPass=rs.getString("a_password");
					//out.println(rs.getString("a_id")+" "+rs.getString("a_password")+" "+rs.getString("a_name")+" "+rs.getString("a_address")+" ");
					if (uId.equals(mainId) && uPass.equals(mainPass) ){
						String redirectURL = "admin.jsp";
						response.sendRedirect(redirectURL);
					}	
				}
				
				con.close();
				%>
				<p class="black-text" Style="text-align:center;">User id or password didn't match. Try again</p>
				<%
			}
			}
			%>
                <!-- Default form login -->
                <form action="signin.jsp" method="post">
                    <p class="h4 text-center mb-4">Sign in</p>

                    <!-- Default input email -->
                    <label for="defaultFormLoginEmailEx" class="black-text">User ID:</label>
                    <input type="text" id="defaultFormLoginEmailEx" class="form-control" name="userId">
                    <br>

                    <!-- Default input password -->
                    <label for="defaultFormLoginPasswordEx" class="black-text">Your password</label>
                    <input type="password" id="defaultFormLoginPasswordEx" class="form-control" name="userPass">

                    <div class="text-center mt-4">
                        <button class="btn btn-indigo" type="submit">Login</button>
                    </div>
                </form>
                <!-- Default form login -->
            </div>
            <div class="col-md-4"></div>
        </div>
    </div>
</main>



<!-- SCRIPTS -->
    <jsp:include page="z_scripts.jsp"></jsp:include>
</body>

</html>