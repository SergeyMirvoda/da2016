#' ---
#' author: "Zhenyok Nazedwox"
#' ---

# Source data
library(MASS)
data(Cars93)

# -------------------------------------------------- Task 1 --------------------------------------------------
summary(Cars93)

# Lines amount in the dataframe
nrow(Cars93)

# Average price for rear wheel drive cars
rwdcars = subset(Cars93, DriveTrain == "Rear", select = Price)
mean(rwdcars[[1]])

# Min hp for 7-pass cars
cars7pass = subset(Cars93, Passengers == 7, select = Horsepower)
min(cars7pass[[1]])

# Min hp for 6-pass cars
cars6pass = subset(Cars93, Passengers == 6, select = Horsepower)
min(cars6pass[[1]])
# Secondary way
# cars6pass = Cars93[Cars93[, "Passengers"] == 6, "Horsepower"]

# Mileage for highway
mileage = Cars93[c("Make", "MPG.highway", "Fuel.tank.capacity")]
mileage$Mileage.highway = mileage$MPG.highway * mileage$Fuel.tank.capacity
# max
mileage[mileage[, "Mileage.highway"] == max(mileage[, "Mileage.highway"]), ]
# min
mileage[mileage[, "Mileage.highway"] == min(mileage[, "Mileage.highway"]), ]
# median
mileage[mileage[, "Mileage.highway"] == median(mileage[, "Mileage.highway"]), ]

# -------------------------------------------------- Task 2 --------------------------------------------------
factory.run <- function (o.cars=30, o.trucks=20) {
  factory <- matrix(c(40,1,60,3),nrow=2, dimnames=list(c("трудодни","сталь"),c("автомобили","грузовики")))
  warehouse <- c(1600,70) #Доступно материалов на складе
  names(warehouse) <- rownames(factory)
  reserve <- c(8,1)
  names(reserve) <- rownames(factory)
  output <- c(o.cars, o.trucks)
  names(output) <- colnames(factory)
  
  steps <- 0 # Счётчик числа шагов цикла
  repeat {
    steps <- steps + 1
    needed <- factory %*% output # Подсчитаем ресурсы, которые нам нужны для производства требуемого кол-ва машин
    message(steps)
    print(needed)
    # Если ресурсов достаточно и остаток меньше или равен резерву, то мы произвели максимум возможного.
    # Нужно прекращать
    if (all(needed <= warehouse) && all((warehouse - needed) <= reserve)) {
      break()
    }
    # Если заявка слишком большая и ресурсов недостаточно, уменьшим её на 10%
    if (all(needed > warehouse)) {
      output <- output * 0.9
      next()
    }
    # Если всё наоборот, то увеличим на 10%
    if (all(needed < warehouse)) {
      output <- output * 1.1
      next()
    }
    # Если мы потребили одного ресурса слишком много, а другого недостаточно,
    # то увеличим план на случайную величину
    output <- output * (1+runif(length(output),min=-0.1,max=0.1))
  }
  
  out <- c(round(sum(output)), needed, steps)
  out.names <- c("Total units produced", rownames(needed), "Steps")
  names(out) <- out.names
  return(out)
}

# f1 = factory.run()
# f2 = factory.run()
# f3 = factory.run()
# f4 = factory.run()
# Функция вызвана со значениями по умолчанию, то есть o.cars=1, o.trucks=1
# Результат всегда разный, так как есть ветка со случайной величиной