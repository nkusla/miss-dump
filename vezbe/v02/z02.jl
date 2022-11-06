using Plots

t = 0:0.01:2*pi

y0 = sin.(t)

plt = plot(t, y0,
		xlabel="t",
		ylabel="y",
		label="sin(t)",
		linestyle=:dash, color=:red)

tp = rem.(t, pi/3)
y = y0 .* (tp .< pi/6)

plot!(plt, t, y,
	label="y(t)",
	xtick=0:pi:2*pi,
	color=:blue)
