#connect to SQL Server (postgresql)
library(RPostgreSQL)
library(tidyverse)

filepath_ini <- "D:/learning/Data Rockie/basic_r/config/config.ini"
ini_file <- read.ini(filepath_ini, encoding = getOption("encoding")) 

conn <- dbConnect(PostgreSQL(), 
                  host = data$account$host,
                  port = data$account$port,
                  user = data$account$user,
                  password = data$account$password,
                  dbname = data$account$dbname)

dbListTables(conn)

#create pizza menu table
pizza_menu <- data.frame(
  menu_id = 1:5,
  menu_name = c("Hawaiian", "Seafood", "Cheese", "Pepperoni", "Veggie"),
  price = c(349, 399, 279, 279, 249)
)
dbWriteTable(conn, "pizza_menu", pizza_menu)
dbGetQuery(conn, "select * from pizza_menu")

#create customers table
customers <- data.frame(
  customer_id = 1:6, 
  customer_name = c("Anna", "John", "Sam", "Jojo", "Marry", "Lily"),
  city = c("Bangkok", "London", "Bangkok", "London", "London", "Bangkok"))
dbWriteTable(conn, "customers", customers)

#create orders table
orders <- data.frame(
  order_id = 1:8, 
  customer_id = c(1, 1, 4, 4, 5, 5, 3, 6),
  menu_id = c(1, 2, 3, 5, 2, 4, 2, 3),
  order_date = c("2023-01-01", "2023-01-01", "2023-01-01", "2023-01-01", "2023-01-03", "2023-01-03", "2023-01-03", "2023-01-03"))
dbWriteTable(conn, "orders", orders)

#create transactions table
transactions <- data.frame(
  transaction_id = 1:8, 
  order_id = 1:8,
  total_price = c(349, 399, 279, 349, 399, 279, 399, 279),
  payment_method = c("cash", "cash", "credit card", "credit card", "credit card", "credit card", "credit card", "cash"))
dbWriteTable(conn, "transactions", transactions)

# check database list
dbListTables(conn)

# remove database
dbRemoveTable(conn, "pizza_menu")
dbRemoveTable(conn, "customers")
dbRemoveTable(conn, "orders")
dbRemoveTable(conn, "transactions")
dbListTables(conn)

#close connection
dbDisconnect(conn)
