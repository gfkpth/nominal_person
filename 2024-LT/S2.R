library(stats)
library(dplyr)
library(tidyr)  # for replace_na()
library(lme4)       # generalised linear mixed-effects models
library(geosphere)  # creating distance matrix
library(psych)
#plotting
library(ggplot2)
library(mapdata)
library(showtext)
library(PBSmapping)
library(mapproj)
library(Cairo)
library(lemon)   # for positioning legend
library(scico)  # for colour palette
# generating LaTeX tables
library(xtable)

# adding fonts for graphics
# adapt paths for true type fonts or comment out for standard fonts
font_add(family = "Fira Sans", regular="/usr/share/fonts/TTF/FiraSans-Regular.ttf")
font_add(family = "Linux Libertine", regular="/usr/share/fonts/ttf-linux-libertine/LinLibertine_Rah.ttf")
font_add(family = "Linux Biolinum", regular="/usr/share/fonts/ttf-linux-libertine/LinBiolinum_Rah.ttf")
font_add(family = "Linux Biolinum Bold", regular="/usr/share/fonts/ttf-linux-libertine/LinBiolinum_RBah.ttf")

showtext_auto()

# set working directory to location of script (only works in R Studio, otherwise manually set working directory or provide full paths for files below)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# import data
full <- read.csv("./S1.csv",na.strings=c("NA",""))

# filter out languages without nominal person attestation (specifically Hixkaryana)
persn <- filter(full, NomPers == "y")

####################
# Setting factors

#factors and levels
persn$language <- factor(persn$language)
persn$area.glottolog <- factor(persn$area.glottolog)
persn$family <- factor(persn$family)
persn$genus.WALS <- factor(persn$genus.WALS)
persn$WO <- factor(persn$WO,levels=c("VO","OV","NC","unclear"))
persn$APC.dir <- factor(persn$APC.dir,levels=c("pre","post","both"))
persn$adpos <- factor(persn$adpos,levels=c("pre","post","NoDom","NoAdpos","unclear"))
persn$DemDir <- factor(persn$DemDir,levels=c("DemN","NDem","mixed","both"))
persn$genitive <- factor(persn$genitive,levels=c("NGen","GenN","NoDom","unclear"))
persn$boundPers <- factor(persn$boundPers, levels=c("pre","post","n"))
persn$ArtOrder <- factor(persn$ArtOrder,levels=c("ArtN","NArt"))

######################################################
# Overall data distribution for Section 4.1

# overview
summary(persn)

# list (and number) distinct genera (following WALS classification): 63
persn %>%   distinct(genus.WALS) #-> WALS.list.genera

# overall counts for APCs and BPCs
persn %>% count(APC.dir)
persn %>% count(boundPers)


# distribution by features
xtabs(~genitive+APC.dir, data=persn)
xtabs(~genitive+boundPers, data=persn)

xtabs(~adpos+APC.dir, data=persn)
xtabs(~adpos+boundPers, data=persn)

xtabs(~WO+APC.dir, data=persn)
xtabs(~WO+boundPers, data=persn)

xtabs(~DemDir+APC.dir, data=persn)
xtabs(~DemDir+boundPers, data=persn)

########################################################
# APC-article interactions (Hypothesis 1b, Section 5.2)

# total
sum(!is.na(persn$ArtOrder))

# by type of PersN
xtabs(~ArtOrder+APC.dir, data=persn)
xtabs(~ArtOrder+boundPers, data=persn)

xtabs(~ArtOrder+boundPers+Art.with.Nompers, data=persn)


# only languages where articles cannot co-occur with adnominal pronouns
xtabs(~ArtOrder+APC.dir, data=persn[persn$Art.with.Nompers=="n",])

# for completeness: distribution for languages where articles do occur in APCs
xtabs(~ArtOrder+APC.dir, data=persn[persn$Art.with.Nompers=="y",])
xtabs(~ArtOrder+APC.dir, data=persn[persn$Art.with.Nompers=="unclear",])

# full list (not in article for reasons of space)
persn %>% filter(!is.na(ArtOrder)) %>% arrange(Art.with.Nompers,boundPers,APC.dir,sortclass,genus.WALS,language) %>% select("language","genus.WALS","Art.with.Nompers","ArtOrder","APC.dir","boundPers") %>% {print(xtable(.),include.rownames=FALSE)}


