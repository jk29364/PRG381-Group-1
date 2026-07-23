<%-- 
    Document   : cleaners
    Created on : 23 Jul 2026
    Author     : Xander Oosthuyzen
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Cleaner"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cleaner Management</title>
        
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

        .inactive{
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

        .error{
            color:red;
            font-weight:bold;
        }
        </style>
        
    </head>
    <body>
        <h1>Cleaner Management</h1>
        
        <!--Error message-->
        <%if(request.getAttribute("errorMessage") != null){%>
            <p class="error"><%=request.getAttribute("errorMessage")%></p>
        <%}%>
        
        <!--Search form-->
        <form 
            class="search"
            action="CleanerServlet"
            method="get">
                
            <input
                type="hidden"
                name="action"
                value="search">
            
            <input
                type="text"
                name="keyword"
                value="<%=request.getAttribute("keyword") != null ? request.getAttribute("keyword") : ""%>"
                placeholder="Search Cleaner">
            
            <input
                type="text"
                name="department"
                value="<%=request.getAttribute("department") != null ? request.getAttribute("department") : ""%>"
                placeholder="Department">
            
            <select name="status">
                <option value="">All Statuses</option>
                <option value="Active">Active</option>
                <option value="Inactive">Inactive</option>
            </select>
            
            <input
                type="submit"
                value="Search">
        </form>
        
        <!--Add Button-->
        <p>
            <a href="addCleaner.jsp"
                class="button add">
                   Add Cleaner
            </a>
        </p>
        
        <!--Cleaner Table-->
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Contact Number</th>
                <th>Email</th>
                <th>Department</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            
            <%
                List<Cleaner> cleaners = (List<Cleaner>) request.getAttribute("cleaners");
                
                if(cleaners != null){
                    for(Cleaner cleaner : cleaners){
            %>
            <tr>
                <td><%=cleaner.getCleanerId()%></td>
                <td><%=cleaner.getFullName()%></td>
                <td><%=cleaner.getContactNumber()%></td>
                <td><%=cleaner.getEmail()%></td>
                <td><%=cleaner.getDepartment()%></td>
                <td>
                    <%if("Inactive".equalsIgnoreCase(cleaner.getStatus())) {%>
                    
                        <span class="inactive">
                            INACTIVE
                        </span>
                    
                    <%}else{%>
                        Active
                    <%}%>
                </td>
                <td>
                    <a class="button edit" 
                        href="CleanerServlet?action=edit&id=<%=cleaner.getCleanerId()%>">
                        Edit   
                    </a>
                    &nbsp;
                    <a class="button delete" 
                       onclick="return confirm('Delete this cleaner?');"
                       href="CleanerServlet?action=delete&id=<%=cleaner.getCleanerId()%>">
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
