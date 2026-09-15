# --------------------------------------------
# SOUTH AFRICAN CRIME ANALYSIS - COMPLETE CODE
# Choropleth Map of Contact Crimes (2022/2023)
# --------------------------------------------

# 1. INSTALL & LOAD REQUIRED PACKAGES
install.packages(c("tidyverse", "sf", "geodata", "viridis"))  # Run once
library(tidyverse)
library(sf)
library(geodata)
library(viridis)

# 2. LOAD AND PREPARE CRIME DATA
crime_data <- read_csv("crime_incidents_by_category.csv")

# Filter for relevant year and crime category
crime_2023 <- crime_data %>%
  filter(`Crime Category` == "Contact Crimes",
         `Financial Year` == "2022/2023",
         Geography != "ZA")  # Remove national total

# Create province name lookup table
province_lookup <- data.frame(
  Geography = c("EC", "FS", "GT", "KZN", "LIM", "MP", "NW", "NC", "WC"),
  ADM1_EN = c("Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", 
              "Limpopo", "Mpumalanga", "North West", "Northern Cape", "Western Cape")
)

# Join lookup to crime data
crime_2023 <- crime_2023 %>%
  left_join(province_lookup, by = "Geography")

# 3. GET SOUTH AFRICA PROVINCE MAP GEOMETRY
sa_provinces <- gadm(country = "ZAF", level = 1, path = tempdir()) %>% 
  st_as_sf()

# 4. JOIN CRIME DATA TO MAP DATA
map_data <- sa_provinces %>%
  left_join(crime_2023, by = c("NAME_1" = "ADM1_EN"))

# 5. CREATE CHOROPLETH MAP
ggplot(data = map_data) + 
  geom_sf(aes(fill = Count)) +
  scale_fill_viridis_c(
    option = "plasma",
    direction = -1,
    name = "Number of\nContact Crimes",
    labels = scales::comma
  ) + 
  labs(
    title = "Contact Crimes in South African Provinces (2022/2023)",
    caption = "Data: South African Police Service (SAPS)"
  ) + 
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    panel.background = element_rect(fill = "white")  # White background
  )

# 6. SAVE THE MAP
ggsave("sa_contact_crimes_map.png", width = 10, height = 8, dpi = 300)

# Print completion message
print("Analysis complete! Map saved as 'sa_contact_crimes_map.png'")
