/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

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
-- stored procedure 
create OR alter PROCEDURE bronze.load_bronze as
begin
	declare @start_date datetime , @end_date datetime, @batch_start_time datetime,@batch_end_time datetime;
	begin try
		set @batch_start_time = GETDATE();
		print '====================================================';
		print 'Loading Bronze Layer';
		print '=====================================================';

		print '------------------------------------------------------';
		print 'Loading CRM Tables';
		print '------------------------------------------------------';

		print '>>> Truncating Table: bronze.crm_cust_info';
		truncate table bronze.crm_cust_info;

		set @start_date = GETDATE();
		print '>>> Inserting data into: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'G:\ashraqat\Data Engineer\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_date = GETDATE();
		print'>> load duration: ' + cast(DATEDIFF(second,@start_date,@end_date) as nvarchar) +' seconds';
		print '----------------'


		set @start_date = GETDATE();
		print '>>> Truncating Table: bronze.crm_Prd_info';
		truncate table bronze.crm_prd_info;

		print '>>> Inserting data into: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'G:\ashraqat\Data Engineer\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_date = GETDATE();
		print'>> load duration: ' + cast(DATEDIFF(second,@start_date,@end_date) as nvarchar) +' seconds';
		print '----------------'

		set @start_date=GETDATE();
		print '>>> Truncating Table: bronze.crm_sales_details';
		truncate table bronze.crm_sales_details;

		print '>>> Inserting data into: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'G:\ashraqat\Data Engineer\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_date = GETDATE();
		print'>> load duration: ' + cast(DATEDIFF(second,@start_date,@end_date) as nvarchar) +' seconds';
		print '----------------'

		print '------------------------------------------------------';
		print 'Loading ERP Tables';
		print '------------------------------------------------------';


		set @start_date = GETDATE();
		print '>>> Truncating Table: bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
	
		print '>>> Inserting data into: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'G:\ashraqat\Data Engineer\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_date = GETDATE();
		print'>> load duration: ' + cast(DATEDIFF(second,@start_date,@end_date) as nvarchar) +' seconds';
		print '----------------'


		set @start_date = GETDATE();
		print '>>> Truncating Table: bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101;

		print '>>> Inserting data into: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'G:\ashraqat\Data Engineer\sql-data-warehouse-project-main\datasets\source_erp\loc_a101.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_date = GETDATE();
		print'>> load duration: ' + cast(DATEDIFF(second,@start_date,@end_date) as nvarchar) +' seconds';
		print '----------------'


		set @start_date = GETDATE();
		print '>>> Truncating Table: bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2;

		print '>>> Inserting data into: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'G:\ashraqat\Data Engineer\sql-data-warehouse-project-main\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_date = GETDATE();
		print'>> load duration: ' + cast(DATEDIFF(second,@start_date,@end_date) as nvarchar) +' seconds';
		print '----------------'

		set @batch_end_time = GETDATE();
		print '=============================================';
		print 'Loading Bronze Layer is completed';
		print '- Total load duration:'+cast(datediff(second,@batch_start_time,@batch_end_time)as nvarchar);
		print '==============================================';
	end try
	begin catch
		print '================================================';
		print 'Error occured during Loading';
		print 'Error Message'+error_message();
		print 'Error Message'+cast(error_number() as nvarchar);
		print 'Error Message'+cast(error_state() as nvarchar);
		print '================================================';
	end catch
end;
