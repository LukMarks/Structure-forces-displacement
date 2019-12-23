! Author: Lucas Marques Moreno
! Date: 12/21/2019 
! Script responsible for the
! mesh generation
program mesh
    implicit none
    integer :: n_nodes                                      !number of the nodes
    real :: angle                                           ![degree] temporary angle
    real :: alfa                                            ![degree] angle between two elements
    !real,allocatable,dimension(:) :: nodes                 ![m](x,y) nodes coordenates
    
    
    integer, parameter :: ikind=selected_real_kind(p=18)    !define precision 
    real(kind = ikind) :: E                                 ![N/m²] Young Modulus
    INTEGER :: row,col,max_rows,max_cols


    open(1, file='setup.dat')
    read(1,*) n_nodes
    close(1)

    real, dimension(n_nodes,2) :: nodes                           ![m](x,y) nodes coordenates
    real:: L(n_nodes-1)                                                   ![m] length of the element
    open(2, file='inputMech.dat')
    read(2,*) E
    close(2)

    open(3, file='inputNodes.dat')
    read(3,*) nodes
    close(3)


    L(1) = sqrt((nodes(2,1)-nodes(1,1))**2+(nodes(2,2)-nodes(1,2))**2)
    L(2) = sqrt((nodes(3,1)-nodes(2,1))**2+(nodes(3,2)-nodes(2,2))**2)
    L(3) = sqrt((nodes(4,1)-nodes(3,1))**2+(nodes(4,2)-nodes(3,2))**2)



end program mesh