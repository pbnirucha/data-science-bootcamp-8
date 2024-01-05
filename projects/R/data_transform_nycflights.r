library(nycflights13)
library(tidyverse)
View(flights)
View(airlines)
View(airports)
View(planes)
View(weather)

# [1] Arrange the number of flights by airlines in descending order in the year 2013.
count_carrier <- flights %>%
  select(year, carrier) %>%
  filter(year == "2013") %>%
  group_by(year, carrier) %>%
  summarise( count_flight = n() ) %>%
  arrange(desc(count_flight))

view(count_carrier)

# [2] Which destination has the highest number of flights in each airline?
top_ori_dest <- flights %>%
  select(carrier, origin, dest) %>%
  group_by(carrier, origin, dest) %>%
  summarise( count_flight = n() )%>%
  arrange(carrier,desc(count_flight)) %>%
  group_by(carrier) %>%
  filter(row_number()==1) %>%
  inner_join(airlines, by= c("carrier" = "carrier"))

view(top_ori_dest)

# [3] The top 5 most frequently flown flight routes.
top_flight <- flights %>%
  select(origin, dest) %>%
  group_by(origin, dest) %>%
  summarise( count_flight = n() ) %>%
  arrange(desc(count_flight)) %>%
  head(5)

view(top_flight)

# [4] Which airline has the best average travel time from JFK to LAX?
avg_air_time <- flights %>%
  select(carrier, origin, dest, air_time) %>%
  filter((origin == "JFK") & (dest == "LAX") & !is.na(air_time)) %>%
  group_by(carrier, origin, dest) %>%
  summarise(avg_air_time = mean(air_time)) %>%
  arrange(avg_air_time)

view(avg_air_time)

# [5] The airline with the least average delay time.
# (negative values indicate arriving before schedule, positive values indicate arriving later than scheduled, in minutes).
flights %>%
  select(carrier, dep_delay, arr_delay) %>%
  mutate(dep_delay = replace_na(dep_delay, mean(dep_delay, na.rm = T)),
         arr_delay = replace_na(arr_delay, mean(arr_delay, na.rm = T)),
         time_delay = dep_delay + arr_delay) %>%
  group_by(carrier) %>%
  summarise(avg_time_delay = mean(time_delay)) %>%
  arrange(desc(avg_time_delay))
  



