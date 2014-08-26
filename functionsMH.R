# data = data.frame con longitudes en la primera columna y latitudes en la segunda
# k = número de individuos a simular (100 por default)
# sigma = desviación estandar (en latitud longitud un kilómetro es aproximadamente #.01)
# seed = semilla para hacer los resultados replicables
gen_coords <- function(data, k = 100, sigma = .08, seed =123454321){
  set.seed(seed)
  longs <- list()
  lats  <- list()
  coords <- list()
  for(i in 1:nrow(data)){
    longs[[i]]  <- rnorm(k, data[i, 1], sigma)
    lats[[i]]   <- rnorm(k, data[i, 2], sigma)
    coords[[i]] <- cbind(longs[[i]], lats[[i]])
  }
  coords <- ldply(coords, function(t)t <- t)
  coords
}