### Занятие 7 Обобщенные линейные модели - Пропорции в зависимой переменной
Сначала загрузим файл необходимый для занятия

```{r}
download.file("https://git.io/vxZRh", "Geese_proportion.csv")

Data<-read.csv2('Geese_proportion.csv')

head(Data)
```
строим график
```{r}
plot(Data$Autumn/(Data$Autumn+Data$Spring) ~ Data$Year)

``` 
биномиальная регрессия

```
GLM5<-glm(cbind(Autumn,Spring) ~ Year, family='binomial', data=Data)
summary(GLM5)

GLM6<-glm(cbind(Data$Autumn,Data$Spring) ~ 1, family='binomial')

AIC(GLM5, GLM6)

XX<-data.frame(Year=min(Data$Year):max(Data$Year))

Y<-predict(GLM5, newdata=XX, se.fit=TRUE)

Pred_df<-data.frame(
   Mean=plogis(Y$fit),
   UCI=plogis(Y$fit+1.96*Y$se.fit),
   LCI=plogis(Y$fit-1.96*Y$se.fit),
   X=XX$Year)
   
plot(Data$Autumn/(Data$Autumn+Data$Spring) ~ Data$Year)
   
lines(Mean~X, data=Pred_df)
lines(UCI~X, data=Pred_df, lty=2)
lines(LCI~X, data=Pred_df, lty=2)
   
```