# command linen args
args <- commandArgs(trailingOnly = TRUE)

# true data function 
fun = function(x, y) {
  x * x * exp(-x * y * y - y * y + 2 * y - 4 * x)
}

compare <- function(file = "data.tab", points = FALSE) {
  # read in data
  mat = read.table(file, header = TRUE)


  # actual distribution
  x = seq(0, 3, 0.1)
  y = seq(-1, 3, 0.1)
  z = outer(x, y, fun)
  op = par(mfrow = c(2, 1))
  on.exit(par(op))
  contour(x, y, z, main = "Contours of actual (unnormalized distribution)",
          xlim = c(0, 3), ylim = c(-1, 3))

  # density estimate
  require(KernSmooth)
  fit = bkde2D(as.matrix(mat[, 2:3]), c(0.1, 0.1))
  contour(fit$x1, fit$x2, fit$fhat, main = "Contours of empirical distribution",
          xlim = c(0, 3), ylim = c(-1, 3))
  if(points)
    points(mat[, 2], mat[, 3], col = scales::alpha('#8080FF', .01))

  # output
  print(summary(mat[, 2:3]))
}

# command line logic
if (length(args) == 0) {
  compare()
} else if (length(args) == 1) {
    compare(file = as.character(args[1]))
} else if (length(args) == 2) {
    compare(file = as.character(args[1]), points = as.logical(args[2]))
} else {
    stop("At least one argument must be supplied (file, points).\n", call. = FALSE)
}
