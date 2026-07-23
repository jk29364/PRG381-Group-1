<%-- 
    Document   : navigation
    Created on : 24 Jul 2026
    Author     : theart
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Navigation</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { 
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: #eef1f6;
            margin: 0;
            padding: 0;
            color: #1e293b;
        }

        .page {
            padding: 32px 40px 0;
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

        .top-bar p {
            margin: 4px 0 0;
            color: #64748b;
            font-size: 0.9em;
            font-weight: 500;
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

        .section {
            margin-bottom: 28px;
        }

        .section h3 {
            margin: 0 0 14px;
            color: #94a3b8;
            font-size: 0.78em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .section-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .nav-card {
            display: block;
            background: white;
            padding: 22px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            border-left: 4px solid #3b82f6;
            text-decoration: none;
            color: inherit;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .nav-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .nav-card.warning { border-left-color: #ef4444; }
        .nav-card.dash { border-left-color: #be82e8; }
        .nav-card.clean { border-left-color: #82e88c; }

        .nav-card h2 {
            margin: 0;
            font-size: 1.05em;
            font-weight: 700;
            color: #0f172a;
        }

        .nav-card p {
            margin: 6px 0 0;
            color: #64748b;
            font-size: 0.85em;
            font-weight: 500;
        }
        
        .footer {
            background: white;
            color: #1e293b;
            padding: 40px;
            margin-top: 64px;
            width: 100%;
            border-top: 1px solid #e2e8f0;
            box-shadow: 0 -1px 3px rgba(0,0,0,0.04);
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 40px;
            max-width: 1080px;
            margin: 0 auto 30px;
        }

        .footer-col h4 {
            margin-bottom: 12px;
            font-size: 0.78em;
            font-weight: 600;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .footer-col p, .footer-col li {
            font-size: 0.88em;
            line-height: 1.6;
            color: #64748b;
        }

        .footer-col ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-col ul li::before {
            content: "• ";
            color: #3b82f6;
            font-weight: bold;
        }

        .footer-col ul li {
            margin-bottom: 8px;
        }

        .footer-col a {
            color: #64748b;
            text-decoration: none;
            transition: color 0.15s ease;
        }

        .footer-col a:hover {
            color: #3b82f6;
        }

        .footer-bottom {
            border-top: 1px solid #eef1f6;
            max-width: 1080px;
            margin: 0 auto;
            padding-top: 20px;
            text-align: center;
            font-size: 0.85em;
            color: #94a3b8;
        }

    </style>
</head>
<body>
    <div class="page">
    <div class="top-bar">
        <div>
            <h1>Cleaning Inventory &amp; Issuance System</h1>
            <p>Choose where you'd like to go.</p>
        </div>
        <a href="login.jsp" class="goBack-btn">Sign Out</a>
    </div>

    <div class="section">
        <h3>Overview</h3>
        <div class="section-grid">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-card dash">
                <h2>Dashboard</h2>
                <p>Summary stats and recent activity</p>
            </a>
        </div>
    </div>

    <div class="section">
        <h3>Materials</h3>
        <div class="section-grid">
            <a href="${pageContext.request.contextPath}/MaterialServlet" class="nav-card">
                <h2>Materials</h2>
                <p>View and manage cleaning materials</p>
            </a>
            <a href="addMaterial.jsp" class="nav-card">
                <h2>Add Material</h2>
                <p>Register a new material into stock</p>
            </a>
            <a href="editMaterial.jsp" class="nav-card">
                <h2>Edit Material</h2>
                <p>Update details for an existing material</p>
            </a>
        </div>
    </div>

    <div class="section">
        <h3>Cleaners</h3>
        <div class="section-grid">
            <a href="cleaners.jsp" class="nav-card clean">
                <h2>Cleaners</h2>
                <p>View and manage cleaner records</p>
            </a>
            <a href="addCleaner.jsp" class="nav-card clean">
                <h2>Add Cleaner</h2>
                <p>Register a new cleaner</p>
            </a>
            <a href="editCleaner.jsp" class="nav-card clean">
                <h2>Edit Cleaner</h2>
                <p>Update details for an existing cleaner</p>
            </a>
        </div>
    </div>

    <div class="section">
        <h3>Stock Issuance</h3>
        <div class="section-grid">
            <a href="issueStock.jsp" class="nav-card warning">
                <h2>Issue Stock</h2>
                <p>Issue materials to a cleaner</p>
            </a>
            <a href="${pageContext.request.contextPath}/StockIssuanceServlet" class="nav-card warning">
                <h2>Issuance History</h2>
                <p>View past stock issuances</p>
            </a>
        </div>
    </div>
    </div>

    <footer class="footer">
        <div class="footer-grid">
            <div class="footer-col">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/MaterialServlet">Materials</a></li>
                    <li><a href="cleaners.jsp">Cleaners</a></li>
                    <li><a href="${pageContext.request.contextPath}/StockIssuanceServlet">Issuance History</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Support</h4>
                <p>Helpdesk: support@universitycleaning.com</p>
                <p>Phone: +27 11 325 7783</p>
                <p>Hours: Mon–Fri, 08:00–16:30</p>
            </div>
            <div class="footer-col">
                <h4>System</h4>
                <p>Cleaning Inventory &amp; Issuance System</p>
                <p>Version 1.0.0</p>
                <p>Environment: Overview & Monitoring</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 University Facilities Management. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
