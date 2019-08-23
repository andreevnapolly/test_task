/*Берем из таблицы Rate значения ставок*/
SELECT
	 @First_Rate := (Select Money From Rates Where ID = 1),
     @Second_Rate := (Select Money From Rates Where ID = 2),
     @Third_Rate:= (Select Money From Rates Where ID = 3);
     
/*Считаем количество минут по первой ставке*/
SELECT
   @Total_min_First_rate:= (SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
FROM Call_logs 
	WHERE (Call_dir = 'in');

/*Считаем количество минут по второй ставке*/
SELECT
   @Total_min_Second_rate:= (SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
FROM Call_logs 
	WHERE (Call_dir = 'out') 
	AND
	(Call_logs.To IN (SELECT Phone_Number from Numbers));

/*Считаем количество минут по третьей ставке*/
SELECT
   @Total_min_Third_rate:= (SUM( (MINUTE (TIMEDIFF (Timestamp_end, Timestamp_start)) + IF (SECOND(TIMEDIFF (Timestamp_end, Timestamp_start)) > 0, 1, 0)) ))  
FROM Call_logs 
	WHERE (Call_dir = 'out') 
	AND
	(Call_logs.To NOT IN (SELECT Phone_Number from Numbers));

/*SELECT @First_Rate, @Second_Rate, @Third_Rate, @Total_min_First_rate, @Total_min_Second_rate, @Total_min_Third_rate;*/


/*Считаем итоговое значение*/
SELECT @Resoult := @First_Rate * @Total_min_First_rate + @Second_Rate * @Total_min_Second_rate + @Third_Rate * @Total_min_Third_rate AS Resoult 