using Plots

t = 0:0.01:4

function trougao(t)
	tp = rem(t, 2)
	y = 2*tp * (tp < 1) +
		(-2*tp+4) * ((tp >= 1) & (tp < 2))
end

function kruznica(t)
	tp = rem(t, 2)
	y = sqrt(1 - (tp-1) ^ 2)
end

tr = trougao.(t)
kr = kruznica.(t)
y = min.(tr, kr)

plt = plot(t, tr,
	xlabel="t",
	ylabel="y",
	xlims=(0,4),
	ylims=(0,2),
	label="trougao",
	linestyle=:dash, color=:red)

plot!(plt, t, kr,
	label="kruznica",
	linestyle=:dash, color=:blue)

plot!(plt, t, y,
	label="y",
	linewidth=2,
	color=:green)