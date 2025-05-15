
# operaciones  ------------------------------------------------------------

3+6 # suma

8*9 # multiplicación

10-8 # resta

5/2 # cociente

4^2 # potencia

#reglas de precedencia normales
5 + 2 * 3  #11
(5 + 2) * 3  #21

log(100) # logaritmo natural de 100 (base e)

log(100, 10); log10(100) # logaritmo base 10

exp(2)
sqrt(16)
x <- 90
sin(x)


# objetos -----------------------------------------------------------------

b <- 5
10*b
sqrt(b)

#vectores
w <- 1:6  #":" sirve para crear una secuencia de números de uno en uno
w
seq(1, 6, 0.5)  #intervalos diferentes, cada 0.5 unidades

#vectores caracter
x <- c("a", "a", "a", "b", "b", "b") #  instrucción combine c() para combinar las letras en un solo objeto, comillas para indicar que se trata de texto 
x


#vectores lógicos
ww <- w > 4
ww

#indecsar extraer elementos específicos que cumplen con cierta condición
w[ww]


# matrices 

y <- matrix(1:20, ncol = 4) #número de columnas que queríamos con el argumento ncol
y

matrix(1:20, byrow = TRUE, ncol = 4) #datos sean ordenados en la matriz por fila argumento byrow

y <- matrix(1:20, byrow = TRUE, ncol = 4, dimnames = list(
  paste("r", 1:5, sep = ""), paste("c", 1:4, sep = "."))) #asignar nombres a las columnas y renglones de la matriz dinames
y

# data frames

#vectores y las matrices solo pueden contener el mismo tipo de valores (numéricos, caracteres o lógicos).
#los data frames pueden contener mas de un tipo de dato
z <- data.frame(x, w)
z


#listas 
Z <- list(V = 2*w, V = x, M= log(y))
Z


# Indexar objetos ---------------------------------------------------------
#tener acceso a elementos particulares de un objeto usando índices

x[1:3] # primeros tres elementos del vector x

# matrices y data frames debemos indicar también la columna
y[4:5, 3:4] #extraer filas 4-5 y a las columnas 3-4

#podemos acceder a las columnas mediante el nombre del data frame seguido del símbolo $ y del nombre de la columna:
z$x
z$w

Z$M#igual para listas
Z$M[3:4, 2]# extraer filas tercero y cuarto de la segunda columna de la matriz anterior
Z[[3]][3:4, 2]

#clase de datos
class(w); class(x); class(ww); class(y); class(z); class(Z)# saber a que clase pertenece
attributes(w)#dimensiones y nombres de las columnas y renglones 
str(w) #detalles sobre la estructura del objeto


# usando objetos ----------------------------------------------------------

sqrt(w)# raíz cuadrada de los elementos del vector w y
sqrt(y)

sqrt(z$w)# aplicar una operación de este tipo a una sola columna de una matriz o de un data frame

A <- matrix(c(1,2,3,4), ncol = 2)
b <- c(2,3)
A * b
A %*% b  #producto matricial 
t(A) #matriz transpuesta
solve(A) #matriz inversa

#ver objetos 
ls()
objects()
rm(y) #remover objeto y
rm(list = ls())#borrar todos los objetos 

#Los objetos cuyo nombre comienza por "." están ocultos y no pueden ser mostrados ni borrados 
.invisible <- rnorm(20)
ls() #no se ve
ls(all = TRUE) #Para desplegarlos requerimos añadir el argumento all = TRUE... Random.seed fue creado por la función rnorm()

rm(list = ls(all = TRUE))
ls(all = TRUE) #eliminamos todo



# graficas ----------------------------------------------------------------

z <- data.frame(grupo = sort(rep(c("a", "b"), 8)), var1 = rnorm(16))
z
plot(z$var1) #grafica de deispersion de variable var1 de objeto z
hist(z$var1) #histograma
boxplot(var1 ~ grupo, data=z, main="boxplot de prueba", xlab = "grupo",
        + ylab = "variable 1") #caja y bigotes


