######################################################################################
# thirdgapfinal.R
# Supplementary file 3 for "The third person gap in adnominal pronoun constructions"
# R script
# author: Georg F.K. Höhn (georg.hoehn AT uni-goettingen.de)
######################################################################################
  
library(stats)
library(lme4)
library(dplyr)
library(psych)
# for graphics and maps
library(scico)  # colour palettes
library(ggplot2)
library(showtext)
library(mapproj)
library(ggrepel) # non-overlapping labels

# set working directory to location of script (if working with Rstudio)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# adding proper fonts, adapt to your system's font locations or comment out (will cause problems for generation of graphics below)
font_add(family = "Fira Sans", regular="/usr/share/fonts/TTF/FiraSans-Regular.ttf")
font_add(family = "Fira Sans Medium", regular="/usr/share/fonts/TTF/FiraSans-Medium.ttf")
showtext_auto()

# import data
persnum <- read.csv("./ThirdGapFinal.csv")

####################
# Setting factors

persnum$genus <- factor(persnum$genus)
persnum$NomPers.art.possible <- factor(persnum$NomPers.art.possible)
persnum$Art.neq.3rd <- factor(persnum$Art.neq.3rd,levels=c("y","n"))
persnum$third.Dem <- factor(persnum$third.Dem)
persnum$Pers3 <- factor(persnum$Pers3, levels=c("y","n"))

######
# subsetting

# subset languages where demonstratives and 3rd person pronuns are distinct
persnum %>% filter(third.Dem=="n") -> persnum.excDem

# refactoring
persnum.excDem$genus <- factor(persnum.excDem$genus)
persnum.excDem$NomPers.art.possible <- factor(persnum.excDem$NomPers.art.possible)
persnum.excDem$third.Dem <- factor(persnum.excDem$third.Dem)


####################
# Descriptive data #
####################

# number of languages
nrow(persnum)

# number of languages with 3rd!=Dem
nrow(persnum.excDem)

# number of genera
persnum %>%
  distinct(genus)

persnum.excDem %>%
  distinct(genus)

# individual overview Pers3
xtabs(~Art.neq.3rd+Pers3, data=persnum)
xtabs(~Art.neq.3rd+Pers3+third.Dem, data=persnum)
xtabs(~Art.neq.3rd+Pers3, data=persnum.excDem)

# compressed data by genus

persnum.excDem %>%
    filter(Art.neq.3rd=="y" & Pers3 =="y") %>%
    distinct(genus)

persnum.excDem %>%
  filter(Art.neq.3rd=="y" & Pers3 =="n") %>%
  distinct(genus)

persnum.excDem %>%
  filter(Art.neq.3rd=="n" & Pers3 =="y") %>%
  distinct(genus)

persnum.excDem %>%
  filter(Art.neq.3rd=="n" & Pers3 =="n") %>%
  distinct(genus)

persnum.excDem %>%
  filter(Art.neq.3rd=="y") %>%
  distinct(genus)

persnum.excDem %>%
  filter(Art.neq.3rd=="n") %>%
  distinct(genus)

persnum.excDem %>%
  filter(Pers3 =="y") %>%
  distinct(genus)

persnum.excDem %>%
  filter(Pers3 =="n") %>%
  distinct(genus)


# listing languages with Dem=3rd 
persnum[which(persnum$third.Dem=="y" & persnum$Art.neq.3rd=="y"),]$language
persnum[which(persnum$third.Dem=="y" & persnum$Art.neq.3rd=="n"),]$language


# listing languages with expected pattern
persnum.excDem[which(persnum.excDem$Pers3=="n" & persnum.excDem$Art.neq.3rd=="y"),]$language
persnum.excDem[which(persnum.excDem$Pers3=="y" & persnum.excDem$Art.neq.3rd=="n"),]$language

# languages with unexpected behaviour
persnum.excDem[which(persnum.excDem$Pers3=="y" & persnum.excDem$Art.neq.3rd=="y"),]$language
persnum.excDem[which(persnum.excDem$Pers3=="n" & persnum.excDem$Art.neq.3rd=="n"),]$language

