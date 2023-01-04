using DifferentialEquations, Plots

function sistem!(dx, x, params, t)
	r = params
	e = -x[5] + r(t)
	q = sqrt(x[2] + 3*x[1])				# GRESKA: dobije se kompleksan broj !!!!

	dx[1] = x[2]
	dx[2] = e - x[1]
	dx[3] = x[4]
	dx[4] = 0.5 * (0.5*q - 4*x[3]*(x[4])^2 - x[3])
	dx[5] = -2*x[5] + 2*x[3]
end

t = 0:0.01:10
interval = (0.0, 10.0)
pocetni = [0.0, 0.0, -1.0, 1.0, 0.0]
u(t) = (t >= 4) ? 2 : 0

prob = ODEProblem(sistem!, pocetni, interval, (u))
sol = solve(prob)

# Crtanje ulaza
plt_ulaz = plot(t, u, xticks=0:1:10, label="u(t)")

# Crtanje izlaza
y = [x[5] for x in sol.u]
plt_izlaz = plot(sol.t, y, label="y(t)", xlabel="t[s]")

# Cuvanje grafika
plt = plot(plt_ulaz, plt_izlaz, layout=(2, 1))
savefig(plt, replace(@__FILE__(), ".jl" => ".png"))
