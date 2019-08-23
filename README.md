<h1>Test Task Report </h1>

<em>First of all I want to thank you for such a cool task. That was not so easy for me, but gave the motivation to work on my knowledge.</em>



## DB structure

In general, DB represents a data from system which is used for communication between people by calling. DB includes information about it's users, their additional info and an information about calls which are going on though the system. 

<em>There are no defined Primary and Foreing Keys, so the shown connections between entities are related to the data analysis.</em>

### DB containes next tables:   
* <strong>Accounts</strong> containes an information about system's users: id and name. In this table UID can't be used as a PK because some UIDs are connected with 2 names, so UIT can not define the connection UID<->Name uniqly. 
* <strong>Numbers</strong> represents the information about user's phone numbers. In this table UID also can't be a PK, because some UIDs have 2 numbers connected;
* <strong>Rates</strong> includes the rates for different types of calls; 
* <strong>Call_logs</strong> 
* <strong>Call_Forwarding</strong> 

DB structure can be presented in UML data structure diagram:
[Image](https://github.com/andreevnapolly/test_task/blob/master/UML_diagram.sql)


<em>In additional, most of the parametrs (columns) can be NULL, what makes all connections between entities not strong. For examle, it's possible to create the row in the Numbers table with UID, which doesn't exist in the Accounts table. This situation is the same for all other entitie's relationships.     
Adding constraines such as strong connections by PK and FK, and rules for not NULL cells could structurise and control all DB data.</em>

All relationships which are shown on the diagram have next explanations:
1. One account has 0 or more numbers, while the one number can be connected to the 0 or more accounts;
2. One mumber can be used in 0 or more From-To pairs, while each From-To pairs can use 0 or more times phone numbers from Numbers table;
3. Call logs can use 0 or more times phone numbers from Number table, while one phone number from Number table can be used 0 or more times in Call logs;
4. 





## SQL requests 
### Total expenses
Total expences depend on 2 things: rate and how many minutes was used for each rate.
So my solution is based on counting time for each of 3 availiable rate's option. The full SQL script is [here](https://github.com/andreevnapolly/test_task/blob/master/Total_expenses.sql) 

The final resault is 3.2
