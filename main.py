# exemple for the finite element's

import numpy as np
import time
import finite_elements as fe

start  = time.time() #start the timer

E = 2e6 #[N/m²] Young Modulus 

A = [6, #[m²] Section area from element 1
     8, #[m²] Section area from element 2 
     8  #[m²] Section area from element  3
    ]

#define the nodes coordenates
p0 = [0,0] #[m] x,y coordenates
p1 = [-0.5,6.]
p2 = [1.5,4.]
p3 = [5.5,5.]

nodes = []
nodes.append(p0)
nodes.append(p1)
nodes.append(p2)
nodes.append(p3)

#Free nodes
free_nodes = [3] # the number(s) of the free node(s)


#identifie the link
link1 = [3,4]
link2 = [3,2]
link3 = [3,1]

links =[]

links.append(link1)
links.append(link2)
links.append(link3)

#Define the Forces
F = []

test = fe.mesh(nodes,links)
test.plot_mesh()
#test.export_nodes(nodes)
#test.export_young_modolus(E)
test.export_setup(nodes)
test.export_free_node(free_nodes)


#exemple = fe.finite_elements_methods()
#exemple.run()

end = time.time() #end the timer

time_elapsed = start-end
print(time_elapsed)