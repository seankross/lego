# lego

This R data package contains information about every Lego set manufactured from 1970 to 2015, a total of 6172 sets. A few of the variables included for each set are:

- Item number
- Name
- Year manufactured
- Theme
- Number of pieces
- Number of minifigures included
- Price

##             To install:

```r
library(devtools)
install_github("seankross/lego")
```

##              Play well:

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
