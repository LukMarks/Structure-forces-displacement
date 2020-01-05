! Author: Lucas Marques Moreno
! Date: 12/21/2019 
! Script responsible for the
! mesh generation
program mesh
    implicit none

    integer :: n_nodes                                         !number of the nodes
    integer :: n_elements                                         !number of the nodes
    real :: x,y,xi,xj,yi,yj                                 ![m] elements coordenates
    real :: c,s                                              ![] values for cossine and sine values
    integer :: i,j,col
    real, dimension(:), allocatable :: A                                                ![m²] Section area of the element
    real, dimension(:,:), allocatable :: nodes               ![m](x,y) nodes coordenates
    real, dimension(:,:), allocatable :: links               ![m](x,y) nodes coordenates
    real, dimension(:,:), allocatable :: output_matrix       ![-] the input's matrix used in the stiffness matrix 
    real, dimension(:), allocatable :: L               ![m](x,y) nodes coordenates
    real, dimension(:), allocatable :: alfa                                            ![degree] angle between two elements 
    real, parameter :: pi = 3.1415927
    integer, parameter :: ikind=selected_real_kind(p=18)    !define precision 
    !real(kind = ikind) :: E                                 ![N/m²] Young Modulus
    real :: E

    print *
    print *, '-------------- Building Mesh --------------'

    print *
    print *, '-------------- Importing Setup --------------'

    open(1, file='setup.dat')
    read(1,*) n_nodes,n_elements
    close(1)

    print *
    print *, '-------------- Importing Mechanical Properties --------------'

    open(2, file='input_young_modulos.dat')
    read(2,*) E
    close(2)

    print *
    print *, '-------------- Importing Nodes --------------'

    allocate ( nodes(n_nodes,2) )




    open(3, file='input_nodes.dat')
    DO i = 1,n_nodes
        READ(3,*) (nodes(i,col),col=1,2)
    END DO

    close(3)


    print *
    print *, '-------------- Importing Links --------------'
    
    allocate ( links(n_elements,2) ) 

    open(4, file='input_links.dat')
    read(4,*) links
    close(4)

    open(4, file='input_links.dat')
    DO i = 1,n_elements
        READ(4,*) (links(i,col),col=1,2)
    END DO
    close(4)

    allocate( A(n_elements))
    open(5, file='input_area.dat')
    READ(5,*) A
    CLOSE(5)


    print *
    print *, "-------------- Calculating Element's Properties  --------------"

    allocate ( L(n_elements) )
    allocate ( alfa(n_elements) )

    do i=1,n_elements


        print *
        print *,'element: ',i

        xi = nodes(int(links(i,1)),1)
        yi = nodes(int(links(i,1)),2)

        print *,'--------------------------------------'
        print *
        print *,'node i ',xi,yi

        xj = nodes(int(links(i,2)),1)
        yj = nodes(int(links(i,2)),2)

        print *
        print *,'node j ',xj,yj
        print *,'--------------------------------------'
        x = xj- xi
        y = yj-yi
        print *
        print *,x,y
        L(i) = sqrt(x**2+y**2)
        alfa(i) = atan(y/x) * 180/pi
        if (xj < xi) then 
            alfa(i) = alfa(i) +180
        end if


    end do

    !print *,'================= Debug =================================='
    !do i=1,n_elements
    !    do j =1,n_elements
       
    
            
    
            !xi = nodes(int(links(i)),1)
            !yi = nodes(int(links(i+1)),2)
    
            !print *,'link: ',links(i),links(i+1)      
             
            !print *, nodes(i,j)
    
            !print *, 'nodes: ',xi,yi
    !    end do
    !end do
    !print *,'==================================================='

    print *
    print *, 'Mesh Builded'

    print *
    print *, '-------------- Exporting Mesh --------------'



    allocate ( output_matrix(n_elements,13) )    

    do i=1,n_elements
        c = cos(alfa(i))
        s = sin(alfa(i))
        output_matrix(i,1) = E
        output_matrix(i,2) = A(i)
        output_matrix(i,3) = L(i)
        output_matrix(i,4) = alfa(i)
        output_matrix(i,5) = c
        output_matrix(i,6) = s
        output_matrix(i,7) = c*s
        output_matrix(i,8) = c**2
        output_matrix(i,9) = s**2
        output_matrix(i,10) = (E*A(i)*(c**2))/L(i)
        output_matrix(i,11) = (E*A(i)*(s**2))/L(i)
        output_matrix(i,12) = (E*A(i)*(s*c))/L(i)
        output_matrix(i,13) = (E*A(i))/L(i)
    end do

    print *
    print *, 'Exported mesh'
    print *, '===================================='
    print *, output_matrix
    print *, '===================================='


    open(10, file = 'stiffness_input.dat')
    do i=1,n_elements
        write(10,*) output_matrix(i,:)
    end do
    close(10)

    deallocate(L)
    deallocate(alfa)
    deallocate(links)
    deallocate(nodes)
    deallocate(output_matrix)



end program mesh