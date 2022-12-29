using ControlSystems, Plots

function ulazi(t)
	tp = rem.(t, 40.0)
	u1 = 1/4 .* tp .* (tp.<20) .+ -1/4 .* (tp.-40) .* (tp.>=20)
	u2 = 5 .* (tp.>=10)

	return u1, u2
end

function sistem()
	G1 = tf(1, [1, 3.4])
	G2 = tf([2, 1.1], [1, 2, 2])
	G3 = tf(1, [1, 2])
	G4 = tf(1, [1, 1.5])
	G5 = tf(7)
	G6 = tf(2.2)

	G12 = series(G1, G2)
	G12 = minreal(feedback(G12, 1))

	G34 = series(G3, G4)
	G346 = minreal(feedback(G34, G6))

	W11 = series(G5, 1/G4)
	W11 = series(W11, G346)
	W11 = minreal(feedback(G12, W11))

	W12 = series(G12, G5)
	W12 = series(W12, G346)
	W12 = minreal(feedback(W12, 1/G4))

	W21 = series(G346, 1/G4)
	W21 = series(W21, -G12)
	W21 = minreal(feedback(W21, -G5))

	W22 = series(1/G4, -G12)
	W22 = series(W22, G5)
	W22 = minreal(feedback(G346, -W22))

	return W11, W12, W21, W22
end

t = 0:0.01:120.0

u1, u2 = ulazi(t)
W11, W12, W21, W22 = sistem()

y11, _, _ = lsim(W11, u1', t)
y12, _, _ = lsim(W12, u2', t)
y21, _, _ = lsim(W21, u1', t)
y22, _, _ = lsim(W22, u2', t)

y1 = y11' + y12'
y2 = y21' + y22'

plt = plot(t, y1, label="y1(t)", xlabel="t")
plot!(plt, t, y2, label="y2(t)")

savefig(plt, replace(@__FILE__(), ".jl" => ".png"))
