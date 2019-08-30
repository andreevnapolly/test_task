SELECT  Numbers.UID, COUNT(Call_logs.Call_id) AS Calls_Amount
FROM Call_logs 

INNER JOIN Numbers 
ON Call_logs.From = Numbers.Phone_Number


WHERE (Call_logs.Call_id NOT IN (SELECT Numbers.Call_id
								FROM Call_logs 

								LEFT JOIN Call_logs
								ON Call_logs.To = Numbers.From

								INNER JOIN Call_forwarding AS C 
								on Numbers.from = Call_forwarding.From

								WHERE (Numbers.To = Call_forwarding.To) and (Numbers.From = Call_forwarding.From) AND (Numbers.Timestamp_start > Call_logs.Timestamp_end)
								GROUP BY Numbers.Call_id))

GROUP BY Numbers.UID
ORDER BY Calls_Amount DESC
LIMIT 10
