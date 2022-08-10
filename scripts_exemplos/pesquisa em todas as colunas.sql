DECLARE @schema_name NVARCHAR(10)
      , @table_name  NVARCHAR(MAX)
      , @colunn_name NVARCHAR(MAX)
      , @data_type   NVARCHAR(100)
	  , @ScriptCMD   nchar(3000)

---CREATE TABLE #tbtemp (schema_name NVARCHAR(10),table_name  NVARCHAR(MAX),colunn_name NVARCHAR(MAX),vl NVARCHAR(MAX)  )
TRUNCATE TABLE #tbtemp

DECLARE intancia_for CURSOR FOR

	SELECT [schema_name],[table_name],[colunn_name],[data_type]
	 FROM [SGBD].[vw_colunas]
		WHERE [idInstancia] = 17
		  AND idBaseDeDados = 101
		  AND (data_type = 'INT'
		   OR data_type = 'float'
		   OR data_type = 'tinyint')
OPEN intancia_for 
	FETCH NEXT FROM intancia_for INTO @schema_name, @table_name, @colunn_name, @data_type

		WHILE @@FETCH_STATUS = 0
		BEGIN


			SET @ScriptCMD ='SELECT '''+@schema_name+''','''+@table_name+''','''+@colunn_name+''','+@colunn_name+'
								FROM OPENQUERY([LNK_SQL_S-SEBN26189],''
								SELECT '+@colunn_name+'
								 FROM CM_IFR.'+@schema_name+'.'+@table_name+'
								  WHERE cast('+@colunn_name+' as nvarchar(max)) like  ''''391%''''
								       '' ) AS A '
			
			--PRINT @scriptcmd
			INSERT INTO #tbtemp exec sp_executesql @scriptcmd
		
			-- Alimenta a memória com o próximo registro.
			FETCH NEXT FROM intancia_for INTO @schema_name, @table_name, @colunn_name, @data_type
		END

CLOSE intancia_for
DEALLOCATE intancia_for

SELECT * FROM #tbtemp