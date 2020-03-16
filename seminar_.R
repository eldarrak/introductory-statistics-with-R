#########
# логистическая регрессия
N<-180

X<-seq(1:N) # время

E_Y<- exp( 0.1*X)

Y<-rep(NA, N)# делаем пустой Y

for (i in 1:N) {
   Y[i]<-rpois(n=1,lambda=E_Y[i] )
}
plot(Y~X)
cumsum(Y)
plot(cumsum(Y)~X)












