include("func.jl")

path = "n_body/direct_collision.csv"
a = Animation()

M, X, V = read_data(path)
printstyled("Data read from: $(path)\n", color = :blue)

n = length(M)
body_index = collect(Int32, 1:n)
A = zeros(2, n)

# Main loop
printstyled("\nLoading: \n", color=:yellow)
for t in ProgressBar(0:dt:endt)
	collision_detected = calc_acceleration!(n, X, M, A, body_index)
	if collision_detected
		X, M, A, V, n, body_index = merge_bodies!(n, X, M, A, V, body_index)
	end
	update_positions!(n, X, A, V)
	save_frame!(a, X)
end

gif_path = replace(path, ".csv" => ".gif")
gif(a, gif_path, fps = 30)
