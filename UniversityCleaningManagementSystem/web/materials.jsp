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

        .lowStock{
            color:red;
            font-weight:bold;
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

        .edit{
            background:orange;
        }

        .delete{
            background:red;
        }

        .search{
            margin-bottom:20px;
        }
        </style>
        
    </head>
    <body>
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