##############################
# queries with dplyr requests
# use sortclass as first sort key for more intuitive ordering of language families
# output table only displays WALS genus classification


# postnominal APCs
persn %>% filter(APC.dir=="post") %>% arrange(sortclass,genus.WALS,language) %>% select("language","genus.WALS","adpos","genitive","WO","DemDir") %>% {print(xtable(.),include.rownames=FALSE)}


# languages with ambidirectional APCs
persn %>% filter(APC.dir=="both") %>% arrange(sortclass,genus.WALS,language) %>% select("language","genus.WALS","adpos","genitive","WO","DemDir") %>% {print(xtable(.),include.rownames=FALSE)}

# languages with BPCs
persn %>% filter(boundPers!="n") %>% arrange(sortclass,genus.WALS,language) %>% select("language","genus.WALS","adpos","genitive","WO","DemDir") %>% {print(xtable(.),include.rownames=FALSE)}


#########################
## lists for Section 5

# concerning Hypothesis 1a (Section 5.1)
# prenominal APCs with at least two indicators of head-finality
persn %>% filter(APC.dir=="pre" & ((adpos=="post" & WO=="OV")|(genitive=="GenN" & WO=="OV")|(adpos=="post" & genitive=="GenN") )) %>% arrange(genitive,adpos,WO,sortclass,genus.WALS,language) %>% select("language","genus.print","genitive","adpos","WO") %>% {print(xtable(.),include.rownames=FALSE)}

persn %>% filter(APC.dir=="post" & ((adpos=="pre" & genitive=="NGen")|(adpos=="pre" & WO=="VO")|(WO=="VO" & genitive=="NGen"))) %>% arrange(genitive,adpos,WO,sortclass,genus.WALS,language) %>% select("language","genus.print","APC.dir","boundPers","adpos","genitive","WO") %>% {print(xtable(.),include.rownames=FALSE)}


# concerning Hypothesis 2 (Section 5.3)
# languages with mismatch between directionality of APCs and demonstratives  
persn %>% filter((APC.dir=="pre" & DemDir=="NDem")|(APC.dir=="post" & DemDir=="DemN")) %>% arrange(APC.dir,DemDir,sortclass,genus.WALS,language) %>% select("language","genus.print","APC.dir","DemDir", "PPDC") %>% {print(xtable(.),include.rownames=FALSE)}


# complementary set of languages without mismatch in directionality of APC/demonstratives, and still including PPDCs
persn %>% filter(PPDC=="y" & !((APC.dir=="pre" & DemDir=="NDem") | (APC.dir=="post" & DemDir=="DemN"))) %>% arrange(desc(boundPers),boundPers.simultAPC,APC.dir,DemDir,sortclass,genus.WALS,language) %>% select("language","genus.print","boundPers","APC.dir","DemDir","boundPers.simultAPC","ArtOrder","PPDC","PPDC.ref") # %>% {print(xtable(.),include.rownames=FALSE)}
# %>% replace_na(TRUE)

# separate liste of languages with BPCs and either PPDCs or additional person-sensitive marking 
persn %>% filter((boundPers!="n" & (PPDC=="y"| is.na(boundPers.simultAPC)==FALSE) )) %>% arrange(desc(boundPers),PPDC,boundPers.simultAPC,APC.dir,DemDir,sortclass,genus.WALS,language) %>% select("language","genus.print","APC.dir","DemDir","boundPers.simultAPC","PPDC","PPDC.ref") %>% {print(xtable(.),include.rownames=FALSE)}



####################################
#                                  #
# Statistical analysis             #
#                                  #
# Generalised linear mixed models  #
#                                  #
####################################


###################
#                 #
# Preparing data  #
#                 #  
###################

##########################################
# factor recoding for head-directionality
#
# reduce factors adpos, WO and genitive to a single numerical value headfin.value
#
# 1) avoids issues with interactions between factors adpos, WO and genitive, 
#    all relating to the hypothetical parameter of headedness
# 2) allows systematic inclusion of languages even if no clear "head-initial"/"head-final" value
#    is available for some category (-> larger number of languages can be included in model)
# 
# headfin.value is set to 0 by default
# increased by 1 for each feature value (stereotypically) indiciative for head-finality, 
#   i.e. prenominal genitives, OV order and postpositions;
# decreased by 1 for each feature value (stereotypically) indiciative for head-initiality,
#   i.e. postnominal genitives, VO order and postpositions
# unchanged for other feature values

