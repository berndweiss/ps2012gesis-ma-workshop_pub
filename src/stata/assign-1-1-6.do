// Daten anlegen
clear
input r N
0.5 100
0.4 102
0.1 110
end

// Fisher's z-Transformation manuell
gen z = 0.5*log((1+r)/(1-r))
gen se_z = sqrt(1/(N-3))

list 

/* Es scheint auch Stata Pakete zu geben, mit denen 
sich Fisher's z-Transformation durchfuehren lassen, 
aber der Gebrauch hat sich mir nicht erschlossen, 
siehe 
- net install sg51.pkg
- net install sg52.pkg */
