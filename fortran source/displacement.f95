program displacement

    implicit none
    integer :: n_elements                                                  !number of elements
    integer :: n_nodes                                                     !number of the nodes 
    integer :: i,j,col                                                     !Counters
    real, dimension(:,:), allocatable :: nodes                             ![m](x,y) nodes coordenates
    real, dimension(:,:), allocatable :: d                                 ![m](x,y) displacement of the nodes 
    real, dimension(:), allocatable :: load                             ![N](x,y) Loads in each node
    real, dimension(:), allocatable :: Forces                            ![N](x,y) Loads in the free coordenates
    real, dimension(:,:), allocatable :: k, k_free, k_inverse                          ![N/m] stiffness matrix
    integer, dimension(:,:), allocatable :: links                             !(i,j) Link of each element
    real, dimension(:), allocatable :: free_nodes                        ![] list of free nodes 
    

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

    allocate( free_nodes(n_nodes*2) )

    open(4, file='free_nodes.dat')
    DO i = 1,n_nodes*2
        READ(4,*) free_nodes(i)    
    END DO

    allocate(k(n_elements*4,n_elements*4))
    
    open(5, file='stiffness_matrix.dat')
    DO i=1,n_elements*4
        READ(5,*) k(i,:)
    END DO

    allocate(load(n_nodes*2))

    open(6, file='load.dat')
    DO i=i,n_nodes*2
        READ(6,*) load(i)
    END DO

    !filter only the free nodes

    allocate(Forces(size(free_nodes)))

    DO i=1,size(free_nodes),2
        Forces(i) = load(links(i,1)*2-1)!Add the force in the x axis
        Forces(i+1) = load(links(i,1)*2) !Add the force in the y axis
    END DO


    allocate(k_free(n_elements*4,n_elements*4))

    DO i=1,n_elements*4
        ! filter the free nodes stiffness matrix
    END DO

    call inverse(k,k_inverse,n_elements*4) ! calculating the inverse of k

    d = matmul(k_inverse,Forces)
    



    deallocate(nodes)
    deallocate(links)
    deallocate(free_nodes)
    deallocate(k)
    deallocate(load)
    deallocate(Forces)


        


end program displacement



subroutine inverse(a,c,n)
    !============================================================
    ! Inverse matrix
    ! Method: Based on Doolittle LU factorization for Ax=b
    ! Alex G. December 2009
    !-----------------------------------------------------------
    ! input ...
    ! a(n,n) - array of coefficients for matrix A
    ! n      - dimension
    ! output ...
    ! c(n,n) - inverse matrix of A
    ! comments ...
    ! the original matrix a(n,n) will be destroyed 
    ! during the calculation
    !===========================================================
    implicit none 
    integer n
    double precision a(n,n), c(n,n)
    double precision L(n,n), U(n,n), b(n), d(n), x(n)
    double precision coeff
    integer i, j, k
    
    ! step 0: initialization for matrices L and U and b
    ! Fortran 90/95 aloows such operations on matrices
    L=0.0
    U=0.0
    b=0.0
    
    ! step 1: forward elimination
    do k=1, n-1
       do i=k+1,n
          coeff=a(i,k)/a(k,k)
          L(i,k) = coeff
          do j=k+1,n
             a(i,j) = a(i,j)-coeff*a(k,j)
          end do
       end do
    end do
    
    ! Step 2: prepare L and U matrices 
    ! L matrix is a matrix of the elimination coefficient
    ! + the diagonal elements are 1.0
    do i=1,n
      L(i,i) = 1.0
    end do
    ! U matrix is the upper triangular part of A
    do j=1,n
      do i=1,j
        U(i,j) = a(i,j)
      end do
    end do
    
    ! Step 3: compute columns of the inverse matrix C
    do k=1,n
      b(k)=1.0
      d(1) = b(1)
    ! Step 3a: Solve Ld=b using the forward substitution
      do i=2,n
        d(i)=b(i)
        do j=1,i-1
          d(i) = d(i) - L(i,j)*d(j)
        end do
      end do
    ! Step 3b: Solve Ux=d using the back substitution
      x(n)=d(n)/U(n,n)
      do i = n-1,1,-1
        x(i) = d(i)
        do j=n,i+1,-1
          x(i)=x(i)-U(i,j)*x(j)
        end do
        x(i) = x(i)/u(i,i)
      end do
    ! Step 3c: fill the solutions x(n) into column k of C
      do i=1,n
        c(i,k) = x(i)
      end do
      b(k)=0.0
    end do
    end subroutine inverse