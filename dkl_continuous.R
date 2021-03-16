# Computes the Kullback-Leibler divergence based on kernel density
# estimates with Gaussian kernel

kld_d = function(x,y,...){
  
  integrand = function(x,y,t){
    denx = density(x, na.rm = T)
    deny = density(y, na.rm = T)
    f.x =  approx(denx$x,denx$y,t)$y
    f.y =  approx(deny$x,deny$y,t)$y
    tmpRatio = f.x *(log2(f.x) - log2(f.y))
    tmpRatio = ifelse(is.infinite(tmpRatio),0,ifelse(is.na(tmpRatio),0,tmpRatio))
    tmpRatio
  }
  integrate(integrand,-Inf,Inf,x = x,y = y,stop.on.error=FALSE)$value
  
}