persn <- persn %>% mutate(headfin.value = 0 ) %>%
  mutate( headfin.value = case_when(
    genitive == "GenN" ~ headfin.value + 1,
    genitive == "NGen" ~ headfin.value - 1,
    TRUE ~ headfin.value)) %>%
  mutate( headfin.value = case_when(
    WO == "OV" ~ headfin.value + 1,
    WO == "VO" ~ headfin.value - 1,
    TRUE ~ headfin.value)) %>%
  mutate( headfin.value = case_when(
    adpos == "post" ~ headfin.value + 1,
    adpos == "pre" ~ headfin.value - 1,
    TRUE ~ headfin.value))

# overview of resulting value distribution
persn %>% count(headfin.value)


###################################################
# factor recoding for demonstrative directionality 
#
# again allows systematic inclusion of languages in analysis even if no clear DemN/NDem value
#    is available (-> larger number of languages can be included in model)
#
# demfin.value is set to
#  1  iff the the language is coded NDem order
#  -1 iff the language is coded as having DemN order
#  0  in all other cases (subsuming mixed and both values)
#

persn <- persn %>% mutate(demfin.value = case_when(
  DemDir == "NDem" ~ 1,
  DemDir == "DemN" ~ -1,
  TRUE ~ 0))

# overview of resulting value distribution
persn %>% count(demfin.value)

# overview of data distribution of both properties
xtabs(~headfin.value+demfin.value,data=persn)


######################################################################################
# subsetting data to include only languages with binary values for APC directionality 
# (and excluding languages without APC)

persn %>% 
  filter(APC.dir %in% c("pre", "post")) -> persn.restrapc

# turn APC.dir into a factor
persn.restrapc$APC.dir <- factor(persn.restrapc$APC.dir, levels=c("pre","post"))

###############################################
# overview of phylogenetic variation in subset

# number of languages in restricted sample: 96
nrow(persn.restrapc)

# number of distinct genera in restricted sample: 51
persn.restrapc %>%   distinct(genus.WALS)

# number of distinct families in restricted sample: 31
persn.restrapc %>%   distinct(family)


###########################################
#                                         #
# Selection of random effect structure    #
# test for genealogical and areal biases  #
# (requires geosphere package)            #
#                                         #
###########################################

coords <- persn.restrapc[, c("lon", "lat")]
rownames(coords) <- persn.restrapc$language
# Calculate the distance matrix
distance_matrix <- distm(coords, fun = distHaversine)

# multi-dimensional scaling of distance matrix to 2 dimensions
fit <- cmdscale(distance_matrix,eig=T,k=2) # k is the number of dimensions to scale to
dta.mds.2D <- data.frame(language = persn.restrapc$language, mds1 = fit$points[,1], mds2 = fit$points[,2])

# visualise 2-dimensional downscaling
plot(fit$points[,1], 
     fit$points[,2], 
     xlab="Dimension 1", 
     ylab="Dimension 2",
     main="MDS analysis of the location data", type="n")
text(fit$points[,1], fit$points[,2], labels = dta.mds.2D$language) 


# alternatively: multi-dimensional scaling of distance matrix to 1 dimension
fit.1 <- cmdscale(distance_matrix,eig=T,k=1) # k is the number of dim
dta.mds.1D <- data.frame(language = persn.restrapc$language, mds.single = fit.1$points[,1])

# visualise 1-dimensional downscaling
plot(c(rep(1,nrow(dta.mds.1D))), fit.1$points[,1],
     xlab="Dimension 1", 
     ylab="Dimension 2",
     main="MDS analysis of the data", type="n")
text(c(rep(1,nrow(dta.mds.1D))),fit.1$points[,1], labels = dta.mds.1D$language) 

# merge 2-dimensional scaled distance matrix to main dataset
# variables: mds1, mds2
persn.restrapc <- merge(x= persn.restrapc,
                         y= dta.mds.2D, 
                         by ="language",
                         all.x=T,all.y=F)

# merge 1-dimensional scaled distance matrix to main dataset
# variable: mds.single
persn.restrapc <- merge(x= persn.restrapc,
                         y= dta.mds.1D, 
                         by ="language",
                         all.x=T,all.y=F)

