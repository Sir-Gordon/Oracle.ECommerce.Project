
-- Last modification date: 2022-06-02 01:48:39.437

-- tables
-- Table: Category
CREATE TABLE Category (
    CategoryID int  NOT NULL,
    CategoryName char(50)  NOT NULL,
    Description char(200)  NOT NULL,
    CONSTRAINT Category_pk PRIMARY KEY (CategoryID)
) ;

-- Table: Customers
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    FirstName char(50)  NOT NULL,
    LastName char(50)  NOT NULL,
    Address char(100)  NOT NULL,
    City char(50)  NOT NULL,
    State char(50)  NOT NULL,
    ZipCode int  NOT NULL,
    Country char(50)  NOT NULL,
    Phone int  NULL,
    Email char(100)  NULL,
    Username char(50)  NOT NULL,
    Password char(50)  NOT NULL,
    CreditCardType char(50)  NOT NULL,
    CreditCardNumber int  NOT NULL,
    CardHolderName char(50)  NOT NULL,
    SecurityCode int  NOT NULL,
    ExpirationDate date  NOT NULL,
    BillingAddress char(100)  NOT NULL,
    BillingCity char(50)  NOT NULL,
    BillingState char(50)  NOT NULL,
    BillingZipCode int  NOT NULL,
    BillingCountry char(50)  NOT NULL,
    BillingMatchShipping char(3)  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY (CustomerID)
) ;

-- Table: DIM_TEMPORAL
CREATE TABLE DIM_TEMPORAL (
    DATE_ID integer  NOT NULL,
    REVIEWQUARTER char(2)  NOT NULL,
    REVIEWMONTH char(3)  NOT NULL,
    YEAR char(8)  NOT NULL,
    WEEK  integer  NOT NULL,
    CONSTRAINT DIM_TEMPORAL_pk PRIMARY KEY (DATE_ID)
) ;

-- Table: Orders
CREATE TABLE Orders (
    OrderID int  NOT NULL,
    OrderDate date  NOT NULL,
    OrderStatus char(50)  NOT NULL,
    TotalAmount int  NOT NULL,
    ShippingCost int  NOT NULL,
    TaxAmount int  NOT NULL,
    Discount int  NULL,
    DeliveryDate date  NULL,
    ShipmentStatus char(50)  NULL,
    ShipmentMethod char(50)  NULL,
    CustomerID int  NOT NULL,
    PaymentID int  NOT NULL,
    ProductID int  NOT NULL,
    DIM_TEMPORAL_DATE_ID integer  NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY (OrderID)
) ;

-- Table: Payment
CREATE TABLE Payment (
    PaymentID int  NOT NULL,
    PaymentType char(50)  NOT NULL,
    CustomerID int  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (PaymentID)
) ;

-- Table: ProductReturns
CREATE TABLE ProductReturns (
    ProductReturnID integer  NOT NULL,
    ReturnDate date  NOT NULL,
    CustomerID int  NOT NULL,
    OrderID int  NOT NULL,
    ProductID int  NOT NULL,
    PaymentID int  NOT NULL,
    DIM_TEMPORAL_DATE_ID integer  NOT NULL,
    CONSTRAINT ProductReturns_pk PRIMARY KEY (ProductReturnID)
) ;

-- Table: ProductReviews
CREATE TABLE ProductReviews (
    ReviewID int  NOT NULL,
    ProductID int  NOT NULL,
    CustomerID int  NOT NULL,
    Rating int  NOT NULL,
    ReviewDate date  NOT NULL,
    "Comment" char(200)  NULL,
    DIM_TEMPORAL_DATE_ID integer  NOT NULL,
    CONSTRAINT ProductReviews_pk PRIMARY KEY (ReviewID)
) ;

-- Table: Products
CREATE TABLE Products (
    ProductID int  NOT NULL,
    ProductName char(50)  NOT NULL,
    Description char(200)  NULL,
    SellerID int  NOT NULL,
    Price float(5)  NOT NULL,
    QuantityInStock int  NOT NULL,
    CategoryID int  NOT NULL,
    CONSTRAINT Products_pk PRIMARY KEY (ProductID)
) ;

