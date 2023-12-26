# compare spicy and aso snow depths
# jack tarricone
# dec 26th, 2021

library(terra)

setwd("~/spicy")

# read in raw spicy from feb 28 2021
spicy_v1 <-rast("./rasters/spicy_snd_20210228.tif")
plot(spicy_v1)

# read in raw
aso_v1 <-rast("./rasters/ASO_SanJoaquin_mosaic_2021Feb26-27_AllData_and_Reports/ASO_SanJoaquin_Mosaic_2021Feb26-27_snowdepth_50m.tif")
plot(aso_v1)

# reproj
aso_4326 <-project(aso_v1, crs(spicy_v1))
aso_4326

# crop scipy snow down to aso extent
spicy_usj_v1 <-crop(spicy_v1, ext(aso_4326))
plot(spicy_usj_v1)
plot(aso_4326, add = T)


# resample aso 500m
aso_500m <-resample(aso_4326, spicy_usj_v1, method = "bilinear")

# mask spicy data with aso 500m data
spicy_usj <-mask(spicy_usj_v1, aso_500m)
plot(spicy_usj)
plot(aso_500m)

# stack
stack <-c(aso_500m, spicy_usj)

df <-as.data.frame(stack, xy = TRUE)
head(df)
