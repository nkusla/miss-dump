# Napisati funkciju koja određuje zbir svih elemenata matrice A,
# koji imaju osobinu da je zbir indeksa (i + j) paran broj (A11 + A13 + ...)

n = 10
m = 5

A = rand(1:10, m, n)
mask = zeros(Bool, m, n)

mask[1:2:end, 1:2:end] .= 1
mask[2:2:end, 2:2:end] .= 1

s = sum(A[mask])
