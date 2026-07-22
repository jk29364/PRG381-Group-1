<%-- 
    Document   : addMaterial
    Created on : 22 Jul 2026, 12:55:18
    Author     : Masilo Pudikabekwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Material</title>
        
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

        input{

            width:100%;
            padding:10px;
            margin-top:5px;

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
        </style>
    </head>
    
    <body>
        <div class="container">
            
            <!--Page Title-->
            <h2>Add New Material</h2>
            
            <!--Add Material Form-->
            <form action="MaterialServlet" 
                  method="post">
                
                <input
                    type="hidden"
                    name="action"
                    value="add">
            
                <!--Material Name-->
                <label>Material Name</label>
                <input
                    type="text"
                    name="materialName"
                    required>

                <!--Material Name-->
                <label>Material Name</label>
                <input
                    type="text"
                    name="materialName"
                    required>
                
                <!--Category-->
                <label>Category</label>
                <input
                    type="text"
                    name="category"
                    required>
                
                <!--Quantity-->
                <label>Quantity</label>
                <input
                    type="number"
                    name="quantity"
                    min="0"
                    required>
                
                <!--Reorder Level-->
                <label>Reorder Level</label>
                <input
                    type="number"
                    name="reorderLevel"
                    min="0"
                    required>
                
                <!--Supplier ID-->
                <label>Supplier ID</label>
                <input
                    type="number"
                    name="supplierId"
                    min="0"
                    required>
                
                <!--Submit button-->
                <button
                    class="submit"
                    type="submit">
                    
                    Save Material
                </button>

            </form>
            
            <!--Back button-->
                <button
                    class="back"
                    href="MaterialServlet">
                    
                    Back to Materials
                </button>
            
        </div>
        
    </body>
</html>
