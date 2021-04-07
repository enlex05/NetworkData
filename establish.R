library(neuralnet)
library(caret)
setwd("¹¤×÷Ä¿Â¼")
exp=read.table("RNA-seq.txt",header=F,sep="\t",check.names=F,row.names = 1)
cluster=read.table("cluster.txt",header=F,sep="\t",check.names=F)
rt=merge(exp,cluster,all=FALSE)
Train<-createDataPartition(y=rt$cluster, p=0.8, list=F)
trainset<-rt[Train,]
testset<-rt[-Train,]
trainset$GNB2group<-trainset$cluster=="GNB2group"
trainset$GNB3group<-trainset$cluster=="GNB3group"
trainset$GNB5group<-trainset$cluster=="GNB5group"
network<-neuralnet(GNB2group+GNB3group+GNB5group~
                     GNB1+GNB2+GNB3+GNB5+GNG3+GNG4+GNG5+GNG10+GNG11+GNG12
                   ,trainset,hidden =5,threshold=0.01,linear.output=FALSE, learningrate = 0.03)
network$result.matrix
head(network$generalized.weights[[1]])
plot(network)
net.predict<-compute(network,testset[-11])$net.result
net.prediction<-c("GNB2group","GNB3group","GNB5group")[apply(net.predict,1,which.max)]
predict.table<-table(testset$cluster,net.prediction)
predict.table
confusionMatrix(predict.table)

