# Za proizvoljnu kvadratnu matricu A, izdvojiti sve parne kolone

n = 5
A = rand(1:10, n, n)

B = A[:, 2:2:end]
