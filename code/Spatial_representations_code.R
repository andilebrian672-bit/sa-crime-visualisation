
# 1. LOAD REQUIRED PACKAGES
library(tidyverse)
library(sf)
library(geodata)

# 2. LOAD & PREPARE CRIME DATA 
crime_data <- read_csv("crime_incidents_by_category.csv")

# Create province name lookup table
province_lookup <- data.frame(
  Geography = c("EC", "FS", "GT", "KZN", "LIM", "MP", "NW", "NC", "WC"),
  Province = c("Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", 
               "Limpopo", "Mpumalanga", "North West", "Northern Cape", "Western Cape")
)

# Join lookup to crime data
crime_data <- crime_data %>%
  left_join(province_lookup, by = "Geography")

# 3. ADD PROVINCIAL POPULATION DATA (Using 2021 as a stable mid-point estimate)
population_data <- data.frame(
  Province = c("Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", 
               "Limpopo", "Mpumalanga", "North West", "Northern Cape", "Western Cape"),
  Population = c(6726372, 2924001, 15943576, 11406373, 
                 5924973, 4593252, 4103550, 1320908, 7111643) # Source: Stats SA 2021
)

# 4. CALCULATE AVERAGE ANNUAL CRIME RATE
# Filter for Contact Crimes and remove national total (ZA)
average_crime_rate_data <- crime_data %>%
  filter(`Crime Category` == "Contact Crimes",
         Geography != "ZA") %>%
  left_join(population_data, by = "Province") %>%
  # Calculate the annual rate for each province for each year
  mutate(Annual_Rate = (Count / Population) * 100000) %>%
  # Now calculate the average rate for each province across all years
  group_by(Province) %>%
  summarise(Average_Annual_Rate = mean(Annual_Rate), .groups = 'drop')

# 5. GET SOUTH AFRICA PROVINCE MAP GEOMETRY
sa_provinces <- gadm(country = "ZAF", level = 1, path = tempdir()) %>% 
  st_as_sf() %>%
  select(NAME_1, geometry) %>%
  rename(Province = NAME_1)

# 6. JOIN AVERAGE CRIME RATE DATA TO MAP DATA
map_data_average_rate <- sa_provinces %>%
  left_join(average_crime_rate_data, by = "Province")

# 7. CREATE CHOROPLETH MAP
ggplot(data = map_data_average_rate) + 
  geom_sf(aes(fill = Average_Annual_Rate)) + # Color provinces by the AVERAGE rate
  scale_fill_viridis_c(
    option = "inferno", 
    direction = -1,
    name = "Avg. Annual Crimes\nper 100,000 people" # Update legend title
  ) + 
  geom_sf_text(aes(label = Province), size = 3, color = "black", fontface = "bold") +
  labs(
    title = "Average Annual Contact Crime Rate in South Africa (2011-2021)",
    subtitle = "Mean number of incidents per 100,000 people per year | Source: SAPS & Stats SA",
    caption = "Data: South African Police Service (SAPS) & Statistics South Africa"
  ) +
  theme_void() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    plot.subtitle = element_text(hjust = 0.5, size = 12, margin = margin(b = 10)),
    legend.position = "bottom",
    legend.key.width = unit(1.5, "cm"),
    panel.background = element_rect(fill = "white")
  )

# 8. SAVE THE HIGH-QUALITY MAP
ggsave("SA_Average_Crime_Rate_Map.png", width = 10, height = 8, dpi = 300)

print("Assignment map created successfully! Saved as 'SA_Average_Crime_Rate_Map.png'")
