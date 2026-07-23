<%-- 
    Document   : dashboard
    Created on : 21 Jul 2026, 15:02:24
    Author     : theart
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
    <h2>Dashboard</h2>
    <p>Total Materials: ${totalMaterials}</p>
    <p>Total Cleaners: ${totalCleaners}</p>
    <p>Total Issuances: ${totalIssuances}</p>

    <h3>Low Stock Items</h3>
    <ul>
        <c:forEach var="m" items="${lowStockItems}">
            <li>${m}</li>
        </c:forEach>
    </ul>

    <p><a href="reports?type=inventory">View Inventory Report</a></p>
    <p><a href="reports?type=lowstock">View Low Stock Report</a></p>
    <p><a href="reports?type=issuance">View Issuance History</a></p>
    <p><a href="reports?type=usage">View Material Usage</a></p>
    <p><a href="StockIssuanceServlet?action=issue">Issue Stock</a></p>
    <p><a href="StockIssuanceServlet">View Stock Issuance History</a></p>
</body>
</html>
