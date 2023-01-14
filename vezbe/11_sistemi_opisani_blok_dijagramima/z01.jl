using DifferentialEquations, Plots

function f_step(t)
	tp = rem(t, 2)
	y = 4 * (tp < 1)
end

ulaz(t) = min(f_step(t), 2/5*t)

function sistem!(dx, x, params, t)
	r = params
	e = -0.5*x[2] + r(t)

	dx[1] = 4*e - x[1]
	dx[2] = x[3]
	dx[3] = x[1]^2 - x[2] - 4*x[2]*x[3]^2
end

t = 0:0.01:10
interval = (0.0, 10.0)
pocetni = [0.0, -1.0, 1.0]

prob = ODEProblem(sistem!, pocetni, interval, (ulaz))

# Ispostavi se da je ovo stiff problem (resenje ima nagle skokove i padove),
# zbog toga su neki numericki algoritmi nestabilni za resavanje. Pa je
# potrebno izabrati algoritam koji je napravljen za stiff probleme
sol = solve(prob, alg_hints=[:stiff])

# Crtanje ulaza
plt_u = plot(t, f_step, label="", ylabel="u(t)", color=:red, linestyle=:dash)
plot!(plt_u, t, ulaz, label="u(t)", color=:blue)

# Crtanje odziva
y = [x[2] for x in sol.u]
plt_izlaz = plot(sol.t, y, label="y(t)", xlabel="t[s]")

# Cuvanje grafika
plt = plot(plt_u, plt_izlaz, layout=(2, 1))
savefig(plt, replace(@__FILE__(), ".jl" => ".png"))
