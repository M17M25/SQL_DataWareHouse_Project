USE DataWareHouse
GO


/*
===================================================================
Script: Loading the Bronze Layer
===================================================================
Script Purpose:
    This script truncates and bulk inserts raw CSV data into 
    the 'Bronze' tables from the CRM source system.
    
    Run this script to load fresh sales details and product 
    information datasets into the data warehouse.
===================================================================
*/

CREATE OR ALTER  Procedure Bronze.load_bronze AS
BEGIN
	DECLARE @Start_date DATE, @End_date DATE;
	BEGIN TRY

		SET @Start_date = GETDATE();

		PRINT'==========================================================';
		PRINT'Load Bronze Layer';
		PRINT'==========================================================';


		PRINT'Loading CRM source Table';
		/* Fisrt Table */

		SET @Start_date = GETDATE();
		PRINT'>> Truncate Table:Bronze.crm_cust_info';

		TRUNCATE TABLE Bronze.crm_cust_info;
		BULK INSERT Bronze.crm_cust_info
		FROM 'D:\Data Engineer\SQL Full Course\Data WareHouse Project\datasets\source_crm\cust_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT'>> Bulk Insert Into Bronze.crm_cust_info';

		SET @End_date = GETDATE();

		PRINT'Load Duration: ' + CAST(DATEDIFF(second, @Start_date, @End_date) AS NVARCHAR(10)) + ' Seconds';

		PRINT'=========================================';

		/* SECOND Table */
		SET @Start_date = GETDATE();

		PRINT'>> Truncate Table:Bronze.crm_sales_details';

		TRUNCATE TABLE Bronze.crm_sales_details;
		BULK INSERT Bronze.crm_sales_details
		FROM 'D:\Data Engineer\SQL Full Course\Data WareHouse Project\datasets\source_crm\sales_details.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT'>> Bulk Insert Into :Bronze.crm_sales_details';

		PRINT'=========================================';

		SET @End_date = GETDATE();

		PRINT'Load Duration: ' + CAST(DATEDIFF(second, @Start_date, @End_date) AS NVARCHAR(10)) + ' Seconds';

		/* Third Table */
		SET @Start_date = GETDATE();

		PRINT'>> Truncate Table:Bronze.crm_prd_info';

		TRUNCATE TABLE Bronze.crm_prd_info;
		BULK INSERT Bronze.crm_prd_info
		FROM 'D:\Data Engineer\SQL Full Course\Data WareHouse Project\datasets\source_crm\prd_info.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT'>> Bulk Insert Into :Bronze.crm_prd_info';

		PRINT'=========================================';

		SET @End_date = GETDATE();

		PRINT'Load Duration: ' + CAST(DATEDIFF(second,  @Start_date, @End_date) AS NVARCHAR(10)) + ' Seconds';

		PRINT'Loading ERP source Table';

		/* Fourth Table */
		SET @Start_date = GETDATE();

		PRINT'>> Truncate Table:Bronze.erp_cust_az12';

		TRUNCATE TABLE Bronze.erp_cust_az12;
		BULK INSERT Bronze.erp_cust_az12
		FROM 'D:\Data Engineer\SQL Full Course\Data WareHouse Project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT'>> Bulk Insert Into :Bronze.erp_cust_az12';

		SET @End_date = GETDATE();

		PRINT'Load Duration: ' + CAST(DATEDIFF(second,  @Start_date, @End_date) AS NVARCHAR(10)) + ' Seconds';


		PRINT'=========================================';

		/* Fifth Table */
		SET @Start_date = GETDATE();

		PRINT'>> Truncate Table:Bronze.erp_loc_a101';

		TRUNCATE TABLE Bronze.erp_loc_a101;
		BULK INSERT Bronze.erp_loc_a101
		FROM 'D:\Data Engineer\SQL Full Course\Data WareHouse Project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		PRINT'>> Bulk Insert Into :Bronze.erp_loc_a101';

		SET @End_date = GETDATE();

		PRINT'Load Duration: ' + CAST(DATEDIFF(second, @Start_date, @End_date) AS NVARCHAR(10)) + ' Seconds';

		PRINT'=========================================';
    
		/* Sixth Table */
		SET @Start_date = GETDATE();

		PRINT'>> Truncate Table:Bronze.erp_px_cat_g1v2';

		TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'D:\Data Engineer\SQL Full Course\Data WareHouse Project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT'>> Bulk Insert Into :Bronze.erp_px_cat_g1v2';

		SET @End_date = GETDATE();

		PRINT'Load Duration: ' + CAST(DATEDIFF(second, @Start_date, @End_date) AS NVARCHAR(10)) + ' Seconds';


		PRINT'=========================================';

		SET @End_date = GETDATE();

		PRINT'Load The Whole Bronze Layer: ' + CAST(DATEDIFF(second, @Start_date, @End_date) AS VARCHAR(10)) + ' Seconds';

	END TRY

	BEGIN CATCH
		PRINT '==================================================';
		PRINT 'ERROR OCCURRED IN STORED PROCEDURE';
		PRINT '==================================================';
		PRINT 'Error Message : ' + CAST(ERROR_MESSAGE() AS VARCHAR(4000));
		PRINT 'Error Number  : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
		PRINT 'Error State   : ' + CAST(ERROR_STATE() AS VARCHAR(10));
		PRINT 'Error Line    : ' + CAST(ERROR_LINE() AS VARCHAR(10));
		PRINT '==================================================';
   END CATCH

	
END

EXEC Bronze.load_bronze