###########################################
#                                         #
# Selection of random effect structure    #
# test for genealogical and areal biases  #
#                                         #
###########################################

# 2-dimensional space + family with nested genus 
mdir.2Dfg <- glmer(APC.dir~ headfin.value+demfin.value+
                   (1|family/genus.WALS)+
                   (1|mds1)+
                   (1|mds2),
                 data= persn.restrapc,
                 family="binomial",
                 verbose=T) 

# 2-D space and family
mdir.2Df <- glmer(APC.dir~ headfin.value+demfin.value+
                  (1|family)+
                  (1|mds1)+
                  (1|mds2),
                data= persn.restrapc,
                family="binomial",
                verbose=T) # does not converge

# 2-D space and genus
mdir.2Dg <- glmer(APC.dir~ headfin.value+demfin.value+
                  (1|genus.WALS)+
                  (1|mds1)+
                  (1|mds2),
                data= persn.restrapc,
                family="binomial",
                verbose=T)

# 2-dimensional space only
mdir.2D <- glmer(APC.dir~ headfin.value+demfin.value+
                 (1|mds1)+
                 (1|mds2),
               data= persn.restrapc,
               family="binomial",
               verbose=T) # singular fit!

# 1-D space and family with nested genus
mdir.1Dfg <- glmer(APC.dir~ headfin.value+demfin.value+
                   (1|family/genus.WALS)+
                   (1|mds.single),
                 data= persn.restrapc,
                 family="binomial",
                 verbose=T) # singular fit!

# 1-D space and family
mdir.1Df <- glmer(APC.dir~ headfin.value+demfin.value+
                  (1|family)+
                  (1|mds.single),
                data= persn.restrapc,
                family="binomial",
                verbose=T) # singular fit!

# 1-D space and genus
mdir.1Dg <- glmer(APC.dir~ headfin.value+demfin.value+
                  (1|genus.WALS)+
                  (1|mds.single),
                data= persn.restrapc,
                family="binomial",
                verbose=T)

# 1-D space only
mdir.1D <- glmer(APC.dir~ headfin.value+demfin.value+
                 (1|mds.single),
               data= persn.restrapc,
               family="binomial",
               verbose=T)  # singular fit!

# family with nested genus only
mdir.fg <- glmer(APC.dir~ headfin.value+demfin.value+
                 (1|family/genus.WALS),
               data= persn.restrapc,
               family="binomial",
               verbose=T) 

# only genus 
mdir.g <- glmer(APC.dir~ headfin.value+demfin.value+
                (1|genus.WALS),
              data= persn.restrapc,
              family="binomial",
              verbose=T)

# only family
mdir.f <- glmer(APC.dir~ headfin.value+demfin.value+
                (1|family),
              data= persn.restrapc,
              family="binomial",
              verbose=T)


# comparing all converging models
anova(mdir.2Dfg,mdir.2Dg,mdir.2D,mdir.1Dfg,mdir.1Dg,mdir.1Df,mdir.1D,mdir.fg,mdir.f,mdir.g) %>% {print(xtable(., digits=c(0,0,3,3,3,2,2,0,2)),include.rownames=TRUE)}
min(anova(mdir.2Dfg,mdir.2Dg,mdir.2Df,mdir.2D,mdir.1Dfg,mdir.1Dg,mdir.1Df,mdir.1D,mdir.fg,mdir.f,mdir.g)$AIC)
# winner: mdir.g with AIC=29.398
summary(mdir.g)

###################################
# Model comparisons
# fixed effects for small models are unreliable, so comparing log-likelihood to models removing factors one at a time instead (Bates et al. 2015:33f.)
# model reduction and comparison

# model without factor headfin.value (head-directionality)
mdir.g.noHead <- update(mdir.g, . ~ . - headfin.value)
# model comparison
anova(mdir.g,mdir.g.noHead)
diff(anova(mdir.g,mdir.g.noHead)$AIC) 
# model including head-directionality has lower AIC by 14.155 
# -> dropping headfin.value leads to a significant drop in informativity of the model
# preference for full model

# model without factor demfin.value (demonstrative directionality)
mdir.g.noDem <- update(mdir.g, . ~ . - demfin.value)
# model comparison
anova(mdir.g,mdir.g.noDem)
diff(anova(mdir.g,mdir.g.noDem)$AIC)
# model including demonstrative directionality has 10.207 lower AIC
# -> dropping headfin.value leads to a significant drop in informativity of the model
# preference for full model

