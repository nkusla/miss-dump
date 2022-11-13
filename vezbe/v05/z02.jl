using DifferentialEquations, Plots

function trougao(t)
	tp = rem(t, 2)
	y = 2*tp * (tp <= 1) +
		(-2*tp+4) * (tp > 1)
end

function kruznica(t)
	tp = rem(t, 2)
	y = sqrt(1 - (tp-1)^2) 
end
	
f(t) = min(kruznica(t), trougao(t))

function sistem!(dx, x, p, t)
	m, c1, c2, k1, k2, R, L1, L2 = p
	J = 1/2 * m * R^2

	dx[1] = x[2]
	dx[2] = 1/J * (-c1*R^2*x[2] - k1*x[1] - k2*R^2*x[1] - k2*R*L1*x[3])
	dx[3] = 1/(c2*L2^2) * (-k2*R*L1*x[1] - k2*L1^2*x[3] + L1*f(t))
end

# Crtanje pobudne sile F i pomocnih signala
t=0:0.01:10
plt_F = plot(t, trougao.(t), 
		label="trougao", xticks=0:10,
		xlabel="t", ylabel="y",
		linestyle=:dash, color=:green)

plot!(plt_F, t, kruznica.(t), 
		label="kruznica", linestyle=:dash, color=:red)

plot!(plt_F, t, f.(t), label="y", lw=2, color=:blue)

# Resavanje sistema dif jednacina
interval = (0.0, 100.0)
p = (10.0, 10.0, 8.0, 10.0, 15.0, 1.0, 1.0, 2.0)
pocetni = zeros(3)

prob = ODEProblem(sistem!, pocetni, interval, p)
sol = solve(prob)

# Izdvajanje resenja koje se odnosi na ugaonu poziciju oba tela
ugao_1 = [u[1] for u in sol.u]
ugao_2 = [u[3] for u in sol.u]

plt_ugao = plot(sol.t, [ugao_1, ugao_2],
			label=["ugaona pozicija 1" "ugaona pozicija 2"])

# Pronalazenje grafika ugaonog ubrzanja diska i njegovog maksimuma
ugao_brz_1 = [u[2] for u in sol.u]
ugao_ubrz_1 = diff(ugao_brz_1) ./ diff(sol.t)

_, index = findmax(abs.(ugao_ubrz_1))

plt_ugao_ubrz = plot(sol.t[1:end-1], ugao_ubrz_1, 
					label="ugaono ubrzanje", xlabel="t")

scatter!(plt_ugao_ubrz, [sol.t[index]], [ugao_ubrz_1[index]],
	label="max ubrzanje", markerstyle=:circle, markersize=3)

# Crtanje svih grafika
plt_final = plot(plt_F, plt_ugao, plt_ugao_ubrz, layout=(3,1))
display(plt_final)

# Cuvanje grafika
dir = dirname(@__FILE__())
savefig(plt_final, "$dir/z02.png")
