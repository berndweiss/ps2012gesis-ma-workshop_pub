clear
cd E:\projects\confer\ps2012gesis-ma-workshop\data
insheet using dBCG.csv, delimiter(;)

// Standardfehler berechnen
gen se = sqrt(vi)

// Das FE Model wird in Stata mit dem Befehl vwls geschaetzt
// (vwls = Variance-weighted least squares)
vwls yi ablat, sd(se)

// Mixed-effects model (method of moments estimator, DL-Schaetzer)
metareg yi ablat, wsse(se) mm
