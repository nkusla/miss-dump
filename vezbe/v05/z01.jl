using DifferentialEquations, Plots

function f(t)
	tp = rem(t, 8)

	y = min(sin(pi/4 * tp), 0.5) * (tp <= 4)
end

function sistem!(dx, x, p, t)
	m1, m2, c, k1, k2, R = p
	J = 1/2 * m1 * R^2

	dx[1] = x[2]
	dx[2] = 1/J * (-c*R*x[2] - k2*(x[3]+R*x[1])*R - k1*x[1])
	dx[3] = x[4]
	dx[4] = 1/m2 * (-k2*(x[3]+R*x[1]) + f(t))
end

# Crtanje pobudne sile F
t = 0:0.01:20
plt_F = plot(t, f.(t), ylims=(0, 1.0), label="f(t)",
		xticks=0:2:20, yticks=0:0.25:1, lw=2)

# Resavanje sistema dif jednacina
interval = (0.0, 20.0)
p = [10.0, 5.0, 10.0, 10.0, 15.0, 1.0]
pocetni = [0.0, 2.0, 0.0, 0.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

# Izdvajanje resenja koje se odnosi na ugaonu brzinu
# i formiranje grafika za ugaono ubrzanje diska
ugao_brz = [u[2] for u in sol.u]
ugao_ubrz = diff(ugao_brz) ./ diff(sol.t)

plt_ugao = plot(sol.t, ugao_brz, 
			label="ugaona brzina")

plot!(plt_ugao, sol.t[1:end-1], ugao_ubrz, label="ugaono ubrzanje")

# Izdvajanje resenja koje se odnosi na poziciju i brzinu drugog tela
pos_2 = [u[3] for u in sol.u]
brzina_2 = [u[4] for u in sol.u]

plot_2 = plot(sol.t, [pos_2, brzina_2], 
			label=["pozicija 2" "brzina 2"], xlabel="t")

# Crtanje svih grafika
plt_final = plot(plt_F, plt_ugao, plot_2, layout=(3,1))
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z01.png")
