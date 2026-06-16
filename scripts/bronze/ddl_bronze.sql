create table bronze.crm_cust_info(
	cust_id int,
	cust_key nvarchar(50),
	cust_firstname nvarchar(50),
	cust_lastname nvarchar(50),
	cust_material_status nvarchar(50),
	cust_gender nvarchar(50),
	cust_create_date date
);

create table bronze.crm_prd_info(
	prd_id int,
	prd_key nvarchar(50),
	prd_nm nvarchar(50),
	prd_cost int,
	prd_line nvarchar(50),
	prd_start_dt date,
	prd_end_dt date
);

create table bronze.crm_sales_details(
	sls_ord_num nvarchar(50),
	sls_prd_key nvarchar(50),
	sls_cust_id int,
	sls_order_dt int,
	sls_ship_dt int,
	sls_sales int,
	sls_quantity int,
	sls_price int
);

CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),
    cntry  NVARCHAR(50)
);

CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),
    bdate  DATE,
    gen    NVARCHAR(50)
);

CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),
    cat          NVARCHAR(50),
    subcat       NVARCHAR(50),
    maintenance  NVARCHAR(50)
);

IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
		DROP TABLE bronze.crm_sales_details;
	GO

	CREATE TABLE bronze.crm_sales_details (
		sls_ord_num  NVARCHAR(50),
		sls_prd_key  NVARCHAR(50),
		sls_cust_id  INT,
		sls_order_dt INT,
		sls_ship_dt  INT,
		sls_due_dt   INT,
		sls_sales    INT,
		sls_quantity INT,
		sls_price    DECIMAL(18,4) 
	);
