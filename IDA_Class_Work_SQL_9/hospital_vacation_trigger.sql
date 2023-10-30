CREATE VIEW investigation_list as
		(SELECT * FROM Investigation, ILL_history
		Where Investigation.ILL_history_ID = ILL_history.id)