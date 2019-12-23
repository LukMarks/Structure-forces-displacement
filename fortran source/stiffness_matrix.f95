! Author: Lucas Marques Moreno
! Date: 12/23/2019 
! Script responsible for the
! stiffness matrix generation

program stiffness_matrix
    implicit none
    integer :: size                                                        !first size of the mesh ||variable to read the setup file
    integer :: n_nodes                                                     !number of the nodes
    double precision, dimension(4,2) :: stiff                              !create the stiffness matrix
    
    open(1, file='setup.dat')
    read(1,*) setup


end program stiffness_matrix