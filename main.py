# exemple for the finite element's

import numpy as np
import time
import finite_elements as fe

start  = time.time() #start the timer

E = 2e6 #[N/m²] Young Modulus 

A = [6, #[m²] Section area from element 1
     8, #[m²] Section area from element 2 
     8  #[m²] Section area from element 3
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

n_elements = 3

#Define the Forces
F = [0, #[N] force in the first node in X component
     0, #[N] force in the first node in Y component
     0, #[N] Force x2
     0, #[N] Force y2
     0, #[N] Force x3
     600, #[N] Force y2
     0, #[N] Force x4
     0 #[N] Force y4
]


test = fe.mesh(nodes,links)
test.plot_mesh()
test.export_nodes(nodes)
test.export_link(links)
test.export_young_modolus(E)
test.export_setup(nodes,n_elements)
test.export_free_node(free_nodes)
test.export_elements_area(A)
test.export_loads(F)


#exemple = fe.finite_elements_methods()
#exemple.run()

end = time.time() #end the timer

time_elapsed = end-start
print(time_elapsed)