# Define each query with a description for readability
queries = [
    {
        "description": "Top 10 Customers by Order Count:",
        "query": """ 
            SELECT CustomerID, COUNT(*) AS OrderCount
            FROM SalesOrder
            GROUP BY CustomerID
            ORDER BY OrderCount DESC
            LIMIT 10;
        """
    },
    {
        "description": "Products Low in Stock (less than 50 units):",
        "query": """
            SELECT ProductID, Name, AvailableQuantity
            FROM Product
            WHERE AvailableQuantity < 50;
        """
    },
    {
        "description": "Total Sales per Product:",
        "query": """
            SELECT p.ProductID, p.Name, SUM(AmountPaid) AS TotalSales
            FROM Product p
            JOIN ProductSalesOrder ps ON p.ProductID = ps.ProductID
            JOIN SalesOrder s ON ps.SalesOrderID = s.SalesOrderID
            JOIN Payment pay ON s.SalesOrderID = pay.SalesOrderID
            GROUP BY p.ProductID, p.Name;
        """
    },
    {
        "description": "Suppliers with Active Contracts:",
        "query": """
            SELECT SupplierID, ContractID, ContractStartDate, ContractEndDate
            FROM SupplierContract
            WHERE ContractEndDate >= CURDATE();
        """
    },
    {
        "description": "Products Supplied by Supplier with SupplierID = 1:",
        "query": """
            SELECT p.ProductID, p.Name, p.Type
            FROM Product p
            JOIN SupplierProduct sp ON p.ProductID = sp.ProductID
            WHERE sp.SupplierID = 1;
        """
    }
]

# Execute each query in sequence
for q in queries:
    print(f"\n{q['description']}")
    try:
        cursor.execute(q["query"])
        if cursor.with_rows:  # Check if the query returns rows (for SELECT statements)
            results = cursor.fetchall()
            for row in results:
                print(row)
        else:
            print("Query executed successfully.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")

# Close the cursor and connection
cursor.close()
connection.close()
