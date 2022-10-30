using Plots
using CSV
include("params.jl")

function read_data(path)
	csv_reader = CSV.File(path)
	n = length(csv_reader)

	M = zeros(Float32, n)
	X = zeros(Float32, 2, n)
	V = zeros(Float32, 2, n)
	
	for (i, row) in enumerate(csv_reader)
		M[i] = row.mass
		X[:, i] = [row.x row.y]
		V[:, i] = [row.vx row.vy]
	end

	return [M, X, V]
end

function calc_acceleration!(n, X, M, A, V)
	A .= 0

	for i in 1:n
		for j in 1:n
			if i != j
				dr = X[:, j] - X[:, i]
 				r = sqrt(sum(dr .^ 2))
				A[:, i] += G * M[j] / (r ^ 3) .* dr
			end
		end
	end
end

function update_positions!(n, X, A, V)
	for i in 1:n
		X[:,i] = X[:,i] + V[:,i] .* dt + A[:,i] .* (dt ^ 2) / 2
		V[:,i] = V[:,i] + A[:,i] .* dt
	end
end

function save_frame!(a, X)
	if scale_plt
		min = minimum(X) - padding_plt
		max = maximum(X) + padding_plt
	else
		min = -default_axis_lim
		max = default_axis_lim
	end

	plt = scatter(X[1,:], X[2,:],
				xlims = (min,max),
				ylims = (min,max),
				color = :blue,
				markersize = marker_size,
				label = false)
	frame(a, plt)
end
