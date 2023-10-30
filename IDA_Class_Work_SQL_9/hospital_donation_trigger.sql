CREATE TRIGGER dbo.No_donation_without_wards
ON dbo.Donations

INSTEAD OF INSERT

AS

BEGIN
	
	DECLARE @int_val INT = (select count(*) from inserted)	

	IF @int_val > 1
		begin
			Print 'только по одной записи за раз'
			ROLLBACK TRANSACTION
		end		

		--DECLARE @new_donation_departmentID  INT = (SELECT Departments.id FROM inserted)				

		
		DECLARE @wards_quantity INT = (SELECT count(*) FROM inserted,
		(SELECT Wards.id as WardId, Departments.id  as DepID
		FROM Wards, Departments 	
		WHERE Wards.DepartmentID = Departments.id) AS WardList
		WHERE inserted.DepartmentID = WardList.DepID)


		IF @wards_quantity > 0
			begin
				INSERT INTO dbo.Donations
				(
				amount,
				[Date],
				DepartmentID,
				SponsorID
				)			
				SELECT * FROM inserted
			end
		ELSE 
			begin
				Print 'Error: no wards in this department'
				ROLLBACK TRANSACTION
			end

END