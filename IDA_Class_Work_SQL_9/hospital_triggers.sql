CREATE TRIGGER dbo.examinations_check_qualification
ON dbo.Investigation

INSTEAD OF INSERT

AS

BEGIN
	--DECLARE @name_val
	DECLARE @float_val FLOAT = 1
	SET @float_val = 3.1427
	
	IF @float_val > 0.5
		begin
			SET @float_val = @float_val * 2
		end
	ELSE
		--begin
			SET @float_val = @float_val / 2 
		--end

	DECLARE @int_val INT = (select count(*) from inserted)

	IF @int_val > 1
		begin
			Print 'только по одной записи за раз'
			ROLLBACK TRANSACTION
		end
	ELSE
		begin	
			INSERT INTO dbo.Investigation
			(Pacient_ID,
			ILL_history_ID,
			[name],
			ward_id,
			DateStamp)		
			SELECT * FROM inserted
		end	
END