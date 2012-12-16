# Quelle: http://berndweiss.net/tmp/or_vs_rr.zip

# Definition: RR
# p(E) in Risikogruppe geteilt durch p(E) in Nicht-Risikogruppe
# p(E_risiko) / p(E_nonrisiko)

# Definition: OR
# odds_risiko / odds_nonrisiko

# OR vs RR
# - OR weniger intuitiv als RR
# - das OR ist immer höher als das RR (daher falsche Interpr. 
    OR ~= Riskoverhältnis)
# - für Ereignisse mit kleinen p (<.10 oder <.20), OR und RR nahezu gleich
# - OR können adjustiert werden (via log.Regression)
# - RR in Kohortenstudien (exponiert vs. nicht exponiert), 
#   OR in Fall-Kontroll-Studien (zeitlich nachträglicher vergleich von Fall-
#   und Kontrollgruppe hinsichtlich ihrer Exposition (zB Rauchen))
# - OR ist inhaltlich invariant (Chance ein Jungen, wenn man schwänzt; 
#   Oder: chance zu schwänzen, wenn man ein Jungen ist)
# - Siehe Schmidt/Kohlmann: "When to use the odds ratio or the relative risk?";
#   RR ist einfacher zu interpretieren


# Ereignis hat niedrige Wahrscheinlichkeit (Risikogruppen: Jungen)

#            Geschlecht
#            w(0)  m(1)
#Schwänzen
#   nein(0)   47    45
#     ja(1)    3     5
#   Total     50    50

# RR: 1.66
(5/50) / (3/50) 

# OR: 1.74 (a*d / b*c)
(47*5)/(3*45)


# Ereignis hat hohe Wahrscheinlichkeit (Risikogruppen: Jungen)

#            Geschlecht
#            w(0)  m(1)
#Schwänzen
#   nein(0)   35    15
#     ja(1)   15    35
#   Total     50    50

# RR: 2.33
(35/50)/(15/50)

# OR: 5.44
(35*35)/(15*15)


# OR und RR in R (Tabelle mit grosser Ereigniswahrscheinlichkeit)
tab <- matrix(c(35, 15, 15, 35), ncol = 2)
tab
library(epitools)
riskratio(tab)
oddsratio(tab, method = "wald")