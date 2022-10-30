include("func.jl")

path = "n_body/3_body.csv"
a = Animation()

M, X, V = read_data(path)
printstyled("Data read from: $(path)\n", color = :blue)

n = length(M)
A = zeros(2, n)


# Main loop
for t in 0:dt:endt
	calc_acceleration!(n, X, M, A, V)
	update_positions!(n, X, A, V)
	save_frame!(a, X)
end

gif_path = replace(path, ".csv" => ".gif")
gif(a, gif_path, fps = 30)
