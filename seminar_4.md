# Занятие 4 Линейная регрессия

симулируем данные
```{r}

N<-100

Height<-runif(n=N, 160, 190)

Weight_ideal<-Height-110 
Weight_real<- rnorm(N, mean=Weight_ideal, sd=5)
Weight<-Height-110 + rnorm(N, mean=0, sd=5)
```


Weight=-110+1*Height + Epsilon
Y=a+b*x + Epsilon
a= intercept
b= slope

```{r}
#plot(Weight_real~Height, xlim=c(-10,190), ylim=c(-120,90))
#abline(a=-110, b=1)

Data<-data.frame(Weight=Weight, 
                 Height=Height)

Model<-lm(Weight ~ Height, data=Data)

summary(Model)

hist(residuals(Model))

plot(Data$Weight~Data$Height)

plot(Model)

#Data[1,1]<-300

Model2<-lm(Weight ~ 1, data=Data)


anova(Model2, Model)
AIC(Model2, Model)
```
