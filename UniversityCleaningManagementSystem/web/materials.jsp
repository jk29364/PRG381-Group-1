<%-- 
    Document   : materials
    Created on : 22 Jul 2026, 12:14:43
    Author     : Masilo Pudikabekwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Material"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Material Management</title>
        
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

            .search {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-bottom: 16px;
            }

            .search input[type="text"] {
                padding: 8px 12px;
                border: 1px solid #E2E8F0;
                border-radius: 8px;
                font-size: 0.875rem;
                font-family: inherit;
                color: #0F172A;
                background: #FFFFFF;
                width: 280px;
                outline: none;
                transition: all 0.15s ease-in-out;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04) inset;
            }

            .search input[type="text"]:hover { border-color: #CBD5E1; }
            .search input[type="text"]:focus {
                border-color: #2563EB;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
            }
            .search input[type="text"]::placeholder { color: #CBD5E1; }

            .search input[type="submit"] {
                padding: 8px 16px;
                border: 1px solid #E2E8F0;
                border-radius: 8px;
                background: #FFFFFF;
                color: #374151;
                font-family: inherit;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.15s ease-in-out;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
            }

            .search input[type="submit"]:hover {
                background: #F1F5F9;
                border-color: #CBD5E1;
                color: #0F172A;
            }

            .search input[type="submit"]:focus-visible {
                outline: 2px solid #2563EB;
                outline-offset: 2px;
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

            .edit {
                background: #FFFFFF;
                color: #374151;
                border: 1px solid #E2E8F0;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
            }
            .edit:hover {
                background: #F8FAFC;
                border-color: #CBD5E1;
                color: #0F172A;
                transform: translateY(-1px);
            }
            .edit:active { transform: translateY(0); }

            .delete {
                background: #FFFFFF;
                color: #DC2626;
                border: 1px solid #FECACA;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
            }
            .delete:hover {
                background: #FEF2F2;
                border-color: #FCA5A5;
                transform: translateY(-1px);
            }
            .delete:active { transform: translateY(0); }

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

            .lowStock {
                display: inline-flex;
                align-items: center;
                gap: 5px;
                padding: 2px 9px;
                background: #FEF2F2;
                color: #B91C1C;
                font-size: 0.72rem;
                font-weight: 600;
                letter-spacing: 0.04em;
                text-transform: uppercase;
                border-radius: 100px;
                border: 1px solid #FECACA;
            }

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

            td:last-child { white-space: nowrap; }
            td:last-child a { margin: 0 2px; }

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
        
        <h1>Materials Management</h1>
        
        <!--Search form-->
        <form 
            class="search"
            action="MaterialServlet"
            method="get">
                
            <input
                type="hidden"
                name="action"
                value="search">
            
            <input
                type="text"
                name="keyword"
                placeholder="Search Material">
            
            <input
                type="submit"
                value="Search">
        </form>
        
        <!--Add Button-->
        <p>
            <a href="addMaterial.jsp"
                class="button add">
                   Add Material
            </a>
        </p>
        
        <!--Material Table-->
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Quantity</th>
                <th>Reorder Level</th>
                <th>Supplier ID</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            
            <%
                List<Material> materials = (List<Material>) request.getAttribute("materials");
                
                if(materials != null){
                    for(Material material : materials){
            %>
            <tr>
                <td><%=material.getMaterialId()%></td>
                <td><%=material.getMaterialName()%></td>
                <td><%=material.getCategory()%></td>
                <td><%=material.getQuantity()%></td>
                <td><%=material.getReorderLevel()%></td>
                <td><%=material.getSupplierId()%></td>
                <td>
                    <%if(material.isLowStock()) {%>
                    
                        <span class="lowStock">
                            LOW STOCK
                        </span>
                    
                    <%}else{%>
                        Available
                    <%}%>
                </td>
                <td>
                    <a class="button edit" 
                        href="MaterialServlet?action=edit&id=<%=material.getMaterialId()%>">
                        Edit   
                    </a>
                    &nbsp;
                    <a class="button delete" 
                       onclick="return confirm('Delete this material?');"
                       href="MaterialServlet?action=delete&id=<%=material.getMaterialId()%>">
                       Delete   
                    </a>
                </td>
            </tr>
            <%
                }
                }
            %>
        </table> 
    </body>
</html>
