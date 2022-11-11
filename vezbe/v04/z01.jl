using DifferentialEquations, Plots

function f(t)
	tp = rem.(t, 2)
	y = 5*tp * (tp <= 1) + 
		(-5*tp+10) * (tp > 1)
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, c3, k1, k2 = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c1*x[2] - k2*(x[1]-x[3]) - k1*x[1])
	dx[3] = x[4]
	dx[4] = 1/m2 * (-(c3+c2)*x[4] + k2*(x[1]-x[3]) + f(t))
end

# Crtanje pobudne sile F
t = 0:0.01:20
plt_F = plot(t, f.(t), label="f(t)", xticks=0:1:20)

# Resavanje sistema dif jednacina
interval = (0.0, 20.0)
p = (20.0, 10.0, 10.0, 10.0, 10.0, 20.0, 40.0)
pocetni = [1.0, 0.0, 2.0, 0.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

# Izdvajamo resenja u posebne vektore

brzina_1 = [u[2] for u in sol.u]
pozicija_1 = [u[1] for u in sol.u]
brzina_2 = [u[4] for u in sol.u]
pozicija_2 = [u[3] for u in sol.u]

# Ispisivanje grafika za brzine obe tela 
plt_sol = plot(sol.t, [brzina_1, brzina_2], 
			label=["brzina 1" "brzina 2"], xlabel="t")

# Trazenje maksimalne brzine prvog i drugog tela
# i iscrtavanje maksimalne brzine oba tela

_, index_1 = findmax(abs.(brzina_1))
_, index_2 = findmax(abs.(brzina_2))

scatter!(plt_sol, 
		[sol.t[index_1], sol.t[index_2]],
		[brzina_1[index_1], brzina_2[index_2]],
		label="max brzina",
		marker=:circle, markersize=3)

# Trazenje predjenog puta oba tela
# i pravljenje grafika

put_1 = sum(abs.(diff(pozicija_1)))
put_2 = sum(abs.(diff(pozicija_2)))

println("Ukupan predjeni put 1. i 2. tela je:\n$put_1\n$put_2")

# Prikazivanje svega na grafiku
plt_final = plot(plt_F, plt_sol, layout=(2,1))
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z01.png")
