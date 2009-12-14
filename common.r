get_filename <- function (name)
{
  return(paste("R", "/", name, sep = ""))
}

set_png_output <- function (filename)
{
  png(file=get_filename(filename), bg = "white", width = 1000, height = 800)
}

### connects and loads the table data
get_dataset <- function (password)
{
  con <- dbConnect(dbDriver("MySQL"), dbname="adult", user="root", password=password)
  data <- dbReadTable(con, "adult")
  dbDisconnect(con)
  return(data)
}
