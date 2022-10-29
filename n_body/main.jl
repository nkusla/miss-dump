include("params.jl")
include("func.jl")

a = Animation()
X = [20.0 20.0; -20.0 -20.0;]# 30.0 -30.0]
M = [1e13, 1e13, 1e13]
V = [0.0 -1.0; 0.0 1.0; 0.0 0.0]
#V = zeros(N, dim)
A = zeros(N, dim)

for t in 0:dt:endt
	calc_acceleration!(X, M, A, V)
	update_positions!(X, A, V)
	save_frame!(a, X)
end

gif(a, "n_body/anim.gif", fps = 30)
