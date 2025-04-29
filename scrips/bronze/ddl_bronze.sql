/*
source to bronze
bulk insert
use :
EXEC bronze.load_bronze;
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME; 
	BEGIN TRY
		-- bulk insert bring in the whole table at once
		SET @start_time = GETDATE();
		PRINT 'Loading bronze crm'
		TRUNCATE TABLE bronze.crm_cust_info;--empty the table
		BULK INSERT bronze.crm_cust_info -- name of the table you are loading data to
		FROM 'C:\Users\Ben\OneDrive\Desktop\SQLSERVER DWH HOP\sql-data-warehouse-project\datasets\source_crm\cust_info.csv' --path to document
		WITH( -- options 
			FIRSTROW = 2,--start on row two
			FIELDTERMINATOR = ',', --file delminator
			TABLOCK --lock the table improve performance as it loads the table is locked
		);
		SET @end_time = GETDATE();
		PRINT '>> load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		SELECT count(*)
		FROM bronze.crm_cust_info;

		--prd_info
		TRUNCATE TABLE bronze.crm_prod_info;--empty the table
		BULK INSERT bronze.crm_prod_info -- name of the table you are loading data to
		FROM 'C:\Users\Ben\OneDrive\Desktop\SQLSERVER DWH HOP\sql-data-warehouse-project\datasets\source_crm\prd_info.csv' --path to document
		WITH( -- options 
			FIRSTROW = 2,--start on row two
			FIELDTERMINATOR = ',', --file delminator
			TABLOCK --lock the table improve performance as it loads the table is locked
		);

		SELECT count(*)
		FROM bronze.crm_prod_info;

		--sales_details

		TRUNCATE TABLE bronze.crm_sales_details;--empty the table
		BULK INSERT bronze.crm_sales_details -- name of the table you are loading data to
		FROM 'C:\Users\Ben\OneDrive\Desktop\SQLSERVER DWH HOP\sql-data-warehouse-project\datasets\source_crm\sales_details.csv' --path to document
		WITH( -- options 
			FIRSTROW = 2,--start on row two
			FIELDTERMINATOR = ',', --file delminator
			TABLOCK --lock the table improve performance as it loads the table is locked
		);

		SELECT count(*)
		FROM bronze.crm_sales_details;

		--
		PRINT 'Loading bronze erp'

		TRUNCATE TABLE bronze.erp_cust_az12;--empty the table
		BULK INSERT bronze.erp_cust_az12 -- name of the table you are loading data to
		FROM 'C:\Users\Ben\OneDrive\Desktop\SQLSERVER DWH HOP\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv' --path to document
		WITH( -- options 
			FIRSTROW = 2,--start on row two
			FIELDTERMINATOR = ',', --file delminator
			TABLOCK --lock the table improve performance as it loads the table is locked
		);

		SELECT count(*)
		FROM bronze.erp_cust_az12;


		--

		TRUNCATE TABLE bronze.erp_sloc_a101;--empty the table
		BULK INSERT bronze.erp_sloc_a101 -- name of the table you are loading data to
		FROM 'C:\Users\Ben\OneDrive\Desktop\SQLSERVER DWH HOP\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv' --path to document
		WITH( -- options 
			FIRSTROW = 2,--start on row two
			FIELDTERMINATOR = ',', --file delminator
			TABLOCK --lock the table improve performance as it loads the table is locked
		);

		SELECT count(*)
		FROM bronze.erp_sloc_a101;



		--



		TRUNCATE TABLE bronze.erp_px_cat_g1v2;--empty the table
		BULK INSERT bronze.erp_px_cat_g1v2-- name of the table you are loading data to
		FROM 'C:\Users\Ben\OneDrive\Desktop\SQLSERVER DWH HOP\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv' --path to document
		WITH( -- options 
			FIRSTROW = 2,--start on row two
			FIELDTERMINATOR = ',', --file delminator
			TABLOCK --lock the table improve performance as it loads the table is locked
		);

		SELECT count(*)
		FROM bronze.erp_px_cat_g1v2;

	END TRY
	BEGIN CATCH
		PRINT '======================================'
		PRINT 'ERROR OCCURED'
		PRINT 'Erro Messag' + ERROR_MESSAGE();
		PRINT 'Erro Messag' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '======================================'
	END CATCH
END
