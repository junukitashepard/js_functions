# Written by user Renger on https://forum.gamsworld.org/viewtopic.php?t=9966
rgdx.var <- function(varname) {
  var.data <- data.frame(varname$val)
  var.dim <- length(varname$uels)
  domains <- varname$domains
  for (j in (1:(var.dim))) {
    if (domains[j] == "*") {
      domains[j] <- paste("X", j, sep = "")
    }
  }
  for (i in 1:var.dim) {
    dim           <- data.frame(varname$uels[[i]])
    dim$id        <- seq_along(dim[, 1])
    index         <- varname$domains[i]
    colnames(dim) <- c(index, "id")
    var.colname   <- paste("X", i, sep = "")
    var.data      <- merge(dim, var.data, by.x = "id", by.y = var.colname)
    var.data      <- var.data[, -which(colnames(var.data) == "id")]
  }
  var.data <- var.data[, c(var.dim:1, var.dim + 1)]
  colnames(var.data)[var.dim + 1]  <- c("value")
  colnames(var.data)[var.dim]      <- "field"
  attributes(var.data)$domains     <- varname$domains
  attributes(var.data)$type        <- "variable"
  attributes(var.data)$symName     <- varname$name
  attributes(var.data)$description <- varname$description
  return(var.data)
}
