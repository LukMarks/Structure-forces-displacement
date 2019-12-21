# Author: Lucas Marques Moreno
# Date: 12/21/2019 
# Script capable of use finite elemen's
# with a couple fortran routines

import numpy as np
import matplotlib.pyplot as plt

class mesh:
    def __init__(self, nodes):
        self.nodes = nodes
        return
    

    #export funcitons:
    def export_nodes(self,nodes): #export the input nodes coordenates for the fortran routine
        f = open('inputNodes.dat','w')
        for i in range(0,len(nodes)):
            f.write('%f ' % (nodes[i][0]))
            f.write('%f\n' % (nodes[i][1]))
        f.close()
        return
    def export_mech(self,E): #export the input values of mechanical properties for the fortran routine
        f = open('inputMech.dat','w')
        f.write('%f \n' % (E))
        f.close()
        return

    def plot_mesh(self, nodes):
        plt.figure(1)
        for i in range(0,len(nodes)):
            plt.scatter(nodes[i][0],nodes[i][1],label=('Node '+str(i+1)))
            if i == len(nodes):
                print('foi')
                plt.plot([nodes[i][0], nodes[-1][0]],
                         [nodes[i][1], nodes[-1][1]])
            else:
                plt.plot([nodes[i][0], nodes[i+1][0]],
                         [nodes[i][1], nodes[i+1][1]])
        plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
        plt.show()
        return

class finite_elements:
    def __init__(self):
        pass
        return


