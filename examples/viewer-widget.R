# Matrix of widgets in viewer ---------------------------------------------

library(apexcharter)
library(grillade)
data("economics", package = "ggplot2")

# Create some charts with an htmlwidget
a1 <- apex(
  data = tail(economics, 350),
  mapping = aes(x = date, y = uempmed),
  type = "line"
) %>%
  ax_chart(
    group = "economics", id = "uempmed"
  ) %>%
  ax_yaxis(
    labels = list(
      minWidth = 15
    )
  )

a2 <- apex(
  data = tail(economics, 350),
  mapping = aes(x = date, y = psavert),
  type = "line"
) %>%
  ax_chart(
    group = "economics", id = "psavert"
  ) %>%
  ax_yaxis(
    labels = list(
      minWidth = 15
    )
  )

a3 <- apex(
  data = tail(economics, 150),
  mapping = aes(x = date, y = unemploy),
  type = "line"
) %>%
  ax_chart(
    group = "economics", id = "unemploy"
  ) %>%
  ax_yaxis(
    labels = list(
      minWidth = 15
    )
  )

# Display them
grillade(a1, a2)

# Two columns matrix
grillade(a1, a2, a3, n_col = 2)
grillade(a1, a2, a3, n_col = 2, cols_width = c(NA, NA, 2))