z$var2 <- (z$var1)^2 #agregamos var2 a z
z <- z[order(z$var1), ]  #ordenaremos el data frame con respecto a var1
par(mfrow=c(2,2)) #crear en una sola ventana cuatro gráficas 2 filas 2 columnas
plot(z$var1, z$var2, type="p", main="solo puntos")
plot(z$var1, z$var2, type="l", main="solo líneas")
plot(z$var1, z$var2, type="b", main="puntos y líneas")
plot(z$var1, z$var2, type="o", main="puntos y líneas\n sobrepuestos")


# ayuda -------------------------------------------------------------------

?ls #? antes de funcion abre cuadro de ayuda
help("rnorm")
help.search("linear models") #Cuando desconocemos el nombre de la función o buscamos un tema en particular



# Importar datos externos -------------------------------------------------

#Desde el portapapeles
x <- read.delim("clipboard")

#Mediante read.table()
#datos en un archivo de texto, con nombres de columnas que empiecen por una letra y sin espacios
# (si se desean nombres compuestos se puede usar un guión bajo) y usando tabuladores, comas, espacios etvc.
x <- read.table("ruta/archivo.txt, .dat", header, sep) #header sep = TRUE nombres de columnas y el separador de las mismas.
#espacio (sep = " "), un tabulador (sep = "\t"), una coma (sep = ",") o punto y coma (sep = ";").

# directorio de trabajo ("working directory", wd). Eso simplificará mucho la importación y exportación de datos y figuras,
setwd('G:/analisis') #definir
getwd() # conocer el directorio de trabajo actual

#Desde archivos Excel
library(readxl) #cargar paquete readxl, despues de ser instalado
datos <- read_excel("./datos/archivocondatos.xls", sheet = 1) #sheet = 1 indica que nos interesa la primera hoja del archivo


#
#
# Análisis de datos temporales --------------------------------------------
# data: temperatura del aire, la humedad relativa, la velocidad y dirección del viento registradas cada media hora de junio de 2006 a mayo de 200
cibmeteo <- read.table("cibmeteo.txt", header=TRUE, sep="\t")
dim(cibmeteo)
names(cibmeteo)
summary(cibmeteo) #estadistricas descriptivas
plot(cibmeteo$temperature, type="l", col = "grey")

#crear indice que identifique de manera única a cada día, pues el año, el mes y el día se encuentran en columnas separadas

attach(cibmeteo) #permite acceder a las variables contenidas en un data frame directamente
fecha <- paste(year, month, day, sep = "-")
fecha <- strptime(fecha, "%Y-%m-%d")
fecha_txt <- as.character(fecha)
#calcular extremos (mínimo y máximo) y el promedio diario de la temperatura a partir de las 48 lecturas de cada día
taire <- as.data.frame(
  +    cbind(tapply(temperature, list(fecha_txt), min),
             +          tapply(temperature, list(fecha_txt), max),
             +          tapply(temperature, list(fecha_txt), mean)))
#tapply permite aplicar una función (min, max, mean, ...) a cada celda de una matriz definida por una combinación única de uno a varios factores (fecha_txt
detach(cibmeteo)

colnames(taire) <- c('tmin', 'tmax', 'tavg')#nombrar cplumnas

#promedio mensual de temperatur
attach(cibmeteo)
tapply(temperature, list(month, year), mean) #mas de un factor, la función tapply() genera por defecto una tabla. 
aggregate(temperature, by=list(mes=month, año=year), mean) #otro modo
detach(cibmeteo)

#suavizar los datos  promedios moviles consiste en definir una ventana de cierta longitud, por ejemplo 3 (denominado orden = 3),
#  y obtener el promedio de los valores primero al tercero, segundo al cuarto, tercero al quinto y por ultimo del valor n-2 al n.y obtener el promedio de los valores primero al tercero, segundo al cuarto, tercero al quinto y por ultimo del valor n-2 al n.
Z <- c(4, 8, 9, 7, 8, 9, 4, 5)
# calcular el promedio móvil de orden 3 4+8+9)/3; (8+9+7)/3; (9+7+8)/3; (7+8+9)/3; (8+9+4)/3; (9+4+5)/3;
Z.pmov <- c(7, 8, 8, 8, 7, 6) #longitud (6) es menor que la del vector original (8). agregar NA al inicio y al final de Z.pmov
Z.pmov <- c(NA, Z.pmov, NA)
Z.pmov

