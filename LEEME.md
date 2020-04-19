# lego

Este paquete R data contiene información sobre cada juego de Legos fabricados desde 1970 hasta 2015, un total de 6172 juegos. Algunas de las variables incluídas para cada juego son:


- Número de ítem
- Nombre
- Año de fabricación
- Tema
- Número de piezas
- Número de mini figuras incluídas
- Precio

## Para instalar:

```r
library(devtools)
install_github("seankross/lego")
```

## Play well:

```r
library(dplyr)

avg_price_per_year <- legosets %>%
  filter(!is.na(USD_MSRP)) %>%
  group_by(Year) %>%
  do(data.frame(Price = mean(.$USD_MSRP)))

med_price_per_year <- legosets %>%
  filter(!is.na(USD_MSRP)) %>%
  group_by(Year) %>%
  do(data.frame(Price = median(.$USD_MSRP)))

plot(avg_price_per_year, type = "l", col = "blue", 
     main = "Lego set prices over time", ylim = c(0, max(avg_price_per_year$Price)))
points(med_price_per_year, type = "l", col = "red")
legend("topleft", inset=c(0.2,0), legend=c("Average","Median"), lty=c(1,1), col=c("blue", "red"))
```
