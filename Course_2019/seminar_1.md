# Занятие 1 Базовые основы R


## R, как калькулятор, создание простых объектов 

```{r}
log(10)

2+3*6
A<-25
A
A+10

A^2

rm(A)
A
B<-c(1,4,100)
B

B*2

B[1] #first object from B
B>4
B[B>4]

B[B>=4]
B[B!=4] # not 4
B[B==4]

B[B==3]

C<-B[B>=2]
C=B[B>=2]

B<-c(B,C)

B[c(1,3)]

B[c(1,2,3)]

B[c(1:3)]

c(1:3)
B
B[-1]
B<-B[-1]

B<-B[-c(1,2)]

length(B)
B<-B[-length(B)]]

B<-B[-(length(B)-1)]]
```
## Нормальное распределение
```{r}
Tail<-rnorm(n=10, mean=50, sd=10)

?rnorm
??norm

hist(Tail)

Tail<-rnorm(1e6, 50, 10)
hist(Tail)

mean(Tail)
sd(Tail)
```

## Создание табицы с данными (dataframe)

```{r}
# делаем табличку
# ВАРИАНТ 1

Males<-data.frame(
        Sex=rep('Male', 50),
        Tail=rnorm(50, 50, 10))
Males

Females<-data.frame(
        Sex=rep('Female', 50),
        Tail=rnorm(50, 40, 10))
Swifts<-rbind(Males, Females)

```
