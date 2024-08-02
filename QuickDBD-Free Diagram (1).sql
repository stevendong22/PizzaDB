-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/AqILb3
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [order] (
    [row_id] int  NOT NULL ,
    [order_id] varchar(10)  NOT NULL ,
    [created_at] datetime  NOT NULL ,
    [item_id] int  NOT NULL ,
    [quantity] int  NOT NULL ,
    [cust_id] int  NOT NULL ,
    [delivery] boolean  NOT NULL ,
    [address_id] int  NOT NULL ,
    CONSTRAINT [PK_order] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [customers] (
    [cust_id] int  NOT NULL ,
    [customer_firstname] varchar(50)  NOT NULL ,
    [customer_lastname] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_customers] PRIMARY KEY CLUSTERED (
        [cust_id] ASC
    )
)

CREATE TABLE [address] (
    [address_id] int  NOT NULL ,
    [delivery_address1] varchar(200)  NOT NULL ,
    [delivery_address2] varchar(200)  NULL ,
    [delivery_zipcode] varchar(20)  NOT NULL ,
    [delivery_city] varchar(50)  NOT NULL ,
    CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED (
        [address_id] ASC
    )
)

CREATE TABLE [item] (
    [item_id] varchar(10)  NOT NULL ,
    [sku] varchar(20)  NOT NULL ,
    [item_name] varchar(50)  NOT NULL ,
    [item_cat] varchar(50)  NOT NULL ,
    [item_size] varchar(20)  NOT NULL ,
    [item_price] decimal(5,2)  NOT NULL 
)

CREATE TABLE [recipe] (
    [row_id] int  NOT NULL ,
    [recipe_id] varchar(20)  NOT NULL ,
    [ingredient_id] varchar(20)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_recipe] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [ingredient] (
    [ingredient_id] varchar(10)  NOT NULL ,
    [ingredient_name] varchar(20)  NOT NULL ,
    [ingredient_weight] int  NOT NULL ,
    [ingredient_meas] varchar(20)  NOT NULL ,
    [ingredient_price] decimal(5,2)  NOT NULL 
)

CREATE TABLE [inventory] (
    [inv_id] int  NOT NULL ,
    [item_id] varchar(10)  NOT NULL ,
    [quantity] int  NOT NULL ,
    CONSTRAINT [PK_inventory] PRIMARY KEY CLUSTERED (
        [inv_id] ASC
    )
)

CREATE TABLE [rota] (
    [row_id] int  NOT NULL ,
    [rota_id] varchar(20)  NOT NULL ,
    [date] datetime  NOT NULL ,
    [shift_id] varchar(20)  NOT NULL ,
    [staff_id] varchar(20)  NOT NULL ,
    CONSTRAINT [PK_rota] PRIMARY KEY CLUSTERED (
        [row_id] ASC
    )
)

CREATE TABLE [staff] (
    [staff_id] varchar(20)  NOT NULL ,
    [first_name] varchar(50)  NOT NULL ,
    [last_name] varchar(50)  NOT NULL ,
    [position] varchar(100)  NOT NULL ,
    [hourly_rate] decimal(5,2)  NOT NULL 
)

CREATE TABLE [shift] (
    [shift_id] varchar(20)  NOT NULL ,
    [day_of_week] varchar(10)  NOT NULL ,
    [start_time] time  NOT NULL ,
    [end_time] time  NOT NULL 
)

ALTER TABLE [customers] WITH CHECK ADD CONSTRAINT [FK_customers_cust_id] FOREIGN KEY([cust_id])
REFERENCES [order] ([cust_id])

ALTER TABLE [customers] CHECK CONSTRAINT [FK_customers_cust_id]

ALTER TABLE [address] WITH CHECK ADD CONSTRAINT [FK_address_address_id] FOREIGN KEY([address_id])
REFERENCES [order] ([address_id])

ALTER TABLE [address] CHECK CONSTRAINT [FK_address_address_id]

ALTER TABLE [item] WITH CHECK ADD CONSTRAINT [FK_item_item_id] FOREIGN KEY([item_id])
REFERENCES [order] ([item_id])

ALTER TABLE [item] CHECK CONSTRAINT [FK_item_item_id]

ALTER TABLE [recipe] WITH CHECK ADD CONSTRAINT [FK_recipe_recipe_id] FOREIGN KEY([recipe_id])
REFERENCES [item] ([sku])

ALTER TABLE [recipe] CHECK CONSTRAINT [FK_recipe_recipe_id]

ALTER TABLE [ingredient] WITH CHECK ADD CONSTRAINT [FK_ingredient_ingredient_id] FOREIGN KEY([ingredient_id])
REFERENCES [recipe] ([ingredient_id])

ALTER TABLE [ingredient] CHECK CONSTRAINT [FK_ingredient_ingredient_id]

ALTER TABLE [inventory] WITH CHECK ADD CONSTRAINT [FK_inventory_item_id] FOREIGN KEY([item_id])
REFERENCES [recipe] ([ingredient_id])

ALTER TABLE [inventory] CHECK CONSTRAINT [FK_inventory_item_id]

ALTER TABLE [rota] WITH CHECK ADD CONSTRAINT [FK_rota_date] FOREIGN KEY([date])
REFERENCES [order] ([created_at])

ALTER TABLE [rota] CHECK CONSTRAINT [FK_rota_date]

ALTER TABLE [staff] WITH CHECK ADD CONSTRAINT [FK_staff_staff_id] FOREIGN KEY([staff_id])
REFERENCES [rota] ([staff_id])

ALTER TABLE [staff] CHECK CONSTRAINT [FK_staff_staff_id]

ALTER TABLE [shift] WITH CHECK ADD CONSTRAINT [FK_shift_shift_id] FOREIGN KEY([shift_id])
REFERENCES [rota] ([shift_id])

ALTER TABLE [shift] CHECK CONSTRAINT [FK_shift_shift_id]

COMMIT TRANSACTION QUICKDBD