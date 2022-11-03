using Plots

t = 0:0.01:10

tp = rem.(t, 2)
p = 4/10 * t

y1 = 4 * (tp .<= 1)
y = min.(p, y1) .* (tp .<= 1)

plt = plot(t, y1,
	xticks=0:10,
	linestyle=:dash, color=:red)

plot!(plt, t, y, 
	label="y",	
	color=:blue)