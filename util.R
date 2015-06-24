breakAt <-function(data,runlength){
  newframe <- data[1:runlength,]
  i<- 1
  
  while(i*runlength < nrow(data)){
    from <- (runlength * i) +1
    to <- runlength * (i+1)
    newframe <- data.frame(newframe, data[from:to,])
    i <- i + 1
  }
  newframe
}

restoreAt <- function(data,breakpoint){
    newframe <- data[1:breakpoint]
    i<- 1
    
    while(i*breakpoint < length(data)){
      from <- (breakpoint* i) +1
      to <- breakpoint * (i+1)
      newframe <- data.frame(newframe, data[from:to])
      i <- i + 1
    }
    newframe
  }

#Idompotent apply
iapply <- function (X, MARGIN, FUN, ...)  {
  dims <- c((1:length(dim(X)))[!(1:length(dim(X)) %in% MARGIN)], MARGIN)
  res <- apply(X, MARGIN, FUN)
  
  if (length(dim(res)) == length(dims)) {
    aperm(res, order(dims))
  } else {
    res
  }	
}

#A more general function is as follows where x is the number and k is the number of decimals to show.
specify_decimal <- function(x) format(round(x, 2), nsmall=2)




  
