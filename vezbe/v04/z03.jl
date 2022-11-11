using DifferentialEquations, Plots

function f(t)
	tp = rem.(t, 3)

	y = sin(pi/3 * tp)
end

function sistem!(dx, x, p, t)
	m1, m2, m3, c, k, g = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c*(x[2]-x[4]) - 2*k*x[1] + k*x[3] + m1*g)
	dx[3] = x[4]
	dx[4] = 1/m2 * (c*(x[2]-x[4]) - k*(2*x[3]-x[1]-x[5]) + m2*g)
	dx[5] = x[6]
	dx[6] = 1/m3 * (k*(x[3]-x[5]) + m3*g - f(t))
end

# Crtanje pobudne sile F
t = 0:0.01:12
plt_F = plot(t, f.(t),
		label="f(t)",
		xtick=0:1:12, yticks=0.0:0.25:1.0)

# Resavanje sistema dif jednacina
interval = (0.0, 12.0)
p = (5.0, 10.0, 5.0, 10.0, 15.0, 9.81)
pocetni = [0.0 3.0 0.0 3.0 0.0 3.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

# Izdvajanje pozicije prvog i drugog tela
pos_1 = [u[1] for u in sol.u]
pos_2 = [u[2] for u in sol.u]

plt_pos = plot(sol.t, [pos_1, pos_2],
			label=["pozicija 1" "pozicija 2"])

# Trazenje najudaljenijih pozicija provg i drugog tela
_, index_1 = findmax(abs.(pos_1))
_, index_2 = findmax(abs.(pos_2))

scatter!(plt_pos, 
		[sol.t[index_1], sol.t[index_2]],
		[pos_1[index_1], pos_2[index_2]],
		label="max pozicija",
		markerstyle=:circle, markersize=3)

# Rastojanje drugog i treceg tela za drugi pocetni uslov
pocetni[3] = pocetni[5] = 2.0
prob_new = ODEProblem(sistem!, pocetni, interval, p)
sol_new = solve(prob_new)

pos_3 = [u[3] for u in sol_new.u]
pos_5 = [u[5] for u in sol_new.u]

plt_pos_new = plot(sol_new.t, [pos_3, pos_5],
			label=["pozicija 3" "pozicija 5"],
			xlabel="t")

# Crtanje svih grafika
plt_final = plot(plt_F, plt_pos, plt_pos_new, layout=(3,1))
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z03.png")
