program displacement

    implicit none
    integer :: n_elements                                                  !number of elements
    integer :: n_nodes                                                     !number of the nodes 
    integer :: i,j,col                                                     !Counters
    real, dimension(:,:), allocatable :: nodes                             ![m](x,y) nodes coordenates
    real, dimension(:,:), allocatable :: d                                 ![m](x,y) displacement of the nodes 
    real, dimension(:), allocatable :: load                             ![N](x,y) Loads in each node
    real, dimension(:), allocatable :: Forces                            ![N](x,y) Loads in the free coordenates
    real, dimension(:,:), allocatable :: k                                 ![N/m] stiffness matrix
    integer, dimension(:,:), allocatable :: links                             !(i,j) Link of each element
    real, dimension(:), allocatable :: free_nodes                        ![] list of free nodes 
    

    open(1, file='setup.dat')
    read(1,*) n_nodes,n_elements
    close(1)

    allocate ( nodes(n_nodes,2) )

    open(2, file='input_nodes.dat')
    DO i = 1,n_nodes
        READ(2,*) (nodes(i,col),col=1,2)
    END DO

    close(2)

    allocate ( links(n_elements,2) ) 

    open(3, file='input_links.dat')
    DO i = 1,n_elements
        READ(3,*) (links(i,col),col=1,2)
    END DO
    close(3)

    allocate( free_nodes(n_nodes*2) )

    open(4, file='free_nodes.dat')
    DO i = 1,n_nodes*2
        READ(4,*) free_nodes(i)    
    END DO

    allocate(k(n_elements*4,n_elements*4))
    
    open(5, file='stiffness_matrix.dat')
    DO i=1,n_elements*4
        READ(5,*) k(i,:)
    END DO

    allocate(load(n_nodes*2))

    open(6, file='load.dat')
    DO i=i,n_nodes*2
        READ(6,*) load(i)
    END DO

    !filter only the free nodes

    allocate(Forces(size(free_nodes)))

    DO i=1,size(free_nodes),2
        Forces(i) = load(links(i,1)*2-1)!Add the force in the x axis
        Forces(i+1) = load(links(i,1)*2) !Add the force in the y axis
    END DO




    



    deallocate(nodes)
    deallocate(links)
    deallocate(free_nodes)
    deallocate(k)
    deallocate(load)
    deallocate(Forces)
    

        


end program displacement