# занятие 8 

download.file('https://git.io/vxc8b', 'Data_for_pca.RData', mode='wb')

load('Data_for_pca.RData')

str(Data)

plot(Data)

Data<-Data[,-1]
Data_no_na<-na.omit(Data)
str(Data)
str(Data_no_na)

param.pca<-prcomp(Data_no_na, center=TRUE, scale=TRUE)

plot(param.pca)
biplot(param.pca, scale=FALSE)

summary(param.pca)

print(param.pca)

# GAM

library(mgcv)

install.packages('gamair')
library(gamair)

data(cairo)
str(cairo)
head(cairo)
tail(cairo)
summary(cairo)

plot(temp~time, data=cairo)

#save(cairo, file='cairo.RData')

cairo$tempC<-(cairo$temp-32)/1.8

Gam1<-gam(tempC~time+s(month), data=cairo[1:1000,])
summary(Gam1)

plot(Gam1)

Gam2<-gam(tempC~time+s(month, bs='cc', k=12), knots=list(month=c(0.5, 12.5)), data=cairo[1:1000,])
summary(Gam2)
plot(Gam2)








