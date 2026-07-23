<%-- 
    Document   : register.jsp
    Created on : 22 Jul 2026, 16:26:34
    Author     : Tinyiko Siwele
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <style>
            body{
                font-family: Arial, sans-serif;
                background:#f4f4f4;
            }

            .container{
                width:400px;
                margin:50px auto;
                background:white;
                padding:20px;
                border-radius:8px;
                box-shadow:0px 0px 10px gray;
            }

            input, select {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                box-sizing: border-box;   /* ensures padding is included in width */
                font-size: 1em;           /* keeps text size consistent */
            }

            button{
                width:100%;
                padding:10px;
                background:#007BFF;
                color:white;
                border:none;
                cursor:pointer;
            }
           

            button:hover{
                background:#0056b3;
            }

            .error{
                color:red;
            }

            .success{
                color:green;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>User Registration</h2>
            <%
            String error=(String)request.getAttribute("errorMessage");
            if(error!=null){
            %>
            <p class="error"><%=error%></p>
            <%}%>

            <form action="RegisterServlet" method="post">
                <div class="inputs">
                <label>Full Name</label>
                <input
                type="text"
                name="fullName"
                value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>"
                required>

                <label>Username</label>
                <input
                type="text"
                name="username"
                value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"
                required>

                <label>Email</label>
                <input
                type="email"
                name="email"
                value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                required>

                <label>Password</label>
                <input
                type="password"
                name="password"
                required>

                <label>Confirm Password</label>
                <input
                type="password"
                name="confirmPassword"
                required>

                <label>Role</label>
                <select name="role">
                    <option value="Storekeeper" <%= "Storekeeper".equals(request.getAttribute("role")) ? "selected" : "" %>> Storekeeper </option>
                    <option value="Supervisor" <%= "Supervisor".equals(request.getAttribute("role")) ? "selected" : "" %>> Supervisor </option>
                </select>
                </div>

                <button type="submit"> Register </button>

            </form>
            <br>
            Already have an account?
            <a href="login.jsp">
            Login Here
            </a>
        </div>
    </body>
</html>


