gibbs = function(N, thin) {
  x = 0
  y = 0
  cat(paste("Iter", "x", "y", "\n"))
  for (i in 1:N) {
    for (j in 1:thin) {
      x = rgamma(1, 3, y * y + 4)
      y = rnorm(1, 1 / (x + 1), 1 / sqrt(2 * x + 2))
    }
    cat(paste(i,x,y,"\n"))
  }
}

gibbs(50000, 1000)
