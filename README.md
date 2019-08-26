<h1>Test Task Report </h1>

<em>First of all I want to thank you for such a cool task. That was not so easy for me, but gave the motivation to work on my knowledge.</em>



## DB structure

In general, DB represents a data from system which is used for communication between people by calling. DB includes information about it's users, their additional info and an information about calls which are going on though the system. 

<em>There are no defined Primary and Foreing Keys, so the shown connections between entities are related to the data analysis.</em>

### DB containes next tables:   
* <strong>Accounts</strong> contains an information about system's users: id and name. In this table UID can't be used as a PK because some UIDs are connected with 2 names, so UIT can not define the connection UID<->Name uniquely. 
* <strong>Numbers</strong> represents the information about user's phone numbers. In this table UID also can't be a PK, because some UIDs have 2 numbers connected;
* <strong>Rates</strong> includes the rates for different types of calls; 
* <strong>Call_logs</strong> contains the information about each call through the system;
* <strong>Call_Forwarding</strong> contains an information about call forwarding from one number to another and can be represented in a form like this, which shows the full lines of numbers connections:
![Image](https://github.com/andreevnapolly/test_task/blob/master/Connections.png) 


DB structure can be presented in UML data structure diagram:
![Image](https://github.com/andreevnapolly/test_task/blob/master/UML_diagram.png)


<em>In additional, most of the parameters (columns) can be NULL, what makes all connections between entities not strong. For example, it's possible to create the row in the Numbers table with UID, which doesn't exist in the Accounts table. This situation is the same for all other entities's relationships.     
Adding constraints such as strong connections by PK and FK, and rules for not NULL cells could structure and control all DB data.</em>

All relationships which are shown on the diagram have next explanations:
1. One account has 0 or more numbers, while the one number can be connected to the 0 or more accounts;
2. One number can be used in 0 or more From-To pairs, while each From-To pairs can use 0 or more times phone numbers from Numbers table;
3. Call logs can use 0 or more times phone numbers from Number table, while one phone number from Number table can be used 0 or more times in Call logs;
4. One Call-logs row can include 0 or 1 Account, while one Account can be used in 0 or more Call-logs notes;
5. One Call-logs row can include 0 or 1 Rate, while one Rate can be used in 0 or more Call-logs notes.




## SQL requests 
### Total expenses
Total expenses depend on 2 things: rate and how many minutes was used for each rate.
So my solution is based on counting time for each of 3 available rate's option. The full SQL script is [here](https://github.com/andreevnapolly/test_task/blob/master/Total_expenses.sql) 

The final result is 3.2.    

### Top 10: Most active users
The solution is based on idea that user's activity is counting on his initial calls. That means that all forwarding calls don't influence on user's activity. Than more user makes initial calls that more he is an active user.     

One more addition - the activity is counting only for people who have the personal UID in the system.    

The main task is to exclude all forwarding calls. The call can be forwarding if:
1. The pair of numbers 'From-To' is encounting in the table Call_forwarding; 
2. This call has a potential initial call. 

When all initial users calls are difined, it's easy to find users with the biggest amount of calls. The user for each call is an Account which phone number is defined as 'From' nubmer in the Call log.


The Final result is 
![Image](https://github.com/andreevnapolly/test_task/blob/master/Top_10_Most_Active_Users.png)
