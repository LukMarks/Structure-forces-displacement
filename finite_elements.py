# Author: Lucas Marques Moreno
# Date: 12/21/2019 
# Script capable of use finite elemen's
# with a couple fortran routines

import numpy as np
import os
import matplotlib.pyplot as plt

class mesh:
    def __init__(self, nodes,links):
        self.nodes = nodes
        self.links = links
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

    def export_setup(self,E): #export the setup configuration for the fortran routine
        f = open('setup.dat','w')
        f.write('%f \n' % (E))
        f.close()
        return

    def plot_mesh(self):
        plt.figure(1)
        for i in range(0,len(self.nodes)):
            plt.scatter(self.nodes[i][0],self.nodes[i][1],label=('Node '+str(i+1)))
            
        for i in range(0,len(self.links)):
            plt.plot([self.nodes[self.links[i-1][0]-1][0], self.nodes[self.links[i-1][1]-1][0]],
                        [self.nodes[self.links[i-1][0]-1][1], self.nodes[self.links[i-1][1]-1][1]],label=('Element '+str(i+1)) )
        plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.)
        plt.title("Figure 01 Initial Mesh")
        plt.show()
        return

class finite_elements_methods:
    def __init__(self):
        pass
        return
    
    def run(self):
        os.system('./finite_elements')
        return


