# --------------------------------------------
# BIVARIATE ANALYSIS: Contact Crimes vs. Property Crimes
# Scatter Plot by Province (2011-2021 Totals)
# --------------------------------------------

# 1. Install & Load Required Packages
# Install ggrepel
if (!require(ggrepel)) {
  install.packages("ggrepel")
  library(ggrepel)
}

library(tidyverse)

# 2. Load and Prepare Data
crime_data <- read_csv("crime_incidents_by_category.csv")

province_lookup <- data.frame(
  Geography = c("EC", "FS", "GT", "KZN", "LIM", "MP", "NW", "NC", "WC"),
  Province = c("Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", 
               "Limpopo", "Mpumalanga", " North West", "Northern Cape", "Western Cape")
)

# Reshape data to have crime categories as columns
crime_wide <- crime_data %>%
  filter(Geography != "ZA") %>%
  left_join(province_lookup, by = "Geography") %>%
  group_by(Province, `Crime Category`) %>%
  summarise(Total = sum(Count), .groups = 'drop') %>%
  pivot_wider(names_from = `Crime Category`, values_from = Total)

# 3. Create Scatter Plot (Version 1: With ggrepel for best labels)
ggplot(crime_wide, aes(x = `Contact Crimes`, y = `Property Related Crimes`)) +
  geom_point(aes(color = Province), size = 5, alpha = 0.8) +
  geom_smooth(method = "lm", se = FALSE, color = "darkred", linetype = "dashed") +
  geom_text_repel(aes(label = Province), point.padding = 0.5) + # Non-overlapping labels
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma) +
  scale_color_viridis_d() +
  labs(
    title = "Relationship Between Contact Crimes and Property Crimes",
    subtitle = "Total incidents per province (2011/2012 - 2020/2021)",
    x = "Total Contact Crimes",
    y = "Total Property Related Crimes",
    caption = "Data Source: South African Police Service (SAPS)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16),
    plot.subtitle = element_text(hjust = 0.5, size = 12),
    legend.position = "none"
  )

# 4. Save the Visualization
ggsave("scatter_plot_contact_vs_property.png", width = 10, height = 8, dpi = 300)