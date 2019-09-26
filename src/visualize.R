install.packages("pacman")
pacman::p_load(plotly, processx)

# set wd
setwd("C:/Projects/Personal/kosovo-gender-equality-academia")

# read data
df <- read.csv("data/processed/gender-equality.csv", stringsAsFactors=FALSE, encoding="UTF-8")
df$Perqindja.Femra <- df$Perqindja.Femra*100
df <- arrange(df, -Perqindja.Femra)


# English Version
p1 <- plot_ly(df, x = ~Perqindja.Femra, y = ~reorder(Emri, Perqindja.Femra), name = 'Tertiary education, academic staff (% female)',
              type = 'bar', orientation = 'h',
              marker = list(color = 'rgba(202,73,140, 0.6)',
                            line = list(color = 'rgba(202,73,140, 1.0)', width = 1))) %>%
  layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  x = df$Perqindja.Femra + 6,  y = df$Emri,
                  text = paste(round(df$Perqindja.Femra, 2), '%'),
                  font = list(family = 'Arial', size = 12, color = 'rgb(202,73,140)'),
                  showarrow = FALSE)

p2 <- plot_ly(df, x = ~df$Total, y = ~reorder(df$Emri, df$Perqindja.Femra), name = 'Total academic staff (absolute number)',
              type = 'scatter', mode = 'lines+markers',
              line = list(color = 'rgb(128, 0, 128)'), marker = list(color = "rgb(128,0,128)")) %>%
  layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
                      linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2,
                      domain = c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
                      side = 'top', dtick = 500)) %>%
  add_annotations(xref = 'x2', yref = 'y',
                  x = df$Total-100, y = df$Emri,
                  text = paste(df$Total),
                  font = list(family = 'Arial', size = 12, color = 'rgb(128, 0, 128)'),
                  showarrow = FALSE)

p <- subplot(p1, p2) %>%
  layout(title = "Gender Equality in Kosovo's Academia",
         legend = list(x = 0.029, y = 1.038,
                       font = list(size = 10)),
         margin = list(l = 10, r = 20, t = 100, b = 70),
         paper_bgcolor = 'rgb(248, 248, 255)',
         plot_bgcolor = 'rgb(248, 248, 255)') %>%
  add_annotations(xref = 'paper', yref = 'paper',
                  x = -0.50, y = -0.17,
                  text = paste('Source: Kosovo Agency of Statistics'),
                  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                  showarrow = FALSE)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
p %>% offline()

# Export offline
#orca(p, "figures/academia-gender-equality.png")





# Shqip Version
p1 <- plot_ly(df, x = ~Perqindja.Femra, y = ~reorder(Emri, Perqindja.Femra), name = 'Arsimi universitar, stafi akademik (% femra)',
              type = 'bar', orientation = 'h',
              marker = list(color = 'rgba(202,73,140, 0.6)',
                            line = list(color = 'rgba(202,73,140, 1.0)', width = 1))) %>%
  layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  x = df$Perqindja.Femra + 6,  y = df$Emri,
                  text = paste(round(df$Perqindja.Femra, 2), '%'),
                  font = list(family = 'Arial', size = 12, color = 'rgb(202,73,140)'),
                  showarrow = FALSE)

p2 <- plot_ly(df, x = ~df$Total, y = ~reorder(df$Emri, df$Perqindja.Femra), name = 'Stafi akademik gjithsej (numri total)',
              type = 'scatter', mode = 'lines+markers',
              line = list(color = 'rgb(128, 0, 128)'), marker = list(color = "rgb(128,0,128)")) %>%
  layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
                      linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2,
                      domain = c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
                      side = 'top', dtick = 500)) %>%
  add_annotations(xref = 'x2', yref = 'y',
                  x = df$Total-100, y = df$Emri,
                  text = paste(df$Total),
                  font = list(family = 'Arial', size = 12, color = 'rgb(128, 0, 128)'),
                  showarrow = FALSE)

p <- subplot(p1, p2) %>%
  layout(title = "Barazia Gjinore në Arsimin Universitar në Kosovë",
         legend = list(x = 0.029, y = 1.038,
                       font = list(size = 10)),
         margin = list(l = 10, r = 20, t = 100, b = 70),
         paper_bgcolor = 'rgb(248, 248, 255)',
         plot_bgcolor = 'rgb(248, 248, 255)') %>%
  add_annotations(xref = 'paper', yref = 'paper',
                  x = -0.50, y = -0.17,
                  text = paste('Burimi: Agjencia e Statistikave të Kosovës'),
                  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                  showarrow = FALSE) %>%
  add_annotations(xref = 'paper', yref = 'paper',
                  x = 1.0, y = -0.17,
                  text = paste('© Gent Rexha'),
                  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                  showarrow = FALSE)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
p %>% offline()




#######################################################################################
# Numri i studenteve
# read data
df <- read.csv("data/processed/students.csv", stringsAsFactors=FALSE, encoding="UTF-8")
df$Perqindja.Femra <- (df$Femra / df$Gjithsej) * 100
df$Total <- df$Gjithsej
df <- arrange(df, -Perqindja.Femra)

p1 <- plot_ly(df, x = ~Perqindja.Femra, y = ~reorder(Emri, Perqindja.Femra), name = 'School enrollment, tertiary (% female)',
              type = 'bar', orientation = 'h',
              marker = list(color = 'rgba(202,73,140, 0.6)',
                            line = list(color = 'rgba(202,73,140, 1.0)', width = 1))) %>%
  layout(yaxis = list(showgrid = FALSE, showline = FALSE, showticklabels = TRUE, domain= c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE)) %>%
  add_annotations(xref = 'x1', yref = 'y',
                  x = df$Perqindja.Femra + 8.5,  y = df$Emri,
                  text = paste(round(df$Perqindja.Femra, 2), '%'),
                  font = list(family = 'Arial', size = 12, color = 'rgb(202,73,140)'),
                  showarrow = FALSE)

p2 <- plot_ly(df, x = ~df$Total, y = ~reorder(df$Emri, df$Perqindja.Femra), name = 'Total enrollment, tertiary (absolute number)',
              type = 'scatter', mode = 'lines+markers',
              line = list(color = 'rgb(128, 0, 128)'), marker = list(color = "rgb(128,0,128)")) %>%
  layout(yaxis = list(showgrid = FALSE, showline = TRUE, showticklabels = FALSE,
                      linecolor = 'rgba(102, 102, 102, 0.8)', linewidth = 2,
                      domain = c(0, 0.85)),
         xaxis = list(zeroline = FALSE, showline = FALSE, showticklabels = TRUE, showgrid = TRUE,
                      side = 'top', dtick = 10000)) %>%
  add_annotations(xref = 'x2', yref = 'y',
                  x = df$Total-5000, y = df$Emri,
                  text = paste(df$Total),
                  font = list(family = 'Arial', size = 12, color = 'rgb(128, 0, 128)'),
                  showarrow = FALSE)

p <- subplot(p1, p2) %>%
  layout(title = "Gender diversity in Kosovo's Tertiary Education Sector",
         legend = list(x = 0.029, y = 1.038,
                       font = list(size = 10)),
         margin = list(l = 10, r = 20, t = 100, b = 70),
         paper_bgcolor = 'rgb(248, 248, 255)',
         plot_bgcolor = 'rgb(248, 248, 255)') %>%
  add_annotations(xref = 'paper', yref = 'paper',
                  x = -0.50, y = -0.17,
                  text = paste('Source: Kosovo Agency of Statistics'),
                  font = list(family = 'Arial', size = 10, color = 'rgb(150,150,150)'),
                  showarrow = FALSE)

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
p %>% offline()