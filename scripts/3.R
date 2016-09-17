seq(from = 1, to = 3, by = .5)
order(1:3, decreasing = TRUE)
rev(1:3)
i <- sample(5)
j <- order(i)
list(i, j)
j
i[order(i)]
