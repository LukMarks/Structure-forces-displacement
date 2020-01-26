! Author: Lucas Marques Moreno
! Date: 12/23/2019 
! Script responsible for the
! stiffness matrix generation

program stiffness_matrix
    implicit none
    integer :: n_elements                                                  !number of elements
    integer :: n_nodes                                                     !number of the nodes 
    integer :: i,j,col,current_element                                     !Counters
    integer :: xi,yi                                                       ![m] coordenates indexes
    integer :: xj,yj                                                       ![m] coordenates indexes
    double precision, dimension(:,:), allocatable :: k                     ![N/m]create the stiffness matrix for each element
    double precision, dimension(:,:), allocatable :: k_mesh                ![N/m]create the mesh stiffness matrix
    real, dimension(:,:), allocatable :: mesh                              !import the mesh builded in mesh.f95
    integer, dimension(:,:), allocatable :: links                          !(i,j) Link of each element
    real, dimension(:,:), allocatable :: nodes                             ![m](x,y) nodes coordenates

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

    allocate( k(n_nodes*2,n_nodes*2) )

    DO i=1,n_nodes*2
        DO j=1,4
            k(i,j)=0
        END DO
    END DO

    

    DO i=1,n_elements
        
        !Get node position

        print *
        print *,'element: ',i

        xi = links(i,1)*2-1
        yi = links(i,1)*2

        print *,'--------------------------------------'
        print *
        print *,'node i ',xi,yi

        xj = links(i,2)*2-1
        yj = links(i,2)*2

        print *
        print *,'node j ',xj,yj
        print *,'--------------------------------------'


        !Stiffness for the x coordenate of i node
        k(xi,xi) = mesh(i,10)
        k(xi,yi) = mesh(i,12)
        k(xi,xj) = -mesh(i,10)
        k(xi,yj) = -mesh(i,12)
        !Stiffness for the y coordenate of i node
        K(yi,xi) = mesh(i,12)
        k(yi,yi) = mesh(i,11)
        k(yi,xj) = -mesh(i,12)
        k(yi,yj) = -mesh(i,11)
        !Stiffness for the x coordenate of i node
        k(xj,xi) = -mesh(i,10)
        k(xj,yi) = -mesh(i,12)
        k(xj,xj) = mesh(i,10)
        k(xj,yj) = mesh(i,12)
        !Stiffness for the y coordenate of j node
        k(xj,xi) = -mesh(i,12)
        k(xj,yi) = -mesh(i,11)
        k(xj,xj) = mesh(i,12)
        k(xj,yj) = mesh(i,11)

    END DO

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
            !print *, 'mesh', mesh
            print *
            print*, 'K'!, k
            DO i=1,8
                print *, 'line: ',i
                write(*,1) k(i,:)
                1 format(8f20.2)
            END DO

    print *,'==================================================='


    open(5, file = 'stiffness_matrix.dat')
    do i=1,n_nodes*2
        write(5,*) k(i,:)
    end do
    close(5)

    deallocate(nodes)
    deallocate(links)
    deallocate(k)
    deallocate(mesh)

    

end program stiffness_matrix