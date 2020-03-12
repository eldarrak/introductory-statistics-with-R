## Meeting 1-3

2+2
log(2)

exp(3)

?log

A<-2+3

A+100

ls() # посмотреть объекты в памяти
rm() # стереть объекты

rm('A')

A<-100

?rm

rm(list=ls())

## вектор

B<-c(2,3,8, 1000)
B
B+10

B[1] # первый элемент вектора

B>10
B[B>10]
B[B<10]
B[B!=10]
B[B==10]

B[1]<-6
B<- B[-2]

B[c(1,2)]

?rnorm
Tail<-rnorm(n=30, mean=35, sd=5)
Tail

hist(Tail)

Tail<-rnorm(n=1000, mean=35, sd=5) # теперь тысячу
# 1000 == 1e3
# 1000000 == 1e6
Tail<-rnorm(n=1e7, mean=35, sd=5) # теперь тысячу
hist(Tail, breaks=10)

head(Tail, 10) # первые значения ветора
tail(Tail) # послендине значения вектора

mean(Tail)
sd(Tail)
summary(Tail)

mouse<-data.frame(Sex=c(rep('Male', 50), rep('Female', 50)),
      Tail=c(rnorm(50, 50, 5), rnorm(50, 35, 5)))

head(mouse)

str(mouse)
# mouse[строки , столбцы]
mouse[1 , ]

mouse[1 , 2]

mouse$Tail[1] # первое значение во второй колонке

mouse[mouse$Tail>50,]
mouse[mouse$Tail>50 & mouse$Sex=='Male',]
mouse[mouse$Tail>50 | mouse$Sex=='Male',]

############################
# вторая пара
getwd()
setwd('d:\\Department_MSU\\R')
A<-1
save(mouse, A, file='mouse.RData')

save.image('all.garbage.RData') # сохранить всё
rm('mouse')
mouse

load('mouse.RData')
mouse

ls() # посмотреть, что есть в памяти.

write.csv2(mouse, file='Mouse.csv', row.names=FALSE)

install.packages('FLightR') # установить пакет
library(FLightR) # загрузить пакет в память

citation()
citation('FLightR')

###############
# загружаем файл из Интернет
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
Godwits$DATE<-as.Date(Godwits$DATE)
as.Date(Godwits$DATE[1])
str(Godwits)

Godwits$Year<-as.numeric(format(Godwits$DATE, format='%Y'))

str(Godwits)
format(3.1415)

# доля года
Godwits$Year_part<-as.numeric(format(Godwits$DATE, format='%j'))/366

table(Godwits$SEX)

Godwits$SEX[Godwits$SEX=='9' | Godwits$SEX=='o' ]<-NA

Godwits$SEX[Godwits$SEX %in% c('9', 'o')]<-NA

table(Godwits$SEX, useNA='always')

Godwits$SEX<-tolower(Godwits$SEX)
table(Godwits$SEX, useNA='always')

tolower('gjposfjgo;ijgoijsg[JHPOHjkhuh')

Godwits_s<-subset(Godwits, select=c(SEX, MASS, WING, TARS, Year_part))

str(Godwits_s)

Godwits_s$SEX<-as.factor(Godwits_s$SEX)

summary(Godwits_s)

plot(Godwits_s)
Godwits_s$MASS[Godwits_s$MASS==999]<-NA
Godwits_s$WING[Godwits_s$WING==999]<-NA
Godwits_s$TARS[Godwits_s$TARS==999]<-NA
plot(Godwits_s)

plot(Godwits_s$MASS ~ Godwits_s$SEX)
plot(Godwits_s$MASS ~ Godwits_s$WING)

plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Wing, mm', ylab='Mass, g', las=1)
# подписи, повернули подписи х
plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Wing, mm', ylab='Mass, g', las=1, pch=19)
plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Wing, mm', ylab='Mass, g', las=1, pch=as.numeric(Godwits_s$SEX), col='black', bg='black') 

plot(Godwits_s$MASS ~ Godwits_s$WING, xlab='Wing, mm', ylab='Mass, g', las=1, type='n') 
points(Godwits_s$MASS[Godwits_s$SEX=='f'] ~ Godwits_s$WING[Godwits_s$SEX=='f'], pch=21, col='white', bg='#f1a340', cex=2) 
points(Godwits_s$MASS[Godwits_s$SEX=='m'] ~ Godwits_s$WING[Godwits_s$SEX=='m'], pch=21, col='white', bg='#998ec3', cex=2) 
