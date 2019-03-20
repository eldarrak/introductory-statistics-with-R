# Занятие 5 Линейная регрессия

Читаем и чистим данные
```
Godwits<-read.csv('https://git.io/vaDJt',
                          as.is=TRUE)

head(Godwits)

tail(Godwits)
str(Godwits)
Godwits$DATE<-as.Date(Godwits$DATE)
str(Godwits)

Godwits$yday<-format(Godwits$DATE,
                       format='%j')

format(Godwits$DATE[1:10], format='%j')
format(Godwits$DATE[1:10], format='%Y')


Godwits$yday<-as.numeric(format(Godwits$DATE,
                       format='%Y'))

table(Godwits$SEX)
Godwits$SEX[Godwits$SEX==9 | 
            Godwits$SEX=='o']<-NA

Godwits$SEX[Godwits$SEX %in% c(9, 'o')]<-NA

Godwits$SEX<-toupper(Godwits$SEX)

table(Godwits$SEX)

Godwits_s<-subset(Godwits, 
     select=c(SEX, DATE, MASS, WING, TARS, yday))

Godwits_s$SEX<-as.factor(Godwits_s$SEX)

Godwits_s$MASS[Godwits_s$MASS==999]<-NA
Godwits_s$WING[Godwits_s$WING==999]<-NA
Godwits_s$TARS[Godwits_s$TARS==999]<-NA
```

Проверяем зависимость массы птиц от пола и крыла
Строим модель со взаимодействием
```{r}
str(Godwits_s)

Model1<-lm(MASS~ SEX * WING,
              data=Godwits_s)

summary(Model1)

plot(Model1)

# другой вариант написания той же модели
Model1a<-lm(MASS~ SEX + WING + 
           SEX:WING, data=Godwits_s)
summary(Model1a)
```
Проверяем значимсоть взаимодействия

```{r}
Model2<-lm(MASS~ SEX + WING,
              data=Godwits_s)

summary(Model2)

anova(Model1, Model2)

AIC(Model1, Model2)
```
взаимодействие оказалось статистически не значимым

пробуем упрощать дальше

```{r}
# сначала убираем все NA
Godwits_s_no_na<-subset(Godwits_s, 
           select=c(MASS, SEX, WING))
nrow(Godwits_s_no_na)
Godwits_s_no_na<-na.omit(Godwits_s_no_na)
nrow(Godwits_s_no_na)

Model3<-lm(MASS~ SEX,
              data=Godwits_s_no_na)

anova(Model2, Model3)

Model4<-lm(MASS~ WING,
              data=Godwits_s_no_na)

anova(Model2, Model4)

AIC(Model1, Model2, Model3, Model4)

```
Заключаем что модель с влиянием и пола и длины крыла была лучшей

Строим графики
```{r}
plot(MASS~WING, data=Godwits_s_no_na,
       type='n')

points(MASS~WING, 
       data=subset(Godwits_s_no_na, SEX=='M'),
       col='blue')

points(MASS~WING, 
       data=subset(Godwits_s_no_na, SEX=='F'),
       col='red')

XX_F<-data.frame(SEX='F', WING=
     min(Godwits_s_no_na$WING): 
    max(Godwits_s_no_na$WING))

XX_M<-data.frame(SEX='M', WING=
     min(Godwits_s_no_na$WING): 
    max(Godwits_s_no_na$WING))

Pred_F<-predict(Model2, newdata=XX_F, 
                se.fit=TRUE)

str(Pred_F)
Pred_M<-predict(Model2, newdata=XX_M, 
                se.fit=TRUE)

Pred_df<-data.frame(
   Female_mean=Pred_F$fit,
   Female_UCI=Pred_F$fit+1.96*Pred_F$se.fit,
   Female_LCI=Pred_F$fit-1.96*Pred_F$se.fit,
   Male_mean=Pred_M$fit,
   Male_UCI=Pred_M$fit+1.96*Pred_M$se.fit,
   Male_LCI=Pred_M$fit-1.96*Pred_M$se.fit,
   Wing=XX_F$WING)

lines(Female_mean~Wing, 
      data=Pred_df, col='red', lwd=2)
lines(Female_UCI~Wing, 
      data=Pred_df, col='red', lwd=2, lty=2)
lines(Female_LCI~Wing, 
      data=Pred_df, col='red', lwd=2, lty=2)

lines(Male_mean~Wing, 
      data=Pred_df, col='blue', lwd=2)
lines(Male_UCI~Wing, 
      data=Pred_df, col='blue', lwd=2, lty=2)
lines(Male_LCI~Wing, 
      data=Pred_df, col='blue', lwd=2, lty=2)
```
