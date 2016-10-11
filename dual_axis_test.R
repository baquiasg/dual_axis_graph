# Exemples of graphs obtained with the file dual_axis.R

library(ggplot2)
library(gtable)
library(grid)
source("dual_axis.R")

# ##########################
# Plot number of russian bilionaires
# ##########################

# Data
dat = read.csv(text = ",Russia,World
               1996,0,423
               1997,4,220
               1998,1,221
               1999,0,298
               2000,0,322
               2001,8,530
               2002,6,466
               2003,17,459
               2004,25,562
               2005,27,664
               2006,33,760
               2007,53,893
               2008,87,1038
               2009,32,761
               2010,62,949
               2011,101,1109
               2012,96,1130
               2013,110,1317
               2014,111,1535
               2015,88,1738", header  = TRUE)
rus <- dat[,1:2]
world <- dat[,-2]

# Graph 1
graph_1 <- ggplot(rus, aes(X, Russia)) +
  geom_line(colour = "#68382C", size = 1.5) +
  labs(x=NULL,y=NULL) +
  scale_x_continuous(breaks= c(1996, seq(2000,2015,5))) +
  scale_y_continuous(expand = c(0, 0), limits = c(0,200)) +
  theme(
    panel.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray50", size = 0.75),
    panel.grid.major.x = element_blank(),
    axis.text.y = element_text(colour="#68382C", size = 14),
    axis.text.x = element_text(size = 14, colour = "black"),
    axis.ticks = element_line(colour = 'gray50'),
    axis.ticks.length = unit(.2, "cm"),
    axis.ticks.x = element_line(colour = "black"),
    axis.ticks.y = element_blank(),
    plot.title = element_text(hjust = -0.135, vjust=2.12, colour="#68382C", size = 14))

# Graph 2
graph_2 <- ggplot(world, aes(X, World)) +
  geom_line(colour = "#00A4E6", size = 1.5) +
  labs(x=NULL,y=NULL) +
  scale_y_continuous(expand = c(0, 0), limits = c(0,2000)) +
  theme(
    panel.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    axis.text.y = element_text(colour="#00A4E6", size=14),
    axis.text.x = element_text(size=14),
    axis.ticks.length = unit(.2, "cm"),
    axis.ticks.y = element_blank(),
    plot.title = element_text(hjust = 0.6, vjust=2.12, colour = "#00a4e6", size = 14))

# Labels
label_1 <- "Number in Russia"
label_2 <- "Rest of the world"

# Plot
dual_axis_graph(graph_1, graph_2, label_1, label_2)

# ##########################
# Plot number of bots in online bids
# ##########################
dat <- read.csv(text = "merchandise,total_bids,bot_bids,bids_bot_ratio
                      auto parts,9757,0,0
                books and music,51941,1509,2.9
                clothing,16447,0,0
                computers,81084,11667,14.4
                furniture,99181,0,0
                home goods,1224234,18708,1.5
                jewelry,1902058,37101,2
                mobile,2126587,105138,4.9
                office equipment,289838,7967,2.7
                sporting goods,1855207,230326,12.4"
                , header  = TRUE, sep = ',', strip.white = TRUE)

graph_1 <- ggplot() +
  geom_bar(data = dat, aes(x = merchandise, y = total_bids), stat = "identity", fill = "#86898C") +
  ggtitle("Bids per product") +
  ylab("") +
  scale_y_continuous(expand = c(0, 0), limits = c(0,2000000)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
label_1 <- "Number of bids"

graph_2 <- ggplot() +
  geom_point(data = dat, aes(x = merchandise, y = bids_bot_ratio), colour = "#F47B16") +
  geom_line(data = dat, aes(x = merchandise, y = bids_bot_ratio, group = 1), colour = "#F47B16") +
  scale_color_manual("Asset") +
  ylab("Percentage of bots") +
  scale_y_continuous(expand = c(0, 0), limits = c(0,20)) +
  theme_bw() +
  theme(panel.background = element_rect(fill = "#F47B16"))
label_2 <- "Percentage of bots (%)"

# Plot
dual_axis_graph(graph_1, graph_2, label_1, label_2)
