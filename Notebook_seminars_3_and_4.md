---
title: "Семинары 3 и 4"
output: html_notebook
---

Загружаем данные по веретеннику

```{r}
download.file('https://git.io/vaDJt',
                    'godwit.data.csv')

Godwits<-read.csv('godwit.data.csv') # дата стала фактором
#, as.is=TRUE)
str(Godwits)
Godwits<-read.csv('godwit.data.csv'
, as.is=TRUE)
str(Godwits)

head(Godwits)
Godwits$DATE<-as.Date(Godwits$DATE)
Godwits$Year<-as.numeric(format(Godwits$DATE, format='%Y'))
# доля года
Godwits$yday<-as.numeric(format(Godwits$DATE, format='%j'))

Godwits$SEX[Godwits$SEX %in% c('9', 'o')]<-NA

Godwits$SEX<-tolower(Godwits$SEX)

Godwits_s<-subset(Godwits, select=c(SEX, MASS, WING, TARS, yday))

Godwits_s$SEX<-as.factor(Godwits_s$SEX)
```

Посмотрим на выбросы

```{r}
hist(Godwits_s$MASS)
```
```{r}
summary(Godwits_s$MASS)

Godwits_s$MASS[Godwits_s$MASS==999]<-NA
Godwits_s$WING[Godwits_s$WING==999]<-NA
Godwits_s$TARS[Godwits_s$TARS==999]<-NA

summary(Godwits_s$MASS)

```
## Простые графики
```{r}
plot(Godwits_s)

str(Godwits_s)

summary(Godwits_s)

plot(Godwits_s$MASS ~ Godwits_s$SEX)
```
зависимость массы от длины крыла

```{r}
plot(Godwits_s$MASS ~ Godwits_s$WING)

plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Крыло, мм', ylab='Масса, г', las=1)

plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Крыло, мм', ylab='Масса, г', las=1, pch=19)
```

```{r}
# самцы и самки разным цветами
plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Крыло, мм', ylab='Масса, г', las=1, type='n') # пустой график

points(Godwits_s$MASS[Godwits_s$SEX=='m'] ~ Godwits_s$WING[Godwits_s$SEX=='m'],        pch=21, col='white', bg='#8da0cb')

points(Godwits_s$MASS[Godwits_s$SEX=='f'] ~ Godwits_s$WING[Godwits_s$SEX=='f'],        pch=22, col='white', bg='#66c2a5')

mean(Godwits_s$MASS[Godwits_s$SEX=='m'], na.rm=TRUE)

abline(h=mean(Godwits_s$MASS[Godwits_s$SEX=='m'], na.rm=TRUE), col='blue')

```
подбор цветов для графика
https://colorbrewer2.org/#type=qualitative&scheme=Pastel1&n=3

https://cran.r-project.org/web/packages/ggsci/vignettes/ggsci.html

векторный формат - pdf

растровый формат - png


сохраняем картинку
```{r}

pdf(file='figure_1.pdf')
# самцы и самки разным цветами
plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Крыло, мм', ylab='Масса, г', las=1, type='n') # пустой график

points(Godwits_s$MASS[Godwits_s$SEX=='m'] ~ Godwits_s$WING[Godwits_s$SEX=='m'],        pch=21, col='white', bg='#8da0cb')

points(Godwits_s$MASS[Godwits_s$SEX=='f'] ~ Godwits_s$WING[Godwits_s$SEX=='f'],        pch=22, col='white', bg='#66c2a5')

abline(h=mean(Godwits_s$MASS[Godwits_s$SEX=='m'], na.rm=TRUE), col='blue')

dev.off()

```
## Линейная регрессия

`Y = a + b*x` уравнение прямой

`Y = a + b*x + \Epsilon` 

```{r}
N<-50

Height<-runif(n=N, 160, 190) # равномерно случайный рост

hist(Height)

Weight<- -110 + 1*Height

plot(Weight~Height) # неправдоподбно - нет разброса значений

Weight<- -110 + 1*Height + rnorm(n=N, mean=0, sd=5)

plot(Weight~Height) 

Data<-data.frame(Height=Height, Weight=Weight)
str(Data)
```

```{r}

Model1<-lm(Weight ~ Height, data=Data)

summary(Model1)

Residuals<-residuals(Model1)
hist(Residuals)
sd(Residuals)

plot(Model1)

# график 1 - проверка гетероскедастичности

# график 4 - влияние точки на результаты регрессии
```
Добавим выбросы

```{r}
head(Data)

Data_1<-Data

Data_1[1,1]<-210
Data_1[1,2]<-70

plot(Weight~Height, data=Data_1)

Model1<-lm(Weight ~ Height, data=Data_1)

summary(Model1)

plot(Model1)
```
Зависимость веса от роста..
альтернатива - вес не меняется при изменении роста..

вес = a + b*рост

если b == 0, то вес не зависит от роста

```{r}
Model1<-lm(Weight ~ Height, data=Data)

Model2<-lm(Weight ~ 1, data=Data)

anova(Model1, Model2)

AIC(Model1, Model2)

```
Разница в AIC > 3, значимость отличия с p<0.05.

## двухфакторная регрессия
симулируем данные

```{r}
N<-1000
HeightM<-runif(n=N, 160, 190)
HeightF<-runif(n=N, 160, 190)

WeightM<- -100 +1.05*HeightM + rnorm(N, mean=0, sd=5)
WeightF<- -110 +1*HeightF + rnorm(N, mean=0, sd=5)

DataM<- data.frame(Height=HeightM, Weight=WeightM, Sex='M')
DataF<- data.frame(Height=HeightF, Weight=WeightF, Sex='F')

DataS<-rbind(DataM, DataF)
str(DataS)
head(DataS)
```
## Модель с полным взаимодействием

```{r}
ModelS<-lm(Weight ~ Height*Sex, data=DataS)

summary(ModelS)

```
 (Intercept) - значение веса, когда все остальные переменные равны 0
 
 Height - наклон для девочек
 
 SexM - отличие веса мальчиков с при нулевом росте
 
 Height:SexM - отличие наклона мальчиков от девочек
 
 ## Построим график
 
```{r}
plot(Weight ~ Height, data=DataS, type='n')
points(Weight ~ Height, data=DataS[DataS$Sex=='F',], col='blue')
abline(a= -129, b=1.11457, col='blue')

points(Weight ~ Height, data=DataS[DataS$Sex=='M',], col='red')

abline(a= -129 +29.05430, b=1.11457-0.06058, col='red')

```
Тестируем разницу в наклонах

```{r}

ModelS<-lm(Weight ~ Height*Sex, data=DataS)

ModelS2<-lm(Weight ~ Height+Sex, data=DataS)

summary(ModelS2)

anova(ModelS, ModelS2)
AIC(ModelS, ModelS2)

``` 
 