<%-- 
    Document   : editCleaner
    Created on : 23 Jul 2026
    Author     : Xander Oosthuyzen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Cleaner"%>

<%Cleaner cleaner = (Cleaner) request.getAttribute("cleaner");%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Cleaner</title>
        
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
            box-shadow:0px 0px 10px #999;

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

            width:100%;
            margin-top:20px;
            padding:12px;
            background:#0d6efd;
            color:white;
            border:none;
            cursor:pointer;
            font-size:16px;

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
            <h2>Edit Cleaner</h2>

            <!--Error message-->
            <%if(request.getAttribute("errorMessage") != null){%>
                <p class="error"><%=request.getAttribute("errorMessage")%></p>
            <%}%>

            <!--Update Form-->
            <form action="CleanerServlet" method="post">
                
                <input
                    type="hidden"
                    name="action"
                    value="update">
            
                <!--Cleaner Id-->
                <input
                    type="hidden"
                    name="cleanerId"
                    value="<%=cleaner.getCleanerId()%>">
                
                <!--First Name-->
                <label>First Name</label>
                <input
                    type="text"
                    name="firstName"
                    value="<%=cleaner.getFirstName()%>"
                    required>
                
                <!--Last Name-->
                <label>Last Name</label>
                <input
                    type="text"
                    name="lastName"
                    value="<%=cleaner.getLastName()%>"
                    required>
                
                <!--Contact Number-->
                <label>Contact Number</label>
                <input
                    type="text"
                    name="contactNumber"
                    value="<%=cleaner.getContactNumber() != null ? cleaner.getContactNumber() : ""%>">
                
                <!--Email-->
                <label>Email</label>
                <input
                    type="email"
                    name="email"
                    value="<%=cleaner.getEmail() != null ? cleaner.getEmail() : ""%>">
                
                <!--Department-->
                <label>Department (optional)</label>
                <input
                    type="text"
                    name="department"
                    value="<%=cleaner.getDepartment() != null ? cleaner.getDepartment() : ""%>">
                
                <!--Status-->
                <label>Status</label>
                <select name="status">
                    <option value="Active" <%="Active".equalsIgnoreCase(cleaner.getStatus()) ? "selected" : ""%>>Active</option>
                    <option value="Inactive" <%="Inactive".equalsIgnoreCase(cleaner.getStatus()) ? "selected" : ""%>>Inactive</option>
                </select>
                
                <!--Submit button-->
                <button
                    class="submit"
                    type="submit">
                    
                    Update Cleaner
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
