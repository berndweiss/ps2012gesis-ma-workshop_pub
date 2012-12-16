import re
import os

f = open(r'E:\projects\confer\ps2012gesis-ma-workshop\src\tex\ps2012gesis-ma-workshop.log', "r")


## Read LaTex log file
tex_log = f.read()
f.close()


## Extract figures from LaTeX log file
keep_figures = re.findall("E:/projects/confer/ps2012gesis-ma-workshop/fig/.*>", tex_log)
## Remove stuff ...
keep_figures = [re.sub("<", "", i) for i in keep_figures]
keep_figures = [re.sub(">", "", i) for i in keep_figures]
## Remove more stuff ...
keep_figures = [os.path.split(i) for i in keep_figures]
## Keep final list of figures
keep_figures = [i[1] for i in keep_figures]

# Change dir to /fig
os.chdir("../../fig")

## Get list of files that are actually in /fig
list_figures = os.listdir(".")

## Remove files that are not necessary 
list_rm_files = list(set(list_figures) - set(keep_figures))

#print list_rm_files
print keep_figures
print (list_rm_files)
print len(keep_figures)

#figRechercheDatensaetze
#figKodierschema.pdf

		
for f in list_rm_files:
    print "entferne " + f + "\n"
    os.remove(f)

