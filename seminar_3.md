# Занятие 3 Работа с таблицами, простые графики

Загружаем данные из Интернета
```{r}
download.file('https://git.io/vaDJt',
                    'godwit.data.csv')

Godwits<-read.csv('godwit.data.csv',
                           as.is=TRUE)


Godwits<-read.csv('https://git.io/vaDJt',
                           as.is=TRUE)
```
форматируем и чистим таблицу
```{r}
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

tolower('DSGAGA   FGHDSAHDF')

table(Godwits$SEX)

Godwits_s<-subset(Godwits, 
     select=c(SEX, DATE, MASS, WING, TARS, yday))

Godwits_s$SEX<-as.factor(Godwits_s$SEX)

summary(Godwits_s)
```
Графики
```{r}
plot(Godwits_s)

Godwits_s$MASS[Godwits_s$MASS==999]<-NA
Godwits_s$WING[Godwits_s$WING==999]<-NA
Godwits_s$TARS[Godwits_s$TARS==999]<-NA

plot(Godwits_s$MASS ~ Godwits_s$SEX)

plot(Godwits_s$MASS ~ Godwits_s$WING)

plot(Godwits_s$MASS ~ Godwits_s$WING, 
      xlab='Wing length, mm',
      ylab='Mass, g', las=1)

plot(Godwits_s$MASS ~ Godwits_s$WING, 
      xlab='Wing length, mm',
      ylab='Mass, g', las=1, type='n')

points(Godwits_s$MASS[Godwits_s$SEX=='M'] ~ 
       Godwits_s$WING[Godwits_s$SEX=='M'],
       col='#66c2a5', pch=19)

points(Godwits_s$MASS[Godwits_s$SEX=='F'] ~ 
       Godwits_s$WING[Godwits_s$SEX=='F'],
       col='#8da0cb', pch=19 )

abline(h=mean(Godwits_s$MASS[Godwits_s$SEX=='M'], 
             na.rm=TRUE), col='#66c2a5', lwd=3)

abline(h=mean(Godwits_s$MASS[Godwits_s$SEX=='M'], 
             na.rm=TRUE), col='#66c2a5', lwd=3)
```