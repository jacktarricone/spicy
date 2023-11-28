library(terra)
library(ncdf4)




# path to file
nc_in <-nc_open("~/spicy/rasters/SnowEx-Data/Little_Cottonwood_2021-03-18.nc") # open
nc_in


# pull out needed info
sd_rast <-rast(ncvar_get(nc_in,"snow_depth")) # read in
extent <-ext(-111.720928684407, -111.614772255332, 40.5202025157807, 40.5984294421262)
ext(sd_rast) <-extent
crs(sd_rast) <-'EPSG:4326'
plot(sd_rast[[1]])

# pull out needed info
rast <-rast(ncvar_get(nc_in,"lidar-sd")) # read in
extent <-ext(-111.720928684407, -111.614772255332, 40.5202025157807, 40.5984294421262)
ext(rast) <-extent
crs(rast) <-'EPSG:4326'
plot(rast[[1]])


# make test rast from one day
flip_mat <-apply(t(sc_mat),2,rev) # rotate matrix 90 deg counter clockwise
sc_rast <-rast(flip_mat)
