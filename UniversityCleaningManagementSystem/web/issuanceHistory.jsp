<%-- 
    Document   : issuanceHistory
    Author     : Stock Issuance Module
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.StockIssuance"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Stock Issuance History</title>

        <style>
            body{
            font-family: Arial, sans-serif;
            margin:40px;
            background:#f4f4f4;
        }

        h1{
            color:#333;
        }

        table{
            width:100%;
            border-collapse:collapse;
            background:white;
        }

        table, th, td{
            border:1px solid #ccc;
        }

        th{
            background:#0d6efd;
            color:white;
            padding:12px;
        }

        td{
            padding:10px;
            text-align:center;
        }

        tr:nth-child(even){
            background:#f8f8f8;
        }

        .button{

            padding:8px 14px;
            text-decoration:none;
            border-radius:4px;
            color:white;

        }

        .add{
            background:green;
        }

        .empty{
            text-align:center;
            padding:20px;
            color:#777;
        }
        </style>

    </head>
    <body>
        <h1>Stock Issuance History</h1>

        <!--Issue Stock Button-->
        <p>
            <a href="StockIssuanceServlet?action=issue"
                class="button add">
                   Issue Stock
            </a>
        </p>

        <!--Issuance Table-->
        <table>
            <tr>
                <th>ID</th>
                <th>Material</th>
                <th>Issued To</th>
                <th>Quantity Issued</th>
                <th>Issue Date</th>
                <th>Issued By</th>
            </tr>

            <%
                List<StockIssuance> issuances = (List<StockIssuance>) request.getAttribute("issuances");

                if (issuances != null && !issuances.isEmpty()) {
                    for (StockIssuance issuance : issuances) {
            %>
            <tr>
                <td><%=issuance.getIssuanceId()%></td>
                <td><%=issuance.getMaterialName()%></td>
                <td><%=issuance.getCleanerName()%></td>
                <td><%=issuance.getQuantityIssued()%></td>
                <td><%=issuance.getIssueDate()%></td>
                <td><%=issuance.getIssuedBy() != null ? issuance.getIssuedBy() : "-"%></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6" class="empty">No stock has been issued yet.</td>
            </tr>
            <%
                }
            %>
        </table>
    </body>
</html>
