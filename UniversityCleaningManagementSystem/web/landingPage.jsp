<%-- 
    Document   : navigation
    Created on : 24 Jul 2026
    Author     : theart
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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

        html, body {
            height: 100%;
        }

        body {
            font-family: 'Inter', Arial, sans-serif;
            background: #F8FAFC;
            margin: 0;
            padding: 0;
            color: #0F172A;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            -webkit-font-smoothing: antialiased;
            line-height: 1.5;
        }

        .page {
            flex: 1 0 auto;
            max-width: 1180px;
            width: 100%;
            margin: 0 auto;
            padding: 32px 40px 0;
        }

        /* ---------- Top bar ---------- */

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 24px;
        }

        h1 {
            font-size: 1.5em;
            font-weight: 700;
            letter-spacing: -0.02em;
            color: #0F172A;
        }

        .top-bar .meta {
            margin: 5px 0 0;
            color: #64748B;
            font-size: 0.875em;
            font-weight: 500;
        }

        .top-bar-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .staff-pill {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 12px 6px 6px;
            background: #FFFFFF;
            border: 1px solid #E2E8F0;
            border-radius: 100px;
            font-size: 0.8125em;
            font-weight: 500;
            color: #374151;
            box-shadow: 0 1px 2px rgba(0,0,0,0.04);
        }

        .staff-pill .avatar {
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: #0F172A;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75em;
            font-weight: 600;
        }

        .goBack-btn {
            text-decoration: none;
            color: #475569;
            font-size: 0.875em;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            border: 1px solid #E2E8F0;
            background: white;
            transition: all 0.15s ease-in-out;
            box-shadow: 0 1px 2px rgba(0,0,0,0.04);
        }

        .goBack-btn:hover {
            background: #F8FAFC;
            border-color: #CBD5E1;
            color: #0F172A;
        }

        /* ---------- Notice banner ---------- */

        .notice {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 13px 18px;
            background: #FFFBEB;
            border: 1px solid #FDE68A;
            border-radius: 10px;
            margin-bottom: 28px;
            font-size: 0.875em;
        }

        .notice .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #D97706;
            flex-shrink: 0;
        }

        .notice strong {
            color: #92400E;
            font-weight: 600;
        }

        .notice span.msg {
            color: #78350F;
        }

        .notice a {
            margin-left: auto;
            color: #92400E;
            font-weight: 600;
            text-decoration: none;
            white-space: nowrap;
            padding-left: 16px;
        }

        .notice a:hover { text-decoration: underline; }

        /* ---------- Stats row ---------- */

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: #FFFFFF;
            border: 1px solid #E2E8F0;
            border-radius: 12px;
            padding: 18px 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 4px 12px rgba(0,0,0,0.03);
        }

        .stat-card .label {
            font-size: 0.72em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: #94A3B8;
            margin-bottom: 8px;
        }

        .stat-card .value {
            font-size: 1.6em;
            font-weight: 700;
            color: #0F172A;
            letter-spacing: -0.02em;
        }

        .stat-card .delta {
            margin-top: 4px;
            font-size: 0.78em;
            font-weight: 600;
        }

        .stat-card .delta.up { color: #059669; }
        .stat-card .delta.down { color: #DC2626; }
        .stat-card .delta.flat { color: #94A3B8; }

        /* ---------- Sections ---------- */

        .section {
            margin-bottom: 32px;
        }

        .section-head {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            margin-bottom: 14px;
        }

        .section h3 {
            color: #94A3B8;
            font-size: 0.78em;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .section-head .hint {
            font-size: 0.78em;
            color: #CBD5E1;
            font-weight: 500;
        }

        .section-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .nav-card {
            display: block;
            background: white;
            padding: 20px 22px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 4px 12px rgba(0,0,0,0.03);
            border: 1px solid #E2E8F0;
            border-left: 3px solid #2563EB;
            text-decoration: none;
            color: inherit;
            transition: transform 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
            position: relative;
        }

        .nav-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .nav-card.warning { border-left-color: #D97706; }
        .nav-card.admin { border-left-color: #7C3AED; }
        .nav-card.clean { border-left-color: #059669; }
        .nav-card.disabled {
            opacity: 0.55;
            cursor: default;
            pointer-events: none;
        }

        .nav-card h2 {
            font-size: 1em;
            font-weight: 700;
            color: #0F172A;
        }

        .nav-card p {
            margin: 6px 0 0;
            color: #64748B;
            font-size: 0.83em;
            font-weight: 500;
        }

        .badge-soon {
            position: absolute;
            top: 16px;
            right: 16px;
            font-size: 0.65em;
            font-weight: 700;
            letter-spacing: 0.04em;
            text-transform: uppercase;
            color: #94A3B8;
            background: #F1F5F9;
            border: 1px solid #E2E8F0;
            padding: 2px 8px;
            border-radius: 100px;
        }

        /* ---------- Guidelines panel ---------- */

        .guidelines {
            background: #FFFFFF;
            border: 1px solid #E2E8F0;
            border-radius: 12px;
            padding: 22px 26px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05), 0 4px 12px rgba(0,0,0,0.03);
        }

        .guidelines-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px 32px;
        }

        .guidelines ul {
            list-style: none;
        }

        .guidelines li {
            display: flex;
            gap: 10px;
            font-size: 0.875em;
            color: #374151;
            padding: 7px 0;
        }

        .guidelines li::before {
            content: "✓";
            color: #059669;
            font-weight: 700;
            flex-shrink: 0;
        }

        /* ---------- Footer ---------- */

        .footer {
            background: white;
            color: #1e293b;
            padding: 40px;
            margin-top: 48px;
            width: 100%;
            border-top: 1px solid #E2E8F0;
            box-shadow: 0 -1px 3px rgba(0,0,0,0.04);
            flex-shrink: 0;
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
            color: #2563EB;
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
            color: #2563EB;
        }

        .status-ok {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .status-ok::before {
            content: "";
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: #059669;
        }

        .footer-bottom {
            border-top: 1px solid #F1F5F9;
            max-width: 1080px;
            margin: 0 auto;
            padding-top: 20px;
            text-align: center;
            font-size: 0.85em;
            color: #94a3b8;
        }

        @media (max-width: 1000px) {
            .stats-grid, .section-grid { grid-template-columns: repeat(2, 1fr); }
            .footer-grid { grid-template-columns: repeat(2, 1fr); }
            .guidelines-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 640px) {
            .page { padding: 24px 20px 0; }
            .stats-grid, .section-grid, .footer-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="page">

    <div class="top-bar">
        <div>
            <h1>Cleaning Inventory &amp; Issuance System</h1>
            <p class="meta"><%= new SimpleDateFormat("EEEE, d MMMM yyyy").format(new Date()) %> &middot; Facilities Management Portal</p>
        </div>
        <div class="top-bar-right">
            <div class="staff-pill">
                <span class="avatar">S</span>
                Staff Session
            </div>
            <a href="login.jsp" class="goBack-btn">Sign Out</a>
        </div>
    </div>

    <div class="section">
        <div class="section-head">
            <h3>Overview</h3>
        </div>
        <div class="section-grid">
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-card">
                <h2>Dashboard</h2>
                <p>Summary stats and recent activity</p>
            </a>
        </div>
    </div>

    <div class="section">
        <div class="section-head">
            <h3>Inventory</h3>
        </div>
        <div class="section-grid">
            <a href="${pageContext.request.contextPath}/MaterialServlet" class="nav-card">
                <h2>Materials</h2>
                <p>View and manage cleaning materials</p>
            </a>
            <a href="${pageContext.request.contextPath}/StockIssuanceServlet" class="nav-card warning">
                <h2>Issuance History</h2>
                <p>View past stock issuances</p>
            </a>
            <a href="#" class="nav-card">
                <h2>Suppliers</h2>
                <p>Manage supplier contacts and orders</p>
            </a>
        </div>
    </div>

    <div class="section">
        <div class="section-head">
            <h3>Staff</h3>
        </div>
        <div class="section-grid">
            <a href="cleaners.jsp" class="nav-card clean">
                <h2>Cleaners</h2>
                <p>View and manage cleaner records</p>
            </a>
        </div>
    </div>

    <div class="section">
        <div class="section-head">
            <h3>Administration</h3>
            <span class="hint">Restricted to admin accounts</span>
        </div>
        <div class="section-grid">
            <a href="${pageContext.request.contextPath}/reports" class="nav-card admin">
                <h2>Reports</h2>
                <p>Export usage and stock reports</p>
            </a>
        </div>
    </div>

    <div class="section">
        <div class="section-head">
            <h3>Staff Guidelines</h3>
        </div>
        <div class="guidelines">
            <div class="guidelines-grid">
                <ul>
                    <li>Report materials below reorder level via the Materials module the same day they're noticed.</li>
                    <li>Confirm a cleaner's identity before issuing any stock against their record.</li>
                    <li>Log every issuance immediately — do not batch entries at end of shift.</li>
                </ul>
                <ul>
                    <li>Store cleaning chemicals according to the safety data sheet for that product.</li>
                    <li>Escalate discrepancies in stock counts to your supervisor before adjusting records.</li>
                    <li>Contact Facilities IT for account access or password resets.</li>
                </ul>
            </div>
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
                <p class="status-ok">All systems operational</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 University Facilities Management. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>
