## check 
sheck <- c(my.type, cc, B)














# --- BABY IMAGE PLOTS
# to test imageplot labels/legends/spacing
mat <- cos(2*pi*seq(0,3,length.out = 20)) %*% t(cos(2*pi*seq(0,3,length.out = 20)))

# --- TEST 1
png(filename = paste0("FinalPlots/test.png"),
    width = 8, height = 8*0.8, units = "in", res = 200, pointsize = 10)

par(mar = c(4,4,3,0), oma = c(0,0,0,5))
image(mat, xlab = "", ylab = "", las = 1, col = tim.colors()); sox(); gc()
slab("True TFS", "UMP: Modulated Stationary AR(2)", "Frequency", "Time",
     cex.factor = 1.25, yline = 2.75)
par(oma = c(0,0,0,0))
image.plot(legend.only = TRUE, legend.lab = "Power", zlim = 0:1,
           legend.line = 0.5, legend.cex = 1,
           smallplot  = c(0.925,0.95,0.1,0.925))

dev.off()



{
# --- TEST 2 horizontal
png(filename = paste0("FinalPlots/test.png"),
    width = 17, height = 8*0.8, units = "in", res = 200, pointsize = 10)

s
image(mat, xlab = "", ylab = "", las = 1, col = tim.colors()); sox(); gc()
slab("True TFS", "UMP: Modulated Stationary AR(2)", "Frequency", "Time",
     cex.factor = 1.5, yline = 2.5)

image(mat, xlab = "", ylab = "", las = 1, col = tim.colors()); sox(); gc()
slab("True TFS", "UMP: Modulated Stationary AR(2)", "Frequency", "Time",
     cex.factor = 1.5, yline = 2.5)

par(oma = c(0,0,0,0))
image.plot(legend.only = TRUE, legend.lab = "Power", zlim = 0:1,
           legend.line = 1, legend.cex = 1.2,
           smallplot  = c(0.9,0.94,0.1,0.925))

dev.off()
}















## ------------  PLaying w non-stationary stuff ------------
psi.1 <- 0.2                            # pcaf 1
psi.2 <- t(t(0.1*sin(2*pi*(0.001)*t)))  # pcaf 2
a.12  <- t(t(psi.1*(1 - psi.2)))


get <- function(){
  z <- rnorm(N+2,0,10)
  x <- z[3:(N+2)] + a.12*z[2:(N+1)] + psi.2*z[1:N]
}

oingo  <- get()
boingo <- 1e2/(Mod(1 - (a.12)%*%exp(-i*2*pi*Fs) - psi.2%*%exp(-i*2*pi*Fs*2))^2)


# splot(a.12)
# splot(psi.2)

image(boingo, col = tim.colors())

stop <- 0











  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  




# stop here
1










































# figureing out how to get gest for each sim
tfunc <- function(mat){
  c(mat)
}

arr <- array(data = 1:343, dim = rep(7,3))
arg <- apply(arr, 3, tfunc)
arg
arr[,,1]

c(arr[,,1])

## --- Testing Plot Margins/Dimensions ------------------------------------------------- ##

png(filename = paste0("Plots/TEST0.png"),
    width = 12, height = 16, units = "in", res = 200, bg = skrown$salt, pointsize = 10)

par(mfrow = c(3,2), mar = c(4,4.4,4.4,1))

splot(1,1); slab("main","subb","xlab","ylab")
splot(1,1); slab("main","subb","xlab","ylab")
splot(1,1); slab("main","subb","xlab","ylab")
splot(1,1); slab("main","subb","xlab","ylab")

dev.off()







## --------- framework for getting stats for yf estimates from TRIAL
tester <- array(data = rnorm(1500), dim = c(10,15,10))
tested <- pbapply(tester, 3, colMeans)
testey <- matrix(0, nrow = 10, ncol = 15)
for(j in 1:10){testey[j,] <- colMeans(tester[,,j])}

tested <- pbapply(tester, 2:3, sd)
t(tested)
for(j in 1:10){testey[j,] <- apply(tester[,,j], 2, sd)}
all(testey == t(tested))
















#################### Azadeh's g

# png(filename = paste0("NewPlots/gest_UMP_B",B,"_B",B,"_rev.png"),
#     # png(filename = paste0("NewPlots/gest_UMP_B",B,".png"),
#     width = 12.6, height = 9, units = "in", res = 200, bg = skrown$salt, pointsize = 10)
# ----------------------------------------------------------------------------------------
par(mfrow = c(1,3), mar = c(4,4,4.4,1))
lim1 <- range(ct^2, g.bc$mean, -nag.bc, nag.tru)
lim2 <- range(ct^2, g.cbc$mean, -nag.cbc, nag.tru)

