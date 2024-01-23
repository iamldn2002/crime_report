raw_data <-
  list_package_resources("neighbourhood-crime-rates") |>
  filter(name == "neighbourhood-crime-rates - 4326.csv") |>
  get_resource()

write_csv(
  x = raw_data,
  file = "raw_data.csv"
)