# Import data from SQL
import_sql <- function(statement, user, password, dbname, outdf) {

  connection = RMySQL::dbConnect(MySQL(),
                                 user= user,
                                 password= password,
                                 dbname= dbname,
                                 host='localhost')

  df <- dbSendQuery(connection, statement)
  df <- dbFetch(df, n = -1)

  assign(outdf, df, envir = parent.frame())

  RMySQL::dbDisconnect(connection)
}
