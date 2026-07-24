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
            *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

            body {
                font-family: "Inter", system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: #F8FAFC;
                min-height: 100vh;
                padding: 40px 48px 64px;
                color: #0F172A;
                -webkit-font-smoothing: antialiased;
                line-height: 1.5;
            }

            h1 {
                font-size: 1.375rem;
                font-weight: 600;
                letter-spacing: -0.02em;
                color: #0F172A;
                margin-bottom: 24px;
            }

            p { margin-bottom: 16px; }

            .button {
                display: inline-block;
                padding: 7px 14px;
                text-decoration: none;
                border-radius: 7px;
                font-family: inherit;
                font-size: 0.8125rem;
                font-weight: 500;
                color: #FFFFFF;
                letter-spacing: 0em;
                transition: all 0.15s ease-in-out;
                white-space: nowrap;
                border: none;
                cursor: pointer;
            }

            .button:focus-visible {
                outline: 2px solid #2563EB;
                outline-offset: 2px;
            }

            .add {
                background: #0F172A;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.08);
            }
            .add:hover {
                background: #1E293B;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.14);
                transform: translateY(-1px);
            }
            .add:active { transform: translateY(0); box-shadow: none; }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #FFFFFF;
                border-radius: 12px;
                overflow: hidden;
                box-shadow:
                    0 1px 3px rgba(0, 0, 0, 0.05),
                    0 4px 12px rgba(0, 0, 0, 0.03);
                border: 1px solid #E2E8F0;
            }

            table, th, td { border: none; }

            th {
                background: #F8FAFC;
                color: #64748B;
                padding: 11px 16px;
                font-size: 0.75rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                text-transform: uppercase;
                text-align: center;
                white-space: nowrap;
                border-bottom: 1px solid #E2E8F0;
            }

            th:first-child { text-align: left; padding-left: 20px; }

            td {
                padding: 11px 16px;
                text-align: center;
                font-size: 0.875rem;
                color: #374151;
                border-bottom: 1px solid #F1F5F9;
            }

            td:first-child {
                text-align: left;
                padding-left: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                color: #94A3B8;
            }

            tbody tr { transition: background 0.12s ease-in-out; }
            tbody tr:hover { background: #F8FAFC; }
            tbody tr:last-child td { border-bottom: none; }
            tr:nth-child(even) { background: #FAFBFD; }
            tr:nth-child(even):hover { background: #F8FAFC; }

            .empty {
                text-align: center;
                padding: 32px 16px;
                color: #94A3B8;
                font-size: 0.875rem;
            }
            .empty:hover { background: #FFFFFF; }

            .back-dashboard {
                display: inline-block;
                margin-bottom: 20px;
                padding: 8px 16px;
                background: #2563EB;
                color: #FFFFFF;
                text-decoration: none;
                border-radius: 8px;
                font-size: 0.875rem;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .back-dashboard:hover {
                background: #1D4ED8;
                transform: translateY(-1px);
            }

            @media (max-width: 900px) {
                body { padding: 24px 16px; }
                table { display: block; overflow-x: auto; -webkit-overflow-scrolling: touch; }
            }
        </style>
    </head>
    <body>

        <a href="landingPage.jsp" class="back-dashboard">
        ← Back to Menu
        </a>

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
