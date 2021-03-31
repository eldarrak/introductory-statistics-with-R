---
title: "Конспект 1 и 2 семинаров, XXX"
output:
  word_document: default
  html_notebook: default
---

_Это Ваш личный блокнот, в котором Вы будете сегодня выполнять задания._

_Для того, чтобы запустить кусок кода нажмите кнопку *Run* или просто комбинацию клавиш *Ctrl+Shift+Enter*._

_В куски с тремя кавычками можно писать тект. Там же его можно запускать._

```{r}
1+10
```

_Для добавления нового куска кода вы можете воспользоваться кнопкой *Insert Chunk* или комбинацией клавиш *Ctrl+Alt+I*._

_Как только вы сохраняете блокнот, html, связанный с этим блокнотом тоже обновляется (нажмите кнопку *Preview* или *Ctrl+Shift+K*, чтобы посмотреть HTML)._


## Простые математические действия

```{r}
2*2

2^2

2+3*10

log(3)

?log
```

## Простые объекты

```{r}
a<-100
a
ls() # посмотреть объекты в памяти
a+20
rm(a)
```

## Вектор

```{r}
B<-c(2,3,8,1000) # concatenate - склеивание
B
B[1]
B>8
B>=8
B!=10
B==8
B[B>=8]

B[1]<-100
B

```
## Создаем случайную переменную
```{r}
Tail<-rnorm(n=10, mean=7, sd=1)
?rnorm

rnorm(n=5)

rnorm(10, 7, 1)

Tail

hist(Tail)


Tail_large<-rnorm(n=1000, mean=7, sd=1)
hist(Tail_large)

mean(Tail)
sd(Tail)
mean(rnorm(n=10, mean=7, sd=1))
```
## Создаем таблицу (data.frame)
```{r}
Parrots<-data.frame(Sex=c(rep('Female', 50), rep('Male', 50)),
                    Tail=c(rnorm(50, 7, 1), rnorm(50, 8, 1)))
Parrots
# другой способ
ParrotsF<-data.frame(Sex=c(rep('Female', 50)),
                    Tail=c(rnorm(50, 7, 1)))
ParrotsM<-data.frame(Sex=c(rep('Male', 50)),
                    Tail=c(rnorm(50, 8, 1)))
Parrots<-rbind(ParrotsF, ParrotsM)
Parrots
head(Parrots)
tail(Parrots)
```
## Операции с таблицей

```{r}
Parrots[1,] # первая строка 
Parrots[,1] # первый столбец 

Parrots[Parrots$Tail>10,] # найти строки, где столбец хвост больше 10

str(Parrots)

save(Parrots, file='Parrots.RData')

load('Parrots.RData')

write.csv(Parrots, file='Parrots.csv')

write.csv2(Parrots, file='Parrots.csv') # для русифицированного екселя

Parrots_new<-read.csv( file='Parrots.csv')

```

## Загружаем и смотрим на реальные данные

```{r}
download.file('https://git.io/vaDJt', 'godwit.data.csv')

Godwits<-read.csv('godwit.data.csv')

str(Godwits)

head(Godwits)

tail(Godwits)

Godwits$DATE<-as.Date(Godwits$DATE)
str(Godwits)

Godwits$Year<-as.numeric(format(Godwits$DATE, format='%Y')) # год

Godwits$yday<-as.numeric(format(Godwits$DATE, format='%j')) # день года
str(Godwits)

table(Godwits$SEX)

Godwits$SEX[Godwits$SEX==9 | Godwits$SEX=='o']<-NA

table(Godwits$SEX)

table(Godwits$SEX, useNA='always')

tolower('WEWdsdwWDW4DDWWefef6')

Godwits$SEX<-tolower(Godwits$SEX)
table(Godwits$SEX, useNA='always')

Godwits_s<-subset(Godwits, select=c(SEX, MASS, WING, TARS, Year, yday))

str(Godwits_s)


```
