### Занятие 6 Обобщенные линейные модели - Целочисленная зависимая переменная

Сначала загрузим файл необходимый для занятия
```{r} 
download.file("https://git.io/vVQUv", "tree_swallow_data.csv")

Data<-read.csv("tree_swallow_data.csv", as.is=TRUE)

str(Data)

head(Data)
```
строим график и делаем линейную регрессию
```{r}

Data<-read.csv('tree_swallow_data.csv')

str(Data)

head(Data)

plot(nclutch~jd, data=Data, pch='.', cex=2)

plot(jitter(nclutch)~jitter(jd), data=Data, pch='.', cex=2)

Model1<-lm(nclutch~jd, data=Data)

summary(Model1)

plot(Model1)

hist(residuals(Model1))
```
Обсуждаем некорректность использования линейной регрессии для анализа размера кладки

линейная регрессия
Y~a+bx + ошибка (нормальная)

обобщенная линейная регрессия
Y~ e^(a+bx) + ошибка (пуассон)

```{r} 

GLM1<-glm(nclutch~jd, data=Data, family=poisson)

summary(GLM1)

Data$fseason<-as.factor(Data$nseason)

GLM2<-glm(nclutch~jd * fseason, data=Data, family=poisson)

GLM2<-glm(nclutch~jd + fseason +      jd:fseason, data=Data, family=poisson)

summary(GLM2)

GLM3<-glm(nclutch~jd + fseason, data=Data, family=poisson)

anova(GLM3, GLM2, test='Chisq')
AIC(GLM3, GLM2)

summary(GLM3)

anova(GLM3, GLM1, test='Chisq')
AIC(GLM3, GLM1)

GLM4<-glm(nclutch~1, data=Data, family=poisson)

anova(GLM4, GLM1, test='Chisq')
AIC(GLM4, GLM1)
```
строим график
```{r}
plot(jitter(nclutch)~jitter(jd), data=Data, pch='.', cex=2)

XX<-data.frame(jd=min(Data$jd):max(Data$jd))
XX

Y<-predict(GLM1, newdata=XX, se.fit=TRUE)
str(Y)

Pred_df<-data.frame(
   Mean=exp(Y$fit),
   UCI=exp(Y$fit+1.96*Y$se.fit),
   LCI=exp(Y$fit-1.96*Y$se.fit),
   X=XX$jd)

lines(Mean~X, data=Pred_df)
lines(UCI~X, data=Pred_df, lty=2)
lines(LCI~X, data=Pred_df, lty=2)

plot(jitter(nclutch)~jitter(jd), data=Data, pch='.', cex=2, xlim=c(120, 250))

XX<-data.frame(jd=min(Data$jd):250)

Y<-predict(GLM1, newdata=XX, se.fit=TRUE)
str(Y)

Pred_df<-data.frame(
   Mean=exp(Y$fit),
   UCI=exp(Y$fit+1.96*Y$se.fit),
   LCI=exp(Y$fit-1.96*Y$se.fit),
   X=XX$jd)

lines(Mean~X, data=Pred_df)
lines(UCI~X, data=Pred_df, lty=2)
lines(LCI~X, data=Pred_df, lty=2)
```