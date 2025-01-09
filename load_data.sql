
# Insert data for each table

def insert_data_from_csv(file_path, table_name, columns):
    data = pd.read_csv(file_path)
    for _, row in data.iterrows():
        placeholders = ', '.join(['%s'] * len(row))
        # Using ON DUPLICATE KEY UPDATE to handle duplicates
        update_clause = ', '.join([f"{col} = VALUES({col})" for col in columns])  # Only updates with new values
        sql = f"INSERT INTO {table_name} ({', '.join(columns)}) VALUES ({placeholders}) ON DUPLICATE KEY UPDATE {update_clause}"
        try:
            cursor.execute(sql, tuple(row))
        except mysql.connector.IntegrityError as err:
            print(f"Skipping duplicate entry for {row['SupplierID']} in table {table_name}")
    connection.commit()
    print(f"Data inserted into {table_name} successfully.")

# Run the insertion
try:

# 1. Suppliers
    insert_data_from_csv('/Users/ruthie/Downloads/suppliers.csv', 'Supplier', 
                        ['SupplierID', 'Name', 'Address', 'Location'])

# 2. Products
    insert_data_from_csv('/Users/ruthie/Downloads/products.csv', 'Product', 
                        ['ProductID', 'Name', 'Type', 'AvailableQuantity', 'PurchasePrice', 'RestockLeadTime', 'SupplierID'])

# 3. Supplier Contracts
    insert_data_from_csv('/Users/ruthie/Downloads/supplier_contracts.csv', 'SupplierContract', 
                        ['ContractID', 'SupplierID', 'ContractStartDate', 'ContractEndDate', 'Terms'])
# 4. Customers
    insert_data_from_csv('/Users/ruthie/Downloads/customers.csv', 'Customers', 
                        ['CustomerID', 'Name', 'ContactDetails'])
# 5. Employees
    insert_data_from_csv('/Users/ruthie/Downloads/employees.csv', 'Employees', 
                        ['EmployeeID', 'Name', 'Role', 'ContactDetails', 'HireDate'])

# 6. Sales Orders
    insert_data_from_csv('/Users/ruthie/Downloads/sales_orders.csv', 'SalesOrders', 
                        ['SalesOrderID', 'OrderDate', 'TotalAmount', 'CustomerID'])

# 7. Purchase Orders
    insert_data_from_csv('/Users/ruthie/Downloads/purchase_orders.csv', 'PurchaseOrders', 
                        ['PurchaseOrderID', 'OrderDate', 'SupplierID'])

# 8. ReturnRefunds 
    insert_data_from_csv('/Users/ruthie/Downloads/return_refunds.csv', 'ReturnRefunds', 
                        ['ReturnID', 'ProductID','CustomerID','ReasonForReturn','ReturnDate'])

# 9. Reviews
    insert_data_from_csv('/Users/ruthie/Downloads/reviews.csv', 'Reviews', 
                        ['ReviewID', 'Comment', 'CustomerID','ProductID'])

# 10. Payments 
    insert_data_from_csv('/Users/ruthie/Downloads/payments.csv', 'Payments', 
                        ['PaymentID', 'PaymentMethod', 'AmountPaid', 'PaymentDate','SalesOrderID'])

# 11. Stock Locations
    insert_data_from_csv('/Users/ruthie/Downloads/stock_locations.csv', 'StockLocations', 
                        ['LocationID', 'Address'])

# 12. Shipping Info
    insert_data_from_csv('/Users/ruthie/Downloads/shipping_info.csv', 'ShippingInfo', 
                        ['ShippingID', 'Carrier', 'TrackingNumber', 'ShippingDate','ExpectedDeliveryDate','SalesOrderID'])

# 13. Warehouses
    insert_data_from_csv('/Users/ruthie/Downloads/warehouses.csv', 'Warehouses', 
                        ['WarehouseID', 'Name', 'Location', 'Capacity'])

# 14. Stock Audits
    insert_data_from_csv('/Users/ruthie/Downloads/stock_audits.csv', 'StockAudits', 
                        ['AuditID', 'AuditDate', 'Findings', 'WarehouseID','EmployeeID'])
# 15. Promotions
    insert_data_from_csv('/Users/ruthie/Downloads/promotions.csv', 'SalesPromotions', 
                        ['PromotionID', 'Description', 'StartDate', 'EndDate'])

# 16. Inventory Adjustments
    insert_data_from_csv('/Users/ruthie/Downloads/inventory_adjustments.csv', 'InventoryAdjustments', 
                        ['AdjustmentID', 'ProductID', 'EmployeeID', 'AdjustmentDate','AdjustmentQuantity','Reason'])

# 17. Supplier Products
    insert_data_from_csv('/Users/ruthie/Downloads/supplier_products.csv', 'SupplierProducts', 
                        ['SupplierID', 'ProductID'])

# 18. Product Stock Locations
    insert_data_from_csv('/Users/ruthie/Downloads/product_stock_locations.csv', 'ProductStockLocations', 
                        ['ProductID', 'LocationID'])

# 19. Product Purchase Orders
    insert_data_from_csv('/Users/ruthie/Downloads/product_purchase_orders.csv', 'ProductPurchaseOrders', 
                        ['ProductID', 'PurchaseOrderID'])

# 20. Product Sales Orders
    insert_data_from_csv('/Users/ruthie/Downloads/product_sales_orders.csv', 'ProductStockOrders', 
                        ['ProductID', 'SalesOrderID'])
except Exception as e:
    print(f"Error during data insertion: {e}")
finally:
    # Close the cursor and connection after all insertions
    cursor.close()
    connection.close()  
