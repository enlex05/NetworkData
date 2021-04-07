library(neuralnet)
setwd("C:\\Users\\Enlex\\Desktop\\zhuanli\\NetworkData") 
load("network.RData")
rt=read.table("patient.txt",header=T,sep="\t",check.names=F,row.names = 1)
net.predict<-compute(network,rt)$net.result
net.prediction<-c("GNB2group","GNB3group","GNB5group")[apply(net.predict,1,which.max)]
net.prediction
