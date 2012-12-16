clear
cd E:\projects\confer\ps2012gesis-ma-workshop\data
insheet using uebung2-2-2_dVerbAb.csv, delimiter(;)

// Funnelplot erstellen
metafunnel zr sez

// Eggers Regressions Test
metabias zr sez, egger
