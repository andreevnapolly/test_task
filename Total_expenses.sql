/*Defining the rate's velues*/
SELECT
	@First_Rate:= (Select Money From Rates Where ID = 1),
	@Second_Rate:= (Select Money From Rates Where ID = 2),
	@Third_Rate:= (Select Money From Rates Where ID = 3);
     
/*Counting total amount of minutes for the first rate*/
SELECT
  	@Total_min_First_rate:= (SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
	FROM Call_logs 
		WHERE (Call_dir = 'in');

/*Counting total amount of minutes for the second rate*/
SELECT
   	@Total_min_Second_rate:= (SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
	FROM Call_logs 
		WHERE (Call_dir = 'out') 
		AND
		(Call_logs.To IN (SELECT Phone_Number from Numbers));

/*Counting total amount of minutes for the third rate*/
SELECT
   	@Total_min_Third_rate:= (SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
	FROM Call_logs 
		WHERE (Call_dir = 'out') 
		AND
		(Call_logs.To NOT IN (SELECT Phone_Number from Numbers));


/*Counting the final result*/
SELECT @Result:= @First_Rate * @Total_min_First_rate + @Second_Rate * @Total_min_Second_rate + @Third_Rate * @Total_min_Third_rate AS Result 
