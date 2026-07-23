<%-- 
    Document   : addCleaner
    Created on : 23 Jul 2026
    Author     : Xander Oosthuyzen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Cleaner</title>
        
        <style>
            body{
            font-family:Arial, sans-serif;
            background:#f4f4f4;
            margin:40px;
        }

        .container{

            width:500px;
            margin:auto;
            background:white;
            padding:25px;
            border-radius:8px;
            box-shadow:0 0 10px rgba(0,0,0,0.2);

        }

        h2{

            text-align:center;

        }

        label{

            display:block;
            margin-top:15px;
            font-weight:bold;

        }

        input, select{

            width:100%;
            padding:10px;
            margin-top:5px;
            box-sizing:border-box;

        }

        .button{

            margin-top:20px;
            padding:12px;
            width:100%;
            border:none;
            background:#0d6efd;
            color:white;
            font-size:16px;
            cursor:pointer;

        }

        .button:hover{

            background:#0b5ed7;

        }

        .back{

            display:block;
            text-align:center;
            margin-top:15px;

        }

        .error{
            color:red;
            font-weight:bold;
            text-align:center;
        }
        </style>
    </head>
    
    <body>
        <div class="container">
            
            <!--Page Title-->
            <h2>Add New Cleaner</h2>
            
            <!--Error message-->
            <%if(request.getAttribute("errorMessage") != null){%>
                <p class="error"><%=request.getAttribute("errorMessage")%></p>
            <%}%>
            
            <!--Add Cleaner Form-->
            <form action="CleanerServlet" 
                  method="post">
                
                <input
                    type="hidden"
                    name="action"
                    value="insert">
            
                <!--First Name-->
                <label>First Name</label>
                <input
                    type="text"
                    name="firstName"
                    required>
                
                <!--Last Name-->
                <label>Last Name</label>
                <input
                    type="text"
                    name="lastName"
                    required>
                
                <!--Contact Number-->
                <label>Contact Number</label>
                <input
                    type="text"
                    name="contactNumber">
                
                <!--Email-->
                <label>Email</label>
                <input
                    type="email"
                    name="email">
                
                <!--Department-->
                <label>Department (optional)</label>
                <input
                    type="text"
                    name="department">
                
                <!--Submit button-->
                <button
                    class="submit"
                    type="submit">
                    
                    Save Cleaner
                </button>

            </form>
            
            <!--Back button-->
            <form action="CleanerServlet" method="get">
                <button
                    class="back button"
                    type="submit">
                    
                    Back to Cleaners
                </button>
            </form>
            
        </div>
        
    </body>
</html>
