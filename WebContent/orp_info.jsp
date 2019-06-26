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

<!--Main Navigation-->

<!--Main Layout-->
<main text-center py-5 style="margin-top: 100px">

    <div class="container-fluid">

        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8" style="text-align: center">
            
            <form method="post" action="orp_info.jsp">
                    <label>Select to Know information :</label>
                <div class="form-check mb-4">
                    <input class="form-check-input" type="radio" name="infoSelected" id="exampleRadios1" value="orphan" >
                    <label class="form-check-label" for="exampleRadios1">
                        Orphan
                    </label>
                </div>
                <div class="form-check mb-4">
                    <input class="form-check-input" type="radio" name="infoSelected" id="exampleRadios2" value="donor">
                    <label class="form-check-label" for="exampleRadios2">
                        Donors
                    </label>
                </div>
                <div class="form-check mb-4">
                    <input class="form-check-input" type="radio" name="infoSelected" id="exampleRadios3" value="donation">
                    <label class="form-check-label" for="exampleRadios3">
                        Donation
                    </label>
                </div>

                    <button type="submit" class="btn btn-outline-default btn-rounded waves-effect">submit</button>
                </form>


            </div>
            <div class="col-md-2"></div>
        </div>
            
            <%
			String info = request.getParameter("infoSelected");
			
			if (info == null) {
			// myText is null when the page is first requested, 
			// so do nothing
			}
			//orphan table display
			else if(info.equals("orphan")){ 
				Class.forName("com.mysql.jdbc.Driver");
				// 1. get a connection to data base
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
				// 2. create a statement
				Statement st = con.createStatement();
				//3. execute the sql queries
				ResultSet rs = st.executeQuery("select * from orphan");
				
				%>
				<div class="row" style="margin-top: 20px">
        			<div class="col-md-1"></div>
        			<div class="col-md-10">

            		<h3>Orphan's details</h3>
            			<div class="card">
                		<div class="card-body">
                    	<!--Table-->
                    	<table class="table table-hover table-responsive-md table-fixed">
                        <!--Table head-->
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th colspan=2>Address</th>
                            <th colspan=4>Description</th>
                        </tr>
                        </thead>
                        <!--Table head-->
                        <!--Table body-->
                        <tbody>
				<%
				// 4. process the resultset
				while(rs.next()) {
					String id=rs.getString("o_id");
					String name=rs.getString("o_name");
					String address=rs.getString("o_address");
					String description=rs.getString("o_description");
					
					out.println("<tr>"+"<td>"+id+"</td>"+"<td>"+name+"</td>"+"<td colspan=2>"+address+"</td>"+"<td colspan=4>"+description+"</td>"+"</tr>");
					
				}
				%>
					</tbody>
              	  	<!--Table body-->
            		</table>
            		<!--Table-->
       				</div>
   					 </div>
					</div>
					<div class="col-md-1"></div>
		 		</div>
				<% 
				con.close();
			}
			
			
			
			
			//donor table display
			else if(info.equals("donor")){ 
				Class.forName("com.mysql.jdbc.Driver");
				// 1. get a connection to data base
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
				
				// 2. create a statement
				Statement st = con.createStatement();
				
				//3. execute the sql queries
				ResultSet rs = st.executeQuery("select * from doner");
				
				%>
				<div class="row" style="margin-top: 20px">
        			<div class="col-md-1"></div>
        			<div class="col-md-10">

            		<h3>Donor's details</h3>
            			<div class="card">
                		<div class="card-body">
                    	<!--Table-->
                    	<table class="table table-hover table-responsive-md table-fixed">
                        <!--Table head-->
                        <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th >Mobile Number</th>
                            <th >Total donation</th>
                        </tr>
                        </thead>
                        <!--Table head-->
                        <!--Table body-->
                        <tbody>
				<%
				// 4. process the resultset
				while(rs.next()) {
					String dId=rs.getString("d_id");
					String dName=rs.getString("d_name");
					String dAddress=rs.getString("d_address");
					String dDescription=rs.getString("d_number");
					
					String sql = "select sum(dt_amount) as pp from donation where dt_id = '"+dId+"';";
					PreparedStatement pt = con.prepareStatement(sql);
					//pt.executeUpdate(); 
					ResultSet rs1 = pt.executeQuery(sql);
					int value =0;
					while(rs1.next()){
						String amount = rs1.getString("pp");
						if(amount!=null){
							value= value+ Integer.parseInt(amount);
						}
						//out.print(""+value);
					}
					
					
					rs1.close();
					out.println("<tr>"+"<td>"+dId+"</td>"+"<td>"+dName+"</td>"+"<td>"+dAddress+"</td>"+"<td>"+dDescription+"</td>"+"<td>"+value+"</td>"+"</tr>");
					
				}
				%>
					</tbody>
              	  	<!--Table body-->
            		</table>
            		<!--Table-->
       				</div>
   					 </div>
					</div>
					<div class="col-md-1"></div>
		 		</div>
				<% 
				con.close();
			}
			
			//donations table display
			else if(info.equals("donation")){ 
				Class.forName("com.mysql.jdbc.Driver");
				// 1. get a connection to data base
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
				
				// 2. create a statement
				Statement st = con.createStatement();
				
				//3. execute the sql queries
				ResultSet rs = st.executeQuery("select * from donation order by dt_date");
				
				%>
				<div class="row" style="margin-top: 20px">
        			<div class="col-md-1"></div>
        			<div class="col-md-10">

            		<h3>Donation details</h3>
            			<div class="card">
                		<div class="card-body">
                    	<!--Table-->
                    	<table class="table table-hover table-responsive-md table-fixed">
                        <!--Table head-->
                        <thead>
                        <tr>
                            <th>Donor Id</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th >Amount Donated</th>
                            
                        </tr>
                        </thead>
                        <!--Table head-->
                        <!--Table body-->
                        <tbody>
				<%
				// 4. process the resultset
				while(rs.next()) {
					String dtId=rs.getString("dt_id");
					String dtDate=rs.getString("dt_date");
					String dtTime=rs.getString("dt_time");
					String dtAmount=rs.getString("dt_amount");
					
					/* String sql = "select sum(dt_amount) as pp from donation where dt_id = '"+dId+"';";
					PreparedStatement pt = con.prepareStatement(sql);
					//pt.executeUpdate(); 
					ResultSet rs1 = pt.executeQuery(sql);
					int amount = rs1.getInt("pp");
					out.print(""+amount);
					rs1.close(); */
					
					//ResultSet rsnext = stnext.executeQuery("select sum(dt_amount) as pp from donation where dt_id = 'd1';");
					//String dDonation = rsnext.getString("dt_amount");
					out.println("<tr>"+"<td>"+dtId+"</td>"+"<td>"+dtDate+"</td>"+"<td>"+dtTime+"</td>"+"<td >$"+dtAmount+"</td>"+"</tr>");
					
				}
				%>
					</tbody>
              	  	<!--Table body-->
            		</table>
            		<!--Table-->
       				</div>
   					 </div>
					</div>
					<div class="col-md-1"></div>
		 		</div>
				<% 
				con.close();
			}
			
			
			%>

    </div>

</main>
<!--Main Layout-->



<!-- SCRIPTS -->
<jsp:include page="z_scripts.jsp"></jsp:include>
</body>

</html>
    