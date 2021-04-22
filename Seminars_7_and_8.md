---
title: "Семинары 7 и 8"
output: html_notebook
---

В этом задании нам понадобятся следующие файлы


- 1. Данные по заболеваемости коронавирусом в России

> Our world in data https://covid.ourworldindata.orgps://covid.ourworldindata.org

Выборка по России доступна на [моей странице в GitHub](https://git.io/JOOXp)
 
- 2. Данные по промерам малого веретенника из [Rakhimberdiev et al. 2018 Nat. Comms.](https://www.nature.com/articles/s41467-018-06673-5). 
RData файл доступен по адресу https://git.io/vxc8b.

## Пакеты и библиотеки в R
часть загружена автоматически

часть функций скачана, но не заружена
```{r}
??gam
library(mgcv)
№gam()
?gam
```
часть не загружена и не скачана
```{r}
install.packages('FLightR')
library(FLightR)
```
```{r}
citation('FLightR')

citation('mgcv')
```
## Книги по R

https://cran.r-project.org/doc/contrib/Shipunov-rbook.pdf

Analysing ecological data

Mixed effects models in ecology with R


## Биномиальная регрессия
Данные - пропорции..

Загружаем данные по коронавирусу

```{r}
Rus_data<-read.csv('https://git.io/JOOXp')
str(Rus_data)

Rus_data$date<-as.Date(Rus_data$date)
plot(total_cases~date, data=Rus_data, pch='.')

Rus_data_short<-Rus_data[Rus_data$date<'2020-04-20' &
                         Rus_data$date>='2020-03-01',]
head(Rus_data_short)
tail(Rus_data_short)
```

Логистическая регрессия количественных данных

Пуассон 
Y~ e^a+b*x
ln(Y)~a+b*x

Биномиальная регрессия

logit(p) = ln(p/(1-p)) =a+b*x

Биномиальная ошибка 

## Создаем колонки с пропорцией заболевших

```{r}

Rus_data_short$not_infected<-Rus_data_short$population-Rus_data_short$total_cases

M1<-glm(cbind(total_cases, not_infected)~date, family=binomial, data=Rus_data_short)

summary(M1)

XX<-seq(as.Date('2020-03-01'), as.Date('2020-09-01'), by='days')
Pred<-predict(M1, newdata=data.frame(date=XX), se.fit=TRUE)

Pred_df<-data.frame(Pred_mean=plogis(Pred$fit),
                    Pred_LCI=plogis(Pred$fit - 1.96*Pred$se.fit),
                    Pred_UCI=plogis(Pred$fit + 1.96*Pred$se.fit), 
                    date=XX)

plot(Pred_mean~date, data=Pred_df, type='lines')
lines(Pred_LCI~date, data=Pred_df, lty=2)
lines(Pred_UCI~date, data=Pred_df, lty=2)


plot(I(total_cases/not_infected)~date, data=Rus_data_short, type='points')
lines(Pred_mean~date, data=Pred_df)
lines(Pred_LCI~date, data=Pred_df, lty=2)
lines(Pred_UCI~date, data=Pred_df, lty=2)

```
Сравнение предсказания с реальными данными

```{r}
str(Rus_data)


plot(Pred_mean~date, data=Pred_df, type='lines')
lines(Pred_LCI~date, data=Pred_df, lty=2)
lines(Pred_UCI~date, data=Pred_df, lty=2)

abline(h=0.5)
abline(v=as.Date('2020-06-09'))
Pred_df[101,]

M1<-glm(cbind(total_cases, not_infected)~date, family=binomial, data=Rus_data_short)

M2<-glm(cbind(total_cases, not_infected)~1, family=binomial, data=Rus_data_short)

AIC(M1, M2)

#points(total_cases_per_million/1e6~date, data=Rus_data)
#tail(Rus_data$total_cases_per_million)
```
## Метод главных компонент

```{r}
download.file('https://git.io/vxc8b', destfile='Data_for_pca.RData', mode='wb')
load('Data_for_pca.RData')

str(Data)

Data<-Data[,-1] # убрали первую колонку
 
Data_no_na<-na.omit(Data)

str(Data) 
str(Data_no_na)

param.pca<-prcomp(Data_no_na, center=TRUE, scale=TRUE)

plot(param.pca)

biplot(param.pca, scale=TRUE)

biplot(param.pca, scale=FALSE)

print(param.pca)
 
```