-- Table: SellerReviews
CREATE TABLE SellerReviews (
    ID int  NOT NULL,
    ReviewDate date  NOT NULL,
    SellerID int  NOT NULL,
    DATE_ID integer  NOT NULL,
    DIM_TEMPORAL_DATE_ID integer  NOT NULL,
    Rating integer  NOT NULL,
    CONSTRAINT SellerReviews_pk PRIMARY KEY (ID,Rating)
) ;

-- Table: Sellers
CREATE TABLE Sellers (
    SellerID int  NOT NULL,
    Seller char(50)  NOT NULL,
    Address char(100)  NOT NULL,
    City char(50)  NOT NULL,
    State char(50)  NOT NULL,
    ZipCode int  NOT NULL,
    Country char(50)  NOT NULL,
    Phone int  NULL,
    Email char(100)  NULL,
    username char(50)  NOT NULL,
    password char(50)  NOT NULL,
    CONSTRAINT Sellers_pk PRIMARY KEY (SellerID)
) ;

-- foreign keys
-- Reference: Order_Customers (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Order_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Order_Payment (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Order_Payment
    FOREIGN KEY (PaymentID)
    REFERENCES Payment (PaymentID);

-- Reference: Order_Products (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Order_Products
    FOREIGN KEY (ProductID)
    REFERENCES Products (ProductID);

-- Reference: Orders_DIM_TEMPORAL (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_DIM_TEMPORAL
    FOREIGN KEY (DIM_TEMPORAL_DATE_ID)
    REFERENCES DIM_TEMPORAL (DATE_ID);

-- Reference: Payment_Customers (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: ProductReturns_Customers (table: ProductReturns)
ALTER TABLE ProductReturns ADD CONSTRAINT ProductReturns_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: ProductReturns_DIM_TEMPORAL (table: ProductReturns)
ALTER TABLE ProductReturns ADD CONSTRAINT ProductReturns_DIM_TEMPORAL
    FOREIGN KEY (DIM_TEMPORAL_DATE_ID)
    REFERENCES DIM_TEMPORAL (DATE_ID);

-- Reference: ProductReturns_Order (table: ProductReturns)
ALTER TABLE ProductReturns ADD CONSTRAINT ProductReturns_Order
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: ProductReturns_Payment (table: ProductReturns)
ALTER TABLE ProductReturns ADD CONSTRAINT ProductReturns_Payment
    FOREIGN KEY (PaymentID)
    REFERENCES Payment (PaymentID);

-- Reference: ProductReturns_Products (table: ProductReturns)
ALTER TABLE ProductReturns ADD CONSTRAINT ProductReturns_Products
    FOREIGN KEY (ProductID)
    REFERENCES Products (ProductID);

-- Reference: ProductReviews_Customers (table: ProductReviews)
ALTER TABLE ProductReviews ADD CONSTRAINT ProductReviews_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: ProductReviews_DIM_TEMPORAL (table: ProductReviews)
ALTER TABLE ProductReviews ADD CONSTRAINT ProductReviews_DIM_TEMPORAL
    FOREIGN KEY (DIM_TEMPORAL_DATE_ID)
    REFERENCES DIM_TEMPORAL (DATE_ID);

-- Reference: ProductReviews_Products (table: ProductReviews)
ALTER TABLE ProductReviews ADD CONSTRAINT ProductReviews_Products
    FOREIGN KEY (ProductID)
    REFERENCES Products (ProductID);

-- Reference: Products_Category (table: Products)
ALTER TABLE Products ADD CONSTRAINT Products_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Category (CategoryID);

-- Reference: Products_Sellers (table: Products)
ALTER TABLE Products ADD CONSTRAINT Products_Sellers
    FOREIGN KEY (SellerID)
    REFERENCES Sellers (SellerID);

-- Reference: SellerReviews_DIM_TEMPORAL (table: SellerReviews)
ALTER TABLE SellerReviews ADD CONSTRAINT SellerReviews_DIM_TEMPORAL
    FOREIGN KEY (DATE_ID)
    REFERENCES DIM_TEMPORAL (DATE_ID);

-- Reference: SellerReviews_Sellers (table: SellerReviews)
ALTER TABLE SellerReviews ADD CONSTRAINT SellerReviews_Sellers
    FOREIGN KEY (SellerID)
    REFERENCES Sellers (SellerID);

-- End of file.

