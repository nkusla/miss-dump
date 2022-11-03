using Plots, DifferentialEquations

function F(t)
	tp = rem(t, 3)

	F = 4 * tp * (tp < 1) + 
		4 * ((tp >= 1) & (tp < 2)) +
		0 * ((tp >= 2) & (t < 3))
end

function dif_jednacina!(dx, x, params, t)
	A, B, C = params

	dx[1] = x[2]
	dx[2] = -3*x[2] - C*(x[2]-x[3]) + B*(x[1]-x[3])
	dx[3] = x[4]
	dx[4] = C/2 * (x[2]-x[4]) + A/2 * x[3] + B/2 * (x[1]-x[3]) + F(t)

end

A = 12
B = 8
C = 4
params = (A, B, C)

interval = (0.0, 9.0)
pocetni = [0.0 0.0 0.0 0.0]

plt_F = plot(F, interval[1], interval[2], ylabel="F", label="F(t)")

prob = ODEProblem(dif_jednacina!, pocetni, interval, params)
sol = solve(prob)

plt_sol = plot(sol, xlabel="t", ylabel="u(t)", legend=:topleft)

plot(plt_F, plt_sol, layout = (2, 1))