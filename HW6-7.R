# Installing package RPostgreSQL
#install.packages("RPostgreSQL")

# Loading package RPostgreSQL
require(RPostgreSQL)

# Loading Postgres driver
drv <- dbDriver("PostgreSQL")

# Opening connection
conn <- dbConnect(drv, host="localhost", user="postgres", password="parth0", dbname="CUNY")

# Creating SQL Statement
sql <- 'select a.ordr_number, to_char(a.ordr_date,\'DD-Mon-YYYY\') "Order Date", b.cust_name,'
sql <- paste(sql, " (b.cust_addr).street1, (b.cust_addr).street2,")
sql <- paste(sql, " (b.cust_addr).state, (b.cust_addr).zip, c.prod_name, c.prod_price")
sql <- paste(sql, ' from cuny_homework."order" a, cuny_homework.customer b, cuny_homework.products c')
sql <- paste(sql, ' where a.cust_numb = b.cust_id and a.prod_numb = c.prod_id')
sql <- paste(sql, " order by a.ordr_date")

# Submit the statement
res <- dbSendQuery(conn, sql)

# Fetching the records
# Starting the name of dataset variable with . so that it remains after cleanup
.query_data <- fetch(res, n=-1)

# Flashing pending data, Closing the connection and Freeing the resources on the driver
dbClearResult(res)
dbDisconnect(conn)
dbUnloadDriver(drv)

# Clearing the workspace
rm(list=ls())

# Open dataframe
View(.query_data)
