
## @knitr echo=FALSE
options(width=70)


## @knitr assign-1-1-1
x <- 123 + 789
x



## @knitr assign-1-1-2
x^2


## @knitr assign-1-1-3
myseq <- 1:10
1/(myseq^2)


## @knitr assing-1-1-4
y1 <- 103
y2 <- 100
s1 <- 5.5
s2 <- 4.5
n1 <- n2 <- 50 ## "Doppelzuweisung"

## Berechne die Mittelwertdifferenz (Eine Klammer (...)
## um diesen Ausdruck bedeutet "print()")
(D <- y1 - y2)

s.pooled <- sqrt(((n1-1)*s1^2 + (n2-1)*s2^2)/(n1+n2-2))

vd <- s.pooled^2 * (n1+n2)/(n1*n2)

## Mittelwertdifferenz:
D

## Varianz:
vd



## @knitr assign-1-1-5.1
r <- 0.50
N <- 100

r.z <- 0.5*log((1+r)/(1-r))
r.z

var.r.z <- 1/(N-3)
var.r.z
sqrt(var.r.z)



## @knitr echo=FALSE, message=FALSE
library(psychometric)


## @knitr assign-1-1-5.2, messages=FALSE, warning=FALSE

library(psychometric)

(r.z <- r2z(r))
SEz(N)
z2r(r.z)



## @knitr assing-1-1-6
r <- c(0.5, 0.4, 0.1)
N <- c(100, 102, 110)

r2z(r)
SEz(N)



## @knitr assign-1-1-7.1
lnor <- 0.9069
V.lnor <- 0.0676

d <- lnor * (sqrt(3)/pi)
d

V.d <- V.lnor * (3/pi^2)
V.d



## @knitr assign-1-1-7.2

lor2d <- function(lor, V){
    d <- lor * (sqrt(3)/pi)
    V.d <- V * (3/pi^2)
    res <- c(d=d, Var=V.d)
    return(res)
}

coh.d <- lor2d(lnor, V.lnor)
coh.d

coh.d[1]
coh.d[2]



## @knitr assign-1-1-9
dfVerb <- read.csv(file = "../../data/uebung1-1-9_dVerbAb.csv", sep = ";")
dfVerb



## @knitr assign-1-1-10
library(psychometric)

## Geben Sie einfach nur den Namen der Funktion r2z ein. Kommt Ihnen
## das bekannt vor?
r2z

## Nun die Fisher-z-Trasformation durchfuehren. Die neue Variable soll
## im Datensatz dfVerb gespeichert werden.
dfVerb$z.r <- r2z(dfVerb$r)

## Den Standardfehler von r.z ermitteln:
dfVerb$se.z <- SEz(dfVerb$N)

## Den erweiterten Datensatz anzeigen lassen:
dfVerb



## @knitr assign-1-1-11.1, fig.width = 5, fig.height = 5
plot(x = dfVerb$r, y = dfVerb$z.r, xlab = "r", ylab = "Fisher's z",
     main = "Zusammenhang zwischen r und z.r")



## @knitr assign-1-1-11.2, fig.width = 5, fig.height = 5
hist(dfVerb$z.r)


## @knitr assign-1-1-11.3, fig.width = 5, fig.height = 5
## Mit dem Argument freq = FALSE wird im Histogramm nicht die absolute
## Haeufigkeit sondern die Wahrscheinlichkeitsdichte dargestellt
## Mit xlim = ... geben wir die Begrenzungen der x-Achse an.
hist(dfVerb$z.r, freq = FALSE, xlim = c(-0.3, 0.4), xlab = "Fisher's z",
     ylab = "Dichte", main = "")

## Zunächst wird die Wahrschenlichkeitsdichte geschaetzt
tmp <- density(dfVerb$z.r)

## Mit der lines()-Funktion wird zu einem bestehenden Plot ein Linien-
## plot hinzugefuegt
lines(tmp)


## @knitr assign-2-1-1.1
library(meta)

## Ein
metagen(TE = z.r, seTE = se.z, data = dfVerb)



## @knitr assign-2-1-1.2
## Sie koennen den REM Schaetzer natuerlich auch von Hand eintippen, aber
## besser ist es, das Ergebnis der Meta-Analyse in einem Objekt tmp zu
## speichern und dieses Objekt enthaelt auch die entsprechenden Angaben
tmp <- metagen(TE = z.r, seTE = se.z, data = dfVerb)

## Mit der Funktion str() koennen Sie sich anzeigen lassen, was in tmp
## enthalten ist. Aus Platzgruenden wird der folgende Befehl nicht ausgefuehrt:
## str(tmp)

## Sieht zunaechst verwirrend aus, aber schlussendlich findet sich in der
## Zeile " TE.random : num 0.088" das, was wir suchen, naemlich der Name
## des Listenelementes "TE.random".
tmp$TE.random

## Schliesslich die Ruecktransformation:
z2r(tmp$TE.random)



## @knitr assign-2-1-1.3
metacor(cor = r, n = N, data = dfVerb)



## @knitr assign-2-1-1.4
tmp <- metacor(cor = r, n = N, data = dfVerb)
forest(tmp, main = "", smlab = "Fisher's z", leftcols = c("studlab"),
       text.fixed = "FEM", text.random = "REM", pooled.total = FALSE,
       hetstat = FALSE )



## @knitr assign-2-2-1.1
library(metafor)

dfReg <- read.csv(file = "../../data/dBCG.csv", sep = ";")

## Teile der Tabellenangaben mit -c(1,2,3,9) ausblenden
dfReg[, -c(1,2,3,9)]



## @knitr assign-2-2-1.2
bcg.fem <- rma(yi = yi, vi = vi, mods=~ablat, method = "FE", data = dfReg)
summary(bcg.fem)



## @knitr assign-2-2-1.3
summary(rma(yi = yi, vi = vi, mods=~ablat, method = "DL", data = dfReg))



## @knitr assign-2-2-2.1
tmp <- metacor(cor = r, n = N, data = dfVerb)
funnel(tmp)



## @knitr assign-2-2-2.2
## Eggers Regressions-Test durchfuehren
metabias(tmp, method.bias = "linreg")



## @knitr 
## Eggers Regressions-Test mit den R-Standard-Funktionen durchfuehren
dfVerb$snd <- dfVerb$z.r/dfVerb$se.z
dfVerb$prec <- 1/dfVerb$se.z

summary(lm(snd ~ prec, data = dfVerb))



