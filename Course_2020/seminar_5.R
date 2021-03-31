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

Data=data.frame(time=X, count=Y)

Model1<-glm(count~time, data=Data, family=poisson)
summary(Model1)

XX<-seq(1, 365)

YY_pred<-predict(Model1, newdata=data.frame(time=XX), se.fit=TRUE)

YY_pred_df<-data.frame(
     Mean=exp(YY_pred$fit), 
	 Mean_UCI=exp(YY_pred$fit+1.96*YY_pred$se.fit),
	 Mean_LCI=exp(YY_pred$fit-1.96*YY_pred$se.fit), 
	 time=XX )
plot(Mean~time, data=YY_pred_df, type='l')
lines(Mean_UCI~time, data=YY_pred_df, lty=2)
lines(Mean_LCI~time, data=YY_pred_df, lty=2)

download.file("https://git.io/vxZRh", "Geese_proportion.csv")

Data<-read.csv2('Geese_proportion.csv')

str(Data)

plot(Data$Autumn/(Data$Autumn+Data$Spring)~Data$Year)

GLM1<-glm(cbind(Autumn, Spring)~Year, family='binomial', data=Data)

summary(GLM1)
GLM2<-glm(cbind(Autumn, Spring)~1, family='binomial', data=Data)
AIC(GLM1, GLM2)

XX<-seq(min(Data$Year), max(Data$Year)+1000)

Y_pred<-predict(GLM1, newdata=data.frame(Year=XX), se.fit=TRUE)

Y_pred_df<-data.frame(
     Mean=plogis(Y_pred$fit), 
	 UCI=plogis(Y_pred$fit+1.96*Y_pred$se.fit),
	 LCI=plogis(Y_pred$fit-1.96*Y_pred$se.fit), 
	 Year=XX)
	 
plot(Data$Autumn/(Data$Autumn+Data$Spring)~Data$Year, xlim=c(1960, 3000))

lines(Mean~Year, data=Y_pred_df)
lines(UCI~Year, data=Y_pred_df, lty=2)
lines(LCI~Year, data=Y_pred_df, lty=2)















