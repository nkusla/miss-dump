using Plots

t = 0:0.5:9

s = 2*sin.(pi/3 * t)
y =  min.(s, 1) .* (s .> 0) .+ 
	max.(s, -1) .* (s .<= 0)

plt = scatter(t, s,
		label="sin",
		xlabel="t",
		ylabel="y",
		xticks=0:9)

plot!(plt, t, y,
	label="y",
	color=:red)
