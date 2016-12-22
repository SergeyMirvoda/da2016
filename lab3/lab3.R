#' ---
#' author: "Zhenyok Nazedwox"
#' ---

html = readLines("../data/forbes.htm")
length(html)
sum(nchar(html))

regex = "<td class=\"worth\">(.*)</td>"
worth = grep(regex, html, value=TRUE)
regex = "\\W{1}\\d+\\W{1}\\d*\\s?\\w+"
worth = regmatches(worth, regexpr(regex, worth))
worth

regex = "<h3>\\w+"
rich = grep(regex, html, value=TRUE, perl = TRUE)
rich = rich[3:length(rich)]
regex = "(\\w*.?\\s+\\w*&?\\s?\\w+|-\\w+)+[^<]?"
rich = regmatches(rich, regexpr(regex, rich, perl = TRUE))
rich

worths = as.double(gsub(",", ".", regmatches(worth, regexpr("\\d+(\\.|,)?\\d*", worth))))
worths
df = data.frame(rich, worths)
names(df) = c("Name", "Worth")
df
nrow(df)
richest = df[df$Worth == max(df$Worth),]
richest
nrow(richest)
df[df$Name == "Larry Ellison",]
df[duplicated(df$Worth),][1:10,]

worthsB = worths * 1000000000
worthsB
median(worthsB)
mean(worthsB)
sum(worthsB > 5000000000)
sum(worthsB > 10000000000)
sum(worthsB > 25000000000)
sum(worthsB)
sum(worthsB[1:5]) / sum(worthsB)
sum(worthsB[1:20]) / sum(worthsB)
householdNetWorth = 90196 * 1000000000
sum(worthsB) / householdNetWorth
