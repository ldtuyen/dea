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
CRS_IO_Result <- cbind(round(CRS_IOModel$thetaOpt,4))
rownames(CRS_IO_Result) <- Data[[1]]
colnames(CRS_IO_Result) <- c("Efficiency")
View(CRS_IO_Result)

CRS_OO_Result <- cbind(round(CRS_OOModel$thetaOpt,4))
rownames(CRS_OO_Result) <- Data[[1]]
colnames(CRS_OO_Result) <- c("Efficiency")
View(CRS_OO_Result)
