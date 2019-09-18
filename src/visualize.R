install.packages("pacman")
pacman::p_load(plotly)

# set wd
setwd("C:/Projects/Personal/kosovo-gender-equality-academia")

# read data
df <- read.csv("data/processed/gender-equality.csv", stringsAsFactors=FALSE, encoding="UTF-8")
df$Perqindja.Femra <- df$Perqindja.Femra*100
df <- arrange(df, -Perqindja.Femra)

p1 <- plot_ly(df, x = ~Perqindja.Femra, y = ~reorder(Emri, Perqindja.Femra), name = 'Tertiary education, academic staff (% female)',
              type = 'bar', orientation = 'h',
              marker = list(color = 'rgba(50, 171, 96, 0.6)',
                            line = list(color = 'rgba(50, 171, 96, 1.0)', width = 1))) %>%
  layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  x = df$Perqindja.Femra + 5,  y = df$Emri,
                  text = paste(round(Perqindja.Femra, 2), '%'),
                  font = list(family = 'Arial', size = 12, color = 'rgb(50, 171, 96)'),
                  showarrow = FALSE)

p2 <- plot_ly(df, x = ~df$Total, y = ~reorder(df$Emri, df$Perqindja.Femra), name = 'Total academic staff',
              type = 'scatter', mode = 'lines+markers',
              line = list(color = 'rgb(128, 0, 128)')) %>%
  layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
                      linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2,
                      domain = c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
                      side = 'top', dtick = 500)) %>%
  add_annotations(xref = 'x2', yref = 'y',
                  x = df$Total-250, y = df$Emri,
                  text = paste(df$Total),
                  font = list(family = 'Arial', size = 12, color = 'rgb(128, 0, 128)'),
                  showarrow = FALSE)

p <- subplot(p1, p2) %>%
  layout(title = "Gender equality in Kosovo's Academia",
         legend = list(x = 0.029, y = 1.038,
                       font = list(size = 10)),
         margin = list(l = 10, r = 20, t = 100, b = 70),
         paper_bgcolor = 'rgb(248, 248, 255)',
         plot_bgcolor = 'rgb(248, 248, 255)') %>%
  add_annotations(xref = 'paper', yref = 'paper',
                  x = -0.40, y = -0.15,
                  text = paste('Source: Kosovo Agency of Statistics'),
                  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                  showarrow = FALSE)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
chart_link = api_create(p, filename="horizontalbar-subplots-gender-equality-v1")
chart_link