#The R code used to create the boxplots in the Appendices 2a and 2b of the following paper published by Methods in Ecology and Evolution:
#Hooman Latifi, Stefanie Holzwarth, Andrew Skidmore, Josef Bruna, Jaroslav Cervenka, Roshanak Darvishzadeh, Martin Hais, Uta Heiden, 
#Lucie Homolová, Peter Krzystek, Thomas Schneider, Martin Starý, Tiejun Wang, Jörg Müller, Marco Heurich. 2021. 
#A laboratory for conceiving Essential Biodiversity Variables (EBVs) - The "Data Pool Initiative for the Bohemian Forest Ecosystem. 
#Methods in ecology and Evolution. Accepted for publication.

#Additional links to sources
######http://www.sthda.com/english/articles/32-r-graphics-essentials/132-plot-grouped-data-box-plot-bar-plot-and-more/
######https://www.r-graph-gallery.com/209-the-options-of-barplot.html#horiz 
##############################################################################
#Install and load the required packages

install.packages ("ggpubr", dependencies=T)

library(dplyr) 
library(ggplot2)
library(ggpubr)

install.packages ("viridis")
library(viridis)

install.packages ("cowplot")
library(cowplot)

theme_set(theme_grey())

#############################################
# Arrange/sort and compute cumulative summs
table_papers <- read.csv(file.choose())
head (table_papers)
table_papers$Year <- as.factor(table_papers$Year)
table_papers$Topic <- as.factor(table_papers$Topic)
str (table_papers)

##### not necessary#######
#table_papers <-table_papers[order(table_papers$topic),]

#table_papers <- table_papers %>%
#  arrange(topic, desc(year)) %>%
#  mutate(lab_ypos = cumsum(count) - 0.5 * count) 

head(table_papers)


##############create boxpolot by topic###############
# Create stacked bar graphs with labels
tiff("papers_dp1_ver2.tiff", units="cm", width=30, height=20, res=300)

ggplot(table_papers, aes(x = Topic, y = Count)) +
  geom_bar(aes(color = Year, fill = Year), stat = "identity") +
  # geom_text(
  #  aes(y = lab_ypos, label = count, group = year),
  #  color = "white") + 
  scale_color_viridis(discrete = TRUE, option = "D")+
  scale_fill_viridis(discrete = TRUE) +
  ylim(0, 20)

dev.off()

##############create boxpolot by year###############
# Create stacked bar graphs with labels
#ggplot(table_papers, aes(x = year, y = count)) +
#  geom_bar(aes(color = topic, fill = topic), stat = "identity") +
#  geom_text(
#    aes(y = lab_ypos, label = count, group = topic),
#    color = "white"
#  ) + 
#  scale_color_viridis(discrete = TRUE, option = "D")+
#  scale_fill_viridis(discrete = TRUE)

##############create boxpolot by IF###############
# Default plot
table_papers2 <- read.csv(file.choose())
head (table_papers2)
table_papers2$Year <- as.factor(table_papers2$Year)
table_papers2$Topic <- as.factor(table_papers2$Topic)
str (table_papers2)

##############alternative way used to create boxpolot by year and topic###############


tiff("papers_dp3_ver2.tiff", units="cm", width=30, height=20, res=300)

a <- ggplot(table_papers2, aes(x = Topic, y = Latest.IF)) +

# Notched box plot with mean points
 geom_boxplot(notch = F, fill = "lightgray")+
  stat_summary(fun = mean, geom = "point", color = "#FC4E07") +
  ylim(0, 12)
a

 b <- ggplot(table_papers2, aes(x = Year, y = Latest.IF)) +
 
 # Notched box plot with mean points
 geom_boxplot(notch = F, fill = "lightgray")+
   stat_summary(fun = mean, geom = "point", color = "#FC4E07") +
   ylim(0, 12) 
b

 plot_grid(a, b, 
           labels = c("A", "B"),
           ncol = 2, nrow = 1) 
  dev.off()
 

##### grouping ploted data by color 
  tiff("papers_dp4_ver2.tiff", units="cm", width=30, height=20, res=300)
  
 b + geom_boxplot(
   aes(fill = Topic),
   position = position_dodge(0.9)) +
   scale_fill_viridis(discrete = TRUE) + 
   facet_wrap(~Topic)
 dev.off()
 
 ############End of the code############## 
 
