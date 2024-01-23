cleaned_crime_rates <-
  clean_names(raw_data) |>
  select(contains("assault"), contains("robbery"), contains("breakenter"), contains("biketheft")) |>
  select(-contains("2014"), -contains("2015"), -contains("2016"), -contains("2017"))

sum_crime_numbers <-
  cleaned_crime_rates |>
  summarise(across(-contains("rate"), ~sum(., na.rm = TRUE)))


downtown_neighborhoods <- c('Church-Wellesley', 'Bay-Cloverhill', 'Yonge-Bay Corridor')
western_neighborhoods <- c('Edenbridge-Humber Valley', 'Islington', 'Pelmo Park-Humberlea')
scarborough_neighborhoods <- c('Centennial Scarborough', 'Scarborough Village', 'Agincourt North')

# Filter data for the selected neighborhoods
filtered_data <- raw_data %>% 
  filter(AREA_NAME %in% c(downtown_neighborhoods, western_neighborhoods, scarborough_neighborhoods))

# Aggregate crime data
filtered_data <- filtered_data %>%
  mutate(
    TOTAL_ASSAULT = rowSums(select(., contains("ASSAULT_"))),
    TOTAL_ROBBERY = rowSums(select(., contains("ROBBERY_"))),
    TOTAL_BREAKENTER = rowSums(select(., contains("BREAKENTER_"))),
    TOTAL_BIKETHEFT = rowSums(select(., contains("BIKETHEFT_")))
  )