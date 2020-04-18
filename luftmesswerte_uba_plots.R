#######################################
library(ggplot2)
library(ggridges)

# Get rid of extreme values for plotting
no2=no2[no2$no2 < quantile(no2$no2, 0.99), ]
no2 = no2[!is.na(no2$year),]
no2$date2 = format(as.Date(no2$date), "%Y-%m")
summary(no2$no2)

pm10=pm10[pm10$pm10 < quantile(pm10$pm10, 0.99), ]
pm10 = pm10[!is.na(pm10$year),]
pm10$date2 = format(as.Date(pm10$date), "%Y-%m")
summary(pm10$pm10)

# NO2
ggplot(no2, aes(x = no2, y = date2)) +
  #geom_density_ridges_gradient(scale = 2, rel_min_height = 0.001, gradient_lwd = 1.) +
  stat_density_ridges(quantile_lines = TRUE, quantiles = c(0.5), alpha = 0.7) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = expand_scale(mult = c(0.01, 0.01))) +
  scale_fill_viridis_c(name = "NO2 µg/m³", option = "C") +
  labs(
    title = 'NO2 by month',
    subtitle = 'NO2 concentration Germany by month (µg/m³)'
  ) +
  theme_ridges(font_size = 13, grid = TRUE) + 
  theme(axis.title.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  geom_vline(xintercept = median(no2$no2[no2$date2=="2020-04"])) +
  geom_vline(xintercept = median(no2$no2),linetype = "dashed") 
ggsave(filename = paste0(savepath,"no2_monthly.png"), width = 5, height = 20, dpi = 800, units = "in", device='png')

# PM10
ggplot(pm10, aes(x = pm10, y = date2)) +
  #geom_density_ridges_gradient(scale = 2, rel_min_height = 0.001, gradient_lwd = 1.) +
  stat_density_ridges(quantile_lines = TRUE, quantiles = c(0.5), alpha = 0.7) +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_discrete(expand = expand_scale(mult = c(0.01, 0.01))) +
  scale_fill_viridis_c(name = "PM10 µg/m³", option = "C") +
  labs(
    title = 'PM10 by month',
    subtitle = 'PM10 concentration Germany by month (µg/m³)'
  ) +
  theme_ridges(font_size = 13, grid = TRUE) + 
  theme(axis.title.y = element_blank()) +
  theme(axis.title.x = element_blank()) +
  geom_vline(xintercept = median(pm10$pm10[pm10$date2=="2020-04"])) +
  geom_vline(xintercept = median(pm10$pm10),linetype = "dashed") ## Grenzwert
ggsave(filename = paste0(savepath,"pm10_monthly.png"), width = 5, height = 20, dpi = 800, units = "in", device='png')
#######################################

# Subset data / plot shorter timeseies
no2b = no2[!(no2$date<'2018-02-01'),]
pm10b = pm10[!(pm10$date<'2018-02-01'),]

# no2
ggplot(no2b, aes(x = date, y = no2, colour = state)) + # geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = T) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.POSIXct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.POSIXct("2020-03-23"))), linetype=4, colour="black") +
  xlab("Date") +
  ylab("NO2 µg/m³") +
  ggtitle("NO2 by German states (Bundesländer)")
ggsave(filename = paste0(savepath,"no2_18_20.png"), width = 8, height = 6, dpi = 800, units = "in", device='png')

# pm10
ggplot(pm10b, aes(x = date, y = pm10, colour = state)) + # geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x, k = 20),se = T) + theme_bw() +
  #geom_vline(aes(xintercept = as.integer(as.POSIXct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.POSIXct("2020-03-23"))), linetype=4, colour="black") +
  xlab("Date") +
  ylab("PM10 µg/m³") +
  ggtitle("PM10 by German states (Bundesländer)")
ggsave(filename = paste0(savepath,"pm10_18_20.png"), width = 8, height = 6, dpi = 800, units = "in", device='png')

