import pandas as pd 
import matplotlib.pyplot as plt 
import matplotlib as mpl 
from os.path import expanduser


plt.style.use("classic")
mpl.rcParams['text.usetex']=True
mpl.rcParams['text.latex.unicode']=True
mpl.rcParams["legend.fancybox"] = True
# path of data

path_csv = expanduser("nevin74expV_data.csv")
nevin1974 = pd.read_csv(path_csv)
comp_sorted = nevin1974.groupby('comp')['mrate'].mean().sort_values(ascending=False)
components = list(comp_sorted.index)  # nevin1974['comp'].unique()
line_sty = ['solid', 'dotted', 'dashed', 'dotted']
line_comp = dict(zip(components, line_sty))

lwd = dict(
    zip(
        components,
        [2, 6, 2, 2]
    )
)

for c in components:
    
    x = nevin1974['x'][nevin1974['comp'] ==  c]
    y = nevin1974['mrate'][nevin1974['comp'] ==  c]
    
    plt.plot(x, y,
             color='black',
             linewidth=lwd[c],
             label=c,
             linestyle=line_comp[c])
    plt.xlabel(r"RCN $h^{-1}$")
    plt.ylabel(r"$\langle \frac{R_{d}}{R_{LB}} \rangle $", fontsize=18)
    plt.legend(loc='best')
    
plt.xticks(fontsize=14)
plt.yticks(fontsize=14)
plt.savefig('nevin1974.pdf')
plt.show()

