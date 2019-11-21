library(readr)
library(dplyr)
library(rDEA)
library(ggplot2)
Data <- read_csv("data.csv")
head(Data)
dplot <- data.frame(Data)


in_var <- select(Data, "OPERATING_EXPENSE","LOANS_TO_CUSTOMER","TOTAL_SECURITIES")
out_var <- select(Data, "FIXED_ASSETS" ,	"NET_INCOME" )
CRS_IOModel <- dea(XREF = in_var, YREF = out_var, X=in_var, Y=out_var, model = "input", RTS = "constant")
CRS_OOModel <- dea(XREF = in_var, YREF = out_var, X=in_var, Y=out_var, model = "output", RTS = "constant")

VRS_Model <- dea(XREF = in_var, YREF = out_var, X=in_var, Y=out_var, model = "input", RTS = "variable")
result1 <- cbind(round(CRS_IOModel$thetaOpt,4))
rownames(result1) <- Data[[1]]
colnames(result1) <- c("Efficiency")
View(result1)

result2 <- cbind(round(CRS_OOModel$thetaOpt,4))
rownames(result2) <- Data[[1]]
colnames(result2) <- c("Efficiency")
View(result2)