# --- BC
splot(t, ct^2 , type = "l", ylim = lim1, colr = skrown$smoke, labs = FALSE)
lines( g.bc$mean,  col = skaturate$blue)
lines(-c(nag.bc),  col = skaturate$red)
lines(c(nag.tru),  col = skaturate$green)
slab(main = "Estimation of g(t) based on BC",
     subb = bquote(hat(g)*" is the solution to:    (1/N)Ag = g"),
     xlab = "Time", ylab = "g(t)")
legend("top", legend = c("True g(t)", "BC", "Azadeh", paste("B =",B)),
       col = c("black", skaturate$blue),
       lwd = c(2,2,NA), inset = 0.01)

# --- CBC
splot(t,   ct^2, type = "l", ylim = lim2, colr = skrown$smoke, labs = FALSE, lwd = 2)
lines(g.cbc$mean,  col = skaturate$yellow, lwd = 2)
lines(-c(nag.cbc),  col = skaturate$red, lwd = 2)
lines(c(nag.tru),  col = skaturate$green)
slab(main = "Estimation of g(t) based on CBC",
     subb = bquote(hat(g)*" is the solution to:    (1/N)Ag = g"),
     xlab = "Time", ylab = "g(t)")
legend("top", legend = c("True g(t)", "CBC", "Azadeh", paste("B =",B)),
       col = c("black", skaturate$yellow, skaturate$red),
       lwd = c(2,2,NA), inset = 0.01)
# ----------------------------------------------------------------------------------------
# dev.off()






################### Colmeans from sgrams: AR-2

set.seed(17)
yt <- arima.sim(model = list(ar = c(0.5,-0.5), sd = 10), n = N)
yf.mtm <- spec.mtm(yt,plot = FALSE)$spec


lim <- range(yf.mtm, yf.bc, yf.cbc, tru$yf/1e2)
splot(Fs, tru$yf/1e2, ylim = lim, type = "l", lwd = 3)
sadd(x = Fs, f = list(yf.bc, yf.cbc), type = "l", lwd = 2)
lines(Fs, yf.mtm, col = skaturate$green)

# -----------




# -----------



a
















## --- Testing IMAGE Plot Margins/Dimensions ------------------------------------------------- ##

png(filename = paste0("Plots/TEST3.png"),
    width = 12, height = 16, units = "in", res = 200, bg = skrown$salt, pointsize = 10)

## --- MARGINS
# par(mfrow = c(1,3), oma = c(0,3,0,5), mar = c(7,5,0,2))
# par(mfrow = c(1,3), oma = c(0,3,0,5))
par(mfrow = c(3,2), mar = c(4,4.4,4.4,1))
mat <- matrix(1:100, nrow = 10)

## --- TRUE Z 
image(x = 1:10, y = 1:10, z = mat,
      xlab = "", ylab = "",
      las = 1, col = tim.colors()); sox()
slab("True Time-Frequency Spectrum: White Noise z(t)","",
     "Frequency","Time")

## --- TRUE Y
image(x = 1:10, y = 1:10, z = mat,
      xlab = "", ylab = "",
      las = 1, col = tim.colors()); sox()
slab("True Time-Frequency Spectrum: AR(2) series y(t)","",
     "Frequency","Time")


## --- BC Z
image(x = 1:10, y = 1:10, z = mat,
      xlab = "", ylab = "",
      las = 1, col = tim.colors()); sox()
slab("BCMTFSE:  White Noise x(t)","",
     "Frequency","Time")

## --- BC Y
image(x = 1:10, y = 1:10, z = mat,
      xlab = "", ylab = "",
      las = 1, col = tim.colors()); sox()
slab("BCMTFSE:  AR(2) series y(t)","",
     "Frequency","Time")


## --- CBC Z
image(x = 1:10, y = 1:10, z = mat,
      xlab = "", ylab = "",
      las = 1, col = tim.colors()); sox()
slab("CBCMTFSE:  White Noise x(t)","",
     "Frequency","Time")
# image.plot(legend.only = TRUE,
#            zlim = range(mat),
#            horizontal = TRUE, smallplot = c(0.11,0.96,0,0.05))

## --- CBC Y
image(x = 1:10, y = 1:10, z = mat,
      xlab = "", ylab = "",
      las = 1, col = tim.colors()); sox()
slab("CBCMTFSE:  AR(2) series y(t)","",
     "Frequency","Time")
# image.plot(legend.only = TRUE , legend.lab = "Evolutionary Power Spectral Density",
#            legend.line = -2.75, legend.cex = 0.9,
#            horizontal = TRUE, smallplot = c(0.11,0.96,0,0.05))

## ----------------- RENDER
dev.off()
