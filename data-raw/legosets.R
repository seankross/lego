library(XML)
library(dplyr)

# Read xml files
parsed_xml <- list()
for(i in 1970:2015){
  file_name <- file.path("data-raw", paste0(i, ".xml"))
  parsed_xml[[i]] <- xmlToDataFrame(xmlParse(file_name))
}

# Reduce list of xml data frames to one data frame
lego_raw <- tbl_df(Reduce(function(...) merge(..., all=T), parsed_xml))

# Filter raw data frame
legosets <- lego_raw %>% 
  filter(year >= 1970) %>% # Information on Legos before the 70s is too poor
  filter(UKRetailPrice != "" | USRetailPrice != "" | 
           CARetailPrice != "" | EURetailPrice != "") %>% # Each set should have a price in at least one currency
  select(setID, number, name, year, theme, subtheme, pieces, minifigs, 
         imageURL, UKRetailPrice, USRetailPrice, CARetailPrice,
         EURetailPrice, packagingType, availability) %>% # Select only relevant columns
  filter(theme != "Gear") %>% # Gear includes many items that are not actual Lego sets
  filter(!is.na(imageURL)) # Every set should have an image

# Re-format some data types
legosets$year <- as.integer(legosets$year)
legosets$pieces <- as.integer(legosets$pieces)
legosets$minifigs <- as.integer(legosets$minifigs)
legosets$USRetailPrice <- as.numeric(legosets$USRetailPrice)
legosets$UKRetailPrice <- as.numeric(legosets$UKRetailPrice)
legosets$EURetailPrice <- as.numeric(legosets$EURetailPrice)
legosets$CARetailPrice <- as.numeric(legosets$CARetailPrice)

legosets <- legosets %>% 
  mutate(Packaging = ifelse(packagingType == "{Not specified}", "Not specified",
                     ifelse(packagingType == "None (loose parts)", "Loose Parts",
                        packagingType))) %>%
  mutate(Availability = ifelse(availability == "{Not specified}", "Not specified", 
                               availability)) %>%
  select(number, name, year, theme, subtheme, pieces, 
               minifigs, imageURL, UKRetailPrice, USRetailPrice, 
               CARetailPrice, EURetailPrice, Packaging, Availability)

# Make new column names
colnames(legosets) <- c("Item_Number", "Name", "Year", "Theme", "Subtheme", "Pieces",
                    "Minifigures", "Image_URL", "GBP_MSRP", "USD_MSRP", "CAD_MSRP",
                    "EUR_MSRP", "Packaging", "Availability")

# Prettily arrange dataset
legosets <- arrange(legosets, desc(Year), Item_Number)

# Change some names which contain non-ascii characters
legosets$Name <- chartr("–üé", "-ue", legosets$Name)
legosets$Name <- gsub("°", " degree", legosets$Name)
legosets$Name <- gsub("•", "-", legosets$Name)

save(legosets, file="data/legosets.rda")
write.csv(legosets, file="data-tidy/legosets.csv", row.names = FALSE)
