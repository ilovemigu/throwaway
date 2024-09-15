from pathlib import Path
pwd=Path(__file__).parent
myfile = "preProcessCountries"
myfileout = "postProcessCountries"
line = []
with open( pwd / myfile, 'r') as file:
        line = file.readlines()
splits = [x.split() for x in line ] # list of lists of each line
first = [x[:1][0] for x in splits if len(x) > 0] # list of location options if line wasn't empty
conc = first[3:] # cuts off up to smart location
with open(pwd / myfileout , 'w+') as of:
        [of.write(str(conc[x])+'\n') for x in range(len(conc))] # write ea location option and append newline
        of.flush() # ensure complete
        of.close()