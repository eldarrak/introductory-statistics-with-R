# Занятие 2 Базовые основы R
```{r}
Males<-data.frame(
        Sex=rep('Male', 50),
        Tail=rnorm(50, 50, 10))
Males

Females<-data.frame(
        Sex=rep('Female', 50),
        Tail=rnorm(50, 40, 10))
Swifts<-rbind(Males, Females)

Swifts

head(Swifts, 10)

tail(Swifts)

str(Swifts)

ls() # просмотреть объекты в памяти

?ls

Swifts[ 1:10, 2] # с первой по десятую строки во втором столбце

Swifts$Sex
Swifts[,1]

nrow(Swifts) # число колонок
ncol(Swifts) # число столбцов

Swifts[nrow(Swifts), ncol(Swifts)]<-40
Swifts$Tail[length(Swifts$Tail)]<-40


Swifts[Swifts$Tail>60,]

Swifts[Swifts$Sex=='Male',]


getwd() # посмотреть рабочую директорию
setwd('F:/tmp') # установить рабочую директорию

Сохраняем в внутреннем формате R
```{r}
save(Swifts, file='Swifts.RData')
load('Swifts.RData')
```



Сохраняем .csv файл
```{r}
write.csv2(Swifts, 
      file='Swifts.csv',
      row.names=FALSE)

Swifts<-read.csv2(file='Swifts.csv')
```

пакеты и библиотеки
```{r}
install.packages('FLightR')

library('nlme')
citation('nlme')

```
