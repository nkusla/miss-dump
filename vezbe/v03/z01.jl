using Plots, DifferentialEquations

function dif_jednacina!(dx, x, params, t)
	alpha, beta, gamma = params

	dx[1] = alpha * (x[2] - x[1])
	dx[2] = x[1] * (beta - x[3]) - x[2]
	dx[3] = x[1] * x[2] - gamma * x[3]
end

alpha = 10
beta = 27
gamma = 8/3
params = (alpha, beta, gamma)

interval = (0.0, 30.0)

pocetni_0 = [1.0, 0.0, 0.0]
pocetni_1 = [1.0, 0.01, 0.01]

prob_0 = ODEProblem(dif_jednacina!, pocetni_0, interval, params)
sol_0 = solve(prob_0)

prob_1 = ODEProblem(dif_jednacina!, pocetni_1, interval, params)
sol_1 = solve(prob_1)

plt_0 = plot(sol_0,
	title="Plot 0",
	xlabel = "t",
	ylabel = "u(t)")

plt_1= plot(sol_1,
	title="Plot 1",
	xlabel = "t",
	ylabel = "u(t)")

plot(plt_0, plt_1, layout = (2, 1))