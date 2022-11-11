using DifferentialEquations, Plots

function f(t)
	tp = rem(t, 3)

	y = min(sin(pi/3 * tp), 1/3 * tp)
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, k1, k2, g = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c1*x[2] - k1*x[1] - k2*(x[1]-x[3]) + m2*g)
	dx[3] = x[4]
	dx[4] = 1/m2 * (-c2*x[4] + k2*(x[1]-x[3]) + m2*g + f(t))
end

# Crtanje pobudne sile
t = 0:0.01:18
plt_F = plot(t, f.(t), 
	label="f(t)",
	xticks=0:1:18, yticks=0:0.25:1)

# Resavanje sistema dif jednacina
interval = (0.0, 12.0)
p = (10.0, 8.0, 5.0, 10.0, 15.0, 15.0, 9.81)
pocetni = zeros(4)

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

# Izdvajanje pozicije prvog i drugog tela
pos_1 = [u[1] for u in sol.u]
pos_2 = [u[3] for u in sol.u]

plt_pos = plot(sol.t, [pos_1, pos_2], 
				label=["pozicija 1" "pozicija 2"])

# Izdvajanje brzine i ubrzanja prvog tela
brzina_1 = [u[2] for u in sol.u]
ubrz_1 = diff(brzina_1) ./ diff(sol.t)

plt_brz = plot(sol.t, brzina_1, label="brzina 1")
plot!(plt_brz, sol.t[1:end-1], ubrz_1, label="ubrzanje 1", xlabel="t")

# Oznacavanje na grafiku maksimalne brzine i ubrzanja
_, index_brz = findmax(abs.(brzina_1))
_, index_ubrz = findmax(abs.(ubrz_1))

scatter!(plt_brz, [sol.t[index_brz]], [brzina_1[index_brz]],
		label="max brzina 1", markerstyle=:circle, markersize=3)

scatter!(plt_brz, [sol.t[index_ubrz]], [ubrz_1[index_ubrz]],
		label="max ubrzanje 1", markerstyle=:circle, markersize=3)

# Crtanje svih grafika
plt_final = plot(plt_F, plt_pos, plt_brz, layout=(3,1))
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z04.png")