---
title: "Семинары 5 и 6"
output: html_notebook
---

В этом задании нам понадобятся следующие файлы

- 1. Изучите данные по соотношению роста и веса [народа Кунг](https://ru.wikipedia.org/wiki/%D0%9A%D1%83%D0%BD%D0%B3_(%D0%BD%D0%B0%D1%80%D0%BE%D0%B4))

> Demographic data from Kalahari !Kung San people collected by Nancy Howell in the 60's

Скачайте даные по данной [ссылке](https://git.io/JYx7y) и загрузите в R

- 2. Данные по заболеваемости коронавирусом в России

> Our world in data htthttps://covid.ourworldindata.orgps://covid.ourworldindata.org

Выборка по России доступна на [моей странице в GitHub](https://git.io/JOOXp)

## Загружаем данные по росту и весу

```{r}
Kung_data<-read.csv2('https://git.io/JYx7y')
str(Kung_data)
Kung_data$age<-as.numeric(Kung_data$age)
Kung_data$height<-as.numeric(Kung_data$height)
Kung_data$weight<-as.numeric(Kung_data$weight)
Kung_data$sex<-factor(Kung_data$male, labels=c('Female', 'Male'))
str(Kung_data)
Kung_adult<-Kung_data[Kung_data$age>15,]

```
Линейная модель зависимости роста от пола
```{r}

M1<-lm(weight~height*sex, data=Kung_adult)
summary(M1)

# тоже самое

M1a<-lm(weight~height+sex + height:sex , data=Kung_adult)
summary(M1a)

plot(M1)

```
Упрощаем модель

```{r}
M2<-lm(weight~height+sex, data=Kung_adult)

summary(M2)

anova(M1, M2)

AIC(M1, M2)
```
## Упрощаем дальше

```{r}
M3<-lm(weight ~ height, data = Kung_adult)

summary(M3)

anova(M2, M3)

AIC(M1, M2, M3)
```
Модель 3 лучшая!
```{r}
M4<-lm(weight~1, data = Kung_adult)

summary(M4)

mean(Kung_adult$height, na.rm=TRUE)

#anova(M3, M4) # не работает, т.к. где-то не было данных по полу, модели оперируют данными разной длины

M4<-lm(weight~1, data = Kung_adult[!is.na(Kung_adult$height),])

anova(M3, M4) 

AIC(M3, M4)

```

Строим графики

```{r}
plot(weight~height, data=Kung_adult, pch=19)
summary(M3)

XX<-seq(min(Kung_adult$height, na.rm=TRUE), max(Kung_adult$height, na.rm=TRUE), by=1)

XX

PredictM3<-predict(M3, newdata=data.frame(height=XX), se.fit=TRUE)

str(PredictM3)

Predict_df<-data.frame(height=XX, weight_mean=PredictM3$fit,
                      weight_LCI=PredictM3$fit-1.96*PredictM3$se.fit,
                      weight_UCI=PredictM3$fit+1.96*PredictM3$se.fit)

plot(weight~height, data=Kung_adult, pch=19)
lines(weight_mean~height, data=Predict_df)
lines(weight_UCI~height, data=Predict_df, lty=2)
lines(weight_LCI~height, data=Predict_df, lty=2)

```
## Логистическая регрессия

Данные целые числа..

Y = a + b*x + Epsilon; Epsilon~Norm(0, sigma^2)

E(Y) = e^(a+b*x); Y ~ Poisson(E(Y))

Симулируем данные

```{r}

Days<-seq(1, 200)

#Days<-runif(5000, 1, 200)

Exp_Y<-exp(1 + 0.01* Days)

Y<-rep(NA, length(Exp_Y))

for (i in 1:length(Exp_Y)) {
  Y[i]<-rpois(n=1,lambda=Exp_Y[i])
}

#Y

Id_data<-data.frame(Day=Days, Animals=Y)

plot(jitter(Animals)~Days, Id_data, pch='.')

```
Обобщенная линейная модель

```{r}

GLM1<-glm(Animals~Days, data=Id_data, family=poisson)
summary(GLM1)

```
## Коронавирус в России
Загружаем данные

```{r}
Rus_data<-read.csv('https://git.io/JOOXp')
str(Rus_data)

Rus_data$date<-as.Date(Rus_data$date)
plot(total_cases~date, data=Rus_data, pch='.')

Rus_data_short<-Rus_data[Rus_data$date<'2020-04-20' &
                         Rus_data$date>='2020-03-01',]
head(Rus_data_short)
tail(Rus_data_short)

plot(total_cases~date, Rus_data_short)

```
## Делаем модель.
```{r}
GLM2<-glm(total_cases~date, data=Rus_data_short, family=poisson)
summary(GLM2)
```
график

```{r}
XX<-seq(from=as.Date('2020-03-01'), to=as.Date('2020-06-01'), by='day')
Predict_1<-predict(GLM2, newdata=data.frame(date=XX), se.fit=TRUE, type='link')
str(Predict_1)

Pred_df<-data.frame(date=XX, Cases_mean=exp(Predict_1$fit),
                    cases_LCI=exp(Predict_1$fit-1.96*Predict_1$se.fit),
                    cases_UCI=exp(Predict_1$fit+1.96*Predict_1$se.fit))

plot(total_cases~date, Rus_data_short, xlim=c(as.Date('2020-03-01'), as.Date('2020-06-01')), ylim=c(0, 30000000))
lines(Cases_mean~date, Pred_df)
lines(cases_LCI~date, Pred_df, lty=2)
lines(cases_UCI~date, Pred_df, lty=2)

```