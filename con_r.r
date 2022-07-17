library(tidyverse)
library(RMySQL)

con = dbConnect(
    RMySQL::MySQL(),
    host = '127.0.0.1',
    port = 3306,
    user = 'root',
    password = 'GaboFuentes*3',
    dbname = 'sakila'
)

dbListTables(con)

query = dbSendQuery(
    con,
    'SELECT * FROM actor'
)

data = fetch(query, n = 5)

data |> as_tibble()
