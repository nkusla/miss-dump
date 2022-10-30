#= 
Napisati funkciju koja za zadate kvadratne matrice A i B istih dimenzija određuje:
	- vektor m koji se sastoji od elemenata ispod glavne dijagonale matrice A koji su
		pozitivni celi brojevi deljivi sa 3
	- skalar s koji predstavlja srednju vrednost elemenata sa sporedne dijagonale matrice
		B koji su veći od srednje vrednosti elemenata sa glavne dijagonale matrice A
=#

using LinearAlgebra, Statistics

n = 10

A = rand(-10:10, n, n)
B = rand(-10:10, n, n)

mask = ones(Bool, n, n)
tril!(mask, -1)

m = A[mask .& (A .% 3 .== 0) .& (A .> 0)]

avg_A = mean(diag(A))
s = reverse(B, dims = 2)
s = diag(s)

s = mean(s[s .> avg_A])
