# Gellerman-like
# crea matriz de 0 y 1, donde cada fila contiene n número de 0s y 1s
# distribuidos según distribución binomial, con probabilidad de 0.5,
# pero con la restricción de no más de 3 valores repetidos
# Creada: abril 4, 2019
# Autor: Emmanuel Alcalá

gell_like = function(n){ # n debe ser un número par
  # Vector de 0s de tamaño n
  half = n/2
  gell = numeric(n)
  # Llenar primeras 3 posiciones
  gell[1:3] = rbinom(3,1,0.5)
  while(sum(gell == 0) != half & sum(gell == 1) != half){
    for(i in 4:n){ # comenzar en cuarta posición
      gell[i] = rbinom(1,1,0.5)
      # Si las últimos 4 valores suman 4
      # o si los últimos 4 valores suman 0,
      # recalcular el último valor
      while(sum(gell[(i-3):i]) == 4 | sum(gell[(i-3):i]) == 0 ){
        gell[i] = rbinom(1,1,0.5)
      } # continuar
    }
  }
  # retornar el vector de 0 y 1
  
  gell
}

## Ejemplo: hace chunks de 12 columnas con 120 ensayos por fila y los apila 
# por columna. Es decir, primero hace 120x12, los apila, luego
# otros 12 etc

sesiones = 120
ensayos = 30
reps = 2
matrix_gell1 = matrix(0,nrow = sesiones,ncol = ensayos)

matrix_gell = matrix(0,nrow = sesiones,ncol = ensayos * reps)
k = 1
for (jj in 1:reps){
  for(ii in 1:sesiones){
    matrix_gell1[ii, ] = gell_like(ensayos)
  }
  
  matrix_gell[ ,k:(jj*ensayos)] = matrix_gell1
  k = k + ensayos

}

path_comp = "C:/Users/Laboratorio_Jonathan/Dropbox/Dropbox/Emmanuel/rats/"

write.table(matrix_gell,file = paste0(path_comp,'components_distr.txt'),
            sep = ",", col.names = F, row.names = F)
