<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="z_head.jsp"></jsp:include>
</head>

<body>



<jsp:include page="z_navbar.jsp"></jsp:include>

<!--Main Navigation-->

<!--Main Layout-->
<main text-center py-5 style="margin-top: 70px">

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3">


                <!-- Collapse buttons -->
                <div STYLE="text-align: center">

                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-unique" data-toggle="collapse" href="#Orphan" aria-expanded="false" aria-controls="collapseExample">
                                Orphan
                            </a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-unique" data-toggle="collapse" href="#collapseExample2" aria-expanded="false" aria-controls="collapseExample">
                                Admin
                            </a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-unique" data-toggle="collapse" href="#collapseExample3" aria-expanded="false" aria-controls="collapseExample">
                                Doner
                            </a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-unique" data-toggle="collapse" href="#collapseExample6" aria-expanded="false" aria-controls="collapseExample">
                                Donation
                            </a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-unique" data-toggle="collapse" href="#collapseExample4" aria-expanded="false" aria-controls="collapseExample">
                                Update
                            </a>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-unique" data-toggle="collapse" href="#collapseExample5" aria-expanded="false" aria-controls="collapseExample">
                                Delete
                            </a>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12">
                            <a class="btn btn-indigo"  href="signin.jsp">
                                Sign out
                            </a>
                        </div>
                    </div>


                </div>
                <!-- / Collapse buttons -->


            </div>




            <div class="col-md-6">
					<!-- this is for Orphan input -->
					<%
					String ooName = request.getParameter("oName");
					String ooAddress = request.getParameter("oAddress");
					String ooDescription = request.getParameter("oDescription");
					if (ooName == null && ooAddress == null && ooDescription==null) {
					// myText is null when the page is first requested, 
					// so do nothing
					} else  if (ooName.length() == 0 || ooAddress.length()==0 || ooDescription.length()==0) {
					// There was a querystring like ?myText=
					// but no text, so myText is not null, but 
					// a zero length string instead.
					%>
					<p class="black-text" Style="text-align:center;">All fields are not filled up. Try again</p>
					<% } else { 
						//out.print(ooName+"  "+ooAddress+"  "+ooDescription);
						 Class.forName("com.mysql.jdbc.Driver");
						// 1. get a connection to data base
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
						// 2. create a statement
						Statement st = con.createStatement();
						//3. execute the sql queries
						
						String sql = "INSERT INTO orphan(o_name, o_address, o_description) VALUES(?,?,?)";
						PreparedStatement preparedStatement = con.prepareStatement(sql);
						preparedStatement.setString(1, ooName);
						preparedStatement.setString(2, ooAddress);
						preparedStatement.setString(3, ooDescription);
						// execute insert SQL stetement
						preparedStatement.executeUpdate(); 
						
						%>
						<p class="black-text" Style="text-align:center;">Orphan's information has been inserted successfully.</p>
						<%
						
						con.close(); 
					}
					
					%>
					
					
					<!-- this is for Admin input -->
					<%
					String aaId = request.getParameter("aId");
					String aaPass = request.getParameter("aPass");
					String aaName = request.getParameter("aName");
					String aaAddress = request.getParameter("aAddress");
					if (aaId == null && aaPass == null && aaName==null && aaAddress==null) {
					// myText is null when the page is first requested, 
					// so do nothing
					} else { 
					if (aaId.length() == 0 || aaPass.length()==0 || aaName.length()==0 || aaAddress.length()==0) {
					// There was a querystring like ?myText=
					// but no text, so myText is not null, but 
					// a zero length string instead.
					%>
					<p class="black-text" Style="text-align:center;">All fields are not filled up. Try again</p>
					<% } else { 
						Class.forName("com.mysql.jdbc.Driver");
						// 1. get a connection to data base
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
						// 2. create a statement
					
						//3. execute the sql queries
						String dq="select a_id from admin" ; 
						PreparedStatement ps=con.prepareStatement(dq); 
						ResultSet rs=ps.executeQuery(dq); 
						
						
						// 4. process the resultset
						boolean flag = false;
						while(rs.next()) {
							String mainId=rs.getString("a_id");
							if (aaId.equals(mainId) ){
								%>
								<p class="black-text" Style="text-align:center;">This admin user id already exists. Try with another ID..</p>
								<% 
								flag=true;
								break;
							}	
						}
						
						
						
						if(flag==false){
							
							String sql = "INSERT INTO admin (a_id, a_password, a_name, a_address) VALUES(?,?,?,?);";
							PreparedStatement preparedStatement = con.prepareStatement(sql);
							preparedStatement.setString(1, aaId);
							preparedStatement.setString(2, aaPass);
							preparedStatement.setString(3, aaName);
							preparedStatement.setString(4, aaAddress);
							// execute insert SQL stetement
							preparedStatement.executeUpdate();
							//ResultSet rs1=preparedStatement.executeQuery(sql);
							//rs1.close();
							preparedStatement.close();
							%>
							<p class="black-text" Style="text-align:center;">Admin's information has been inserted successfully.</p>
							<%
						} 
						ps.close();
						rs.close();
						
						con.close();
						
					}
					}
					%>
					
					<!-- this is for Donor input -->
					<%
					String ddId = request.getParameter("dId");
					String ddName = request.getParameter("dName");
					String ddAddress = request.getParameter("dAddress");
					String ddNumber = request.getParameter("dNumber");
					//out.print(ddId+ddName+ddAddress+ddNumber);
					if(ddId==null && ddName==null && ddAddress==null && ddNumber==null){
						//do nothing
					}
					else if(ddId.length()==0 && ddName.length()==0 && ddAddress.length()==0 && ddNumber.length()==0){
						%>
						<p class="black-text" Style="text-align:center;">All fields are not filled up. Try again</p>
						<%
					}
					else{
						
						
						Class.forName("com.mysql.jdbc.Driver");
						// 1. get a connection to data base
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
						// 2. create a statement
					
						//3. execute the sql queries
						String dq="select d_id from doner" ; 
						PreparedStatement ps=con.prepareStatement(dq); 
						ResultSet rs=ps.executeQuery(dq); 
						
						
						// 4. process the resultset
						boolean flag = false;
						while(rs.next()) {
							String mainId=rs.getString("d_id");
							if (ddId.equals(mainId) ){
								%>
								<p class="black-text" Style="text-align:center;">This admin user id already exists. Try with another ID..</p>
								<% 
								flag=true;
								break;
							}	
						}
						
						
						
						if(flag==false){
							
							String sql = "INSERT INTO doner (d_id, d_name, d_address, d_number) VALUES(?,?,?,?);";
							PreparedStatement preparedStatement = con.prepareStatement(sql);
							preparedStatement.setString(1, ddId);
							preparedStatement.setString(2, ddName);
							preparedStatement.setString(3, ddAddress);
							preparedStatement.setString(4, ddNumber);
							// execute insert SQL stetement
							preparedStatement.executeUpdate();
							//ResultSet rs1=preparedStatement.executeQuery(sql);
							//rs1.close();
							preparedStatement.close();
							%>
							<p class="black-text" Style="text-align:center;">Admin's information has been inserted successfully.</p>
							<%
						} 
						ps.close();
						rs.close();
						
						con.close();	
					}
					%>
					
					
					
						<!-- this is for Donation input -->
						<%
						String dtId = request.getParameter("dtIds");
						if(dtId==null){
							//do nothing
						}
						else if(dtId.length()==0){
							%>
							<p class="black-text" Style="text-align:center;">All fields are not filled up properly. Try again</p>
							<%
						}
						else{
							int dtAmount = Integer.parseInt(request.getParameter("dtAmounts"));
							java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
							String dates = String.valueOf(date);
							String[] parts = dates.split(" ");
						    String dtDate = parts[0];
						    String dtTime = parts[1];
							//out.print(dtId+"  "+dtAmount+ parts[0]+ "  "+ parts[1]);
							
						     Class.forName("com.mysql.jdbc.Driver");
							// 1. get a connection to data base
							Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root"); 
							
						    String sql = "INSERT INTO donation (dt_id, dt_date, dt_time, dt_amount) VALUES(?,?,?,?);";
							PreparedStatement preparedStatement = con.prepareStatement(sql);
							preparedStatement.setString(1, dtId);
							preparedStatement.setString(2, dtDate);
							preparedStatement.setString(3, dtTime);
							preparedStatement.setInt(4, dtAmount);
							
							preparedStatement.executeUpdate();
							
							preparedStatement.close();
							
							con.close(); 
							%>
							<p class="black-text" Style="text-align:center;">Donation Amount added successfully.</p>
							<%
						}
						%>
						
						<!-- this is for update for orphan table. -->
						<%
						String field="",value="",id="";
						try{
						 field = request.getParameter("update");
    					 value = request.getParameter("value");
    					 id = request.getParameter("inid");
    					 
    					if(id!=null && field!=null && value!=null){
    					try{
    						Class.forName("com.mysql.jdbc.Driver");
        					// 1. get a connection to data base
        					Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");			
        				    String sql = "update orphan set "+field+"='"+value+"' where o_id = "+id+";";
        				    //String sql = "update orphan set o_name='hellooooo' where o_id = 2;"; 
    						//String sql = "update orphan set "+field+"='"+value+"' where o_id = "+id+";";
    						//String sql = "update orphan set ? = ? where o_id = ?;";
							Statement st = con.createStatement();
							//3. execute the sql queries
							ResultSet rs = st.executeQuery("SELECT * FROM db.orphan where o_id="+id+";");
							if(rs.next()){
								PreparedStatement pt = con.prepareStatement(sql);
								pt.executeUpdate();
								%>
								<p class="black-text" Style="text-align:center;">updated successfully</p>
								<%
							}
							else{
								%>
								<p class="black-text" Style="text-align:center;">your given id not found to orphan table</p>
								<%
							}
    						
    						
    						//pt.setString(1, field);
        				   // pt.setString(2, value);
        				   // pt.setString(3, id); 
    						//ResultSet rs = pt.executeQuery(sql);
    						
    					}
    					catch(SQLException e){
    						System.err.println("SQL exception: " + e.getMessage());
    					}
    					catch(Exception e){
    						System.err.println("exception: " + e.getMessage());
    					}
    					//String sql= "select sum(dt_amount) as pp from donation where dt_id = 'd1';";
    					// rs = pt.executeQuery(sql);  			
    					}
						}
						catch(Exception e){
							System.err.println("exception: " + e.getMessage());
						}
						%>
						
						
					<!-- this is for delete -->	
					<%
                    String inputId=request.getParameter("inputId");
                    String type =request.getParameter("delete");
                    if(inputId==null && type==null){
                    	
                    }
					else if(inputId.length()==0|| type.length()==0){
                    	%>
                    	<p class="black-text" Style="text-align:center;">all fields are not checked or given values.try again.</p>
                    	<% 
                    }
                    else if(type.equals("orphan")){
                    	//out.print(type+inputId);
                    	Class.forName("com.mysql.jdbc.Driver");
        				// 1. get a connection to data base
        				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
        				// 2. create a statement
        				Statement st = con.createStatement();
        				//3. execute the sql queries
        				ResultSet rs = st.executeQuery("select o_id from orphan");
        				// 4. process the resultset
        				boolean flag= false;
        				 while(rs.next()) {
        					int mainId=rs.getInt("o_id");
        					 if (inputId.equals(String.valueOf(mainId))){
        						 String sql = "delete from orphan where o_id="+mainId+";";
        							PreparedStatement preparedStatement = con.prepareStatement(sql);
        							preparedStatement.executeUpdate();
        							flag =true;
        							%>
            						<p class="black-text" Style="text-align:center;">Successfully deleted.</p>
            						<%
        					}	
        				}
        				if(flag==false){
        					%>
    						<p class="black-text" Style="text-align:center;">didn't find your given id. try again.</p>
    						<%
        				}
        				con.close();
                    }
                    else if(type.equals("admin")){
                    	Class.forName("com.mysql.jdbc.Driver");
        				// 1. get a connection to data base
        				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
        				// 2. create a statement
        				Statement st = con.createStatement();
        				//3. execute the sql queries
        				ResultSet rs = st.executeQuery("select a_id from admin");
        				// 4. process the resultset
        				boolean flag= false;
        				  while(rs.next()) {
        					String mainId=rs.getString("a_id");
        					 if (inputId.equals(mainId)){
        						 String sql = "delete from admin where a_id='"+mainId+"';";
        						 PreparedStatement preparedStatement = con.prepareStatement(sql);
        						 preparedStatement.executeUpdate();
        						 flag =true; 
        							%>
            						<p class="black-text" Style="text-align:center;">Successfully deleted.</p> 
            						<%
            						break;
        					}	
        				}
        				if(flag==false){
        					%>
    						<!-- <p class="black-text" Style="text-align:center;">didn't find your given id. try again.</p> -->
    						<%
        				}
        				con.close();
					}
                    else if(type.equals("donor")){
                    	 //out.print(type+inputId);
                    	Class.forName("com.mysql.jdbc.Driver");
        				// 1. get a connection to data base
        				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
        				// 2. create a statement
        				Statement st = con.createStatement();
        				//3. execute the sql queries
        				ResultSet rs = st.executeQuery("select d_id from doner");
        				// 4. process the resultset
        				boolean flag= false;
        				 while(rs.next()) {
        					String mainId=rs.getString("d_id");
        					 if (inputId.equals(mainId)){
        						 String sql = "delete from doner where d_id='"+mainId+"';";
        						 PreparedStatement preparedStatement = con.prepareStatement(sql);
        						 preparedStatement.executeUpdate();
        						 flag =true;
        							%>
            						 <p class="black-text" Style="text-align:center;">Successfully deleted.</p> 
            						<%
            						break;
        					}	
        				}
        				if(flag==false){
        					%>
    						<!-- <p class="black-text" Style="text-align:center;">didn't find your given id. try again.</p> -->
    						<%
        				}
        				con.close();
					}
                    else if(type.equals("donation")){
                    	 //out.print(type+inputId);
                    	Class.forName("com.mysql.jdbc.Driver");
        				// 1. get a connection to data base
        				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/db"+"?autoReconnect=true&useSSL=false", "root", "root");
        				// 2. create a statement
        				Statement st = con.createStatement();
        				//3. execute the sql queries
        				ResultSet rs = st.executeQuery("select dt_id from donation");
        				// 4. process the resultset
        				boolean flag= false;
        				 while(rs.next()) {
        					String mainId=rs.getString("dt_id");
        					 if (inputId.equals(mainId)){
        						 String sql = "delete from donation where dt_id='"+mainId+"';";
        						 PreparedStatement preparedStatement = con.prepareStatement(sql);
        						 preparedStatement.executeUpdate();
        						 flag =true;
        							%>
            						 <p class="black-text" Style="text-align:center;">Successfully deleted.</p> 
            						<%
        					}	
        				}
        				if(flag==false){
        					%>
    						<!-- <p class="black-text" Style="text-align:center;">didn't find your given id. try again.</p> -->
    						<%
        				}
        				con.close();
					}
                    %>
						
						
						
						

                <!-- Collapsible element -->
                <div class="collapse" id="Orphan">
                    <div class="mt-3 justify">
                        <!-- Default form contact -->
                        <form action="admin.jsp" method="post">
                            <p class="h4 text-center mb-4">Orphan Data Input</p>
                            <!-- Default input email -->
                            <label  class="black-text">Name</label>
                            <input type="text"  class="form-control" name="oName">
                            <br>
                            <!-- Default input subject -->
                            <label  class="black-text">Address</label>
                            <input type="text" class="form-control" name= "oAddress">
                            <br>
                            <!-- Default textarea message -->
                            <label  class="black-text">Description</label>
                            <textarea type="text"  class="form-control" rows="3" name="oDescription"></textarea>
                            <div class="text-center mt-4">
                                <button class="btn btn-outline-warning" type="submit" aria-expanded="true">insert<i class="fa fa-paper-plane-o ml-2"></i></button>
                            </div>
                        </form>
                        <!-- Default form contact -->
                    </div>
                </div>
                <!-- / Collapsible element -->


                <!-- Collapsible element -->
                <div class="collapse" id="collapseExample2">
                    <div class="mt-3 justify">

					

                        <!-- Default form contact -->
                        <form action="admin.jsp" method="post">
                            <p class="h4 text-center mb-4">Admin</p>
                            <!-- Default input name -->
                            <label  class="black-text">ID:</label>
                            <input type="text"  class="form-control" name="aId">
                            <br>
                            <!-- Default input email -->
                            <label  class="black-text">Password</label>
                            <input type="password"  class="form-control" name="aPass">
                            <br>
                            <!-- Default input subject -->
                            <label  class="black-text">Name</label>
                            <input type="text"  class="form-control" name="aName">
                            <br>
                            <!-- Default textarea message -->
                            <label  class="black-text">Address</label>
                            <textarea type="text"  class="form-control" rows="3" name="aAddress"></textarea>
                            <div class="text-center mt-4">
                                <button class="btn btn-outline-warning" type="submit">insert<i class="fa fa-paper-plane-o ml-2"></i></button>
                            </div>
                        </form>
                        <!-- Default form contact -->

                    </div>
                </div>
                <!-- / Collapsible element -->


                <!-- Collapsible element -->
                <div class="collapse" id="collapseExample3">
                    <div class="mt-3 justify">
					
					
						
                        <!-- Default form contact -->
                        <form action="admin.jsp" method="post">
                            <p class="h4 text-center mb-4">Donor</p>

                            <!-- Default input name -->
                            <label  class="black-text">ID</label>
                            <input type="text"  class="form-control" name="dId">

                            <br>

                            <!-- Default input email -->
                            <label  class="black-text">Name</label>
                            <input type="text"  class="form-control" name="dName">

                            <br>

                            <!-- Default input subject -->
                            <label  class="black-text">Address</label>
                            <input type="text"  class="form-control" name="dAddress">

                            <br>

                            <!-- Default textarea message -->
                            <label  class="black-text">Mobile number</label>
                            <input type="text"  class="form-control" name="dNumber"></input>

                            <div class="text-center mt-4">
                                <button class="btn btn-outline-warning" type="submit">insert<i class="fa fa-paper-plane-o ml-2"></i></button>
                            </div>
                        </form>
                        <!-- Default form contact -->

                    </div>
                </div>
                <!-- / Collapsible element -->



				
                <div class="collapse" id="collapseExample6">
                    <div class="mt-3 justify">
		
						
						
                        <!-- Default form contact -->
                        <form action="admin.jsp" method="post">
                            <p class="h4 text-center mb-4">Donation</p>

                            <!-- Default input name -->
                            <label  class="black-text">Doner ID</label>
                            <input type="text"  class="form-control" name="dtIds">

                            <br>


                            <!-- Default textarea message -->
                            <label  class="black-text">Amount of Donation $</label>
                            <input type="number"  class="form-control" name ="dtAmounts"></input>

                            <div class="text-center mt-4">
                                <button class="btn btn-outline-warning" type="submit">insert<i class="fa fa-paper-plane-o ml-2"></i></button>
                            </div>
                        </form>
                        <!-- Default form contact -->

                    </div>
                </div>
                <!-- / Collapsible element -->



                <!-- Collapsible element -->
                <div class="collapse" id="collapseExample4">
                    <div class="mt-3 justify">


						
                        <!-- Default form contact -->
                        <form style="text-align: center" action="admin.jsp" method="post">

                            <p class="h4 text-center mb-4">Update orphan information</p>
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="radio" name="update" id="exampleRadios11" value="o_name">
                                <label class="form-check-label" for="exampleRadios11">
                                    update name
                                </label>
                            </div>
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="radio" name="update" id="exampleRadios22" value="o_address">
                                <label class="form-check-label" for="exampleRadios22">
                                    update address
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="update" id="exampleRadios33" value="o_description">
                                <label class="form-check-label" for="exampleRadios33">
                                    update description
                                </label>
                            </div>
                                <br>
                            <!-- Default input -->
                            <label for="exampleForm2">Give new value:</label>
                            <input type="text" class="form-control" name="value">
							<label for="exampleForm2">give valid id:</label>
                            <input type="text" class="form-control" name="inid">
                            <div class="text-center mt-4">
                                <button class="btn btn-outline-warning" type="submit">update<i class="fa fa-paper-plane-o ml-2"></i></button>
                            </div>
                        </form>
                        <!-- Default form contact -->

                    </div>
                </div>
                <!-- / Collapsible element -->



                <!-- Collapsible element -->
                <div class="collapse" id="collapseExample5">
                    <div class="mt-3 justify">

                        <form style="text-align: center" action= "admin.jsp" method="post">

                            <p class="h4 text-center mb-4">Delete</p>
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="radio" name="delete" id="exampleRadios1" value="orphan">
                                <label class="form-check-label" for="exampleRadios1">
                                    Orphan information Delete
                                </label>
                            </div>
                            <div class="form-check mb-4">
                                <input class="form-check-input" type="radio" name="delete" id="exampleRadios2" value="admin">
                                <label class="form-check-label" for="exampleRadios2">
                                    Admin information Delete
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="delete" id="exampleRadios3" value="donor">
                                <label class="form-check-label" for="exampleRadios3">
                                    Donor information Delete
                                </label>
                            </div>
                            <br>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="delete" id="exampleRadios4" value="donation">
                                <label class="form-check-label" for="exampleRadios4">
                                    Donation information Delete
                                </label>
                            </div>
                            <br>
                            <!-- Default input -->
                            <label for="exampleForm2">Give id:</label>
                            <input type="text" id="exampleForm3" class="form-control" name="inputId">

                            <div class="text-center mt-4">
                                <button class="btn btn-outline-warning" type="submit">Delete<i class="fa fa-paper-plane-o ml-2"></i></button>
                            </div>
                        </form>
                        <!-- Default form contact -->

                    </div>
                </div>
                <!-- / Collapsible element -->



            </div>
        </div>
    </div>

</main>
<!--Main Layout-->



<!-- SCRIPTS -->
<jsp:include page="z_scripts.jsp"></jsp:include>
</body>

</html>
    