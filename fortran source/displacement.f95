program displacement

    implicit none
    integer :: n_elements                                                  !number of elements
    integer :: n_nodes                                                     !number of the nodes 
    integer :: i,j,col                                                     !Counters
    real, dimension(:,:), allocatable :: nodes                             ![m](x,y) nodes coordenates
    real, dimension(:,:), allocatable :: d                                 ![m](x,y) displacement of the nodes 
    real, dimension(:,:), allocatable :: loads                             ![N](x,y) Loads in each node
    real, dimension(:,:), allocatable :: k                                 ![N/m] stiffness matrix
    real, dimension(:,:), allocatable :: links                             !(i,j) Link of each element
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

    deallocate(nodes)
    deallocate(links)
    deallocate(free_nodes)

        


end program displacement