! Author: Lucas Marques Moreno
! Date: 12/23/2019 
! Script responsible for the
! stiffness matrix generation

program stiffness_matrix
    implicit none
    integer :: n_elements                                                  !number of elements
    integer :: n_nodes                                                     !number of the nodes 
    integer :: i,j,col,current_element                                     !Counters
    integer :: xi,xj,yi,yj                                                 ![m] coordenates indexes
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

    allocate( k(n_elements*4,4) )

    DO i=1,n_elements*4
        DO j=1,4
            k(i,j)=0
        END DO
    END DO

    

    DO i=1,n_elements*4,4
        
        current_element = i/4

        !Stiffness for the x coordenate of i node
        k(i,1) = mesh(current_element,10)
        k(i,2) = mesh(current_element,12)
        k(i,3) = -mesh(current_element,10)
        k(i,4) = -mesh(current_element,12)
        !Stiffness for the y coordenate of i node
        K(i+1,1) = mesh(current_element,12)
        k(i+1,2) = mesh(current_element,11)
        k(i+1,3) = -mesh(current_element,12)
        k(i+1,4) = -mesh(current_element,11)
        !Stiffness for the x coordenate of i node
        k(i+2,1) = -mesh(current_element,10)
        k(i+2,2) = -mesh(current_element,12)
        k(i+2,3) = mesh(current_element,10)
        k(i+2,4) = mesh(current_element,12)
        !Stiffness for the y coordenate of j node
        k(i+3,1) = -mesh(current_element,12)
        k(i+3,2) = -mesh(current_element,11)
        k(i+3,3) = mesh(current_element,12)
        k(i+3,4) = mesh(current_element,11)

    END DO


    allocate( k_mesh(n_elements*4,n_elements*4) )

    DO i=1,n_elements*4
        DO j=1,n_elements*4
            k_mesh(i,j)=0
        END DO
    END DO

    DO i=1,n_elements*4,4

        current_element = i/4

        xi = links(current_element,1)*2-1
        yi = links(current_element,1)*2


        xj = links(current_element,2)*2-1
        yj = links(current_element,1)*2
       
        print *,'xi',xi
        print *,'yi',yi
        print *,'xj',xj
        print *,'yj',yj

        k_mesh(xi,xi) = k(i,1)
        k_mesh(xi,yi) = k(i,2)
        k_mesh(xi,xj) = k(i,3)
        k_mesh(xi,yj) = k(i,4)

        k_mesh(yi,xi) = k(i+1,1)
        k_mesh(yi,yi) = k(i+1,2)
        k_mesh(yi,xj) = k(i+1,3)
        k_mesh(yi,yj) = k(i+1,4)

        k_mesh(xj,xi) = k(i+2,1)
        k_mesh(xj,yi) = k(i+2,2)
        k_mesh(xj,xj) = k(i+2,3)
        k_mesh(xj,yj) = k(i+2,4)

        k_mesh(yj,xi) = k(i+3,1)
        k_mesh(yj,yi) = k(i+3,2)
        k_mesh(yj,xj) = k(i+3,3)
        k_mesh(yj,yj) = k(i+3,4)


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
            !print*, 'K', k
            print *
            print*, 'K_mesh', k_mesh
    print *,'==================================================='


    open(5, file = 'stiffness_matrix.dat')
    do i=1,n_elements*4
        write(5,*) k_mesh(i,:)
    end do
    close(5)

    deallocate(nodes)
    deallocate(links)
    deallocate(k)
    deallocate(k_mesh)
    deallocate(mesh)

    

end program stiffness_matrix