##################
#                #
#  Drawing maps  #
#                #
##################

# separate data set for drawing maps
APCmap <- droplevels(subset(persn,print=="1"))

# factor coding and ordering
APCmap$APC.dir <- factor(APCmap$APC.dir, levels=c("pre","post","both","NA","n/a"))
APCmap$boundPers <- factor(APCmap$boundPers, levels=c("n","n/a","post","pre"))


APCmap[is.na(APCmap$APC.dir),]$APC.dir <- "n/a"
APCmap[APCmap$boundPers == "n",]$boundPers <- "n/a"

APCmap$boundPers <- factor(APCmap$boundPers, levels=c("n/a","post","pre"))

BPCmap <- filter(APCmap, boundPers != "n/a")


# colour-blind-friendly colour palette using scico package
library(scico)  # colour palettes
colpalette <- scico(4, palette= "roma")

colpalette <- colpalette[order(c(4,1,3,2))]

# preparing world map
world_map <- map_data("world")
clipped_map <- world_map %>%
  # the PBSmapping package expects a data frame with these names
  rename(X=long, Y=lat, PID=group, POS=order) %>% 
  clipPolys(xlim=c(-100, 185), ylim=c(-40, 70))

# plotting APC/BPC directionality data on world map
ggplot(APCmap, aes(x=lon, y=lat)) +
  geom_polygon(data=clipped_map,
               aes(x=X,
                   y=Y,
                   group=PID
               ),
               fill = "gray90") +
  coord_map(xlim=c(-100, 185), ylim=c(-40, 70)) +
  geom_point(data = APCmap, aes(x = lon,
                                y = lat,
                                color = APC.dir,
                                shape = boundPers),
             size = 2) +
  geom_text(data = APCmap, aes(x=lon,y=lat),label = APCmap$printname,
            hjust=APCmap$hjust,
            vjust=APCmap$vjust,
            size = 2.9,
            family = "Linux Biolinum") +
  geom_rect(xmin=122, xmax=150, ymin=-10.5, ymax=0, alpha = 0, color="black", size = 0.3) + # marking for Papua map
  annotate("text",x= 130, y = 3, label = "Fig. 2", size = 3.5, family ="Linux Biolinum Bold") +
  geom_rect(xmin=155, xmax=163, ymin=-10.5, ymax=-6, alpha = 0, color="black", size = 0.3) + # marking for Solomon Islands map
  annotate("text",x= 160, y = -4, label = "Fig. 3", size = 3.5, family ="Linux Biolinum Bold") +
  theme_minimal(base_family = "Linux Biolinum") +
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        legend.position = c(0.955,0.89),
        legend.justification = c(1,1),
        legend.box.background = element_rect(),
        legend.text = element_text(size=12, family="Linux Biolinum"),
        legend.title = element_text(size=14, family="Linux Biolinum")
  ) +
  scale_color_manual(values=colpalette, labels=c("pre","post","both", "n/a")) +
  scale_shape_discrete(breaks=c("pre","post","n/a")) +
  labs(colour = "APC", shape = "BPC", family = "Linux Biolinum", size=12) +
  guides(colour = guide_legend(order = 1, keyheight = 0.8), 
         shape = guide_legend(order = 2, keyheight = 0.8))


# save as pdf
ggsave(filename="./map-world.pdf", width = 26, height = 13, units = "cm", dpi = 300, device = cairo_pdf)
#ggsave(filename="./map-world.jpg", width = 26, height = 13, units = "cm", dpi = 300)

# cropping whitespace from the pdf
# relies on pdfcrop being installed on a Linux-based system 
# (can safely be commented out if white space around graphic is not an issue)
system("pdfcrop './map-world.pdf' './map-world.pdf'")


### map for Papua New Guinea
clipped_map_OC <- world_map %>%
  # the PBSmapping package expects a data frame with these names
  rename(X=long, Y=lat, PID=group, POS=order) %>% 
  clipPolys(xlim=c(122, 150),   # 183 to include Tuvaluan # 163 previous version to include Solomon Islands # 120,153
            ylim=c(-10, 0))    #-39 to include Maori  # -19 previous version  # -11, 0


