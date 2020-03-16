## линейная регрессия
N<-100

Height<-runif(n=N, 160, 190)

Weight=-110 + 1*Height

# Y=a+b*x
# Y=a+b*x + Epslion

Weight=-110 + 1*Height + rnorm(N, mean=0, sd=5)

plot(Weight~Height, pch='.')

Data<-data.frame(Weight=Weight, Height=Height)

Model1<-lm(Weight~Height, data=Data)

summary(Model1)

#var(Weight)
#1-4.889^2/102
#var(residuals(Model1))

Residuals<-residuals(Model1)
hist(Residuals)
sd(Residuals)

plot(Model1)

#Data[1,1]<-150
#Data[1,2]<-30
#Data[2,1]<-150
#Data[2,2]<-30
Model1<-lm(Weight~Height, data=Data)
plot(Model1)

# проверяем влияет ли рост на вес
# делаем модель без роста
Model2<-lm(Weight~1, data=Data)
summary(Model2)

# сравниваем
anova(Model1, Model2)
AIC(Model1, Model2)
# разница больше трех - значит модель с меньшим значением лучше
# если разница три, это значит p-level 0.05


N<-100

HeightM<-runif(n=N, 160, 190)
HeightF<-runif(n=N, 160, 190)

WeightM=-100 + 1.05*HeightM + rnorm(N, mean=0, sd=5)
WeightF=-110 + 1*HeightF + rnorm(N, mean=0, sd=5)

plot(Weight~Height, pch='.')

DataF<-data.frame(Weight=WeightF, Height=HeightF, Sex='F')
DataM<-data.frame(Weight=WeightM, Height=HeightM, Sex='M')

Data<-rbind(DataF, DataM)
head(Data)
tail(Data)

Model3<-lm(Weight~Height*Sex, data=Data)
summary(Model3)
###############################
# 
Model3a<-lm(Weight~Height+Sex+Height:Sex, data=Data)

Model4<-lm(Weight~Height+Sex, data=Data)
summary(Model4)

anova(Model3, Model4)

AIC(Model3, Model4)

Model5<-lm(Weight~Height, data=Data)
summary(Model5)
anova(Model4, Model5)
AIC(Model4, Model5)
# пол был важен

# теперь проверим рост

Model6<-lm(Weight~Sex, data=Data)
anova(Model4, Model6)
AIC(Model4, Model6)

plot(Weight~Height, data=Data, type='n')
points(Weight~Height, data=Data[Data$Sex=='F',], col='pink', pch=19)




