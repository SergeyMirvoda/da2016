#В теле функции должна вызываться функция predict 
forecast <- function(arg1, arg2) { 
		return (arg1 + arg2)
	}
save(forecast, file='c:/temp/forecast.RData') #Этот файл будет загружен в C#