OCmap <- ggplot(APCmap,
                aes(x = lon, y = lat)) +
  geom_polygon(data=clipped_map_OC,
               aes(x=X,
                   y=Y,
                   group=PID
               ),
               fill = "gray90") +
  coord_map(xlim=c(122, 150),   # 183 to include Tuvaluan
            ylim=c(-10, 0)) +    #-39 to include Maori
  theme_minimal(base_family = "Linux Biolinum") +
  geom_point(aes(x = lon,
                 y = lat,
                 colour = APC.dir,
                 shape = boundPers),
             size = 3.5) +
  geom_text(label = APCmap$Oc.printname,
            hjust=APCmap$Oc.hjust,
            vjust=APCmap$Oc.vjust,
            family = "Linux Biolinum",
            size = 3.5
  ) +
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        legend.position = c(0,1),
        legend.justification = c("left","top"),
        legend.direction = "vertical",
        legend.box = "horizontal",
        legend.box.background = element_rect(),
        legend.text = element_text(size=12, family="Linux Biolinum"),
        legend.title = element_text(size=14, family="Linux Biolinum")
  ) +
  scale_color_manual(labels=c("pre","post","both", "n/a"), values=colpalette) +
  scale_shape_discrete(breaks=c("pre","post","n/a")) +
  labs(colour = "APC", shape = "BPC", family = "Linux Biolinum") +
  guides(colour = guide_legend(order = 1, keyheight = 0.9), 
         shape = guide_legend(order = 2, keyheight = 0.9))

ggsave(OCmap, filename="./map-Papua.pdf", width = 17, height = 9, units = "cm", dpi = 300, device = cairo_pdf)

# this crops white space from the pdf, relies on pdfcrop being installed on a Linux-based system (can be commented out if white space is not an issue)
cmd="pdfcrop './map-Papua.pdf' './map-Papua.pdf'"
system(cmd)

### map for Solomon Islands
clipped_map_Solomon <- world_map %>%
  # the PBSmapping package expects a data frame with these names
  rename(X=long, Y=lat, PID=group, POS=order) %>% 
  clipPolys(xlim=c(155, 163),   # 183 to include Tuvaluan # 163 previous version to include Solomon Islands # 120,153
            ylim=c(-10, -6))    #-39 to include Maori  # -19 previous version  # -11, 0


Solomonmap <- ggplot(APCmap,
                     aes(x = lon, y = lat)) +
  geom_polygon(data=clipped_map_Solomon,
               aes(x=X,
                   y=Y,
                   group=PID
               ),
               fill = "gray90") +
  coord_map(xlim=c(155, 163),   # 183 to include Tuvaluan
            ylim=c(-10, -6)) +    #-39 to include Maori
  theme_minimal(base_family = "Linux Biolinum") +
  geom_point(aes(x = lon,
                 y = lat,
                 colour = APC.dir,
                 shape = boundPers),
             size = 3.5) +
  geom_text(label = APCmap$Oc.printname,
            hjust=APCmap$Oc.hjust,
            vjust=APCmap$Oc.vjust,
            family = "Linux Biolinum",
            size = 4
  ) +
  theme(axis.text = element_blank(),
        axis.line = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank(),
        panel.grid = element_blank(),
        axis.title = element_blank(),
        legend.position = c(1,1),
        legend.justification = c("right", "top"),
        legend.direction = "vertical",
        legend.box = "horizontal",
        legend.box.background = element_rect(),
        legend.text = element_text(size=12, family="Linux Biolinum"),
        legend.title = element_text(size=14, family="Linux Biolinum")
  ) +
  scale_color_manual(labels=c("pre","post","both", "n/a"), values=colpalette) +
  scale_shape_discrete(breaks=c("pre","post","n/a")) +
  labs(colour = "APC", shape = "BPC", family = "Linux Biolinum") +
  guides(colour = guide_legend(order = 1, keyheight = 0.9), 
         shape = guide_legend(order = 2, keyheight = 0.9))

ggsave(Solomonmap, filename="./map-Solomon.pdf", width = 114, height = 6, units = "cm", dpi = 300, device = cairo_pdf)

# this crops white space from the pdf, relies on pdfcrop being installed on a Linux-based system (can be commented out if white space is not an issue)
cmd="pdfcrop './map-Solomon.pdf' './map-Solomon.pdf'"
system(cmd)
