## Занятие 8 Главные компоненты и GAM

Загружаем данные

```{r}
download.file('https://git.io/vxc8b', 'Data_for_pca.RData', mode='wb')
load('Data_for_pca.RData')

str(Data)
```
Строим общую картинку

```{r}
plot(Data)
```
Убираем ненужные столбцы и пустые значения
```{r}
# Data_for_pca<-Data[,2:7]
Data_for_pca<-Data[,-1]

head(Data_for_pca)

Data_for_pca_no_na<-na.omit(Data_for_pca)

head(Data_for_pca_no_na)

nrow(Data_for_pca_no_na)
nrow(Data_for_pca)
```
Классический анализ главных компонент
```{r}
param.pca<-prcomp(Data_for_pca_no_na, center=TRUE, scale=TRUE)

plot(param.pca)

biplot(param.pca, scale=FALSE)

summary(param.pca)

print(param.pca)
```
Теперь сделаем анализ, устойчивый к пропущенным значениям

```{r}
source("https://bioconductor.org/biocLite.R")

biocLite("pcaMethods")

library('pcaMethods')

pc <- pca(Data_for_pca, nPcs=3, method="ppca", scale="uv", center=TRUE)

plot(pc)

biplot(pc, scale=TRUE)
```

GAM general additive models

Скачиваем пакет с данными
```{r}
install.packages('gamair') пакет с данными

```{r}
library(gamair)

data(cairo)

str(cairo)

tail(cairo)

plot(temp~time, data=cairo)
```

анализируем
```{r}
library(mgcv)

Gam1<-gam(temp ~ time + s(month), data=cairo)

summary(Gam1)

plot(Gam1)


Gam2<-gam(temp ~ time + s(month, bs="cc",k=12), knots = list(month = c(0.5, 12.5)), data=cairo)

summary(Gam2)

plot(Gam2)

cairo$monthday<-(cairo$month-1)+(cairo$day.of.month-1)/30

head(cairo)
str(cairo)

cairo$nyear<-as.numeric(as.character(cairo$year))


Gam3<-gam(temp ~ nyear + s(monthday, bs="cc",k=12), knots = list(monthday = c(0.5, 12.5)), data=cairo)

summary(Gam3)

plot(Gam3)
```
