# Napisati funkciju, po uzoru na funkciju prod, koja određuje proizvod svih elemenata vektora

n = 2
A = rand(n, 1) .* 10
A = vec(A)

function proiz(vec)
	p = 1

	for elem in vec
		p *= elem
	end

	return p
end

println(proiz(A))