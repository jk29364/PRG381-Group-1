<%-- 
    Document   : dashboard
    Created on : 21 Jul 2026, 15:02:24
    Author     : theart
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: #eef1f6;
            margin: 0;
            padding: 32px 40px;
            color: #1e293b;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        h1 {
            font-size: 1.6em;
            font-weight: 700;
            margin: 0;
            color: #1a202c;
        }

        .goBack-btn {
            text-decoration: none;
            color: #475569;
            font-size: 0.9em;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 6px;
            border: 1px solid #cbd5e1;
            background: white;
            transition: background 0.15s ease, border-color 0.15s ease;
        }

        .goBack-btn:hover {
            background: #f8fafc;
            border-color: #94a3b8;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }

        .card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            border-left: 4px solid #3b82f6;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .card.warning { border-left-color: #ef4444; }
        .card.clean { border-left-color: #82e88c; }
        
        .card h2 {
            margin: 0;
            font-size: 2.2em;
            font-weight: 700;
            color: #0f172a;
        }

        .card p {
            margin: 6px 0 0;
            color: #64748b;
            font-size: 0.9em;
            font-weight: 500;
        }

        .low-stock {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            margin-bottom: 28px;
        }

        .low-stock h3 {
            margin: 0 0 16px;
            color: #1e293b;
            font-size: 1.1em;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .low-stock h3::before {
            content: "";
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #ef4444;
            display: inline-block;
        }

        .low-stock ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .low-stock li {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 4px;
            border-bottom: 1px solid #eef1f6;
            font-size: 0.95em;
        }

        .low-stock li:last-child {
            border-bottom: none;
        }

        .tag-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .low-stock-tag {
            background: #fef2f2;
            border: 1px solid #ef4444;
            color: #ef4444;
            font-size: 0.75em;
            font-weight: 600;
            padding: 3px 10px;
            border-radius: 5px;
            text-transform: uppercase;
            letter-spacing: 0.03em;
        }

        .qty {
            color: #ef4444;
            font-weight: 600;
        }

        .panels {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
        }

        .panel h3 {
            margin: 0 0 16px;
            color: #1e293b;
            font-size: 1.1em;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.92em;
        }

        thead th {
            text-align: left;
            color: #94a3b8;
            font-weight: 600;
            font-size: 0.78em;
            text-transform: uppercase;
            letter-spacing: 0.03em;
            padding: 0 8px 10px;
            border-bottom: 1px solid #eef1f6;
        }

        tbody td {
            padding: 10px 8px;
            border-bottom: 1px solid #eef1f6;
            color: #334155;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .empty-state {
            text-align: center;
            color: #94a3b8;
            padding: 24px 0;
            font-size: 0.9em;
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <h1>Cleaning Inventory Dashboard</h1>
        <div>
            <a href="landingPage.jsp" class="goBack-btn">← Go Back</a>
        </div>
    </div>

    <div class="dashboard">
        <div class="card">
            <h2>${totalMaterials}</h2>
            <p>Total Materials</p>
        </div>
        <div class="card clean">
            <h2>${totalCleaners}</h2>
            <p>Total Cleaners</p>
        </div>
        <div class="card warning">
            <h2>${lowStockCount}</h2>
            <p>Low Stock Items</p>
        </div>
    </div>

    <div class="low-stock">
        <h3>Low Stock Materials</h3>
        <c:choose>
            <c:when test="${empty lowStockMaterials}">
                <div class="empty-state">All materials are sufficiently stocked.</div>
            </c:when>
            <c:otherwise>
                <ul>
                    <c:forEach var="m" items="${lowStockMaterials}">
                        <li>
                            <span>${m.materialName}</span>
                            <span class="tag-group">
                                <span class="low-stock-tag">Low Stock</span>
                                <span class="qty">${m.quantity}</span>
                            </span>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="panels">
        <div class="panel">
            <h3>Materials</h3>
            <c:choose>
                <c:when test="${empty allMaterials}">
                    <div class="empty-state">No materials found.</div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Quantity</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="m" items="${allMaterials}">
                                <c:if test="${m.quantity > m.reorderLevel}">
                                <tr>
                                    <td>${m.materialName}</td>
                                    <td>${m.category}</td>
                                    <td>${m.quantity}</td>
                                </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="panel">
            <h3>Cleaners</h3>
            <c:choose>
                <c:when test="${empty allCleaners}">
                    <div class="empty-state">No cleaners found.</div>
                </c:when>
                <c:otherwise>
                    <table>
                        <thead>
                            <tr>
                                <th>Name</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${allCleaners}">
                                <tr>
                                    <td>${c.name}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>