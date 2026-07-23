<%-- 
    Document   : issueStock
    Author     : Stock Issuance Module
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Material"%>
<%@page import="model.Cleaner"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Issue Stock</title>

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

            background:#f8d7da;
            color:#842029;
            padding:10px;
            border-radius:4px;
            margin-top:15px;
            text-align:center;

        }
        </style>
    </head>

    <body>
        <div class="container">

            <!--Page Title-->
            <h2>Issue Stock</h2>

            <!--Error message-->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
            <div class="error"><%=errorMessage%></div>
            <%
                }
            %>

            <!--Issue Stock Form-->
            <form action="StockIssuanceServlet"
                  method="post">

                <input
                    type="hidden"
                    name="action"
                    value="issue">

                <!--Material-->
                <label>Material</label>
                <select name="materialId" required>
                    <option value="">-- Select Material --</option>
                    <%
                        List<Material> materials = (List<Material>) request.getAttribute("materials");
                        if (materials != null) {
                            for (Material material : materials) {
                    %>
                    <option value="<%=material.getMaterialId()%>">
                        <%=material.getMaterialName()%> (<%=material.getQuantity()%> available)
                    </option>
                    <%
                            }
                        }
                    %>
                </select>

                <!--Cleaner-->
                <label>Issue To (Cleaner)</label>
                <select name="cleanerId" required>
                    <option value="">-- Select Cleaner --</option>
                    <%
                        List<Cleaner> cleaners = (List<Cleaner>) request.getAttribute("cleaners");
                        if (cleaners != null) {
                            for (Cleaner cleaner : cleaners) {
                    %>
                    <option value="<%=cleaner.getCleanerId()%>">
                        <%=cleaner.getFullName()%>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>

                <!--Quantity-->
                <label>Quantity to Issue</label>
                <input
                    type="number"
                    name="quantity"
                    min="1"
                    required>

                <!--Issued By-->
                <label>Issued By</label>
                <input
                    type="text"
                    name="issuedBy"
                    placeholder="Storekeeper name">

                <!--Submit button-->
                <button
                    class="button"
                    type="submit">

                    Issue Stock
                </button>

            </form>

            <!--Back button-->
            <a class="back"
                href="StockIssuanceServlet">

                View Issuance History
            </a>

        </div>

    </body>
</html>