persnum.excDem[which(persnum.excDem$Pers3=="y" & persnum.excDem$Art.neq.3rd=="y"),]$NomPers.art.possible

xtabs(~language+NomPers.art.possible,data=persnum.excDem[which(persnum.excDem$Pers3=="y" & persnum.excDem$Art.neq.3rd=="y"),])



############################################################
# Inferential statistics: Generalised linear mixed model   #
############################################################

# presence of distinct article as dependent of third Person gap
# genus as random variable
lin.PersArt <- glmer(Art.neq.3rd~Pers3+(1|genus),persnum.excDem,family="binomial",verbose=T)
summary(lin.PersArt)
lin.PersArt.check <- glmer(Art.neq.3rd~(1|genus),persnum.excDem,family="binomial",verbose=T)
anova(lin.PersArt, lin.PersArt.check)


########################
## Generating barplots #
########################

thirdArt.abs <- ggplot(data=persnum.excDem, aes(Pers3, fill=Art.neq.3rd)) +
  geom_bar() +
  scale_fill_manual(values=c('grey80','grey30'), labels=c(expression(Art[yes]), expression(Art[no])))+
  scale_x_discrete(labels=c(expression(APC[3]), expression(GAP[3])))+
  labs(fill="Article", x="3rd person APCs")+  
  theme_bw()+
  theme(
    plot.title=element_text(size = 14, family="Fira Sans"),
    text=element_text(size = 10, family="Fira Sans"),
    axis.text = element_text(size=10, family="Fira Sans"),
    legend.text = element_text(size=10,  family="Fira Sans"),
    legend.title =  element_blank(),
    axis.title.y = element_blank(),
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.title.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = 'top'
  )

ggsave(thirdArt.abs, filename="./Figure1a-abs.pdf", unit="cm", width=4.4, height=5.6, dpi=300,device = cairo_pdf)
cmd="pdfcrop './Figure1a-abs.pdf' './Figure1a-abs.pdf'"
system(cmd)

thirdArt.rel <- ggplot(data=persnum.excDem, aes(Pers3, fill=Art.neq.3rd)) +
  geom_bar(position="fill") +#
  scale_fill_manual(values=c('grey80','grey30'),labels=c("yes", "no"))+
  scale_x_discrete(labels=c(expression(APC[3]), expression(GAP[3])))+
  labs(fill="Distinct article", x="3rd person APCs")+
  theme_bw()+
  theme(
    plot.title=element_text(size = 14, family="Fira Sans"),
    text=element_text(size = 12, family="Fira Sans"),
    legend.text = element_text(size=10, family="Fira Sans"),
    legend.title = element_text(size=10, family="Fira Sans"),
    axis.text = element_text(size=10, family="Fira Sans"),
    panel.grid = element_blank(),
    panel.border = element_blank(),
    axis.title.y = element_blank(),
    axis.title.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = 'none'
  )

ggsave(thirdArt.rel, filename="./Figure1b-rel.pdf", unit="cm", width=4.4, height=4.3, dpi=300,device = cairo_pdf)
cmd="pdfcrop './Figure1b-rel.pdf' './Figure1b-rel.pdf'"
system(cmd)


###################
# Generating maps #
###################
library(mapdata)
library(PBSmapping)
library(Cairo)
library(lemon)   # for positioning legend

persnum.map <- droplevels(subset(persnum.excDem,print=="1"))

world_map <- map_data("world")

clipped_map <- world_map %>%
  # the PBSmapping package expects a data frame with these names
  rename(X=long, Y=lat, PID=group, POS=order) %>% 
  clipPolys(xlim=c(-60, 185), ylim=c(-40, 66))

# colour-blind-friendly colour palette
colpalette <- scico(2, palette= "roma")

