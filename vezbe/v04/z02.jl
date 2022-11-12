using DifferentialEquations, Plots

function f(t)
	tp = rem(t, 1)
	
	y = 1/2 * t * (tp <= 0.5) + 0.0
end

function sistem!(dx, x, p, t)
	m1, m2, c1, c2, k1, k2, g = p

	dx[1] = x[2]
	dx[2] = 1/m1 * (-c1*x[2] - k1*x[1] - k2*(x[1]-x[3]) + m1*g)
	dx[3] = x[4]
	dx[4] = 1/m2 * (-c2*x[4] + k2*(x[1]-x[3]) + m2*g + f(t))
end

# Crtanje pobudne sile F
t = 0:0.01:10
plt_F = plot(t, f.(t), 
			label="f(t)", 
			xticks=0:1:10)

# Resavanje sistema dif jednacina
interval = (0.0, 10.0)
p = (20.0, 10.0, 10.0, 10.0, 20.0, 40.0, 9.81)
pocetni = [-1.0, 0.0, -1.0, 0.0]

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

# Izdvajamo poziciju i brzinu prvog tela
pos_1 = [u[1] for u in sol.u]
brzina_1 = [u[2] for u in sol.u]

plt_sol = plot(sol.t, [pos_1, brzina_1],
			label=["pozicija 1" "brzina 1"])

# Kreiranje grafika ubrzanja prvog tela
ubrz = diff(brzina_1) ./ diff(sol.t)
plt_ubrz = plot(sol.t[1:end-1], ubrz, 
			label="ubrzanje 1", xlabel="t")

# Oznacnavanje maksimalnog ubrzanja
_, index = findmax(abs.(ubrz))
scatter!(plt_ubrz, [sol.t[index]], [ubrz[index]],
		label="max ubrzanje",
		markerstyle=:circle, markersize=3)

# Crtanje svih grafika
plt_final = plot(plt_F, plt_sol, plt_ubrz, layout=(3,1))
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z02.png")
