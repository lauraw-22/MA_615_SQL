library(tidyverse)

library(RSQLite)
library(DBI)
library(readxl)


# con <- dbConnect(SQLite(),"chinook.db")
# dbGetQuery(con,
#            "SELECT FirstName, LastName 
#            FROM Customers
#            where Country = 'Brazil';" )

## read data
donars_des <- read_excel("Top_MA_Donors_2016-2020.xlsx",sheet = 1)
contrib_all <- read_excel("Top_MA_Donors_2016-2020.xlsx",sheet = 2)
JFC <- read_excel("Top_MA_Donors_2016-2020.xlsx",sheet = 3)

length(unique(contrib_all$fectransid))


## Seperate table

transactions <- select(contrib_all,fectransid,cycle,date,amount,type,contribid,fam,recipid,cmteid)%>%distinct()

contributors <- select(contrib_all,contribid,fam,contrib,lastname,State,City,Zip,Fecoccemp,orgname)%>%distinct()

recipients <- select(contrib_all,recipid,recipient,party,recipcode)%>%distinct()

orgs <- select(contrib_all,orgname,ultorg)%>%distinct()%>% na.omit()


mydb <- dbConnect(SQLite(),"Laura_Wang_Political_Contribution.sqlite")
dbWriteTable(conn = mydb,value=transactions,name="transactions")
dbWriteTable(conn = mydb,value=contributors,name="contributors")
dbWriteTable(conn = mydb,value=recipients,name="recipients")
dbWriteTable(conn = mydb,value=orgs,name="orgs")






