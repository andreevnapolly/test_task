SELECT   @Phone_number := Call_logs.From AS Phone_Number,   
@UID := (SELECT UID FROM Numbers WHERE Phone_Number = @Phone_number) AS User_ID,

		
		

@Final_Charge := 
	((SELECT
  	(SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
	FROM Call_logs 
		WHERE (Call_dir = 'in') AND (Call_logs.From = @Phone_number))* (Select Money From Rates Where ID = 1)) 
    +
   (( SELECT
   	(SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
	FROM Call_logs 
		WHERE (Call_dir = 'out') 
		AND
		(Call_logs.To IN (SELECT Phone_Number from Numbers))
        AND 
        (Call_logs.From = @Phone_number)) * (Select Money From Rates Where ID = 2))
     +   
     (( SELECT
   	(SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
	FROM Call_logs 
		WHERE (Call_dir = 'out') 
		AND
		(Call_logs.To NOT IN (SELECT Phone_Number from Numbers))
        AND 
        (Call_logs.From = @Phone_number)) * (Select Money From Rates Where ID = 3))   
        
        
	AS Final_Charge

FROM Call_logs 

INNER JOIN Numbers 
ON Call_logs.From = Numbers.Phone_number

GROUP BY Call_logs.From
ORDER BY Final_Charge DESC
LIMIT 10
