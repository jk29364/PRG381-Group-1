<%-- 
    Document   : reports
    Created on : 21 Jul 2026, 15:02:33
    Author     : theart
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
</head>
<body>
    <h2>Reports</h2>

    <c:if test="${not empty inventoryReport}">
        <h3>Inventory Report</h3>
        <c:forEach var="item" items="${inventoryReport}">
            <p>${item}</p>
        </c:forEach>
    </c:if>

    <c:if test="${not empty lowStockReport}">
        <h3>Low Stock Report</h3>
        <c:forEach var="item" items="${lowStockReport}">
            <p>${item}</p>
        </c:forEach>
    </c:if>

    <c:if test="${not empty issuanceHistory}">
        <h3>Issuance History</h3>
        <c:forEach var="entry" items="${issuanceHistory}">
            <p>${entry}</p>
        </c:forEach>
    </c:if>

    <c:if test="${not empty materialUsage}">
        <h3>Material Usage</h3>
        <c:forEach var="entry" items="${materialUsage}">
            <p>${entry.key} used: ${entry.value}</p>
        </c:forEach>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <p style="color:red">${errorMessage}</p>
    </c:if>

    <p><a href="dashboard">Back to Dashboard</a></p>
</body>
</html>

