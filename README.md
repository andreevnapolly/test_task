<h1>Test Task Report </h1>

## Task 1. DB extract analysis



## Task 2. DB structure

DB containes next tables: 

There are no defined Primary and Foreing Keys, so the shown connections are related to the data analysis.

In Accounts table UID can't be a PK because some UIDs are connected with 2 names, so UIT can not define the connection UID<->Name uniqly.

In Numbers table UID also can't be a PK, because some UIDs have 2 numbers connected.


## Task 3. SQL requests 
### Total expenses
Total expences depend on 2 things: rate and how many minutes was used for each rate.
So my solution is based on counting time for each of 3 availiable rate's option. The full SQL script is [here](https://github.com/andreevnapolly/test_task/blob/master/Total_expenses.sql) 
