## cleaning workspace
rm(list = ls())

## installing package for reading .xlsx files
if (!require(readxl)) install.packages('readxl')
library(readxl)

## setting working directory (directory where the "color schemes.xlsx" file must be)
dirw = "~/work/IPCC_WG1/colour_schemes"

## creating IPCC-defined colour palettes (they will be save as .rda files in the working directory) ------------------------------------------------
type.palette = c("diverging", "sequential", "RCPs", "linesshades")
for (tp in type.palette) {
  suppressWarnings(dir.create(sprintf("%s/%s", dirw, tp)))
  df.cs = read_excel(sprintf("%s/color schemes.xlsx", dirw), sheet = tp)
  cs.names = unique(df.cs$`Library name`)
  for (cs in cs.names) {
    ind.cs = which(df.cs$`Library name` == cs)
    if (grepl("CMYK", cs)) {
      r = 255*(1-df.cs$`R/C`[ind.cs]/100)*(1-df.cs$K[ind.cs]/100)
      g = 255*(1-df.cs$`G/M`[ind.cs]/100)*(1-df.cs$K[ind.cs]/100)
      b = 255*(1-df.cs$`B/Y`[ind.cs]/100)*(1-df.cs$K[ind.cs]/100)
    } else if (grepl("RGB", cs)) {
      r = df.cs$`R/C`[ind.cs]
      g = df.cs$`G/M`[ind.cs]
      b = df.cs$`B/Y`[ind.cs]
    }
    rgb.col = rgb(cbind(r, g, b), maxColorValue = 255)
    colour.scheme = rev(colorRampPalette(rgb.col)(length(ind.cs)))
    save(colour.scheme, file = sprintf("%s/%s/%s.rda", dirw, tp, cs))
  }
}


# -----------------------------------------------------------------------
# -----------------------------------------------------------------------
# -----------------------------------------------------------------------

# example of use with maps ------------------------------------------------
## (this requires installation of some of the packages included in the "climate4R" R-based framework,
## in particular "transformeR" and "visualizeR") 
if (!require(devtools)) install.packages('devtools')
library(devtools)
devtools::install_github(c("SantanderMetGroup/transformeR", "SantanderMetGroup/visualizeR"))

## computing climatology for one the datasets included in "visualizeR" 
# E-OBS temperature for Iberia, DJF #
clim.tas = climatology(EOBS_Iberia_tas)  
## selecting one of the colormaps previously defined for temperature (RGB)
load(sprintf("%s/sequential/msequential_5_r_RGB.rda", dirw))
## generating and saving the figure
pdf(file = sprintf("%s/example_map_temp_RGB.pdf", dirw))
spatialPlot(clim.tas, backdrop.theme = "coastline", 
         set.min = 2, set.max = 12,
         at = seq(2, 12, 2),
            col.regions = rev(colour.scheme),
  main = "E-OBS temp")
dev.off()
## same example but for CMYK
rm(colour.scheme)
load(sprintf("%s/sequential/msequential_5_r_CMYK.rda", dirw))
## generating and saving the figure (IMPORTANT: for saving CMYK-based figures,
## it is needed to use the option colormodel = "cmyk")
pdf(file = sprintf("%s/example_map_temp_CMYK.pdf", dirw), colormodel = "cmyk")  
spatialPlot(clim.tas, backdrop.theme = "coastline", 
            set.min = 2, set.max = 12,
            at = seq(2, 12, 2),
            col.regions = rev(colour.scheme),
            main = "E-OBS temp")
dev.off()

# E-OBS precipitation for Iberia, DJF #
clim.pr = climatology(EOBS_Iberia_pr)  
## selecting one of the colormaps previously defined for temperature
load(sprintf("%s/sequential/msequential_5_b_RGB.rda", dirw))
## generating and saving the figure
pdf(file = sprintf("%s/example_map_precip_RGB.pdf", dirw))
spatialPlot(clim.pr, backdrop.theme = "coastline", 
                     set.min = 0, set.max = 5,
                    at = seq(0, 5, 1),
            col.regions = rev(colour.scheme),
            main = "E-OBS precip")
dev.off()
## same example but for CMYK
rm(colour.scheme)
load(sprintf("%s/sequential/msequential_5_b_CMYK.rda", dirw))
## generating and saving the figure (IMPORTANT: for saving CMYK-based figures,
## it is needed to use the option colormodel = "cmyk")
pdf(file = sprintf("%s/example_map_precip_CMYK.pdf", dirw), colormodel = "cmyk")  
spatialPlot(clim.pr, backdrop.theme = "coastline", 
            set.min = 0, set.max = 5,
            at = seq(0, 5, 1),
            col.regions = rev(colour.scheme),
            main = "E-OBS precip")
dev.off()

## example of use with line-plots ------------------------------------------------
rm(colour.scheme)
## selecting one of the colour schemes previously defined for lines
load(sprintf("%s/linesshades/line_6_RGB.rda", dirw))
## generating and saving the figure
pdf(file = sprintf("%s/example_lines_temp_RGB.pdf", dirw)) 
matplot(EOBS_Iberia_tas$Data[, 8, seq(5, 25, 4)], 
        col = colour.scheme,
        type = "l", lty = 1,  
        main = "E-OBS temp at 6 gridboxes over Iberia", 
        xlab = "days", ylab = "degC")
dev.off()
