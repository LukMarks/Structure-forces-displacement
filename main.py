# exemple for the finite element's

import numpy as np
import time
import finite_elements as fe

start  = time.time() #start the timer

E = 1e6 #[N/m²] Young Modulus 

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

test = fe.mesh(nodes)
#test.plot_mesh(nodes)
test.export_nodes(nodes)
test.export_mech(E)

end = time.time() #end the timer

time_elapsed = start-end
print(time_elapsed)