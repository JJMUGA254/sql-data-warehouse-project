/* 
==================================================
Stored Procedure:Load Bronze Layer from the source (Source>>>>bronze)
==================================================

This stored procedure loads data from the sources to the bronze schema
It perfoms the following functions:
- Truncates bronze tables before loading data
-uses th BULKINSERT command to load data from csv file to bronze tables


Use example EXEC bronze.load_bronze */


 CREATE OR ALTER PROCEDURE bronze.load_bronze AS  
 BEGIN
     DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
     BEGIN TRY
     SET @batch_start_time= GETDATE();
          PRINT'===================================';
          PRINT 'Loading Bronze Layer';
          PRINT'===================================';


          PRINT'--------------------------------';
          PRINT 'Loading CRM TABLES';
          PRINT'--------------------------------';
      
          SET @start_time = GETDATE();
          PRINT'>>Truncating Table:bronze.crm_cust_info';
          TRUNCATE TABLE bronze.crm_cust_info;
          PRINT'>>inserting Data into Table:bronze.crm_cust_info';
          BULK INSERT bronze.crm_cust_info
          FROM 'D:\WAREHOUSE\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
          WITH (
          FIRSTROW=2,
          FIELDTERMINATOR=',',
          TABLOCK);
          SET @end_time= GETDATE();
          PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
          SELECT COUNT (*) FROM bronze.crm_cust_info
          PRINT'-------------'; 


          SET @start_time = GETDATE();
          PRINT'>>Truncating Table:bronze.crm_prd_info';
          TRUNCATE TABLE bronze.crm_prd_info;
          PRINT'>>inserting Data into Table:bronze.crm_prd_info';
          BULK INSERT bronze.crm_prd_info
          FROM 'D:\WAREHOUSE\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
          WITH (
          FIRSTROW=2,
          FIELDTERMINATOR=',',
          TABLOCK);
          SET @end_time = GETDATE();
          PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
          SELECT COUNT (*) FROM bronze.crm_prd_info
          PRINT'-------------';


          SET @start_time = GETDATE();
          PRINT'>>Truncating Table:bronze.crm_sales_details';
          TRUNCATE TABLE bronze.crm_sales_details;
          PRINT'>>Inserting Data into Table:crm_sales_details';
          BULK INSERT bronze.crm_sales_details
          FROM 'D:\WAREHOUSE\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
          WITH (
          FIRSTROW=2,
          FIELDTERMINATOR=',',
          TABLOCK);
          SET @end_time = GETDATE();
          PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
          SELECT COUNT (*) FROM bronze.crm_sales_details
          PRINT'-------------';



          PRINT'--------------------------------';
          PRINT 'Loading ERP TABLES';
          PRINT'--------------------------------';

          SET @start_time = GETDATE();
          PRINT'>>Truncating Table:bronze.erp_cust_az12';
          TRUNCATE TABLE bronze.erp_cust_az12;
          PRINT'>>inserting \data into Table:bronze.erp_cust_az12';
          BULK INSERT bronze.erp_cust_az12
          FROM 'D:\WAREHOUSE\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
          WITH (
          FIRSTROW=2,
          FIELDTERMINATOR=',',
          TABLOCK);
          SET @end_time =GETDATE();
          PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
          SELECT COUNT (*) FROM bronze.erp_cust_az12
          PRINT'-------------';


          SET @start_time = GETDATE();
          PRINT'>>Truncating Table:bronze.erp_loc_a101';  
          TRUNCATE TABLE bronze.erp_loc_a101;
          PRINT'>>Inserting Data into Table:erp_loc_a101';
          BULK INSERT bronze.erp_loc_a101
          FROM 'D:\WAREHOUSE\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
          WITH (
          FIRSTROW=2,
          FIELDTERMINATOR=',',
          TABLOCK);
          SET @end_time = GETDATE();
          PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
          SELECT COUNT (*) FROM bronze.erp_loc_a101
          PRINT'-------------';


          SET @start_time = GETDATE();
          PRINT'>>Truncating Table:bronze.erp_px_cat_g1v2';     
          TRUNCATE TABLE bronze.erp_px_cat_g1v2;
          PRINT'>>inserting Data into Table:erp_px_cat_g1v2';
          BULK INSERT bronze.erp_px_cat_g1v2
          FROM 'D:\WAREHOUSE\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
          WITH (
          FIRSTROW=2,
          FIELDTERMINATOR=',',
          TABLOCK);
          SET @end_time = GETDATE();
          PRINT '>>Load Duration: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'Seconds';
          SELECT COUNT (*) FROM bronze.erp_px_cat_g1v2
          PRINT'-------------';

    SET @batch_end_time = GETDATE();
    PRINT '======================';
    PRINT 'Loading Bronze Layer is Complete'
    PRINT '>>>>>Total Load Duration: ' + CAST(DATEDIFF(second,@batch_start_time,@batch_end_time) AS NVARCHAR)+ 'Seconds';
    PRINT '=====================';

    END TRY
    BEGIN CATCH
    PRINT'=========================================';
    PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
    PRINT'Error Message' + ERROR_MESSAGE();
    PRINT'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
    PRINT'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
    PRINT'=========================================';
    END CATCH
 END
