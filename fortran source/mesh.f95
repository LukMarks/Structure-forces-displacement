! Author: Lucas Marques Moreno
! Date: 12/21/2019 
! Script responsible for the
! mesh generation
program mesh
    implicit none

    integer :: n_nodes                                         !number of the nodes
    integer :: n_elements                                         !number of the nodes
    real :: angle                                           ![degree] temporary angle
    real :: alfa                                            ![degree] angle between two elements 
    real :: x,y,xi,xj,yi,yj                                 ![m] elements coordenates
    integer :: i,start,end
    real, dimension(:,:),allocatable :: nodes               ![m](x,y) nodes coordenates
    real, dimension(:,:),allocatable :: links               ![m](x,y) nodes coordenates
    real, dimension(:),allocatable :: L               ![m](x,y) nodes coordenates
    
    integer, parameter :: ikind=selected_real_kind(p=18)    !define precision 
    real(kind = ikind) :: E                                 ![N/m²] Young Modulus


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
    read(3,*) nodes
    close(3)

    
    !deallocate(nodes)
    
    print *, nodes
    print *, 'links', nodes

    print *
    print *, '-------------- Importing Links --------------'
    
    allocate ( links(n_elements,2) ) 

    open(4, file='input_links.dat')
    read(4,*) links
    close(4)

    print *, links
    deallocate(links)

    print *
    print *, "-------------- Calculating Element's Properties  --------------"

    allocate ( L(n_elements) )
    
    do i=1,n_elements
        !L(i) = nodes(i,1)

        xi = nodes(int(links(i,2)),1)
        yi = nodes(int(links(i,1)),1)

        xj = nodes(int(links(i,2)),2)
        yj = nodes(int(links(i,1)),2)

        print *,xi,yi
        print *
        print *,xi,yi

        x = xj- xi
        y = yj-yi
        print *
        print *,x,y
        L(i) = sqrt(x**2+y**2)
        !L(i) = sqrt(( nodes(int(links(i,2)),1) - nodes(int(links(i,1)),1) )**2) !+ ( nodes(int(links(i,2)),2) - nodes( int(links(i,1)) ,2 ) )**2+) 

    end do

    print *, L
    deallocate(L)
    deallocate(nodes)


    print *
    print *, 'Mesh Builded'
end program mesh