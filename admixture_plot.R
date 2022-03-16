# Make custom admixture plot
library(reshape)
library(ggplot2)
library(forcats)
library(ggthemes)

setwd("~/Google Drive/Bioinformatics/Stacks-2.60/chapter_1/Admixture/Long_10k")

#
# For K=2
#
# Load the input file
admix <- read.delim('./admixture_K2.tsv', header = FALSE, stringsAsFactors = FALSE)
# Add thee column names
colnames(admix) <- c('pop','sample','k1','k2')
# Add the population IDs
admix$loc <- sapply(strsplit(admix$sample, '_'), function(admix){admix[1]})
# Sort by population and K val
admix <- admix[
  with(admix, order(pop,k2)),
]
# Melt so single column for Ks
madmix <- melt(admix, id=c('sample','pop', 'loc'))

head(madmix)

admix.plot <-
  ggplot(madmix, aes(factor(sample), value, fill = factor(variable))) +
  geom_col(color = "gray", size = 0.1) +
  facet_grid(~fct_inorder(loc), scales = "free", switch = "x", space = "free") +
  theme_minimal() + labs(x = "Individuals", title = "K=2", y = "Ancestry") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_discrete(expand = expand_scale(add = 1)) +
  theme(
    panel.spacing.x = unit(0.01, "lines"),
    axis.text.x = element_blank(),
    panel.grid = element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
  ) +
  scale_fill_gdocs(guide = FALSE)
admix.plot

ggsave('./admix_plot_k2.pdf', admix.plot,height=4,width=12)


#
# For K=3
#
# Load the input file
admix <- read.delim('./admixture_K3.tsv', header = FALSE, stringsAsFactors = FALSE)
# Add thee column names
colnames(admix) <- c('pop','sample','k1','k2','k3')
# Add the population IDs
admix$loc <- sapply(strsplit(admix$sample, '_'), function(admix){admix[1]})
# Sort by population and K val
admix <- admix[
  with(admix, order(pop,k2)),
]
# Melt so single column for Ks
madmix <- melt(admix, id=c('sample','pop', 'loc'))

head(madmix)

admix.plot <-
  ggplot(madmix, aes(factor(sample), value, fill = factor(variable))) +
  geom_col(color = "gray", size = 0.1) +
  facet_grid(~fct_inorder(loc), scales = "free", switch = "x", space = "free") +
  theme_minimal() + labs(x = "Individuals", title = "K=3", y = "Ancestry") +
  scale_y_continuous(expand = c(0, 0)) +
  scale_x_discrete(expand = expand_scale(add = 1)) +
  theme(
    panel.spacing.x = unit(0.01, "lines"),
    axis.text.x = element_blank(),
    panel.grid = element_blank(),
    axis.title.y=element_blank(),
    axis.text.y=element_blank(),
    axis.ticks.y=element_blank()
  ) +
  scale_fill_gdocs(guide = FALSE)
admix.plot


ggsave('./admix_plot_k3.pdf', admix.plot,height=4,width=12)
