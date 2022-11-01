using Plots
using CSV
using ProgressBars
include("params.jl")

function read_data(path)
	csv_reader = CSV.File(path)
	n = length(csv_reader)

	M = zeros(precision, n)
	X = zeros(precision, 2, n)
	V = zeros(precision, 2, n)
	
	for (i, row) in enumerate(csv_reader)
		M[i] = row.mass
		X[:, i] = [row.x row.y]
		V[:, i] = [row.vx row.vy]
	end

	return [M, X, V]
end

function calc_acceleration!(n, X, M, A, body_index)
	A .= 0
	collision_detected = false

	for i in 1:n
		for j in 1:n
			if i != j
				dr = X[:,j] - X[:,i]
 				r = sqrt(sum(dr .^ 2))
				if r > epsilon
					A[:,i] += G * M[j] / (r ^ 3) .* dr
				else
					collision_detected = true

					if body_index[i] != body_index[j]
						body_index[i] = body_index[j]
					end
				end
			end
		end
	end

	return collision_detected
end

function merge_bodies!(n, X, M, A, V, body_index)

	new_X = reshape([], (2, 0))
	new_M = []
	new_A = reshape([], (2, 0))
	new_V = reshape([], (2, 0))

	for i in 1:n
		idx = findall(body_index .== i)
		if isempty(idx) continue end

		# Summing all masses into one
		res = sum(M[idx])
		push!(new_M, res)

		# Calc new position of merged merged bodies
		new_X = hcat(new_X, X[:, idx[1]])

		# Calc new acceleration vector of merged bodies
		res = sum(A[:,idx], dims=2)
		new_A = hcat(new_A, res)

		# Calc new velocity vector of merged bodies
		res = sum(V[:,idx], dims=2)
		new_V = hcat(new_V, res)
	end

	n = length(new_M)
	body_index = collect(1:n)
	return [new_X, new_M, new_A, new_V, n, body_index]
	
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

	if scale_marker
		size = M ./ default_marker_scale
	else
		size = default_size
	end
	plt = scatter(X[1,:], X[2,:],
				xlims = (min,max),
				ylims = (min,max),
				color = :blue,
				markersize = size,
				label = false)
	frame(a, plt)
end