plotmap <- ggplot(persnum.map,
                  aes(x=lon, y=lat)
) +
  geom_polygon(data=clipped_map,
               aes(x=X,
                   y=Y,
                   group=PID
               ),
               fill = "gray90") +
  coord_map(xlim=c(-60, 185), ylim=c(-40, 66)) +
  geom_point(data = persnum.map, aes(x = lon,
                                y = lat,
                                shape = Pers3,
                                colour = Art.neq.3rd),
             size = 2.3) +
  geom_rect(xmin=122.5, xmax=148.5, ymin=-10.2, ymax=0, alpha = 0, color="black", size = 0.3) + # marking for Papua map
  annotate("text", x= 135, y = 3, label="Figure 3", size = 5, family ="Fira Sans Medium") +
  geom_text(aes(x=lon,y=lat),
            label = persnum.map$P3.printname,
            hjust=persnum.map$P3.hjust,
            vjust=persnum.map$P3.vjust,
            size = 3.1) +
  theme_minimal(base_family = "Fira Sans") +
  theme(
        text = element_text(size = 22, family="Fira Sans"),
        axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        legend.position = c(0.96,0.9),
        legend.justification = c(1,1),
        legend.title.align = 1,
        legend.text.align = 0,
        legend.title = element_blank(),
        legend.box.background = element_rect(),
        plot.title=element_text(size = 16, family="Fira Sans")
  ) +
  scale_color_manual(values= colpalette, labels=c(expression(Art[yes]), expression(Art[no]))) +
  scale_shape_discrete(labels=c(expression(APC[3]), expression(GAP[3]))) +
  labs(colour = "Article", shape = "3rd person APCs", family = "Fira Sans", size= 20) +
  guides(shape = guide_legend(order = 1), colour = guide_legend(order = 2))

plotmap
ggsave(plotmap, filename="./Figure2.pdf", width = 24, height = 13.5, units = "cm", dpi = 300, device = cairo_pdf)


# pdfcrop to remove surrounding whitespace 
# REQUIRES program pdfcrop to be installed, otherwise comment out next two lines
cmd="pdfcrop 'Figure2.pdf' 'Figure2.pdf'"
system(cmd)


### map for Oceania close-up
clipped_map_OC <- world_map %>%
  # the PBSmapping package expects a data frame with these names
  rename(X=long, Y=lat, PID=group, POS=order) %>% 
  clipPolys(xlim=c(121.8, 150.8),   # 183 to include Tuvaluan # 163 previous version to include Solomon Islands # 120,153
            ylim=c(-10, 0))    #-39 to include Maori  # -19 previous version  # -11, 0


OCmap <- ggplot(persnum.map,
                aes(x = lon, y = lat)) +
  geom_polygon(data=clipped_map_OC,
               aes(x=X,
                   y=Y,
                   group=PID
               ),
               fill = "gray90") +
  coord_map(xlim=c(121.8, 150.8), 
            ylim=c(-10, 0)) + 
  theme_minimal(base_family = "Fira Sans") +
  geom_point(data = persnum.map, 
             aes(x = lon,
                y = lat,
                shape = Pers3,
                colour = Art.neq.3rd),
             size = 3.5) +
  geom_text(data = persnum.map, aes(x = lon,
                                       y = lat),
            label = persnum.map$Oc.printname,
            hjust= persnum.map$Oc.hjust,
            vjust= persnum.map$Oc.vjust,
            family = "Fira Sans",
            size = 3.5
  ) +
  theme(text = element_text(size = 12, family="Fira Sans"),
        axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        legend.position = c(0.05,1),
        legend.justification = c(0,1),
        legend.direction = "vertical",
        legend.box = "horizontal",
        legend.box.background = element_rect(),
        legend.text = element_text(size=12, family="Fira Sans"),
        legend.title = element_blank()
  ) +
  scale_color_manual(values= colpalette, labels=c(expression(Art[yes]), expression(Art[no]))) +
  scale_shape_discrete(labels=c(expression(APC[3]), expression(GAP[3]))) +
  guides(shape = guide_legend(order = 1), colour = guide_legend(order = 2))

OCmap
ggsave(OCmap, filename="./Figure3.pdf", width = 17, height = 9, units = "cm", dpi = 300, device = cairo_pdf)

# this crops white space from the pdf, relies on pdfcrop being installed on a Linux-based system (can be commented out if white space is not an issue)
cmd="pdfcrop './Figure3.pdf' './Figure3.pdf'"
system(cmd)

