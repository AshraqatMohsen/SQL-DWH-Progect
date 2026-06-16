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
