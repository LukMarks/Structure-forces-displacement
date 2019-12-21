! Author: Lucas Marques Moreno
! Date: 12/21/2019 
! Script capable of apply the finite elemen's
! algorithm used with the other python scripts
program finiteElements
    implicit none

    real :: angle                                           ![degree] temporary angle
    real :: alfa                                            ![degree] angle between two elements
    !real,allocatable,dimension(:) :: nodes                 ![m](x,y) nodes coordenates
    real, dimension(4,2) :: nodes                           ![m](x,y) nodes coordenates
    real:: L(3)                                             ![m] length of the element
    integer, parameter :: ikind=selected_real_kind(p=18)    !define precision 
    real(kind = ikind) :: E                                 ![N/m²] Young Modulus
    INTEGER :: row,col,max_rows,max_cols

    open(1, file='inputMech.dat')
    read(1,*) E
    close(1)

    open(2, file='inputNodes.dat')
    read(2,*) nodes
    close(2)


    L(1) = sqrt((nodes(2,1)-nodes(1,1))**2+(nodes(2,2)-nodes(1,2))**2)
    L(2) = sqrt((nodes(3,1)-nodes(2,1))**2+(nodes(3,2)-nodes(2,2))**2)
    L(3) = sqrt((nodes(4,1)-nodes(3,1))**2+(nodes(4,2)-nodes(3,2))**2)



end program finiteElements