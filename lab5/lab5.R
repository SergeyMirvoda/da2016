gamma.estimate <- function(data) {
  m <- mean(data)
  v <- var(data)
  s <- v/m
  a <- m/s
  return(c(a=a,s=s))
}
