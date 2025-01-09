#Creating tables within database
table_definitions = [
    """
    CREATE TABLE IF NOT EXISTS Supplier (
        SupplierID INT PRIMARY KEY NOT NULL,
        Name VARCHAR(100) NOT NULL,
        Address VARCHAR(255),
        Location VARCHAR(100)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Product (
        ProductID INT PRIMARY KEY NOT NULL,
        Name VARCHAR(100) NOT NULL,
        Type VARCHAR(50) NOT NULL,
        AvailableQuantity INT NOT NULL,
        PurchasePrice DECIMAL(10, 2) NOT NULL,
        RestockLeadTime INT NOT NULL,
        SupplierID INT NOT NULL,
        FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS SupplierContract (
        ContractID INT PRIMARY KEY NOT NULL,
        SupplierID INT NOT NULL,
        ContractStartDate DATE NOT NULL,
        ContractEndDate DATE NOT NULL,
        Terms TEXT,
        FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS PurchaseOrder (
        PurchaseOrderID INT PRIMARY KEY NOT NULL,
        OrderDate DATE,
        SupplierID INT NOT NULL,
        FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Customers (
        CustomerID INT PRIMARY KEY NOT NULL,
        Name VARCHAR(100) NOT NULL,
        ContactDetails VARCHAR(255)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS SalesOrders (
        SalesOrderID INT PRIMARY KEY NOT NULL,
        OrderDate DATE,
        TotalAmount DECIMAL(10, 2),
        CustomerID INT NOT NULL,
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS ReturnRefund (
        ReturnID INT PRIMARY KEY NOT NULL,
        ProductID INT NOT NULL,
        CustomerID INT NOT NULL,
        ReasonForReturn TEXT,
        ReturnDate DATE,
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    );
    """,

    """
    CREATE TABLE IF NOT EXISTS Review (
        ReviewID INT PRIMARY KEY NOT NULL,
        Rating INT NOT NULL,
        Comment TEXT,
        CustomerID INT NOT NULL,
        ProductID INT NOT NULL,
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Payment (
        PaymentID INT PRIMARY KEY NOT NULL,
        PaymentMethod VARCHAR(50),
        AmountPaid DECIMAL(10, 2),
        PaymentDate DATE,
        SalesOrderID INT NOT NULL,
        FOREIGN KEY (SalesOrderID) REFERENCES SalesOrders(SalesOrderID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS StockLocation (
        LocationID INT PRIMARY KEY NOT NULL,
        Address VARCHAR(255)
    );
    """,
    """ 
    CREATE TABLE IF NOT EXISTS ShippingInformation (
        ShippingID INT PRIMARY KEY NOT NULL,
        Carrier VARCHAR(100),
        TrackingNumber VARCHAR(100),
        ShippingDate DATE,
        ExpectedDeliveryDate DATE,
        SalesOrderID INT NOT NULL,
        FOREIGN KEY (SalesOrderID) REFERENCES SalesOrders(SalesOrderID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Employees (
        EmployeeID INT PRIMARY KEY NOT NULL,
        Name VARCHAR(100) NOT NULL,
        Role VARCHAR(50),
        ContactDetails VARCHAR(255),
        HireDate DATE
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS Warehouse (
        WarehouseID INT PRIMARY KEY NOT NULL,
        Name VARCHAR(100) NOT NULL,
        Location VARCHAR(100),
        Capacity INT
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS StockAudit (
        AuditID INT PRIMARY KEY NOT NULL,
        AuditDate DATE,
        Findings TEXT,
        WarehouseID INT,
        EmployeeID INT,
        FOREIGN KEY (WarehouseID) REFERENCES Warehouse(WarehouseID),
        FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS SalesPromotion (
        PromotionID INT PRIMARY KEY NOT NULL,
        Description TEXT,
        StartDate DATE,
        EndDate DATE
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS InventoryAdjustment (
        AdjustmentID INT PRIMARY KEY NOT NULL,
        ProductID INT,
        EmployeeID INT,
        AdjustmentDate DATE,
        AdjustmentQuantity INT,
        Reason TEXT,
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
        FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
    );
    """,
    #Associative Tables for Many-to-Many Relationships
    """
    CREATE TABLE IF NOT EXISTS SupplierProduct (
        SupplierID INT,
        ProductID INT,
        PRIMARY KEY (SupplierID, ProductID),
        FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID),
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS ProductStockLocation (
        ProductID INT,
        LocationID INT,
        PRIMARY KEY (ProductID, LocationID),
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
        FOREIGN KEY (LocationID) REFERENCES StockLocation(LocationID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS ProductPurchaseOrder (
        ProductID INT,
        PurchaseOrderID INT,
        PRIMARY KEY (ProductID, PurchaseOrderID),
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
        FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID)
    );
    """,
    """
    CREATE TABLE IF NOT EXISTS ProductSalesOrder (
        ProductID INT,
        SalesOrderID INT,
        PRIMARY KEY (ProductID, SalesOrderID),
        FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
        FOREIGN KEY (SalesOrderID) REFERENCES SalesOrders(SalesOrderID)
    );
    """
]
for table_sql in table_definitions:
    try:
        cursor.execute(table_sql)
        print(f"Table created successfully.")
    except mysql.connector.Error as err:
        print(f"Error: {err}")


# Close the cursor and connection
cursor.close()
connection.close()
print("All tables created and connection closed.")
