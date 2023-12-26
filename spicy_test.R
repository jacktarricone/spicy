library(terra)
library(ncdf4)




# path to file
nc_in <-nc_open("~/spicy/rasters/hans_parameters/Little_Cottonwood_2021-03-18.nc") # open
nc_in


# pull out needed info
sd_rast <-rast(ncvar_get(nc_in,"snow_depth")) # read in
extent <-ext(-111.720928684407, -111.614772255332, 40.5202025157807, 40.5984294421262)
ext(sd_rast) <-extent
crs(sd_rast) <-'EPSG:4326'
plot(sd_rast[[1]])

# pull out needed info
dem_mat_v1 <-ncvar_get(nc_in,"lidar-dem") # read in
rast <-rast(t(dem_mat_v1))
extent <-ext(-111.720928684407, -111.614772255332, 40.5202025157807, 40.5984294421262)
ext(rast) <-extent
crs(rast) <-'EPSG:4326'
plot(rast)
writeRaster(rast, "~/spicy/rasters/lcc_lidar_dem_v2.tif")

# pull out needed info
fcf_v1 <-ncvar_get(nc_in,"fcf") # read in
rast <-rast(t(fcf_v1))
extent <-ext(-111.720928684407, -111.614772255332, 40.5202025157807, 40.5984294421262)
ext(rast) <-extent
crs(rast) <-'EPSG:4326'
plot(rast)
writeRaster(rast, "~/spicy/rasters/lcc_fcf.tif")

# pull out needed info
fcf_v1 <-ncvar_get(nc_in,"snow_depth") # read in
rast <-rast(t(fcf_v1[,,40]))
extent <-ext(-111.720928684407, -111.614772255332, 40.5202025157807, 40.5984294421262)
ext(rast) <-extent
crs(rast) <-'EPSG:4326'
plot(rast)
writeRaster(rast, "~/spicy/rasters/lcc_fcf.tif")




# make test rast from one day
flip_mat <-apply(t(sc_mat),2,rev) # rotate matrix 90 deg counter clockwise
sc_rast <-rast(flip_mat)
