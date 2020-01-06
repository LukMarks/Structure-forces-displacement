! Author: Lucas Marques Moreno
! Date: 12/23/2019 
! Script responsible for the
! stiffness matrix generation

program stiffness_matrix
    implicit none
    integer :: n_elements                                                  !number of elements
    integer :: n_nodes                                                     !number of the nodes 
    double precision, dimension(:,:), allocatable :: k                     !create the stiffness matrix
    real, dimension(:,:), allocatable :: mesh                  !import the mesh builded in mesh.f95
    real, dimension(:,:), allocatable :: links                             !(i,j) Link of each element
    real, dimension(:,:), allocatable :: nodes                             ![m](x,y) nodes coordenates
    integer :: i,j,col                                                     !Counters

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


    allocate( mesh(n_elements,13) )

    open(4, file= 'stiffness_input.dat')
    do i=1,n_elements
        READ(4,*) (mesh(i,col),col=1,13)
    end do
    close(4)

    print *
    
    print *,'================= Debug =================================='
            print *, 'n_nodes',n_nodes
            print *
            print *, 'n_elements', n_elements
            print *
            print *, 'nodes', nodes
            print * 
            print *, 'links', links
            print * 
            print *, 'mesh', mesh
    print *,'==================================================='

    deallocate(nodes)
    deallocate(links)

    

end program stiffness_matrix