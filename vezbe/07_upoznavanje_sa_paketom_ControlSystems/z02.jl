using Plots, ControlSystems

function pobuda(t)
	y = sin(π/3 * t) 
end

# Dva nacina da definisemo funkciju prenosa

# Direktno preko kompleknse racionalne funkcije
function funkcija_prenosa(R, L, C)
	s = tf("s")
	G = (L*C*s^2 + 1) / (L*C*s^2 + R*C*s + 1)
end

# Preko matrica modela u prostoru stanja
function model_u_prostoru_stanja(R, L, C)
	A = [-R/L -1/L; 1/C 0]
	B = [1, 0]
	C = [-R 0]
	D = [1]
	G = ss(A, B, C, D)
end

R, L, C = [1e3, 22e-3, 470e-9]

t = 0:0.01:10.0
u = pobuda.(t)

y, t, x = lsim(model_u_prostoru_stanja(R, L, C), u', t)

plt = plot(t, y', xlabel="t", ylabel="y(t)", label="odziv")

# Cuvanje grafika
savefig(plt, replace(@__FILE__(), ".jl" => ".png"))