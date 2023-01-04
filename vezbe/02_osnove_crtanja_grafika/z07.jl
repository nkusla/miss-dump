using Plots

t = 0:0.01:2

plot(t, x -> sqrt(1-(x-1)^2),
	label="kruznica",
	xlabel="t",
	ylabel="y",
	xticks=0:2,
	yticks=0:1)