pmov <- function(x, k) {#x es el vector a suavizar y k es el orden.
  n <- length(x)
  y <- rep(NA, n) # genera un vector vacío (y) de la misma longitud de x
  for (i in k:n)
    y[i-floor(k/2)] <- mean( x[(1+i-k):i] )
  y
} 
tmean.pmov <- pmov(taire$tavg, 15) #emperatura diaria promedio con un orden igual a 15 días
plot(taire$tavg, type = "o",ylab = "temperatura (°C)",xlab="día",
     main = "Temp. diaria promedio en La Paz \n (junio 2006 a mayo 2007)",
     lty = 3, col="grey50", lwd = 1)
lines(tmean.pmov, lwd = 2, col = "blue")#superposicon de medias mobiles
#anomalias
anomalia <- tmean.pmov - mean(tmean.pmov, na.rm=TRUE)
anomalia[is.na(anomalia)] <- 0

dias <- unique(cibmeteo[, 1:3])# extraemos los valores únicos de las primeras tres columnas de cibmeteo
ndmes <- aggregate(dias$day, by = list(dias$month, dias$year), length)# contamos los días por mes y por año con ayuda de la función aggregate()
ndmes

plot(anomalia, type="n", ylab = "anomalía de temperatura", xlab = "",  xaxt = "n" )
polygon(c(1:364, 364:1), c(anomalia, rep(0, 364)), col="green") #polygon(c(1:364), c(anomalia), col="green")
abline(h=0, v=c(0, cumsum(ndmes$x)), col="black", lty=3)#suma acumulada del numero de dias
axis(1, at=cumsum(ndmes$x)-ndmes$x/2, labels = c("jun","jul","ago","sep","oct","nov","dic","ene","feb","mar","abr","may"))
# ndmes$x para dibujar un grid vertical y poner las etiquetas en la gráfic

#
#
# Exportar tablas y figuras -----------------------------------------------
write.table(taire, file = "temp_aire.txt", quote = FALSE, sep = "\t",
            dec = ".", row.names = TRUE, col.names = TRUE)
savePlot(filename="Figura_1.png", type="png") #salvar figuras
#tanto las figuras como las tablas serán guardadas en el directorio de trabajo especificado previamente.


# Análisis de regresión lineal --------------------------------------------

x <- 1:100 #variable independiente
y <- 2.5*x + 31 + (rnorm(100) * 9)
#variable dependiente: 2.5 para la pendiente y de 31 para la ordenada al origen,añadiendo un término de error aleatorio a la ecuación de la rect
plot(x, y)#gráfica de dispersión 

xy.lm <- lm(y ~ x)  #lm funcion de regresión, si se desea forzar a un intercepto 0 =, entonces y∼x+0
summary(xy.lm)
attributes(xy.lm)#otros detalles
coef(xy.lm)#estraer coeficientes
plot(x, y)
abline(xy.lm)
par(mfrow=c(2,2))
plot(xy.lm) #explorar residuales


# Estimación no lineal ----------------------------------------------------

X <- seq(1, 20, length=100)
Y <- 2.5 *( X+runif(100)*3 )^2.5
# a <- 2.5
# b <- 2.5

# función de estimación no lineal nls() especificar valores iniciales de los parámetros de la función, algoritomo Gauss-Newton
modelo.potencial <- nls(Y ~ a * X^b, start = list(a=1, b=1), trace=TRUE, algorithm="default", model = TRUE)

coef(modelo.potencial)
summary(modelo.potencial)
plot(X, Y)
lines(X, predict(modelo.potencial), col="red", lwd=2)
#La estimación no lineal es sensible a los valores iniciales utilizados, por lo que en ocasiones puede no tener éxito.

optim()# funcion de estimacion  criterio a minimizar, generalmente la suma de los residuales al cuadrados, requiere valores semilla


# Análisis de variancia ---------------------------------------------------

exaov <- read.table("exaov.txt" ,header=TRUE, sep=";")
#efecto de la glucosa sobre la liberación de insulina, se trataron muestras de tejido pancreático de animales de laboratorio con 5 estimulantes distintos. 
dim(exaov)
summary(exaov)
insul.anova <- aov(insulina ~ as.factor(estimulante), data=exaov)
insul.anova


