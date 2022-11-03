using Plots

t = -3:0.1:3

plt = plot(t, x -> x^2 - 1,
		xlabel="t",
		ylabel="y",
		label="x^2-1")

plot!(plt, t, x -> -x^2 + 1, 
	label="-x^2+1")