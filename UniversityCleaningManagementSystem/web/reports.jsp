<%-- 
    Document   : dashboard
    Created on : 21 Jul 2026, 15:02:24
    Author     : theart
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Reports</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
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
        
        .kpi-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }
        .card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            text-align: center;
        }
        
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
        
        .panel {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            margin-bottom: 40px;
        }
        
        .panel h3 { 
            margin: 0 0 16px; 
            font-size: 1.1em; 
            font-weight: 600; 
            color: #1e293b; 
        }
        
        table { 
            width: 100%; 
            border-collapse: collapse; 
            font-size: 0.92em; 
        }
        
        th, td { 
            padding: 10px 8px; 
            border-bottom: 1px solid #eef1f6; 
            text-align: left; 
        }
        
        th { 
            text-transform: uppercase; 
            font-size: 0.78em; 
            color: #94a3b8; 
            letter-spacing: 0.03em; 
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
      <h1>Inventory & Operations Report</h1>
      <a href="${pageContext.request.contextPath}/dashboard" class="goBack-btn">Back to Dashboard</a>
    </div>

    <div class="kpi-grid">
        <div class="card"><h2>${totalMaterials}</h2><p>Total Materials</p></div>
        <div class="card"><h2>${lowStockCount}</h2><p>Low Stock</p></div>
        <div class="card"><h2>${totalCleaners}</h2><p>Total Cleaners</p></div>
        <div class="card"><h2>${totalIssuances}</h2><p>Total Issuances</p></div>
    </div>

    <div class="panel">
        <h3>Stock Issuance Trends (Last 30 Records)</h3>
        <canvas id="issuanceChart"></canvas>
    </div>

    <div class="panel">
        <h3>Low Stock Materials</h3>
        <c:choose>
            <c:when test="${empty lowStockMaterials}">
                <div class="empty-state">All materials are sufficiently stocked.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead><tr><th>Name</th><th>Category</th><th>Quantity</th></tr></thead>
                    <tbody>
                        <c:forEach var="m" items="${lowStockMaterials}">
                            <tr><td>${m.materialName}</td><td>${m.category}</td><td>${m.quantity}</td></tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="panel">
        <h3>Recent Issuances</h3>
        <c:choose>
            <c:when test="${empty recentIssuances}">
                <div class="empty-state">No recent issuances found.</div>
            </c:when>
            <c:otherwise>
                <table>
                    <thead><tr><th>Material</th><th>Cleaner</th><th>Quantity</th><th>Issued By</th></tr></thead>
                    <tbody>
                        <c:forEach var="i" items="${recentIssuances}">
                            <tr>
                                <td>${i.materialId}</td>
                                <td>${i.cleanerId}</td>
                                <td>${i.quantityIssued}</td>
                                <td>${i.issuedBy}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        const ctx = document.getElementById('issuanceChart').getContext('2d');
        const issuanceChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [...Array(${recentIssuances.size()}).keys()].map(i => "Issuance " + (i+1)),
                datasets: [{
                    label: 'Quantity Issued',
                    data: [
                        <c:forEach var="i" items="${recentIssuances}" varStatus="status">
                            ${i.quantityIssued}<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59,130,246,0.2)',
                    fill: true
                }]
            }
        });
    </script>
</body>
</html>
