<%-- 
    Document   : login
    Created on : 22 Jul 2026, 16:13:13
    Author     : Tinyiko Siwele
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <style>
            body{
                font-family:Arial;
                background:#f4f4f4;
            }

            .container{
                width:350px;
                margin:80px auto;
                background:white;
                padding:20px;
                border-radius:8px;
                box-shadow:0px 0px 10px gray;
            }

            input{
                width:100%;
                padding:10px;
                margin:10px 0;
            }

            button{
                width:100%;
                padding:10px;
                background:#28a745;
                color:white;
                border:none;
            }

            button:hover{
                background:#218838;
            }

            .error{
                color:red;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h2>Login</h2>
            <%
            String error=(String)request.getAttribute("errorMessage");
            if(error!=null){
            %>
            <p class="error">
            <%=error%>
            </p>
            <%}%>
            <form action="LoginServlet" method="post">

                <label>Username</label>
                <input
                type="text"
                name="username"
                required>

                <label>Password</label>
                <input
                type="password"
                name="password"
                required>
                
                <button type="submit"> Login </button>
            </form>
            <br>
            Don't have an account?
            <a href="register.jsp">
            Register Here
            </a>
        </div>
    </body>
</html>


