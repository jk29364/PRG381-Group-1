<%-- 
    Document   : addMaterial
    Created on : 22 Jul 2026, 12:55:18
    Author     : Masilo Pudikabekwa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Material</title>
        
        <style>
            *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

            body {
                font-family: "Inter", system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: #F8FAFC;
                min-height: 100vh;
                display: flex;
                align-items: flex-start;
                justify-content: center;
                padding: 52px 16px 64px;
                color: #0F172A;
                -webkit-font-smoothing: antialiased;
                line-height: 1.5;
            }

            .container {
                width: 100%;
                max-width: 500px;
                background: #FFFFFF;
                padding: 32px 36px 36px;
                border-radius: 12px;
                box-shadow:
                    0 1px 3px rgba(0, 0, 0, 0.05),
                    0 4px 12px rgba(0, 0, 0, 0.03);
                border: 1px solid #E2E8F0;
            }

            h2 {
                text-align: center;
                font-size: 1.125rem;
                font-weight: 600;
                letter-spacing: -0.01em;
                color: #0F172A;
                margin-bottom: 24px;
                padding-bottom: 20px;
                border-bottom: 1px solid #F1F5F9;
            }

            label {
                display: block;
                margin-top: 18px;
                margin-bottom: 6px;
                font-size: 0.8125rem;
                font-weight: 500;
                color: #374151;
                letter-spacing: 0em;
            }

            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 9px 12px;
                border: 1px solid #E2E8F0;
                border-radius: 8px;
                font-size: 0.9rem;
                font-family: inherit;
                color: #0F172A;
                background: #FFFFFF;
                transition: all 0.15s ease-in-out;
                outline: none;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04) inset;
            }

            input[type="text"]:hover,
            input[type="number"]:hover {
                border-color: #CBD5E1;
            }

            input[type="text"]:focus,
            input[type="number"]:focus {
                border-color: #2563EB;
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.10);
            }

            input[type="text"]::placeholder {
                color: #CBD5E1;
            }

            .submit {
                display: block;
                width: 100%;
                margin-top: 24px;
                padding: 10px 16px;
                border: none;
                border-radius: 8px;
                background: #0F172A;
                color: #FFFFFF;
                font-family: inherit;
                font-size: 0.9rem;
                font-weight: 500;
                letter-spacing: -0.01em;
                cursor: pointer;
                transition: all 0.15s ease-in-out;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.08);
            }

            .submit:hover {
                background: #1E293B;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.12);
                transform: translateY(-1px);
            }

            .submit:active {
                transform: translateY(0);
                background: #0F172A;
                box-shadow: none;
            }

            .submit:focus-visible {
                outline: 2px solid #2563EB;
                outline-offset: 2px;
            }

            .back {
                display: block;
                text-align: center;
                margin-top: 10px;
                padding: 9px 16px;
                border: 1px solid #E2E8F0;
                border-radius: 8px;
                background: transparent;
                color: #64748B;
                font-family: inherit;
                font-size: 0.875rem;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.15s ease-in-out;
            }

            .back:hover {
                background: #F8FAFC;
                border-color: #CBD5E1;
                color: #0F172A;
            }

            .back:focus-visible {
                outline: 2px solid #2563EB;
                outline-offset: 2px;
            }            
        </style>
    </head>
    
    <body>
        <div class="container">
            
            <!--Page Title-->
            <h2>Add New Material</h2>
            
            <!--Add Material Form-->
            <form action="MaterialServlet" 
                  method="post">
                
                <input
                    type="hidden"
                    name="action"
                    value="add">
            
                <!--Material Name-->
                <label>Material Name</label>
                <input
                    type="text"
                    name="materialName"
                    required>
                
                <!--Category-->
                <label>Category</label>
                <input
                    type="text"
                    name="category"
                    required>
                
                <!--Quantity-->
                <label>Quantity</label>
                <input
                    type="number"
                    name="quantity"
                    min="0"
                    required>
                
                <!--Reorder Level-->
                <label>Reorder Level</label>
                <input
                    type="number"
                    name="reorderLevel"
                    min="0"
                    required>
                
                <!--Supplier ID-->
                <label>Supplier ID</label>
                <input
                    type="number"
                    name="supplierId"
                    min="1"
                    required>
                
                <!--Submit button-->
                <button
                    class="submit"
                    type="submit">
                    
                    Save Material
                </button>

            </form>
            
            <!--Back button-->
            <a class="back" href="MaterialServlet">Back to Materials</a>
            
        </div>
        
    </body>
</html>
