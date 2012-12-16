clear
cd E:\projects\confer\ps2012gesis-ma-workshop\data
insheet using uebung1-1-9_dVerbAb.csv, delimiter(;)

// Fisher-z-Transformation
gen z_r = 0.5 * log((1+r)/(1-r))

// Standardfehler fuer z_r
gen se_z = 1/sqrt(n-3)

// -metan- aufrufen 
// (muss zuvor mit -ssc install metan- installiert werden)
// Mit -metan- laesst sich entweder das FEM oder das REM berechnen...
metan z_r se_z, fixed nograph
metan z_r se_z, random nograph

// Mit -metan- laesst sich auch ein Forestplot erstellen, dazu einfach
// das nograph-Argument weglassen
metan z_r se_z, random

