using Plots

t = 0:0.01:10

function y(t)
	tp = rem(t, 5)

	y = 2 * tp * (tp <= 2) +
		2 * ((tp > 2) & (tp <= 4)) +
		(-2*tp+10) * ((tp > 4) & (tp <= 5))
end

plot(t, y.(t),
	xlabel="t",
	ylabel="y",
	label="y(t)",
	xticks=0:10)