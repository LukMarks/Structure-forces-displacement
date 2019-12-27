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
    integer :: i
    real, dimension(:,:),allocatable :: nodes               ![m](x,y) nodes coordenates
    real, dimension(:,:),allocatable :: links               ![m](x,y) nodes coordenates
    real, dimension(:),allocatable :: L               ![m](x,y) nodes coordenates
    
    integer, parameter :: ikind=selected_real_kind(p=18)    !define precision 
    real(kind = ikind) :: E                                 ![N/m²] Young Modulus


    print *
    print *, '-------------- Building Mesh --------------'

    open(1, file='setup.dat')
    read(1,*) n_nodes,n_elements
    close(1)

    open(2, file='input_young_modulos.dat')
    read(2,*) E
    close(2)


    allocate ( nodes(n_nodes,2) ) 

    open(3, file='input_nodes.dat')
    read(3,*) nodes
    close(3)

    
    deallocate(nodes)
    
    print *, nodes
    print *, 'links', n_elements
    
    allocate ( links(n_elements,2) ) 

    open(4, file='input_links.dat')
    read(4,*) links
    close(4)

    print *, links
    deallocate(links)


    allocate ( L(n_elements) )
    
    do i=0,n_elements

        L(i) = sqrt(( nodes(int(links(i,2)),1) - nodes(int(links(i,1)),1) )**2) !+ ( nodes(int(links(i,2)),2) - nodes( int(links(i,1)) ,2 ) )**2+) 

    end do

    print *, L
    deallocate(L)



    print *
    print *, 'Mesh Builded'
end program mesh