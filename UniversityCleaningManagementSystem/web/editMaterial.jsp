<%-- 
    Document   : editMaterial
    Created on : 22 Jul 2026, 13:17:20
    Author     : Masilo Pudikabekwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Material"%>

<%Material material = (Material) request.getAttribute("material");%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Material</title>
        
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

        input{

            width:100%;
            padding:10px;
            margin-top:5px;

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
            
        </style>
    </head>
    <body>
        <div>
            <!--Page Title-->
            <h2>Edit Material</h2>

            <!--Update Form-->
            <form action="MaterialServlet" method="post">
                
                <input
                    type="hidden"
                    name="action"
                    value="update">
            
                <!--Material Id-->
                <label>Material ID</label>
                <input
                    type="hidden"
                    name="materialId"
                    value="<%=material.getMaterialId()%>">
                
                <!--Material Name-->
                <label>Material Name</label>
                <input
                    type="text"
                    name="materialName"
                    value="<%=material.getMaterialName()%>">
                
                <!--Category-->
                <label>Category</label>
                <input
                    type="text"
                    name="category"
                    value="<%=material.getCategory()%>">
                
                <!--Quantity-->
                <label>Quantity</label>
                <input
                    type="number"
                    name="quantity"
                    value="<%=material.getQuantity()%>"
                    min="0"
                    required>
                
                <!--Reorder Level-->
                <label>Reorder Level</label>
                <input
                    type="number"
                    name="reorderLevel"
                    value="<%=material.getReorderLevel()%>"
                    min="0"
                    required>
                
                <!--Supplier ID-->
                <label>Supplier ID</label>
                <input
                    type="number"
                    name="supplierId"
                    value="<%=material.getSupplierId()%>"
                    min="1"
                    required>
                
                <!--Submit button-->
                <button
                    class="submit"
                    type="submit">
                    
                    Update Material
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
