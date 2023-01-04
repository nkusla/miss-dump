# Napisati funkciju koja određuje poziciju nenultih elemenata proizvoljne matrice
# Zadatak rešiti bez korišćenja funkcije findall

n = 5
m = 10
A = rand(0:5, n, m)

function nadjisve(matrix)
	ind = []

	for i in 1:size(matrix, 1)
		for j in 1:size(matrix, 2)
			if matrix[i, j] != 0
				push!(ind, (i, j))
			end
		end
	end
	return ind
end

ind = nadjisve(A)