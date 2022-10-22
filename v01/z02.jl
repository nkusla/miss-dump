# Za proizvoljnu kvadratnu matricu A, 
# izdvojiti sve elemente koji su deljivi sa 9

n = 5
A = rand(1:30, n, n)

B = A[A .% 9 .== 0]
