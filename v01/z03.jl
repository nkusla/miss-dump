# Za proizvoljnu kvadratnu matricu A, izdvojiti elemente koji se nalaze
# na preseku parnih vrsta i parnih kolona

n = 5
A = rand(1:10, n, n)

B = A[2:2:end, 2:2:end]
