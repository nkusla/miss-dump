#= Napisati funkciju koja za zadatu kvadratnu matricu A, određuje:
	- vektor m koji se formira od elemenata sa glavne dijagonale matrice A.
	- skalar s koji predstavlja srednju vrednost elemenata iznad glavne dijagonale matrice A
=#

using LinearAlgebra
using Statistics

n = 5
A = rand(1:10, n, n)

m = diag(A)

mask = ones(Bool, n, n)
mask = triu(mask, 1)
s = mean(A[mask])
