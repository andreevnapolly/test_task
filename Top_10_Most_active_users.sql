SELECT  Numbers.UID, COUNT(Call_logs.Call_id) AS Calls_Amount
FROM Call_logs 

INNER JOIN Numbers 
ON Call_logs.From = Numbers.Phone_Number


WHERE (Call_logs.Call_id NOT IN (SELECT B.Call_id
								FROM Call_logs AS A

								LEFT JOIN Call_logs AS B
								ON A.To = B.From

								INNER JOIN Call_forwarding AS C 
								on B.from = C.From

								WHERE (B.To = C.To) and (B.From = C.From) AND (B.Timestamp_start > A.Timestamp_end)
								GROUP BY B.Call_id))

GROUP BY Numbers.UID
ORDER BY Calls_Amount DESC
LIMIT 10
