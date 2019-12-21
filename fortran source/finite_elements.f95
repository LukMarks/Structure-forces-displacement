! Author: Lucas Marques Moreno
! Date: 12/21/2019 
! Script capable of apply the finite elemen's
! algorithm used with the other python scripts
program finiteElements
    implicit none

    real :: alfa                                            ![degree] angle between two elements
    !real,allocatable,dimension(:) :: nodes                  ![m](x,y) nodes coordenates
    real, dimension(4,2) :: nodes
    integer, parameter :: ikind=selected_real_kind(p=18)    !define precision 
    real(kind = ikind) :: E                                 ![N/m²] Young Modulus
    INTEGER :: row,col,max_rows,max_cols

    open(1, file='inputMech.dat')
    read(1,*) E
    close(1)

    open(2, file='inputNodes.dat')
    read(2,*) nodes
    close(2)



    
end program finiteElements