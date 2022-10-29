using Plots
include("params.jl")

function calc_acceleration!(X, M, A, V)
	A .*= 0

	for i in 1:N
		for j in 1:N
			if i != j
				dr = X[j, :] - X[i, :]
 				r = sqrt(sum(dr .^ 2))
				if r > epsilon
					A[i, :] += G * M[j] / (r ^ 3) * dr[:]		
				end
			end
		end
	end
end

function update_positions!(X, A, V)
	for i in 1:N
		X[i,:] = X[i,:] + V[i,:] .* dt + A[i,:] .* (dt ^ 2) / 2
		V[i,:] = V[i,:] + A[i,:] .* dt
	end
end

function save_frame!(a, X)
	min = minimum(X) - 10
	max = maximum(X) + 10
	plt = scatter(X[:,1], X[:,2],
				xlims = (min,max),
				ylims = (min,max),
				color = :red, 
				markersize = 5, 
				label = false)
	frame(a, plt)
end
